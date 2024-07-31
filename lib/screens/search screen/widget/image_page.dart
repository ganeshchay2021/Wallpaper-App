// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';
import 'package:motion_toast/motion_toast.dart';

class ImagePage extends StatelessWidget {
  final String imageUrl;
  const ImagePage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: imageUrl,
            child: SizedBox(
              height: height,
              width: width,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: imageProvider),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setWallPaper(context, imageUrl);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white54, width: 2)),
                    height: height * 0.050,
                    width: width / 1.7,
                    child: Text(
                      "Apply",
                      style: TextStyle(
                          color: Colors.white, fontSize: height * 0.020),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.040),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: height * 0.050,
                        width: width / 2.7,
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: height * 0.020,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        saveImage(height, context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(width: 2, color: Colors.white54),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        height: height * 0.050,
                        width: width / 2.7,
                        child: Text(
                          "Save image",
                          style: TextStyle(
                            fontSize: height * 0.020,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.025),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveImage(double height, context) async {
    try {
      var response = await Dio().get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );
      final result =
          await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
      if (result['isSuccess']) {
        MotionToast.success(
          position: MotionToastPosition.bottom,
          toastDuration: const Duration(seconds: 1),
          animationCurve: Curves.easeInOutSine,
          iconSize: height * 0.046,
          height: 50,
          width: MediaQuery.of(context).size.width / 1.5,
          description: Text(
            "Image saved",
            style: TextStyle(color: Colors.white54, fontSize: height * 0.023),
          ),
        ).show(context);
      } else {
        MotionToast.error(
          position: MotionToastPosition.bottom,
          toastDuration: const Duration(seconds: 1),
          animationCurve: Curves.easeInOutSine,
          iconSize: height * 0.046,
          height: 50,
          width: MediaQuery.of(context).size.width / 1.5,
          description: Text(
            "Unable to save",
            style: TextStyle(color: Colors.white54, fontSize: height * 0.023),
          ),
        ).show(context);
      }
    } catch (e) {
      MotionToast.success(
        position: MotionToastPosition.bottom,
        toastDuration: const Duration(seconds: 1),
        animationCurve: Curves.easeInOutSine,
        iconSize: height * 0.046,
        height: 50,
        width: MediaQuery.of(context).size.width / 1.5,
        description: Text(
          "Error in saving",
          style: TextStyle(color: Colors.white54, fontSize: height * 0.023),
        ),
      ).show(context);
    }
  }

  Future<void> setWallPaper(BuildContext ctx, String imageUrl) async {
    try {
      var file = await DefaultCacheManager().getSingleFile(imageUrl);
      int location = WallpaperManager.HOME_SCREEN;
      bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      if (result) {
        MotionToast.success(
          position: MotionToastPosition.center,
          toastDuration: const Duration(seconds: 1),
          animationCurve: Curves.easeInOutSine,
          iconSize: MediaQuery.of(ctx).size.height * 0.046,
          height: 50,
          width: MediaQuery.of(ctx).size.width / 1.5,
          description: Text(
            "Applied",
            style: TextStyle(
                color: Colors.white54,
                fontSize: MediaQuery.of(ctx).size.height * 0.023),
          ),
        ).show(ctx);
      } else {
        MotionToast.error(
          position: MotionToastPosition.center,
          toastDuration: const Duration(seconds: 1),
          animationCurve: Curves.easeInOutSine,
          iconSize: MediaQuery.of(ctx).size.height * 0.046,
          height: 50,
          width: MediaQuery.of(ctx).size.width / 1.5,
          description: Text(
            "Saved",
            style: TextStyle(
                color: Colors.white54,
                fontSize: MediaQuery.of(ctx).size.height * 0.023),
          ),
        ).show(ctx);
      }
    } catch (e) {
      MotionToast.error(
        position: MotionToastPosition.center,
        toastDuration: const Duration(seconds: 1),
        animationCurve: Curves.easeInOutSine,
        iconSize: MediaQuery.of(ctx).size.height * 0.046,
        height: 50,
        width: MediaQuery.of(ctx).size.width / 1.5,
        description: Text(
          "Error",
          style: TextStyle(
              color: Colors.white54,
              fontSize: MediaQuery.of(ctx).size.height * 0.023),
        ),
      ).show(ctx);
    }
  }
}
