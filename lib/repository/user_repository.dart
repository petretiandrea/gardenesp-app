import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<User?> signInWithCredentials(String username, String password) async {
    final user = await _firebaseAuth.signInWithEmailAndPassword(
      email: username,
      password: password,
    );
    return user.user;
  }

  Future<User?> signUp(String email, String password) async {
    final user = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user.user;
  }

  Future<void> logout() async {
    return await _firebaseAuth.signOut();
  }

  Future<bool> isLoggedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  Future<User> currentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return Future.value(user);
    } else {
      return Future.error(Exception("Current user not found, not logged!"));
    }
  }
}
