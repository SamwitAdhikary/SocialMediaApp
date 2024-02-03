// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media/screens/addImagePost.dart';
import 'package:social_media/screens/addpost.dart';
import 'package:social_media/utils/palette.dart';
import 'package:social_media/utils/utils.dart';
import 'package:social_media/widgets/imagePost.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uint8List? _file;

  _selectImage(BuildContext parentContext) async {
    Uint8List? file = await pickImage(ImageSource.gallery);
    setState(() {
      _file = file;
    });

    if (_file != null) {
      Navigator.push(
          parentContext,
          MaterialPageRoute(
              builder: (parentContext) => AddImagePost(file: file)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            snap: true,
            floating: true,
            backgroundColor: Palette.black,
            elevation: 0,
            title: Text(
              "CreateOne",
              style: TextStyle(
                color: Palette.white,
                fontSize: 30,
              ),
            ),
            actions: [
              Icon(
                FluentIcons.search_48_filled,
                color: Palette.white,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                FluentIcons.chat_48_regular,
                color: Palette.white,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Palette.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        color: Palette.grey,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddPost(),
                              ),
                            );
                          },
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10, left: 10),
                              child: Text(
                                "Compose a new post",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey.shade700,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Material(
                            color: Palette.grey,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () => _selectImage(context),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: 40,
                                // color: Colors.blue,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        color: Colors.grey.shade500,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        "Add Photo",
                                        style: TextStyle(color: Palette.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Palette.grey,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(5),
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: 40,
                                // color: Colors.blue,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.videocam_outlined,
                                        color: Colors.grey.shade500,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        "Add Video",
                                        style: TextStyle(color: Palette.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .orderBy('datePublished', descending: false)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Container(
                      margin: const EdgeInsets.only(top: 90),
                      // color: Colors.red,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 350,
                            child: Lottie.asset('assets/welcome.json'),
                          ),
                          Text(
                            "Welcome to CreateOne.. Get started by following someone or adding post...",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Palette.darkgrey),
                          )
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, index) {
                      return ImagePost(
                        snap: snapshot.data!.docs[index].data(),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
