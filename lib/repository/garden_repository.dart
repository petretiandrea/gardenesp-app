import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:gardenesp/model/Garden.dart';

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

  List<T> _parseSnapshotList<T>(
      DataSnapshot snapshot, T Function(Map<String, dynamic>) map) {
    return List<dynamic>.from(snapshot.value ?? List.empty())
        .map((e) => map(Map<String, dynamic>.from(e)))
        .toList();
  }
}
