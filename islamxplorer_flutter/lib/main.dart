import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:islamxplorer_flutter/controllers/userDataController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/models/user.dart';
import 'package:islamxplorer_flutter/pages/authPages/SignInPage.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/nav_bar.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FlutterError.onError = (FlutterErrorDetails details) {
  //   FlutterError.dumpErrorToConsole(details);
  //   runApp(ErrorWidgetClass(details));
  // };
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
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: HexColor.fromHexStr(AppColor.primaryThemeSwatch2)
              ),
              child: SpinKitCircle(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch1),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder<AppUser>(
              future: userDataController.getUserData(),
              builder: (BuildContext context, AsyncSnapshot<AppUser> userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: HexColor.fromHexStr(AppColor.primaryThemeSwatch2)
                    ),
                    child: SpinKitCircle(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch1),
                          ),
                        );
                      },
                    ),
                  );
                } else if (userSnapshot.hasError) {
                  return Text('Error: ${userSnapshot.error}');
                } else if (userSnapshot.hasData && userSnapshot.data != null) {
                  if (userSnapshot.data!.type == "A") {
                    return AdminPage();
                  } else {
                    // throw Exception("Error");
                    return UserPage();
                  }
                } else {
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

      // home: AddUpdateDuaPageDummy(),

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