import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamxplorer_flutter/Controllers/userDataController.dart';
import 'package:islamxplorer_flutter/models/user.dart';
import 'package:islamxplorer_flutter/pages/DuaPage.dart';
import 'package:islamxplorer_flutter/pages/HomePage.dart';
import 'package:islamxplorer_flutter/pages/NewPage.dart';
import 'package:islamxplorer_flutter/pages/ProfilePage.dart';
import 'package:islamxplorer_flutter/pages/SearchItemPage.dart';
import 'package:islamxplorer_flutter/pages/SearchResultsPage.dart';
import 'package:islamxplorer_flutter/pages/SearchingPage.dart';
import 'package:islamxplorer_flutter/pages/SignInPage.dart';
import 'package:islamxplorer_flutter/pages/SignUpPage.dart';
import 'package:islamxplorer_flutter/qiblah/qiblah_widget.dart';
import 'package:islamxplorer_flutter/qiblah/QiblaPage.dart';
import 'package:islamxplorer_flutter/widgets/dummy_search_bar.dart';
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
    UserDataController userDataController = UserDataController();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IslamXplorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator if the authentication state is still loading
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle error if necessary
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data != null) {
            // User is signed in, fetch user details
            return FutureBuilder<AppUser>(
              future: userDataController.getUserData(),
              builder: (BuildContext context, AsyncSnapshot<AppUser> userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator if user details are still loading
                  return CircularProgressIndicator();
                } else if (userSnapshot.hasError) {
                  // Handle error if necessary
                  return Text('Error: ${userSnapshot.error}');
                } else if (userSnapshot.hasData && userSnapshot.data != null) {
                  // Check user type and navigate accordingly
                  if (userSnapshot.data!.type == "A") {
                    return AdminPage(); // Replace with the actual AdminPage widget
                  } else {
                    return UserPage(); // Replace with the actual UserPage widget
                  }
                } else {
                  // Handle the case when user details are not available
                  return Text('User details not available');
                }
              },
            );
          } else {
            // User is not signed in, navigate to SignInPage
            return SignInPage(); // Replace with the actual SignInPage widget
          }
        },
      ),

    );
  }
}

class UserPage extends StatefulWidget {
  int state;
  UserPage({this.state = 0,super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>  {

  @override
  Widget build(BuildContext context) {
    print('User Page');
    return SizedBox(
      child: BotNavBar(state: widget.state)
    );
  }
}


class AdminPage extends StatefulWidget {
  int state;
  AdminPage({this.state = 0,super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage>  {

  @override
  Widget build(BuildContext context) {
    print('Admin Page');
    return SizedBox(
        child: BotNavBar(state: widget.state, type: "A")
    );
  }
}