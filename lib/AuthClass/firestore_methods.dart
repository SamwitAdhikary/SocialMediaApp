import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/AuthClass/storage_methods.dart';
import 'package:social_media/models/imagepost.dart';
import 'package:social_media/models/normalpost.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadImagePost(String desctiption, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "Some error occured";

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();

      ImagePost post = ImagePost(
        description: desctiption,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> uploadNormalPost(
      String description, String uid, String username, String profImage) async {
    String res = "Some Error Occured";
    try {
      String postId = const Uuid().v1();

      NormalPost normalPost = NormalPost(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        profImage: profImage,
      );

      _firestore.collection("posts").doc(postId).set(normalPost.toJson());
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occured";

    try {
      if (likes.contains(uid)) {
        _firestore.collection('posts').doc(postId).update({
          "likes": FieldValue.arrayRemove([uid])
        });
      } else {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> postComment(String postId, String text, String uid, String name, String profilePic) async {
    String res = "Some error occured";

    try {
      if(text.isNotEmpty) {
        String commentId = const Uuid().v1();
        _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text, 
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
