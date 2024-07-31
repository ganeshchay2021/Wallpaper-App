import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IndicatorBuilder extends StatelessWidget {
  final int selectedIndex;
  final int count;

  const IndicatorBuilder({
    super.key,
    required this.selectedIndex,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return AnimatedSmoothIndicator(
      activeIndex: selectedIndex,
      count: count,
      effect: WormEffect(radius: height*0.018, activeDotColor: Colors.blue),
    );
  }
}
