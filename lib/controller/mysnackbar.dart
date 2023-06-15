import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

MySnackBar(context, message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18)
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: CupertinoColors.activeGreen,
      content: Text(message),
  ),
  );
}