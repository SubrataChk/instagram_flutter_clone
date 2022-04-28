import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/src/model/user.dart';
import 'package:instagram_flutter_clone/src/provider/user_provider.dart';
import 'package:instagram_flutter_clone/src/utils/color.dart';
import 'package:instagram_flutter_clone/src/widget/follow_button.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    UserModel? users = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mobileBackgroundColor,
        title: Text(users!.username),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10.w,
                      backgroundImage: NetworkImage(users.photoUrl),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildStateDetails(20, "Posts"),
                              buildStateDetails(1203, "Followers"),
                              buildStateDetails(20, "Following"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FollowButton(
                                  backgroundColor: Colors.blue,
                                  textColor: mobileBackgroundColor,
                                  title: "Edit Profile",
                                  borderColor: Colors.grey)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildStateDetails(int num, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.red, fontSize: 14.sp),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontSize: 11.sp),
          ),
        ),
      ],
    );
  }
}
