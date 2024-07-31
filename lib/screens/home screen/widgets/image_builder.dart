import 'package:flutter/material.dart';

class ImageBuilder extends StatelessWidget {
  final String image;
  const ImageBuilder({
    super.key,
    required this.image,
  });


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: height / 1.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width * 0.072),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
