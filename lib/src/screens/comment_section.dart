import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/src/utils/color.dart';
import 'package:sizer/sizer.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({Key? key}) : super(key: key);

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  Widget build(BuildContext context) {
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
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1650551656846-76f0eb35afee?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Comment as username",
                      border: InputBorder.none),
                ),
              )),
              InkWell(
                onTap: () {},
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
