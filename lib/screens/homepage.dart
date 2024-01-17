// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:social_media/AuthClass/auth_class.dart';
import 'package:social_media/screens/signin_screen.dart';
import 'package:social_media/utils/palette.dart';

class MyHomePage extends StatefulWidget {
  final String uid;
  const MyHomePage({super.key, required this.uid});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userData = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get();

      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      'CreateOne',
                      style: TextStyle(color: Palette.white, fontSize: 30),
                    ),
                  ),
                ),
                buttons(FluentIcons.search_48_filled, 20),
                buttons(FluentIcons.chat_28_filled, 20),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                color: Palette.grey,
                borderRadius: BorderRadius.circular(23),
              ),
              child: Column(
                children: [
                  // Compose new post section
                  Material(
                    color: Palette.grey,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                    ),
                    child: InkWell(
                      onTap: () {
                        print("pressed compose new post");
                      },
                      splashColor: Colors.grey.shade900,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(23),
                          topRight: Radius.circular(23)),
                      child: Container(
                        // color: Colors.red,
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.only(left: 15, top: 10),

                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Compose new post',
                          style: TextStyle(
                            fontSize: 14.5,
                            color: Palette.darkgrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Palette.darkgrey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        color: Palette.grey,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(23),
                        ),
                        child: InkWell(
                          onTap: () {
                            print("pressed on add photo");
                          },
                          splashColor: Colors.grey.shade900,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(23)),
                          child: SizedBox(
                            // color: Colors.red,
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  color: Palette.darkgrey,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'Add Photo',
                                  style: TextStyle(
                                    color: Palette.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.5,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Palette.grey,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(23)),
                        child: InkWell(
                          onTap: () {
                            print("pressed on add video");
                          },
                          splashColor: Colors.grey.shade900,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(23),
                          ),
                          child: SizedBox(
                            // color: Colors.red,
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  FluentIcons.video_20_regular,
                                  color: Palette.darkgrey,
                                  // size: 18,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'Add Video',
                                  style: TextStyle(
                                    color: Palette.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.5,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            userData['firstname'] != null
                ? Text(
                    userData['firstname'],
                    style: TextStyle(
                      color: Palette.white,
                    ),
                  )
                : Text("null"),
            SizedBox(
              height: 20,
            ),
            userData['photoUrl'] != null
                ? CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 40,
                    backgroundImage: NetworkImage(userData['photoUrl']),
                  )
                : const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 40,
                  ),
            const SizedBox(
              height: 200,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  bool logout = await AuthClass().signOutFromGoogle();
                  if (logout == true) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SigninScreen()));
                  } else {
                    print(logout.toString());
                  }
                },
                child: const Text(
                  "Signout",
                  style: TextStyle(
                    color: Palette.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buttons(IconData icon, double right) {
    return Padding(
      padding: EdgeInsets.only(top: 20, right: right),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Palette.white,
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: Palette.white,
        ),
      ),
    );
  }
}