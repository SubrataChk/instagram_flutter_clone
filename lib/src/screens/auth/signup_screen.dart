import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter_clone/src/screens/auth/login_screen.dart';
import 'package:instagram_flutter_clone/src/screens/home/homepage.dart';
import 'package:instagram_flutter_clone/src/service/auth_method.dart';
import 'package:instagram_flutter_clone/src/utils/color.dart';
import 'package:instagram_flutter_clone/src/utils/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../responsive/layout.dart';
import '../../responsive/mobileScreen.dart';
import '../../responsive/webScreen.dart';
import '../../widget/button.dart';
import '../../widget/text_field.dart';

class SignupPageScreen extends StatefulWidget {
  const SignupPageScreen({Key? key}) : super(key: key);

  @override
  State<SignupPageScreen> createState() => _SignupPageScreenState();
}

class _SignupPageScreenState extends State<SignupPageScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController userName = TextEditingController();
  Uint8List? image;
  bool isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
    bio.dispose();
    userName.dispose();
  }

  //Pick Image
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);

    setState(() {
      image = img;
    });
  }

  void signUp() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethod().signUpUser(
      context: context,
      email: email.text,
      password: password.text,
      userName: userName.text,
      bio: bio.text,
      file: image!,
    );
    if (res != "success") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayoutSection(),
                  webScreenLayout: WebScreenLayoutSection())));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            //Logo
            SvgPicture.asset(
              "assets/logo.svg",
              color: primaryColor,
              width: 40.w,
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.h),
              child: Stack(
                children: [
                  image != null
                      ? CircleAvatar(
                          radius: 15.w, backgroundImage: MemoryImage(image!))
                      : CircleAvatar(
                          radius: 15.w,
                          backgroundImage: NetworkImage(
                              "https://www.koimoi.com/wp-content/new-galleries/2022/03/sonakshi-sinha-breaks-her-silence-on-non-bailable-warrant-against-her-001.jpg"),
                        ),
                  Positioned(
                      bottom: -13,
                      left: 80,
                      child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 6.w,
                            color: Colors.red,
                          )))
                ],
              ),
            ),
            CustomTextFormField(
                controller: userName,
                hintText: "User Name",
                isPass: false,
                textInputType: TextInputType.text,
                icons: Icons.person),

            CustomTextFormField(
                controller: email,
                hintText: "Email",
                isPass: false,
                textInputType: TextInputType.emailAddress,
                icons: CupertinoIcons.mail),
            CustomTextFormField(
                controller: password,
                hintText: "Password",
                isPass: true,
                textInputType: TextInputType.text,
                icons: Icons.vpn_key),

            CustomTextFormField(
                controller: bio,
                hintText: "Bio",
                isPass: false,
                textInputType: TextInputType.text,
                icons: Icons.date_range),

            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  )
                : CustomButton(
                    title: "Create",
                    onTap: () {
                      signUp();
                    }),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have a account?",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPageScreen()));
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.sp),
                    ))
              ],
            )
          ],
        ),
      )),
    );
  }
}
