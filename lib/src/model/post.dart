import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String? description;
  final String? username;
  final String? uid;

  final String? postUrl;
  final DateTime? datePublished;

  final String? postId;
  final String? profImage;
  final List? likes;

  PostModel(
      {this.description,
      this.datePublished,
      this.likes,
      this.postId,
      this.postUrl,
      this.profImage,
      this.uid,
      this.username});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "description": description,
        "profImage": profImage,
        "datePublished": datePublished,
        "likes": likes,
        "postUrl": postUrl,
        "postId": postId,
      };

  static PostModel fromJson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
      username: snapshot["username"],
      uid: snapshot["uid"],
      description: snapshot["description"],
      profImage: snapshot["profImage"],
      datePublished: snapshot["datePublished"],
      likes: snapshot["likes"],
      postUrl: snapshot["postUrl"],
      postId: snapshot["postId"],
    );
  }
}
