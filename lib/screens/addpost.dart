// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/AuthClass/firestore_methods.dart';
import 'package:social_media/utils/palette.dart';

class AddPost extends StatefulWidget {
  // final Uint8List? file;
  const AddPost({
    super.key,
  });

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _descriptionController = TextEditingController();
  var userData = {};
  final _formkey = GlobalKey<FormState>();
  String typing = "";
  // Uint8List? _file;

  @override
  void initState() {
    super.initState();
    // _file = widget.file;
    getData();
  }

  getData() async {
    var userSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      userData = userSnap.data()!;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  void addNormalPost(
      String uid, String username, String profImage, bool isImagePost) async {
    try {
      String res = "";
      res = await FireStoreMethods().uploadNormalPost(
        _descriptionController.text,
        uid,
        username,
        profImage,
      );

      if (res == 'success') {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Posted",
                style: TextStyle(color: Palette.white),
              ),
            ),
          );
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                res,
                style: const TextStyle(
                  color: Palette.white,
                ),
              ),
            ),
          );
        }
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            err.toString(),
            style: const TextStyle(color: Palette.white),
          ),
        ),
      );
    }
  }

  // void clearImage() {
  //   setState(() {
  //     _file = null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Palette.grey,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
              // setState(() {
              //   clearImage();
              // });
            },
            borderRadius: BorderRadius.circular(50),
            radius: 10,
            child: const Icon(
              Icons.close,
              color: Palette.white,
            ),
          ),
          title: const Text(
            "Create post",
            style: TextStyle(color: Palette.white),
          ),
          centerTitle: true,
          actions: [
            ElevatedButton(
              onPressed: () => typing != ""
                  ? addNormalPost(userData['uid'], userData['username'],
                      userData['photoUrl'], false)
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  typing != "" ? Palette.yellow : Colors.grey,
                ),
              ),
              child: const Text(
                "Post",
                style: TextStyle(
                  color: Palette.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        body: userData['photoUrl'] != null
            ? Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 10),
                    // color: Colors.red,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Palette.yellow,
                          radius: 25,
                          backgroundImage:
                              CachedNetworkImageProvider(userData['photoUrl']),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          userData['firstname'],
                          style: const TextStyle(
                            color: Palette.white,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          userData['lastname'],
                          style: const TextStyle(
                            color: Palette.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Form(
                      key: _formkey,
                      child: TextField(
                        autofocus: true,
                        style: const TextStyle(
                          color: Palette.white,
                        ),
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "What's on your mind?",
                          hintStyle: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: null,
                        expands: true,
                        onChanged: (value) {
                          setState(() {
                            typing = value;
                          });
                        },
                      ),
                    ),
                  ),
                  // _file != null
                  //     ? Container(
                  //         color: Colors.red,
                  //         height: MediaQuery.of(context).size.height * 0.45,
                  //         child: Image(
                  //           image: MemoryImage(_file!),
                  //           fit: BoxFit.fitWidth,
                  //         ),
                  //       )
                  //     : const Offstage(),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
        // floatingActionButton: FloatingActionButton(onPressed: () {}),
      ),
    );
  }
}
