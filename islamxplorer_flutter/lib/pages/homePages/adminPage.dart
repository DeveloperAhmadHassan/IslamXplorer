import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:islamxplorer_flutter/extensions/color.dart';
import 'package:islamxplorer_flutter/pages/AdminPanel.dart';
import 'package:islamxplorer_flutter/pages/HomePage.dart';
import 'package:islamxplorer_flutter/pages/ProfilePage.dart';
import 'package:islamxplorer_flutter/values/colors.dart';
import 'package:islamxplorer_flutter/widgets/custom_tab_bar.dart';
import 'dart:math' as math;


import 'package:islamxplorer_flutter/widgets/side_menu.dart';
import 'package:rive/rive.dart' hide LinearGradient;


class AdminPage extends StatefulWidget {
  int state;
  AdminPage({this.state = 0,super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> with TickerProviderStateMixin {
  late AnimationController? _animationController;
  late AnimationController? _onBoardingAnimController;
  late Animation<double> _onBoardingAnim;
  late Animation<double> _sidebarAnim;

  late SMIBool _menuBtn;

  bool _showOnBoarding = false;
  Widget _tabBody = Container(color: Colors.black);
  int _tabIndex = 0;
  final List<Widget> _screens = [
    AdminPanel(),
    HomePage(),
    ProfilePage(),
    ProfilePage(),
    ProfilePage(),
  ];

  final springDesc = const SpringDescription(
    mass: 0.1,
    stiffness: 40,
    damping: 5,
  );

  void _onMenuIconInit(Artboard artboard) {
    final controller =
    StateMachineController.fromArtboard(artboard, "State Machine");
    artboard.addController(controller!);
    _menuBtn = controller.findInput<bool>("isOpen") as SMIBool;
    _menuBtn.value = true;
  }

  void _presentOnBoarding(bool show) {
    if (show) {
      setState(() {
        _showOnBoarding = true;
      });
      final springAnim = SpringSimulation(springDesc, 0, 1, 0);
      _onBoardingAnimController?.animateWith(springAnim);
    } else {
      _onBoardingAnimController?.reverse().whenComplete(() => {
        setState(() {
          _showOnBoarding = false;
        })
      });
    }
  }

  void onMenuPress() {
    if (_menuBtn.value) {
      final springAnim = SpringSimulation(springDesc, 0, 1, 0);
      _animationController?.animateWith(springAnim);
    } else {
      _animationController?.reverse();
    }
    _menuBtn.change(!_menuBtn.value);

    SystemChrome.setSystemUIOverlayStyle(_menuBtn.value
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light);
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: HexColor.fromHexStr(AppColor.primaryThemeSwatch2),
        systemNavigationBarContrastEnforced: false
    ));
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      upperBound: 1,
      vsync: this,
    );
    _onBoardingAnimController = AnimationController(
      duration: const Duration(milliseconds: 350),
      upperBound: 1,
      vsync: this,
    );

    _sidebarAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.linear,
    ));

    _onBoardingAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _onBoardingAnimController!,
      curve: Curves.linear,
    ));

    _tabBody = _screens.first;
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _onBoardingAnimController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned(child: Container(color: HexColor.fromHexStr(AppColor.secondaryThemeSwatch3))),
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _sidebarAnim,
              builder: (BuildContext context, Widget? child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(((1 - _sidebarAnim.value) * -30) * math.pi / 180)
                    ..translate((1 - _sidebarAnim.value) * -300),
                  child: child,
                );
              },
              child: FadeTransition(
                opacity: _sidebarAnim,
                child: const SideMenu(),
              ),
            ),
          ),
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _showOnBoarding ? _onBoardingAnim : _sidebarAnim,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1 -
                      (_showOnBoarding
                          ? _onBoardingAnim.value * 0.08
                          : _sidebarAnim.value * 0.1),
                  child: Transform.translate(
                    offset: Offset(_sidebarAnim.value * 265, 0),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY((_sidebarAnim.value * 30) * math.pi / 180),
                      child: child,
                    ),
                  ),
                );
              },
              child: _tabBody,
            ),
          ),
          AnimatedBuilder(
            animation: _sidebarAnim,
            builder: (context, child) {
              return Positioned(
                top: MediaQuery.of(context).padding.top + 20,
                right: (_sidebarAnim.value * -100) + 16,
                child: child!,
              );
            },
            child: _tabIndex != 2 ? GestureDetector(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: const Icon(Icons.person_outline),
                ),
              ),
              onTap: () {

              },
            ) : Container() ,
          ),
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _sidebarAnim,
              builder: (context, child) {
                return SafeArea(
                  child: Row(
                    children: [
                      SizedBox(width: _sidebarAnim.value * 216),
                      child!,
                    ],
                  ),
                );
              },
              child: GestureDetector(
                onTap: onMenuPress,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    width: 44,
                    height: 44,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(44 / 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: RiveAnimation.asset(
                      'assets/menu_button.riv',
                      stateMachines: const ["State Machine"],
                      animations: const ["open", "close"],
                      onInit: _onMenuIconInit,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_showOnBoarding)
            RepaintBoundary(
              child: AnimatedBuilder(
                animation: _onBoardingAnim,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                        0,
                        -(MediaQuery.of(context).size.height +
                            MediaQuery.of(context).padding.bottom) *
                            (1 - _onBoardingAnim.value)),
                    child: child!,
                  );
                },
                child: SafeArea(
                  top: false,
                  maintainBottomViewPadding: true,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom + 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 40,
                            offset: const Offset(0, 40))
                      ],
                    ),
                    // child: OnBoardingView(
                    //   closeModal: () {
                    //     _presentOnBoarding(false);
                    //   },
                    // ),
                  ),
                ),
              ),
            ),
          // White underlay behind the bottom tab bar
          // IgnorePointer(
          //   ignoring: true,
          //   child: Align(
          //     alignment: Alignment.bottomCenter,
          //     child: AnimatedBuilder(
          //         animation: !_showOnBoarding ? _sidebarAnim : _onBoardingAnim,
          //         builder: (context, child) {
          //           return Container(
          //             height: 50,
          //             decoration: BoxDecoration(
          //               gradient: LinearGradient(
          //                 colors: [
          //                   Colors.black.withOpacity(0),
          //                   Colors.black.withOpacity(0.3 -
          //                       (!_showOnBoarding
          //                           ? _sidebarAnim.value
          //                           : _onBoardingAnim.value))
          //                 ],
          //                 begin: Alignment.topCenter,
          //                 end: Alignment.bottomCenter,
          //               ),
          //             ),
          //           );
          //         }),
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: RepaintBoundary(
        child: AnimatedBuilder(
          animation: !_showOnBoarding ? _sidebarAnim : _onBoardingAnim,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                  0,
                  !_showOnBoarding
                      ? _sidebarAnim.value * 300
                      : _onBoardingAnim.value * 200),
              child: child,
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomTabBar(
                onTabChange: (tabIndex) {
                  setState(() {
                    _tabBody = _screens[tabIndex];
                    _tabIndex = tabIndex;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}