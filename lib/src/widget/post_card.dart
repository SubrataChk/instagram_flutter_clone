import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:instagram_flutter_clone/src/utils/color.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              widget.snap["postUrl"],
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
