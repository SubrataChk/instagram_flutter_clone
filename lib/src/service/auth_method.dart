import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/src/model/user.dart' as model;
import 'package:instagram_flutter_clone/src/service/storage_method.dart';

class AuthMethod {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<model.UserModel> getUserDetails() async {
    User? currentUser = _firebaseAuth.currentUser;

    DocumentSnapshot snap =
        await firebaseFirestore.collection("users").doc(currentUser!.uid).get();

    return model.UserModel.fromJson(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String userName,
    required String bio,
    required BuildContext context,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        UserCredential userCredential = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        // //Upload Image:
        String photoUrl =
            await StorageMethod().uploadImage("profileImage", file, false);

        //User Model
        model.UserModel user = model.UserModel(
            bio: bio,
            email: email,
            uid: userCredential.user!.uid,
            followers: [],
            username: userName,
            following: [],
            photoUrl: photoUrl);
        //Add user Data
        await firebaseFirestore
            .collection("users")
            .doc(userCredential.user!.uid)
            .set(user.toJson());
        res = "Success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("The password provided is too weak.")));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Email already use!")));
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Login:
  Future<String> logInUsers({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // ignore: unused_local_variable
        UserCredential userCredential = await _firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password);

        res = "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("There is no user on this email")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Wrong password provided for that user.")));
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}

// 