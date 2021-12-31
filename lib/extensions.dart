import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

extension UserFirebaseExt on User {
  String get name => this.displayName ?? this.email!;
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

extension StringExtension on String {
  String toTitleCase() {
    String titleCaseVar = this
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');

    return titleCaseVar;
  }
}

extension ColorExtension on Color {
  Color lighten({double amount = 0.5}) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
