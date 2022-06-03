import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/theme.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final double width;
  final EdgeInsets margin;
  final String title;
  final double height;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    this.height = 50,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: secondaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(defaultRadius)),
          padding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ),
      ),
    );
  }
}
