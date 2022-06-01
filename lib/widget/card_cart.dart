import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/theme.dart';

class CardCart extends StatelessWidget {
  const CardCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadiusDirectional.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 3.0,
              color: greyColor.withOpacity(0.3),
              offset: const Offset(0, 1),
            ),
          ]),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/img2.png',
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Apel Manis',
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Rp. 10.000',
                  style: greenTextStyle.copyWith(fontWeight: bold),
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.close,
                size: 20,
                color: greyColor,
              ),
              const Spacer(),
              Row(
                children: [
                  Image.asset(
                    'assets/icon_pengurangan.png',
                    width: 26,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    '1',
                    style: blackTextStyle.copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Image.asset(
                    'assets/icon_penambahan.png',
                    width: 26,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
