import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/screens/homepage.dart';
import 'package:social_media/utils/palette.dart';

List<Widget> homeScreenItems = [
  MyHomePage(uid: FirebaseAuth.instance.currentUser!.uid),
  const Center(
    child: Text(
      'Explore Screen',
      style: TextStyle(color: Palette.white),
    ),
  ),
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
