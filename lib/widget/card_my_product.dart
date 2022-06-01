import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/product_model.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:intl/intl.dart';

class CardMyProduct extends StatelessWidget {
  final ProductModel product;
  const CardMyProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'ID');

    return Container(
      width: MediaQuery.of(context).orientation == Orientation.landscape
          ? 181
          : MediaQuery.of(context).size.width * 0.4,
      height: 240,
      margin: const EdgeInsets.only(right: 5, left: 5),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 3.0,
          color: greyColor.withOpacity(0.4),
          offset: const Offset(0, 1),
        ),
      ], color: whiteColor, borderRadius: BorderRadius.circular(defaultRadius)),
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
                    child: Hero(
                      tag: product.image.toString(),
                      child: CachedNetworkImage(
                        height: 130,
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
                  product.name,
                  overflow: TextOverflow.ellipsis,
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  currencyFormatter.format(product.price),
                  style: greyTextStyle.copyWith(fontWeight: medium),
                ),
                const SizedBox(height: 9),
                Text(
                  product.category!.name.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: greyTextStyle.copyWith(fontWeight: medium),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
