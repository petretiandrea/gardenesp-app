import 'package:firebase_auth/firebase_auth.dart';

extension UserFirebaseExt on User {
  String get name => this.displayName ?? this.email;
}
