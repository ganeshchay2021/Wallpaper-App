// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaperapp/Image%20Path/image_path.dart';

import 'package:wallpaperapp/bloc/wapppaper_bloc.dart';
import 'package:wallpaperapp/screens/search%20screen/widget/image_list_view.dart';

class AllWallpaper extends StatefulWidget {
  final String name;
  const AllWallpaper({
    super.key,
    required this.name,
  });

  @override
  State<AllWallpaper> createState() => _AllWallpaperState();
}

class _AllWallpaperState extends State<AllWallpaper> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.name,
          style:
              TextStyle(fontSize: height * 0.025, fontWeight: FontWeight.w700),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: width * 0.024, right: width * 0.024),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.005,
            ),
            Expanded(
              child: BlocBuilder<WallpaperBloc, WallpaperState>(
                builder: (context, state) {
                  if (state is WallpaperLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is WallpaperLoadedState) {
                    if (state.photomodel.isEmpty) {
                      return Center(
                        child: Text(
                          "Results not found",
                          style: TextStyle(
                              fontSize: height * 0.023,
                              fontWeight: FontWeight.w400),
                        ),
                      );
                    }
                    return ImageListView(
                      photoModel: state.photomodel,
                    );
                  } else if (state is WallpaperErrorSate) {
                    return SizedBox(
                      height: height,
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImagePath.wifi,
                            height: height * 0.092,
                          ),
                          Text(
                            "Check your internet connection",
                            style: TextStyle(fontSize: height * 0.017),
                          )
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
