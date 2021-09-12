import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:gardenesp/model/garden.dart';

class GardenRepository {
  final FirebaseDatabase _database;
  DatabaseReference? _databaseReference;

  GardenRepository({FirebaseDatabase? firebaseDb})
      : _database = firebaseDb ?? FirebaseDatabase.instance {
    _databaseReference = _database.reference();
  }

  Future<List<Garden>> retrieveGardens(String userId) async {
    final futureResult = Completer<List<Garden>>();
    _databaseReference
        ?.child("$userId")
        .once()
        .then((snap) => _parseSnapshotList(snap, (map) => Garden.fromMap(map)))
        .then(futureResult.complete)
        .catchError((error) {
      futureResult.completeError(error);
    });

    return futureResult.future;
  }

  Future<Garden> createGarden(String userId, Garden garden) {
    final futureResult = Completer<Garden>();
    final newGardenRef = _databaseReference?.child("$userId").push();
    print(newGardenRef?.key);
    newGardenRef?.set(garden.toMap()).then(
          (value) => futureResult.complete(garden),
          onError: (error) => futureResult.completeError(error),
        );
    return futureResult.future;
  }

  List<T> _parseSnapshotList<T>(
      DataSnapshot snapshot, T Function(Map<String, dynamic>) map) {
    return Map<String, dynamic>.from(snapshot.value ?? Map())
        .entries
        .map((e) => map(Map<String, dynamic>.from(e.value)
          ..putIfAbsent("identifier", () => e.key)))
        .toList();
  }
}
