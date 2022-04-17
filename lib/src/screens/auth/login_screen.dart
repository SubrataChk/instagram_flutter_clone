import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter_clone/src/screens/auth/signup_screen.dart';
import 'package:instagram_flutter_clone/src/screens/home/homepage.dart';
import 'package:instagram_flutter_clone/src/utils/color.dart';
import 'package:instagram_flutter_clone/src/widget/text_field.dart';
import 'package:sizer/sizer.dart';

import '../../responsive/layout.dart';
import '../../responsive/mobileScreen.dart';
import '../../responsive/webScreen.dart';
import '../../service/auth_method.dart';
import '../../widget/button.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }

  void logIn() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethod().logInUsers(
      context: context,
      email: email.text,
      password: password.text,
    );
    if (res == "success") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayoutSection(),
                  webScreenLayout: WebScreenLayoutSection())));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
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

            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  )
                : CustomButton(title: "Log In", onTap: logIn),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have a account?",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPageScreen()));
                    },
                    child: Text(
                      "Sign Up",
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
