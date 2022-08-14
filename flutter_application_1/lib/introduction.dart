import 'package:flutter/material.dart';
import 'package:flutter_application_1/intropages/page1.dart';
import 'package:flutter_application_1/intropages/page2.dart';
import 'package:flutter_application_1/intropages/page3.dart';
import 'package:flutter_application_1/pages/loginpage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class introduction extends StatefulWidget {
  const introduction({Key? key}) : super(key: key);

  @override
  State<introduction> createState() => _introductionState();
}

class _introductionState extends State<introduction> {
  bool islastpage = false;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          onPageChanged: (index) {
            setState(() {
              islastpage = (index == 2);
            });
          },
          controller: controller,
          children: const [
            page1(),
            page2(),
            page3(),
          ],
        ),
        Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.jumpToPage(2);
                  },
                  child: const Text("skip"),
                ),
                SmoothPageIndicator(controller: controller, count: 3),
                islastpage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(PageTransition(
                              type: PageTransitionType.fade,
                              child: const loginpage()));
                        },
                        child: const Text("done"))
                    : GestureDetector(
                        onTap: () {
                          controller.nextPage(
                              duration: const Duration(microseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: const Text("next"))
              ],
            ))
      ],
    ));
  }
}
