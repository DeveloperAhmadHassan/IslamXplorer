import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:islamxplorer_flutter/controllers/authController.dart';
import 'package:islamxplorer_flutter/controllers/userDataController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/models/user.dart';
import 'package:islamxplorer_flutter/pages/AdminPanel.dart';
import 'package:islamxplorer_flutter/pages/DuaPage.dart';
import 'package:islamxplorer_flutter/pages/HomePage.dart';
import 'package:islamxplorer_flutter/pages/ProfilePage.dart';
import 'package:islamxplorer_flutter/pages/authPages/SignInPage.dart';
import 'package:islamxplorer_flutter/pages/authPages/SignUpPage.dart';
import 'package:islamxplorer_flutter/pages/homePages/adminPage.dart';
import 'package:islamxplorer_flutter/pages/homePages/userPage.dart';
import 'package:islamxplorer_flutter/pages/onboardingPages/onboarding.dart';
import 'package:islamxplorer_flutter/utils/dataLoaders.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/values/themes/appTheme.dart';
import 'package:islamxplorer_flutter/widgets/custom_tab_bar.dart';
import 'package:islamxplorer_flutter/widgets/nav_bar.dart';
import 'dart:math' as math;
import 'package:flutter_dotenv/flutter_dotenv.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:islamxplorer_flutter/widgets/side_menu.dart';
import 'package:rive/rive.dart' hide LinearGradient;
import 'firebase_options.dart';


Future main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
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
    AuthController authController = AuthController();
    print("${dotenv.env['API_URL']}");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IslamXplorer',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SpinKitCircle(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch1),
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder<AppUser>(
              future: userDataController.getUserData(),
              builder: (BuildContext context, AsyncSnapshot<AppUser> userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: SpinKitCircle(
                        itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch1),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (userSnapshot.hasError) {
                  return Text('Error: ${userSnapshot.error}');
                } else if (userSnapshot.hasData && userSnapshot.data != null) {
                  if (userSnapshot.data!.type == "A") {
                    return AdminPage();
                  } else {
                    return UserPage();
                  }
                } else {
                  return Text('User details not available');
                }
              },
            );
          } else {
            return authController.screenRedirect() ? const OnBoardingScreen() : SignInPage();
          }
        },
      ),
    );
  }
}


