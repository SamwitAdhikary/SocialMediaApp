// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_media/AuthClass/firestore_methods.dart';
import 'package:social_media/screens/comment_screen.dart';
import 'package:social_media/utils/palette.dart';
import 'package:social_media/widgets/likeanimation.dart';

class ImagePost extends StatefulWidget {
  final snap;
  const ImagePost({super.key, required this.snap});

  @override
  State<ImagePost> createState() => _ImagePostState();
}

class _ImagePostState extends State<ImagePost> {
  bool isAnimating = false;
  int commentLen = 0;

  @override
  void initState() {
    super.initState();
    fetchCommentLen();
  }

  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();

      setState(() {
        commentLen = snap.docs.length;
      });
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            err.toString(),
          ),
        ),
      );
    }
    setState(() {});
  }

  String getTimeDifferenceFromNow(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);
    if (difference.inMinutes < 1) {
      return "Just Now";
    } else if (difference.inHours < 1) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return DateFormat.yMMMd().format(widget.snap['datePublished'].toDate());
    }
  }

  @override
  Widget build(BuildContext context) {
    // final model.User user = Provider.of<UserProvider>(context).getUser;

    return SizedBox(
      height: widget.snap['postUrl'] != null
          ? MediaQuery.of(context).size.height * 0.6
          : null,
      width: MediaQuery.of(context).size.width,
      // color: Colors.red,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            // color: Colors.blue,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Palette.yellow,
                  // backgroundImage: NetworkImage(
                  //   widget.snap['profImage'].toString(),
                  // ),
                  backgroundImage: CachedNetworkImageProvider(
                    widget.snap['profImage'].toString(),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.snap['username'].toString(),
                      style: const TextStyle(
                        color: Palette.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      getTimeDifferenceFromNow(
                          widget.snap['datePublished'].toDate()),
                      style: TextStyle(
                        color: Palette.darkgrey,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Text(
              widget.snap['description'].toString(),
              style: const TextStyle(
                color: Palette.white,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          widget.snap['postUrl'] != null
              ? Expanded(
                  child: GestureDetector(
                    onDoubleTap: () {
                      FireStoreMethods().likePost(
                        widget.snap['postId'].toString(),
                        FirebaseAuth.instance.currentUser!.uid,
                        widget.snap['likes'],
                      );
                      setState(() {
                        isAnimating = true;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                widget.snap['postUrl'].toString(),
                              ),
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.medium,
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: isAnimating ? 1 : 0,
                          child: LikeAnimation(
                            isAnimating: isAnimating,
                            duration: const Duration(milliseconds: 400),
                            onEnd: () {
                              setState(() {
                                isAnimating = false;
                              });
                            },
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 100,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : const Offstage(),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            // color: Colors.red,
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),

                // Like Button
                // Icon(
                //   FluentIcons.heart_48_regular,
                //   color: Palette.white,
                //   size: 25,
                // ),
                LikeAnimation(
                  isAnimating: widget.snap['likes']
                      .contains(FirebaseAuth.instance.currentUser!.uid),
                  smallLike: true,
                  child: IconButton(
                    icon: widget.snap['likes']
                            .contains(FirebaseAuth.instance.currentUser!.uid)
                        ? const Icon(
                            FluentIcons.heart_48_filled,
                            color: Colors.red,
                          )
                        : const Icon(
                            FluentIcons.heart_48_regular,
                            color: Palette.white,
                          ),
                    onPressed: () => FireStoreMethods().likePost(
                        widget.snap['postId'].toString(),
                        FirebaseAuth.instance.currentUser!.uid,
                        widget.snap['likes']),
                  ),
                ),
                // const SizedBox(
                //   width: 5,
                // ),
                Text(
                  "${widget.snap['likes'].length}",
                  style: const TextStyle(
                    color: Palette.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),

                // Comment Button
                // const Icon(
                //   FluentIcons.comment_48_regular,
                //   color: Palette.white,
                //   size: 25,
                // ),
                IconButton(
                  icon: const Icon(
                    FluentIcons.comment_48_regular,
                    color: Palette.white,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CommentScreen(
                          postId: widget.snap['postId'].toString(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "$commentLen",
                  style: const TextStyle(
                    color: Palette.white,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey.shade700,
          )
        ],
      ),
    );
  }
}
