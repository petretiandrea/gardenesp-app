import 'package:firebase_auth/firebase_auth.dart';

extension UserFirebaseExt on User {
  String get name => this.displayName ?? this.email;
}

extension CastExtension<T> on T {
  V as<V>() => this as V;
  V? safeAs<V>() => this is V ? this.as() : null;
}

extension FutureExtension<T> on Future<T> {
  Future<V> flatMap<V>(Future<V> Function(T value) f) {
    return this.then((value) => f(value));
  }
}
