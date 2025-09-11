import 'package:flutter/material.dart';
import 'package:minigram/main.dart';

void showSnack(String message) {
  final ctx = navigatorKey.currentContext;
  if (ctx == null) return;
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message)));
}
