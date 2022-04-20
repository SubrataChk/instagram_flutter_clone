import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_flutter_clone/src/app/app_image.dart';
import 'package:instagram_flutter_clone/src/utils/color.dart';
import 'package:sizer/sizer.dart';

import '../widget/post_card.dart';

class FeedScreenSection extends StatefulWidget {
  const FeedScreenSection({Key? key}) : super(key: key);

  @override
  State<FeedScreenSection> createState() => _FeedScreenSectionState();
}

class _FeedScreenSectionState extends State<FeedScreenSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: SvgPicture.asset(
            AppImage.logo,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.messenger_rounded))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return PostCard(snap: snapshot.data!.docs[index]);
                });
          }
        },
      ),
    );
  }
}
