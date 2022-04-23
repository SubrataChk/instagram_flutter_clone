import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
                "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQynIAJReBEhr6FGTQHQkIo0jmfWLY07G0J7qMOUQow9hBHf-Ad"),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "username",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "Some Description",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      "date",
                      style: TextStyle(
                          fontSize: 11.sp, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
          )
        ],
      ),
    );
  }
}
