// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String errorText;
  final bool obscureText;
  final TextEditingController controller;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.errorText,
    this.obscureText = false,
    required this.controller,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: widget.width * 0.048,
          top: widget.height * 0.0057,
          bottom: widget.height * 0.0057),
      margin: EdgeInsets.symmetric(horizontal: widget.width * 0.048),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.height * 0.012),
          border: Border.all(color: const Color.fromARGB(255, 160, 160, 147))),
      child: Center(
        child: TextFormField(
          controller: widget.controller,
          obscureText: isVisible ? false : widget.obscureText,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.errorText;
            }
            return null;
          },
          decoration: InputDecoration(
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      isVisible = !isVisible;
                      setState(() {});
                    },
                    icon: isVisible
                        ? const Icon(
                            Icons.remove_red_eye,
                            
                          )
                        : const Icon(Icons.visibility_off),
                  )
                : null,
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle:
                const TextStyle(color: Color.fromARGB(255, 160, 160, 147)),
          ),
        ),
      ),
    );
  }
}