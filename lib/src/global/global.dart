import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/src/screen/add_post.dart';
import 'package:instagram_flutter_clone/src/screens/feed_screen.dart';
import 'package:instagram_flutter_clone/src/screens/profile/profile_screen.dart';
import 'package:instagram_flutter_clone/src/screens/search/search.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
List<Widget> homeScreenItems = [
  FeedScreenSection(),
  SearchSection(),
  AddPostPage(),
  Text("Feed"),
  ProfileScreen(
    uid: firebaseAuth.currentUser!.uid,
  ),
];
