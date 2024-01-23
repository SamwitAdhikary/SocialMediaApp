import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:social_media/screens/addpost.dart';
import 'package:social_media/utils/palette.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                                    builder: (context) => const AddPost()));
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
                              onTap: () {},
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
              post(),
              post(),
            ],
          ),
        ),
      ),
    );
  }

  Widget post() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
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
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Palette.yellow,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Samwit Adhikary",
                      style: TextStyle(
                        color: Palette.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "2 days ago",
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
            child: const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
              style: TextStyle(
                color: Palette.white,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1682687220777-2c60708d6889?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
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
