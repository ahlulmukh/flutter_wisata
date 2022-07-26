import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/product_model.dart';
import 'package:flutter_tugas_akhir/page/detail_product_page.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CardProduct extends StatelessWidget {
  final ProductModel product;

  const CardProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'ID', symbol: 'Rp. ', decimalDigits: 0);

    return GestureDetector(
      onTap: () {
        Get.to(() => DetailProductPage(product: product));
      },
      child: Container(
        width: MediaQuery.of(context).orientation == Orientation.landscape
            ? 181
            : MediaQuery.of(context).size.width * 0.43,
        height: 220,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: greyColor.withOpacity(0.2)),
            color: whiteColor,
            borderRadius: BorderRadius.circular(defaultRadius)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(defaultRadius),
                ),
              ),
              // ignore: unnecessary_null_comparison
              child: product.image.toString() == null || product.image!.isEmpty
                  ? Image.asset(
                      'assets/images/not_product.jpeg',
                      fit: BoxFit.cover,
                    )
                  : Hero(
                      tag: product.id!.toInt(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(defaultRadius)),
                        child: CachedNetworkImage(
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: product.image.toString(),
                          placeholder: (context, url) =>
                              const Icon(Icons.image),
                          errorWidget: (context, url, error) => const Image(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/not_product.jpeg',
                              )),
                        ),
                      ),
                    ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 9,
                  ),
                  Text(
                    product.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    style:
                        blackTextStyle.copyWith(fontSize: 15, fontWeight: bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    currencyFormatter.format(product.price),
                    style: greyTextStyle.copyWith(fontWeight: medium),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    product.market!.nameStore.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: blackTextStyle.copyWith(
                        fontSize: 15, fontWeight: semiBold),
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
