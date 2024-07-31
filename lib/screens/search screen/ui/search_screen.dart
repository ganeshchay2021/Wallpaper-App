import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaperapp/Image%20Path/image_path.dart';
import 'package:wallpaperapp/bloc/wapppaper_bloc.dart';

import 'package:wallpaperapp/screens/search%20screen/widget/image_list_view.dart';
import 'package:wallpaperapp/screens/search%20screen/widget/search_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
            top: height * 0.057, left: width * 0.048, right: width * 0.048),
        child: Column(
          children: [
            Center(
              child: Text(
                "Search",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.032,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.023,
            ),
            SearchTextField(controller: controller),
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
                      return Text(
                        "Results not found",
                        style: TextStyle(
                            fontSize: height * 0.023,
                            fontWeight: FontWeight.w400),
                      );
                    }
                    return ImageListView(
                      photoModel: state.photomodel,
                    );
                  } else if (state is WallpaperErrorSate) {
                    return Center(
                        child: SizedBox(
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
                    ));
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
