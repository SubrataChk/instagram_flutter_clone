import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/src/provider/user_provider.dart';
import 'package:instagram_flutter_clone/src/responsive/layout.dart';
import 'package:instagram_flutter_clone/src/responsive/mobileScreen.dart';
import 'package:instagram_flutter_clone/src/responsive/webScreen.dart';
import 'package:instagram_flutter_clone/src/screens/auth/login_screen.dart';
import 'package:instagram_flutter_clone/src/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyBSYdz6JYGM-bJEmC26SKwl_N3s8ExCKJQ",
      appId: "1:18594827998:web:17950f67d8e7f7b4bf3c4f",
      messagingSenderId: "18594827998",
      projectId: "instagram-clone-b7c11",
      storageBucket: "instagram-clone-b7c11.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

//! 3:45

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Instagram Clone',
            theme: ThemeData.dark()
                .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return const ResponsiveLayout(
                        mobileScreenLayout: MobileScreenLayoutSection(),
                        webScreenLayout: WebScreenLayoutSection());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  );
                }
                return const LoginPageScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
