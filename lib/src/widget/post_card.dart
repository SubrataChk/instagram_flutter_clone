import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/src/animation/like_animation.dart';
import 'package:instagram_flutter_clone/src/model/user.dart';
import 'package:instagram_flutter_clone/src/provider/user_provider.dart';
import 'package:instagram_flutter_clone/src/service/firestore_method.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:instagram_flutter_clone/src/utils/color.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    UserModel? users = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 1.h),
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
                  backgroundImage: NetworkImage(widget.snap["profImage"]),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap["username"],
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                children: ["Delete"]
                                    .map((e) => InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
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
          GestureDetector(
            onDoubleTap: () async {
              await FirestoreMethod().likePost(
                  widget.snap["postId"], users!.uid, widget.snap["likes"]);
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap["postUrl"],
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    child: Icon(
                      Icons.favorite,
                      size: 20.w,
                      color: Colors.red,
                    ),
                    isAnimating: isLikeAnimating,
                    duration: const Duration(milliseconds: 400),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          //!
          Row(
            children: [
              LikeAnimation(
                  isAnimating:
                      widget.snap["likes"].contains(widget.snap["uid"]),
                  // isAnimating: widget.snap["likes"].contains(users!.uid),
                  smallLikes: true,
                  child: IconButton(
                      onPressed: () async {
                        await FirestoreMethod().likePost(widget.snap["postId"],
                            users!.uid, widget.snap["likes"]);
                      },
                      icon: widget.snap["likes"].contains(widget.snap["uid"])
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                            ))),
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
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    "${widget.snap["likes"].length} Likes",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                      text: TextSpan(
                    style: const TextStyle(color: primaryColor),
                    children: [
                      TextSpan(
                          text: "${widget.snap["username"]}",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: " Hello There",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  )),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 1.w),
                    child: Text(
                      widget.snap["description"],
                      style:
                          const TextStyle(fontSize: 16, color: secondaryColor),
                    ),
                  ),
                ),
                Container(
                  // padding: EdgeInsets.symmetric(vertical: 1.w),
                  child: Text(
                    DateFormat.yMMMd()
                        .format(widget.snap["datePublished"].toDate()),
                    style: TextStyle(fontSize: 16, color: secondaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
