import 'package:ecommerce_app/auth/login_page.dart';
import 'package:ecommerce_app/home.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  Color setColor = Colors.amber;
  PageController pageController = PageController(initialPage: 0);
  int pageChanged = 0;
  String indicatorNextBtn = 'Next';
  String indicatorSkipBtn = 'Skip';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserId?>(context);
    return Scaffold(
        backgroundColor: setColor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      pageChanged = index;
                      if (pageChanged == 0) {
                        setColor = Colors.redAccent;
                        indicatorNextBtn = 'Next';
                      } else if (pageChanged == 1) {
                        setColor = Colors.orangeAccent;
                        indicatorNextBtn = 'Next';
                      } else {
                        setColor = Color.fromARGB(255, 213, 113, 226);
                        indicatorNextBtn = 'Done';
                      }
                    });
                  },
                  children: [
                    Container(
                        color: setColor,
                        child: Padding(
                          padding: EdgeInsets.all(50),
                          child: Image(image: AssetImage("assets/page1BG.png")),
                        )),
                    Container(
                        color: setColor,
                        child: Padding(
                          padding: EdgeInsets.all(50),
                          child: Image(image: AssetImage("assets/page2BG.png")),
                        )),
                    Container(
                        color: setColor,
                        child: Padding(
                          padding: EdgeInsets.all(50),
                          child: Image(image: AssetImage("assets/page3BG.png")),
                        )),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  pageController.animateToPage(pageChanged = 2,
                                      duration: Duration(milliseconds: 1000),
                                      curve: Curves.easeIn);
                                },
                                child: Text(
                                  indicatorSkipBtn,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              SmoothPageIndicator(
                                controller: pageController,
                                count: 3,
                                effect: JumpingDotEffect(
                                  activeDotColor: setColor,
                                  dotHeight: 12,
                                  dotWidth: 12,
                                  dotColor: Colors.white,
                                  verticalOffset: 10,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  pageController.animateToPage(
                                      pageChanged < 2
                                          ? ++pageChanged
                                          : pageChanged++,
                                      duration: Duration(milliseconds: 250),
                                      curve: Curves.easeIn);
                                  if (pageChanged == 3) {
                                    if (user == null) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                    } else {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    }
                                  }
                                },
                                child: Text(
                                  indicatorNextBtn,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}
