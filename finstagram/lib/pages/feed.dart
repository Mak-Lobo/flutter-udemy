import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<FeedPage> {
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
      height: height,
      width: width,
      child: _postView(),
    );
  }

  // list view for the feed
  Widget _postView() {
    return StreamBuilder<QuerySnapshot>(
        stream: firebaseService!.getPosts(),
        builder:
            (BuildContext postContext, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List _postList =
                snapshot.data!.docs.map((post) => post.data()).toList();
            return ListView.builder(
              itemCount: _postList.length,
              itemBuilder: (BuildContext context, index) {
                Map<String, dynamic> _post = _postList[index];
                return Container(
                  height: height! * 0.3,
                  padding: EdgeInsets.all(height! * 0.01),
                  margin: EdgeInsets.all(height! * 0.01),
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
        });
  }
}
