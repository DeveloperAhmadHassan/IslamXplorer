import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamxplorer_flutter/pages/HomePage.dart';
import 'package:islamxplorer_flutter/pages/ProfilePage.dart';
import 'package:islamxplorer_flutter/pages/SearchResultsPage.dart';
import 'package:islamxplorer_flutter/pages/SearchingPage.dart';
import 'package:islamxplorer_flutter/pages/SignInPage.dart';
import 'package:islamxplorer_flutter/pages/SignUpPage.dart';
import 'package:islamxplorer_flutter/widgets/nav_bar.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance
    //     .authStateChanges()
    //     .listen((User? user) {
    //   if (user != null) {
    //     print(user.uid);
    //   }
    // });
    // User? user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   for (final providerProfile in user.providerData) {
    //     // ID of the provider (google.com, apple.com, etc.)
    //     final provider = providerProfile.providerId;
    //     print("Provider: $provider");
    //
    //     // UID specific to the provider
    //     final uid = providerProfile.uid;
    //     print("UID: $uid");
    //
    //     // Name, email address, and profile photo URL
    //     final name = providerProfile.displayName;
    //     print("Name: $name");
    //     final emailAddress = providerProfile.email;
    //     print("email: $emailAddress");
    //     final profilePhoto = providerProfile.photoURL;
    //     print("pp: $profilePhoto");
    //   }
    // }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignInPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage>  {

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: BotNavBar()
    );
  }
}