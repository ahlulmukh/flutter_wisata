import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/product_model.dart';
import 'package:flutter_tugas_akhir/page/detail_product_page.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CardProductCategory extends StatelessWidget {
  final ProductModel product;

  const CardProductCategory({
    required this.product,
    Key? key,
  }) : super(key: key);

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
            : MediaQuery.of(context).size.width * 0.4,
        height: 180,
        margin: const EdgeInsets.only(right: 5, left: 5),
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
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(defaultRadius)),
                      child: CachedNetworkImage(
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: product.image.toString(),
                        placeholder: (context, url) => const Icon(Icons.image),
                        errorWidget: (context, url, error) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/not_product.jpeg',
                            )),
                      ),
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
                    product.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: blackTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 16),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
