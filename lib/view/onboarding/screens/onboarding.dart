import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/view/Authentication/get_started_view.dart';
import '../data/data.dart';
import '../custom/custom_bg.dart';
import '../widgets/item_card.dart';
import '../widgets/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onFinish;

  const OnboardingScreen({Key? key, required this.onFinish}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<Color> myColors = [
    const Color.fromARGB(255, 252, 252, 246),
    const Color.fromARGB(255, 252, 252, 246),
    const Color.fromARGB(255, 252, 252, 246),
    const Color.fromARGB(255, 252, 252, 246)
  ];

  late PageController pageController;
  late int selectedIndex;
  late double pageValue;

  @override
  void initState() {
    selectedIndex = 0;
    pageValue = 0.0;
    pageController =
        PageController(initialPage: selectedIndex, viewportFraction: 1.0)
          ..addListener(() {
            setState(() {
              pageValue = pageController.page!;
            });
          });
    super.initState();
  }

  // Method to mark onboarding as completed
  Future<void> _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    widget.onFinish(); // Trigger the callback after onboarding completion
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 246),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        color: myColors[selectedIndex].withOpacity(0.4),
        child: Stack(
          alignment: Alignment.topLeft,
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            pageValue < 1.001
                ? Positioned(
                    left: 320 - (pageValue * 300),
                    top: 450 - (pageValue * 400),
                    child: blackBall(20 + pageValue * 20),
                  )
                : pageValue < 1.003
                    ?

                    /// big ball in top left
                    Positioned(
                        left: 20,
                        top: 50,
                        child: blackBall(40),
                      )
                    :

                    /// small ball in right
                    Positioned(
                        left: 20 + ((pageValue - 1) * 300),
                        top: 50 + ((pageValue - 1) * 100),
                        child: blackBall(40 - ((pageValue - 1) * 10)),
                      ),

            // THE BACKGROUND TUBE SHAPE IN GREEN COLOR
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
              left: pageValue * -w,
              top: 0,
              child: Container(
                height: h,
                width: w * 3,
                decoration: const BoxDecoration(),
                child: CustomPaint(
                  painter: OnBoardingBackground(),
                ),
              ),
            ),

            // BALL TWO BLACK but it will go above the green background tube from page 1 to 2
            // then it will disappear
            pageValue < 1.001

                /// small ball in center left
                ? Positioned(
                    left: 320 - (pageValue * 300),
                    top: 450 - (pageValue * 400),
                    child: blackBall(20 + pageValue * 20),
                  )
                : const SizedBox.shrink(),

            /// tube in first page center left
            Positioned(
              left: -35,
              top: 350,
              child: AbsorbPointer(
                child: Transform.rotate(
                    angle: -1 * pi * pageValue,
                    alignment: Alignment.center,
                    child: ClipPath(
                      clipper: TubePath(),
                      child: AnimatedContainer(
                        height: 100,
                        width: 100,
                        alignment: Alignment.topRight,
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                      ),
                    )),
              ),
            ),

            Positioned(
              height: h * 0.85,
              width: w,
              child: Center(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 3,
                  controller: pageController,
                  onPageChanged: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: ItemCard(
                        item: items[index],
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              width: w,
              bottom: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedOpacity(
                      opacity: pageValue >= 1.8 ? 0 : 1,
                      duration: const Duration(milliseconds: 400),
                      child: InkWell(
                        onTap: () {
                          pageController.animateToPage(2,
                              duration: Duration(
                                  milliseconds:
                                      selectedIndex == 0 ? 1500 : 600),
                              curve: Curves.easeIn);
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                              color: TColors.black,
                              fontSize: Responsive.fontSize(context, 0.04)),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (pageValue < 2.0) {
                          pageController.nextPage(
                              duration: const Duration(seconds: 1),
                              curve: Curves.ease);
                        } else {
                          _completeOnboarding(); // Save onboarding completion and call the finish callback
                          Navigator.of(context).pushReplacement(
                              CupertinoPageRoute(builder: (ctx) {
                            return GetStartedView();
                          }));
                        }
                      },
                      child: AnimatedCrossFade(
                        duration: const Duration(milliseconds: 500),
                        crossFadeState: pageValue < 2.0
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        firstChild: Center(
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: Responsive.fontSize(context, 0.05),
                            color: Colors.black,
                          ),
                        ),
                        secondChild: Center(
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 0.05),
                              color: TColors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
