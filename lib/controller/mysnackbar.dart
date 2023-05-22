import 'package:flutter/material.dart';
import 'package:jobkar/controller/constant.dart';

MySnackBar(context, message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      clipBehavior: Clip.hardEdge,
      duration: const Duration(seconds: 3),
      backgroundColor: blueColor,
      content: Text(message),
  ),
  );
}