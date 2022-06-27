import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/theme.dart';

class ButtonLoading extends StatelessWidget {
  const ButtonLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(defaultRadius)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation(
                whiteColor,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Loading',
            style: whiteTextStyle.copyWith(fontWeight: semiBold),
          )
        ],
      ),
    );
  }
}
