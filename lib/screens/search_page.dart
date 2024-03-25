import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/utils/palette.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          iconTheme: IconThemeData(color: Palette.darkgrey),
          backgroundColor: Palette.grey,
          title: SizedBox(
            height: 50,
            child: Form(
              child: TextFormField(
                textAlign: TextAlign.left,
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search for a user...',
                  hintStyle: TextStyle(
                    color: Palette.darkgrey,
                    height: 4.5,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Palette.white),
                autofocus: true,
                onFieldSubmitted: (String _) {
                  setState(() {
                    isShowUsers = true;
                  });
                },
              ),
            ),
          ),
        ),
        body: isShowUsers
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where('username',
                        isGreaterThanOrEqualTo: searchController.text)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              (snapshot.data! as dynamic).docs[index]
                                  ['photoUrl'],
                            ),
                            radius: 20,
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (snapshot.data! as dynamic).docs[index]
                                    ['username'],
                                style: const TextStyle(
                                  color: Palette.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${(snapshot.data! as dynamic).docs[index]['firstname']} ${(snapshot.data!).docs[index]['lastname']}",
                                style: TextStyle(
                                  color: Palette.darkgrey,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            : Offstage(),
      ),
    );
  }
}
