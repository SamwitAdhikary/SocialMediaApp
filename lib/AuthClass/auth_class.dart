import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/AuthClass/storage_methods.dart';
import 'package:social_media/models/usermodel.dart' as model;

class AuthClass {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection("users").doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  Future<String> signUpUser(
      {required String email, required String password}) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential creds = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        model.User user = model.User(
          username: "",
          uid: creds.user!.uid,
          photoUrl: "",
          firstname: "",
          lastname: "",
          email: email,
          bio: "",
          followers: [],
          following: [],
        );

        await _firestore
            .collection("users")
            .doc(creds.user!.uid)
            .set(user.toJson());

        res = "success";
      } else {
        res = "Please enter all fields";
      }
    } catch (e) {
      String errorText = getMessageFromErrorCode(e);
      return errorText;
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all fields";
      }
    } catch (e) {
      String errorText = getMessageFromErrorCode(e);
      return errorText;
    }
    return res;
  }

  String getMessageFromErrorCode(error) {
    switch (error.code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to sign in page.";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
      default:
        return "Invalid credentials. Please try again.";
    }
  }

  Future<String> signInWithGoogle() async {
    String res = "Something went wrong";
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credentials);
      final User? gUser = userCredential.user;

      model.User user = model.User(
          username: "",
          uid: gUser!.uid,
          photoUrl: "",
          firstname: "",
          lastname: "",
          email: gUser.email!,
          bio: "",
          followers: [],
          following: []);

      await _firestore.collection("users").doc(gUser.uid).set(user.toJson());
      res = "success";
    } on Exception catch (e) {
      print(e.toString());
    }
    return res;
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await _auth.signOut();
    } on Exception catch (_) {
      return false;
    }
    return true;
  }

  Future<String> createProfile({
    required String firstname,
    required String lastname,
    required String username,
    String? bio,
    required Uint8List file,
  }) async {
    String res = "Something error occured";
    try {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('profilePics', file, false);

      _firestore.collection("users").doc(_auth.currentUser!.uid).update({
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "photoUrl": photoUrl,
        "bio": bio,
      });
      res = "success";
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<bool> checkUsername(String username) async {
    final result = await _firestore
        .collection("users")
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isEmpty;
  }
}
