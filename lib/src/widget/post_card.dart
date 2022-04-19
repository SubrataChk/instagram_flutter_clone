import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:instagram_flutter_clone/src/utils/color.dart';

class PostCard extends StatefulWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 5.w,
                  backgroundColor: Colors.red,
                  // backgroundImage: NetworkImage(""),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "username",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.sp),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                children: ["Delete"]
                                    .map((e) => InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            child: Text(e),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            );
                          });
                    },
                    icon: const Icon(Icons.more_vert))
              ],
            ),
          ),
          //!
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              "https://images.indulgexpress.com/uploads/user/imagelibrary/2020/7/4/original/Tom-Cruise-0-scaled.jpg",
              fit: BoxFit.cover,
            ),
          ),
          //!
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.comment,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                  )),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
              ))
            ],
          )
        ],
      ),
    );
  }
}
