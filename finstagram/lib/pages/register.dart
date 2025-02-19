import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double? width, height;
  String? email, password, username;
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  File? profileImage;
  FirebaseService? firebaseService;
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width! * 0.1),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Finstagram",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                profilePhoto(),
                registrationForm(),
                registerButton(),
                loginLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //register button
  Widget registerButton() {
    return TextButton(
      onPressed: registerUser,
      child: const Text("Register account"),
    );
  }

  // register function
  void registerUser() async {
    if (registerFormKey.currentState!.validate() && profileImage != null) {
      registerFormKey.currentState!.save();
      bool _registerResult = await firebaseService!.registerUser(
          email: email!,
          password: password!,
          image: profileImage!,
          username: username!);
      if (_registerResult) Navigator.pop(context);
      print(
          "Valid: ${registerFormKey.currentState!.validate()}\nprofileImage: $profileImage");
    }
  }

  // registration form
  Widget registrationForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width! * 0.025),
      height: height! * 0.25,
      child: Form(
        key: registerFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Your name...",
                prefixIcon: Icon(Icons.person_2_rounded),
                border: OutlineInputBorder(),
              ),
              onSaved: (nameData) {
                setState(() {
                  username = nameData;
                });
              },
              validator: (nameValue) {
                if (nameValue!.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter your email",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              onSaved: (emailData) {
                setState(() {
                  email = emailData;
                });
              },
              validator: (emailValue) {
                RegExp emailRegExp =
                    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                // Check if the email field is empty or doesn't match the email pattern
                if (emailValue!.isEmpty || !emailRegExp.hasMatch(emailValue)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter your password",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: (hidePassword)
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility)),
                border: const OutlineInputBorder(),
              ),
              obscureText: hidePassword,
              onSaved: (passwordData) {
                setState(() {
                  password = passwordData;
                });
              },
              validator: (passwordValue) {
                if (passwordValue!.isEmpty || passwordValue.length < 5) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  // profile photo
  Widget profilePhoto() {
    // return CircleAvatar(
    //   radius: width! * 0.125,
    //   backgroundImage: const NetworkImage("https://i.pravatar.cc/300"),
    // );
    return GestureDetector(
      onTap: () {
        FilePicker.platform.pickFiles(type: FileType.image).then((imageResult) {
          setState(() {
            profileImage = File(imageResult!.files.first.path!);
            print(profileImage!.path);
          });
        });
      },
      child: CircleAvatar(
        radius: width! * 0.125,
        backgroundImage: (profileImage == null)
            ? const NetworkImage("https://i.pravatar.cc/300")
            : Image.file(profileImage!).image,
      ),
    );
  }

  // login link
  Widget loginLink() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/login');
      },
      child: const Text(
        "Have an account? Click here to login",
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
