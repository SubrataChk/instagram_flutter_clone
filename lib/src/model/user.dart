import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String username;
  final String uid;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;

  UserModel(
      {required this.bio,
      required this.email,
      required this.followers,
      required this.following,
      required this.uid,
      required this.photoUrl,
      required this.username});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "bio": bio,
        "followers": followers,
        "following": following,
        "photoUrl": photoUrl,
      };

  static UserModel fromJson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        bio: snapshot["bio"],
        email: snapshot["email"],
        followers: snapshot["followers"],
        following: snapshot["following"],
        uid: snapshot["uid"],
        photoUrl: snapshot["photoUrl"],
        username: snapshot["username"]);
  }
}
