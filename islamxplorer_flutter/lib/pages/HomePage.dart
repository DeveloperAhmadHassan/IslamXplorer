import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _firstController;
  late AnimationController _secondController;
  late Animation<double> _firstWidthAnimation;
  late Animation<double> _firstHeightAnimation;
  late Animation<double> _secondWidthAnimation;
  late Animation<double> _secondHeightAnimation;

  @override
  void initState() {
    super.initState();

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
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    String? name;
    var user = FirebaseAuth.instance.currentUser;
    name = user!.email;

    void onTap(){
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
      body: Stack(
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
                Padding(
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
                )
                // CustomText("$name",24),
              ],
            ),
          ),
        ],
      )
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