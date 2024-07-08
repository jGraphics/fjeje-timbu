import 'package:flutter/material.dart';
import 'package:fjeje_timbu/constants/bNav.dart';
import 'package:fjeje_timbu/constants/colors.dart';
import 'package:fjeje_timbu/screens/onboardingPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  final List<dynamic> images;
  final List<String> titles, subtitles;

  const OnBoarding(
      {super.key, required this.images, required this.titles, required this.subtitles});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int _currentIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            itemBuilder: (context, index) => OnBoardingPage(
              image: widget.images[index],
              title: widget.titles[index],
              subtitle: widget.subtitles[index],
            ),
            controller: pageController,
            itemCount: widget.titles.length,
            onPageChanged: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          Visibility(
            visible: _currentIndex + 1 == widget.titles.length,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Directionality.of(context) == TextDirection.ltr
                    ? Alignment.bottomRight
                    : Alignment.bottomLeft,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BNavWidget()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: colorPrimary),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Start Shopping',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SmoothPageIndicator(
                controller: pageController,
                count: widget.titles.length,
                effect: const ScrollingDotsEffect(
                    activeDotColor: colorPrimary,
                    dotColor: colorBgW,
                    dotWidth: 8,
                    dotHeight: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
