import 'package:flutter/material.dart';
import 'package:wallpaperapp/Image%20Path/image_path.dart';
import 'package:wallpaperapp/screens/category%20screen/widgets/wallpaper_category_list.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    List<Map<String, dynamic>> categoryName = [
      {
        "wildlife": {"name": "Wildlife", "image": ImagePath.wildlife}
      },
      {
        "food": {"name": "Food", "image": ImagePath.food}
      },
      {
        "nature": {"name": "Nature", "image": ImagePath.nature}
      },
      {
        "city": {"name": "City", "image": ImagePath.city}
      },
    ];

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: height * 0.057),
        child: Column(
          children: [
            // This is header text part
            Center(
              child: Text(
                "Catrgories",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.032,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: ListView.builder(
                  itemCount: categoryName.length,
                  itemBuilder: (context, index) {
                    final key = categoryName[index].keys.first;
                    final name = categoryName[index][key]['name'];
                    final image = categoryName[index][key]['image'];
                    return WallpaperCategoryList(name: name, image: image);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
