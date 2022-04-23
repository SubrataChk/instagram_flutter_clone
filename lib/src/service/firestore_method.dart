import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/src/model/post.dart';
import 'package:instagram_flutter_clone/src/service/storage_method.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethod {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> uploadPost(BuildContext context, String description,
      Uint8List file, String uid, String userName, String profImage) async {
    String res = "Some error occurred";
    try {
      String photoUrl = await StorageMethod().uploadImage("posts", file, true);
      String postId = const Uuid().v1();
      PostModel postModel = PostModel(
          description: description,
          uid: uid,
          username: userName,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          postId: postId,
          likes: []);
      _firebaseFirestore
          .collection("posts")
          .doc(postId)
          .set(postModel.toJson());

      res = "success";
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    } catch (e) {
      res = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firebaseFirestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayRemove([uid])
        });
      } else {
        await _firebaseFirestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComment(String postID, String text, String uid,
      String profImg, String name) async {
    try {
      if (text.isNotEmpty) {
        String commentID = const Uuid().v1();
        await _firebaseFirestore
            .collection("posts")
            .doc(postID)
            .collection("comment")
            .doc(commentID)
            .set({
          "profImg": profImg,
          "name": name,
          "uid": uid,
          "text": text,
          "commentID": commentID,
          "datePublished": DateTime.now()
        });
      } else {
        print("Text is empty");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
