import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamxplorer_flutter/controllers/authController.dart';
import 'package:islamxplorer_flutter/controllers/userDataController.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/models/user.dart';
import 'package:islamxplorer_flutter/pages/SearchingPage.dart';
import 'package:islamxplorer_flutter/qiblah/QiblaPage.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/searchBarWidgets/dummy_search_bar.dart';
import 'package:islamxplorer_flutter/widgets/logoWidgets/primary_logo.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _firstController;
  late AnimationController _secondController;
  late Animation<double> _firstWidthAnimation;
  late Animation<double> _firstHeightAnimation;
  late Animation<double> _secondWidthAnimation;
  late Animation<double> _secondHeightAnimation;

  AppUser? appUser;

  AppLifecycleState? _notification;

  bool _isAnonymous = true; // Default value until appUser is fetched

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_isAnonymous) {
      switch (state) {
        case AppLifecycleState.resumed:
          print("app in resumed");
          break;
        case AppLifecycleState.inactive:
          AuthController authController = AuthController();
          authController.signOut(context);
          print("app in inactive");
          break;
        case AppLifecycleState.paused:
          AuthController authController = AuthController();
          authController.signOut(context);
          print("app in paused");
          break;
        case AppLifecycleState.detached:
          print("app in detached");
          break;
        case AppLifecycleState.hidden:
          AuthController authController = AuthController();
          authController.signOut(context);
          print("app in hidden");
          break;
      }
    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    getUserData();

    _firstController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _secondController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _firstWidthAnimation = Tween<double>(begin: 0, end: 400).animate(_firstController);
    _firstHeightAnimation = Tween<double>(begin: 0, end: 400).animate(_firstController);

    _secondWidthAnimation = Tween<double>(begin: 0, end: 400).animate(_secondController);
    _secondHeightAnimation = Tween<double>(begin: 0, end: 400).animate(_secondController);

    _firstController.forward();

    Future.delayed(const Duration(milliseconds: 100), () {
      _secondController.forward();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    String? name;
    var user = FirebaseAuth.instance.currentUser;
    name = user!.email;

    void onTap() {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchingPage()));
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black.withOpacity(0.0002)
        ),
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            bool isAnonymous = snapshot.data?.isAnonymous ?? true;
            if (snapshot.hasData) {
              _isAnonymous = (snapshot.data as AppUser).isAnonymous;
            }
            return Stack(
              children: [
                Positioned(
                  top: -150,
                  right: -250,
                  child: AnimatedBuilder(
                    animation: _firstController,
                    builder: (context, child) {
                      return Container(
                        width: _firstWidthAnimation.value,
                        height: _firstHeightAnimation.value,
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(400),
                            color: Theme.of(context).colorScheme.primaryContainer
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 100,
                  right: -300,
                  child: AnimatedBuilder(
                      animation: _secondController,
                      builder: (context, child){
                        return Container(
                          width: _secondWidthAnimation.value,
                          height: _secondHeightAnimation.value,
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(400),
                              color: Theme.of(context).colorScheme.primaryContainer
                          ),
                        );
                      }
                  ),
                ),
                Positioned(
                  top: 500,
                  left: -230,
                  child: AnimatedBuilder(
                      animation: _firstController,
                      builder: (context, child){
                        return Container(
                          width: _firstWidthAnimation.value,
                          height: _firstHeightAnimation.value,
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(400),
                              color: Theme.of(context).colorScheme.primaryContainer
                          ),
                        );
                      }
                  ),
                ),
                Positioned(
                  bottom: -240,
                  left: -100,
                  child: AnimatedBuilder(
                      animation: _secondController,
                      builder: (context, child){
                        return Container(
                          width: _secondWidthAnimation.value,
                          height: _secondHeightAnimation.value,
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(400),
                              color: Theme.of(context).colorScheme.primaryContainer
                          ),
                        );
                      }

                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const PrimaryLogo(),
                      DummySearchBar(),
                      if (!isAnonymous) // Using isAnonymous boolean
                        const FeatureItemList(),
                      // CustomText("$name",24),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<AppUser> getUserData() async {
    UserDataController userDataController = UserDataController();
    return await userDataController.getUserData();
  }


}

class FeatureItemList extends StatelessWidget {
  const FeatureItemList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        scrollDirection:Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FeatureItem(),
            const SizedBox(width: 20,),
            FeatureItem(),
            const SizedBox(width: 20,),
            FeatureItem(),
            const SizedBox(width: 20,),
            FeatureItem(),
            const SizedBox(width: 20,),
            FeatureItem(),
            const SizedBox(width: 20,),
            FeatureItem(),
            const SizedBox(width: 20,),
          ],
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget{
  Icon icon;
  Color color;
  FeatureItem({
    super.key,
    this.icon = const Icon(LineAwesomeIcons.compass, size: 40),
    this.color = Colors.white60
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 70,
        height:70,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: icon,
      ),
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const QiblahPage())),
    );
  }

}