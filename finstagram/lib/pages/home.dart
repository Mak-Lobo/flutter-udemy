import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'feed.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? width, height;
  FirebaseService? firebaseService;
  int page = 0;
  final List<Widget> pages = [const FeedPage(), const ProfilePage()];

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
      appBar: AppBar(
        title: const Text(
          "Finstagram",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: postImage,
            child: const Icon(
              Icons.add_a_photo_rounded,
            ),
          ),
          GestureDetector(
            onTap: () async {
              await firebaseService!.signOut;
              Navigator.popAndPushNamed(context, "/login");
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width! * 0.025),
              child: const Icon(
                Icons.logout_rounded,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(),
      body: pages[page],
    );
  }

  // bottom navigation bar
  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: page,
      onTap: (index) {
        setState(() {
          page = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.feed_rounded),
          label: "Feed",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box_rounded),
          label: "Profile",
        ),
      ],
    );
  }

  // posting an image
  void postImage() async {
    FilePickerResult? _imageResult =
        await FilePicker.platform.pickFiles(type: FileType.image);

    File pickedImage = File(_imageResult!.files.first.path!);
    // posting the image to firebase
    await firebaseService!.postImageToFirebase(pickedImage);
  }
}
