// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:wallpaperapp/model/photo_model.dart';
import 'package:wallpaperapp/screens/search%20screen/widget/image_page.dart';

class ImageListView extends StatefulWidget {
  final List<PhotoModel> photoModel;

  const ImageListView({
    super.key,
    required this.photoModel,
  });

  @override
  State<ImageListView> createState() => _ImageListViewState();
}

class _ImageListViewState extends State<ImageListView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.photoModel.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.6),
      itemBuilder: (context, index) {
        final wallpaper = widget.photoModel[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImagePage(
                  imageUrl: wallpaper.src.original,
                ),
              ),
            );
          },
          child: Hero(
            tag: wallpaper.src.original,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: wallpaper.src.original,
                placeholder: (context, url) => Container(
                  color: Colors.grey.shade200,
                ),
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: imageProvider),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
