import 'package:cloud_firestore/cloud_firestore.dart';

class NormalPost {
  final String description;
  final String uid;
  final String username;
  final likes;
  final String postId;
  final DateTime datePublished;
  final String profImage;

  const NormalPost({
    required this.description,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.profImage,
  });

  static NormalPost fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return NormalPost(
      description: snapshot['description'],
      uid: snapshot['uid'],
      likes: snapshot['likes'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      username: snapshot['username'],
      profImage: snapshot['profImage'],
    );
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "likes": likes,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "profImage": profImage,
      };
}
