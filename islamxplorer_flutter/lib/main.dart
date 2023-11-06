import 'package:flutter/material.dart';
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
    return MaterialApp(
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