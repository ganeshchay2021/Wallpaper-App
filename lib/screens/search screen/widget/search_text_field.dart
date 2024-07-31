import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wallpaperapp/bloc/wapppaper_bloc.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController controller;
  const SearchTextField({
    super.key,
    required this.controller,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: width,
      height: height * 0.057,
      decoration: BoxDecoration(
        color: const Color(0xFFececf8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        textInputAction: TextInputAction.search,
        controller: widget.controller,
        onSubmitted: (value) {
          setState(() {
            if (value.isNotEmpty) {
              context
                  .read<WallpaperBloc>()
                  .add(WallpaperSearchEvent(searchPhoto: value));
            }
          });
        },
        style: TextStyle(fontSize: height * 0.023),
        decoration: InputDecoration(
          hintText: "Search ",
          suffixIcon: widget.controller.text.isEmpty
              ? Icon(
                  Icons.search_outlined,
                  color: Colors.grey,
                  size: height * 0.034,
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      widget.controller.clear();
                      context.read<WallpaperBloc>().add(TextClearEvent());
                    });
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: height * 0.034,
                  ),
                ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
