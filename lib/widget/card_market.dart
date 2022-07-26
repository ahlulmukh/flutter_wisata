import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';
import 'package:flutter_tugas_akhir/page/detail_store_page.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:get/get.dart';

class CardMarket extends StatelessWidget {
  final TokoModel toko;
  const CardMarket({Key? key, required this.toko}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => DetailStorePage(toko: toko),
        );
      },
      child: Container(
        width: MediaQuery.of(context).orientation == Orientation.landscape
            ? 181
            : MediaQuery.of(context).size.width * 0.4,
        height: 200,
        margin: const EdgeInsets.only(right: 5, left: 5),
        decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: greyColor.withOpacity(0.2)),
            color: whiteColor,
            borderRadius: BorderRadius.circular(defaultRadius)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            toko.image == null
                ? Image.asset(
                    'assets/images/not_product.jpeg',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(defaultRadius)),
                    child: CachedNetworkImage(
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: toko.image.toString(),
                      placeholder: (context, url) => const Icon(Icons.image),
                      errorWidget: (context, url, error) => const Image(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/images/not_product.jpeg',
                          )),
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
                    toko.nameStore.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: blackTextStyle.copyWith(fontWeight: medium),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    toko.village.toString(),
                    style: blackTextStyle.copyWith(fontWeight: bold),
                    overflow: TextOverflow.ellipsis,
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
