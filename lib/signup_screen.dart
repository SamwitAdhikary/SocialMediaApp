import 'package:flutter/material.dart';
import 'package:social_media/utils/palette.dart';
import 'package:unicons/unicons.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20),
          child: SingleChildScrollView(
            // scrollDirection: Axis.vertical,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  "Let's get started by filling out the form below",
                  style: TextStyle(
                    color: Palette.white,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Form(
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
                            if (value!.isEmpty) {
                              return "Email cannot be empty";
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
                            alignLabelWithHint: true,
                            label: const Text(
                              'Password',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Palette.yellow,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(25),
                            color: Palette.yellow,
                            child: InkWell(
                              onTap: () {},
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
                        const Text(
                          "Or sign up with",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Palette.yellow,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(25),
                            color: Palette.white,
                            child: InkWell(
                              onTap: () {},
                              splashColor: Palette.yellow,
                              borderRadius: BorderRadius.circular(25),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(UniconsLine.google),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
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
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
