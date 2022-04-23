import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/src/model/user.dart';
import 'package:instagram_flutter_clone/src/provider/user_provider.dart';
import 'package:instagram_flutter_clone/src/screens/comment/comment_card.dart';
import 'package:instagram_flutter_clone/src/service/auth_method.dart';
import 'package:instagram_flutter_clone/src/service/firestore_method.dart';
import 'package:instagram_flutter_clone/src/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CommentSection extends StatefulWidget {
  final snap;
  const CommentSection({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  TextEditingController text = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    text.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? users = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text("Comment"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: CommentCard(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(users!.photoUrl),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: TextFormField(
                  controller: text,
                  decoration: InputDecoration(
                      hintText: "Comment as ${users.username}",
                      border: InputBorder.none),
                ),
              )),
              InkWell(
                onTap: () async {
                  await FirestoreMethod().postComment(widget.snap["postId"],
                      text.text, users.uid, users.photoUrl, users.username);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Text(
                    "Post",
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
