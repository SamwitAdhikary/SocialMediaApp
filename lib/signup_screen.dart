// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_media/homepage.dart';
import 'package:social_media/signin_screen.dart';
import 'package:social_media/utils/palette.dart';
import 'package:social_media/models/usermodel.dart' as model;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  bool showPass = false;
  bool showConfPass = false;
  String res = "";

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassword.dispose();
  }

  Future<String> signUpUser(
      {required String email, required String password}) async {
    res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential creds = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        model.User user = model.User(
          username: "",
          uid: creds.user!.uid,
          photoUrl: "",
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
        return "Sign up failed. Please try again.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
              const Text(
                "CreateOne",
                style: TextStyle(
                  color: Palette.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Sign Up',
                style: TextStyle(
                  color: Palette.white,
                  fontSize: 40,
                ),
              ),
              const Text(
                "Let's get started by signing up here...",
                style: TextStyle(
                  color: Palette.white,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Palette.white),
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignLabelWithHint: true,
                        label: const Text(
                          "Email",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                        final regEx = RegExp(pattern);
                        if (value!.isEmpty) {
                          return "Email cannot be empty";
                        } else if (!regEx.hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Palette.white),
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPass = !showPass;
                            });
                          },
                          icon: showPass
                              ? Icon(
                                  MdiIcons.eye,
                                )
                              : Icon(
                                  MdiIcons.eyeOff,
                                ),
                        ),
                        alignLabelWithHint: true,
                        label: const Text(
                          "Password",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      obscureText: !showPass ? true : false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Palette.white),
                      controller: _confirmPassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showConfPass = !showConfPass;
                            });
                          },
                          icon: showConfPass
                              ? Icon(
                                  MdiIcons.eye,
                                )
                              : Icon(
                                  MdiIcons.eyeOff,
                                ),
                        ),
                        alignLabelWithHint: true,
                        label: const Text(
                          "Confirm Password",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      obscureText: !showConfPass ? true : false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Confirm Password cannot be empty";
                        } else if (value != _passwordController.text) {
                          return "Password didn't matched";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.65,
                // margin: EdgeInsets.only(left: 50, right: 50),
                height: 50,
                decoration: BoxDecoration(
                  color: Palette.yellow,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(25),
                  color: Palette.yellow,
                  child: InkWell(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        String result = await signUpUser(
                            email: _emailController.text,
                            password: _confirmPassword.text);

                        if (result == "success") {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                result,
                                style: const TextStyle(color: Palette.white),
                              ),
                            ),
                          );
                        }
                      }
                    },
                    splashColor: Palette.white,
                    borderRadius: BorderRadius.circular(25),
                    child: const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Palette.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              // const Text(
              //   "Or sign up with",
              //   style: TextStyle(
              //     color: Colors.grey,
              //   ),
              //   textAlign: TextAlign.center,
              // ),
              // const SizedBox(
              //   height: 50,
              // ),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: 50,
              //   decoration: BoxDecoration(
              //     color: Palette.yellow,
              //     borderRadius: BorderRadius.circular(25),
              //   ),
              //   child: Material(
              //     borderRadius: BorderRadius.circular(25),
              //     color: Palette.white,
              //     child: InkWell(
              //       onTap: () {},
              //       splashColor: Palette.yellow,
              //       borderRadius: BorderRadius.circular(25),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Icon(
              //             MdiIcons.google,
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           const Text(
              //             "Continue with Google",
              //             style: TextStyle(
              //               color: Palette.black,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 16,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(color: Palette.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SigninScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign In Now",
                      style: TextStyle(
                        color: Palette.yellow,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
