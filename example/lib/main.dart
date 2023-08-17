import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:xx_vendor/xx_ui/base/base.dart';
import 'package:xx_vendor/xx_util/screen/screen_util.dart';

import 'related_expert_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RelatedExpertPage(),
    );
  }
}






class StretchedIndicator extends StatefulWidget {
  @override
  _StretchedIndicatorState createState() => _StretchedIndicatorState();
}

class _StretchedIndicatorState extends State<StretchedIndicator> with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(_animationController);
    _pageController.addListener(() {
      _onPageViewScroll(_pageController.page!);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onPageViewScroll(double position) {
    setState(() {
      _currentPage = position;
      _animationController.value = _currentPage % 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stretched Indicator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                Center(child: Text('Page 1')),
                Center(child: Text('Page 2')),
                Center(child: Text('Page 3')),
              ],
            ),
          ),
          SizedBox(
            height: 4,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                double width = MediaQuery.of(context).size.width;
                double indicatorWidth = width * (1 - _animationController.value) + 16;
                double indicatorPosition = (_currentPage * width) + (_animationController.value * width * 0.5);
                return Transform.translate(
                  offset: Offset(indicatorPosition, 0),
                  child: Container(
                    width: indicatorWidth,
                    color: Colors.blue,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
