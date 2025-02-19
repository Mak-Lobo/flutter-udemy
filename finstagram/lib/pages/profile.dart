import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';

import '../services/firebase_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseService? firebaseService;
  double? width, height;

  @override
  void initState() {
    super.initState();
    firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width! * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          profilePhoto(),
          postView(),
        ],
      ),
    );
  }

// profile photo
  Widget profilePhoto() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(width! * 0.05),
        child: CircleAvatar(
          radius: width! * 0.15,
          backgroundImage: NetworkImage(firebaseService!.currentUser!['image']),
        ),
      ),
    );
  }

  // user posts
  Widget postView() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: firebaseService!.getUserPosts(),
        builder:
            (BuildContext postContext, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List _postList =
                snapshot.data!.docs.map((post) => post.data()).toList();
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 2, crossAxisSpacing: 2),
              itemCount: _postList.length,
              itemBuilder: (BuildContext context, index) {
                Map<String, dynamic> _post = _postList[index];
                return Container(
                  margin: EdgeInsets.all(height! * 0.0005),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(_post['image']),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: SpinKitPulse(
                color: Colors.white,
                size: 50.0,
              ),
            );
          }
        },
      ),
    );
  }
}
