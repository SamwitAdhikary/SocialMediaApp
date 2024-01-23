import 'package:flutter/material.dart';
import 'package:social_media/screens/explore.dart';
import 'package:social_media/screens/homepage.dart';
import 'package:social_media/utils/palette.dart';

List<Widget> homeScreenItems = [
  const MyHomePage(),
  const Explore(),
  const Center(
    child: Text(
      'Profile Screen',
      style: TextStyle(color: Palette.white),
    ),
  ),
  const Center(
    child: Text(
      'Notifications Screen',
      style: TextStyle(color: Palette.white),
    ),
  ),
  const Center(
    child: Text(
      'Menu Screen',
      style: TextStyle(color: Palette.white),
    ),
  ),
];
