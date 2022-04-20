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
}
