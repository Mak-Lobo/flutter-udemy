import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Map? currentUser;

  // Empty constructor for the FirebaseService class
  FirebaseService();

  // Logs in a user with the given email and password
  Future<bool> loginUser(
      {required String email, required String password}) async {
    try {
      // Sign in with email and password
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Check if the user is not null
      if (userCred.user != null) {
        currentUser = await getUserData();
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      // Print the error message
      print(e.message);
      return false;
    }
  }

  // Gets the user data from the Firestore
  Future<Map> getUserData() async {
    // Get the user data document from the Firestore
    final userDataRef = _db.collection("Users").doc(_auth.currentUser!.uid);
    final userData = (await userDataRef.get()).data() as Map<String, dynamic>;

    // Return the user data
    return userData;
  }

  // user registration
  Future<bool> registerUser(
      {required String email,
      required String password,
      required File image,
      required String username}) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String userID = userCred.user!.uid;
      String imageName = Timestamp.now().millisecondsSinceEpoch.toString() +
          path.extension(image.path);

      // Upload the image to Firebase Storage
      UploadTask uploadTask =
          _storage.ref('images/$userID/$imageName').putFile(image);
      TaskSnapshot snap = await uploadTask; // Wait for the upload to complete
      String downloadURL =
          await snap.ref.getDownloadURL(); // Get the download URL

      await _db.collection("Users").doc(userID).set({
        "name": username,
        "email": email,
        "image": downloadURL,
      });
      print("User data saved to Firestore");

      return true;
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.message}");
      return false;
    } on FirebaseException catch (e) {
      print("Firebase Error: ${e.message}");
      return false;
    } catch (e) {
      print("General Error: $e");
      return false;
    }
  }

  // posting image
  Future<bool> postImageToFirebase(File image) async {
    try {
      // Post image to Firebase Storage and return true if successful
      String userID = _auth.currentUser!.uid;
      String imageName = Timestamp.now().millisecondsSinceEpoch.toString() +
          path.extension(image.path);
      UploadTask uploadTask =
          _storage.ref('images/$userID/$imageName').putFile(image);
      TaskSnapshot snap = await uploadTask;
      String downloadURL = await snap.ref.getDownloadURL();

      // posting to database
      await _db.collection("Posts").doc().set({
        "image": downloadURL,
        "userID": userID,
        "timestamp": Timestamp.now(),
      });

      return true;
    } on FirebaseException catch (e) {
      print("Firebase Error: ${e.message}");
      return false;
    }
  }

  // filling profile page
  Stream<QuerySnapshot> getUserPosts() {
    return _db
        .collection("Posts")
        .where("userID", isEqualTo: _auth.currentUser!.uid)
        .snapshots();
  }

//filling the Feed page
  Stream<QuerySnapshot> getPosts() {
    return _db
        .collection("Posts")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Future<void> signOut() async => await _auth.signOut(); // Sign out the user>
}
