import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_media/providers/user_provider.dart';
import 'package:social_media/utils/palette.dart';
import 'package:social_media/models/usermodel.dart' as model;

class ImagePost extends StatefulWidget {
  final snap;
  const ImagePost({super.key, required this.snap});

  @override
  State<ImagePost> createState() => _ImagePostState();
}

class _ImagePostState extends State<ImagePost> {
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
                  backgroundImage: NetworkImage(
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
                      style: TextStyle(
                        color: Palette.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['datePublished'].toDate()),
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
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.snap['postUrl'].toString(),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : const Offstage(),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            // color: Colors.red,
            child: const Row(
              children: [
                SizedBox(
                  width: 10,
                ),

                // Like Button
                Icon(
                  FluentIcons.heart_48_regular,
                  color: Palette.white,
                  size: 25,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "0",
                  style: TextStyle(
                    color: Palette.white,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),

                // Comment Button
                Icon(
                  FluentIcons.comment_48_regular,
                  color: Palette.white,
                  size: 25,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "0",
                  style: TextStyle(
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
