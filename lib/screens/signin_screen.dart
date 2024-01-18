// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_media/AuthClass/auth_class.dart';
import 'package:social_media/screens/bottom_nav.dart';
import 'package:social_media/screens/create_profile.dart';
import 'package:social_media/screens/signup_screen.dart';
import 'package:social_media/utils/palette.dart';
// import 'package:unicons/unicons.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  bool showPass = false;

  ValueNotifier userCredentials = ValueNotifier("");

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          // alignment: Alignment.center,
          // margin: const EdgeInsets.only(left: 20, right: 10),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
              const Text(
                'CreateOne',
                style: TextStyle(
                  color: Palette.white,
                  fontSize: 25,
                  // fontWeight: FontWeight.bold,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Welcome Back',
                style: TextStyle(
                  color: Palette.white,
                  fontSize: 35,
                ),
              ),
              // SizedBox(
              //   height: 5,
              // ),
              const Text(
                "Let's get started by logging here...",
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
                    // Email Field
                    TextFormField(
                      style: const TextStyle(color: Palette.white),
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignLabelWithHint: true,
                        label: const Text(
                          'Email',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
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

                    // Password Field
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
                              ? Icon(MdiIcons.eye)
                              : Icon(MdiIcons.eyeOff),
                        ),
                        alignLabelWithHint: true,
                        label: const Text(
                          'Password',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
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
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              !_isLoading
                  ? Container(
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
                              setState(() {
                                _isLoading = true;
                              });
                              String result = await AuthClass().loginUser(
                                  email: _emailController.text,
                                  password: _passwordController.text);

                              if (result == "success") {
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const BottomNavigation(),
                                  ),
                                );
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      result,
                                      style: const TextStyle(
                                        color: Palette.white,
                                      ),
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
                              "Sign In",
                              style: TextStyle(
                                color: Palette.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Palette.yellow,
                      ),
                    ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Or sign in with",
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Palette.yellow,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(25),
                  color: Palette.white,
                  child: InkWell(
                    onTap: () async {
                      String result = await AuthClass().signInWithGoogle();

                      if (result == "success") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateProfile(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Something went wrong! Please try again after sometime.",
                              style: TextStyle(color: Palette.white),
                            ),
                          ),
                        );
                      }
                    },
                    splashColor: Palette.yellow,
                    borderRadius: BorderRadius.circular(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MdiIcons.google,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Continue with Google",
                          style: TextStyle(
                            color: Palette.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Dont't have an account? ",
                    style: TextStyle(color: Palette.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign Up Now",
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
