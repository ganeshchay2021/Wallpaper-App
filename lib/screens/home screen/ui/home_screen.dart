import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wallpaperapp/Image%20Path/image_path.dart';
import 'package:wallpaperapp/screens/home%20screen/widgets/image_builder.dart';
import 'package:wallpaperapp/screens/home%20screen/widgets/indicator_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<String> images = [ImagePath.image1, ImagePath.image2, ImagePath.image3];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          top: height * 0.069,
          left: width * 0.048,
          right: width * 0.048,
        ),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.023,
            ),
            Text(
              "Wallify",
              style: TextStyle(
                fontSize: height * .028,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: height * 0.034,
            ),
            CarouselSlider(
              items: images.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return ImageBuilder(image: image);
                  },
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                height: height / 1.5,
                enlargeCenterPage: true,
                viewportFraction: 1,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
            ),
            SizedBox(
              height: height * 0.023,
            ),
            IndicatorBuilder(
                selectedIndex: selectedIndex, count: images.length),
          ],
        ),
      ),
    );
  }
}
