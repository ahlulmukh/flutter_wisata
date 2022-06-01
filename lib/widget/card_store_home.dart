import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/theme.dart';

class CardStoreHome extends StatelessWidget {
  const CardStoreHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail-store-page');
      },
      child: Container(
        width: MediaQuery.of(context).orientation == Orientation.landscape
            ? 181
            : MediaQuery.of(context).size.width * 0.4,
        height: 200,
        margin: const EdgeInsets.only(right: 5, left: 5),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 3.0,
                color: greyColor.withOpacity(0.4),
                offset: const Offset(0, 1),
              ),
            ],
            color: whiteColor,
            borderRadius: BorderRadius.circular(defaultRadius)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: const BoxDecoration(
                borderRadius: BorderRadiusDirectional.vertical(
                  top: Radius.circular(12),
                ),
                image: DecorationImage(
                    image: AssetImage('assets/img_store.png'),
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    'Toko Buah Manis',
                    style: blackTextStyle.copyWith(fontWeight: medium),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Baktiya',
                    style: blackTextStyle.copyWith(fontWeight: bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
