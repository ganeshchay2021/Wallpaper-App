// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wallpaperapp/bloc/wapppaper_bloc.dart';
import 'package:wallpaperapp/repository/repository.dart';
import 'package:wallpaperapp/screens/category%20screen/widgets/all_wallpaper.dart';

class WallpaperCategoryList extends StatelessWidget {
  final String name;
  final String image;

  const WallpaperCategoryList({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => WallpaperBloc(repository: Repository())
                  ..add(
                    WallpaperSearchEvent(searchPhoto: name),
                  ),
                child: AllWallpaper(name: name),
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(
            top: height * 0.0115,
            right: height * 0.023,
            bottom: height * 0.0115,
            left: height * 0.023),
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.048),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              image,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.048),
            color: Colors.black38,
          ),
          alignment: Alignment.center,
          height: height * .20,
          child: Text(
            name,
            style: TextStyle(
              letterSpacing: 2,
              fontSize: height * 0.023,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
