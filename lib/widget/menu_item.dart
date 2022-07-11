import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/theme.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final IconData icons;

  const MenuItem({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.icons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              Icon(icons),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                  title,
                  style: blackTextStyle.copyWith(fontWeight: semiBold),
                ),
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
