import 'package:flutter/material.dart';
import 'package:social_media/utils/palette.dart';

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: const TextStyle(color: Palette.white),
      ),
    ),
  );
}
