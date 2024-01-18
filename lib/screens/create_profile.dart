// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:social_media/AuthClass/auth_class.dart';
import 'package:social_media/screens/bottom_nav.dart';
import 'package:social_media/utils/palette.dart';
import 'package:social_media/utils/utils.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  Uint8List? _image;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
  }

  selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // resizeToAvoidBottomInset: false,
          body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create Profile",
                style: TextStyle(
                  color: Palette.white,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                            backgroundColor: Colors.red,
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.yellow.shade700,
                            child: const Icon(
                              Icons.person_outline_sharp,
                              color: Palette.black,
                              size: 64,
                            ),
                          ),
                    Positioned(
                      bottom: 0,
                      left: 82,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Palette.black,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                            Palette.darkgrey,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Palette.white),
                      controller: _firstnameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignLabelWithHint: true,
                        label: const Text(
                          "First Name*",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter First Name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Palette.white),
                      controller: _lastnameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignLabelWithHint: true,
                        label: const Text(
                          "Last Name*",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Last Name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Palette.white),
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignLabelWithHint: true,
                        label: const Text(
                          "Username*",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Username";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: _bioController,
                      style: const TextStyle(color: Palette.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignLabelWithHint: true,
                        label: const Text(
                          "Bio",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      maxLength: 200,
                      maxLines: 5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Palette.yellow,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(25),
                        color: Palette.yellow,
                        child: InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              final valid = await AuthClass()
                                  .checkUsername(_usernameController.text);
                              if (!valid) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Username already exists. Try something different'),
                                  ),
                                );
                              } else {
                                String result = await AuthClass().createProfile(
                                  firstname: _firstnameController.text,
                                  lastname: _lastnameController.text,
                                  username: _usernameController.text,
                                  bio: _bioController.text,
                                  file: _image!,
                                );
                                print(result);

                                if (result == "success") {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BottomNavigation()));
                                }
                              }
                            }
                          },
                          splashColor: Palette.white,
                          borderRadius: BorderRadius.circular(25),
                          child: const Center(
                            child: Text(
                              "Let's Begin...",
                              style: TextStyle(
                                color: Palette.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
