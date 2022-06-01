import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/theme.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const MenuItem({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    blackTextStyle.copyWith(fontWeight: medium, fontSize: 15),
              ),
              const Icon(
                Icons.chevron_right,
                size: 20,
              )
            ],
          )),
    );
  }
}
