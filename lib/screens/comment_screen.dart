import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/AuthClass/firestore_methods.dart';
import 'package:social_media/utils/palette.dart';
import 'package:social_media/widgets/comment.dart';

class CommentScreen extends StatefulWidget {
  final postId;
  const CommentScreen({super.key, required this.postId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController commentController = TextEditingController();
  var userdata = {};
  String typing = "";

  @override
  void initState() {
    super.initState();
    getCurrentUserData();
  }

  getCurrentUserData() async {
    var userSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      userdata = userSnap.data()!;
    });
  }

  void postComment(String uid, String name, String profilePic) async {
    try {
      String res = await FireStoreMethods().postComment(
          widget.postId, commentController.text, uid, name, profilePic);

      if (res != 'success') {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(res)));
        }
      }
      setState(() {
        commentController.text = "";
      });
    } catch (err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              err.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.black,
          title: const Text(
            "Comments",
            style: TextStyle(color: Palette.white),
          ),
          iconTheme: const IconThemeData(color: Palette.white),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.postId)
              .collection('comments')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Palette.yellow,
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) => CommentCard(
                snap: snapshot.data!.docs[index],
              ),
            );
          },
        ),
        bottomNavigationBar: userdata['photoUrl'] != null
            ? SafeArea(
                child: Container(
                  height: kToolbarHeight,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            CachedNetworkImageProvider(userdata['photoUrl']),
                        radius: 18,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: TextField(
                            style: const TextStyle(
                              color: Palette.white,
                            ),
                            controller: commentController,
                            decoration: InputDecoration(
                              hintText: "Comment as ${userdata['username']}",
                              hintStyle: TextStyle(
                                color: Palette.darkgrey,
                              ),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {
                                typing = value;
                              });
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (typing != "") {
                            postComment(userdata['uid'], userdata['username'],
                                userdata['photoUrl']);
                          } else {
                            null;
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: Text(
                            'Post',
                            style: TextStyle(
                              color:
                                  typing != "" ? Palette.yellow : Palette.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : const Offstage(),
      ),
    );
  }
}
