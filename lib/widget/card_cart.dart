import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/cart_model.dart';
import 'package:flutter_tugas_akhir/provider/cart_provider.dart';
import 'package:flutter_tugas_akhir/services/service.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CardCart extends StatelessWidget {
  final CartModel cart;
  const CardCart({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'ID', symbol: 'Rp. ', decimalDigits: 0);
    CartProvider cartProvider = Provider.of<CartProvider>(context);

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
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(
                    Service.urlImage + cart.product!.image.toString(),
                  ),
                  fit: BoxFit.cover,
                )),
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
                  cart.product!.name.toString(),
                  style: blackTextStyle.copyWith(fontWeight: semiBold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  currencyFormatter.format(cart.product!.price),
                  style: greyTextStyle.copyWith(fontWeight: medium),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  cart.product!.market!.nameStore.toString(),
                  style: greyTextStyle.copyWith(fontWeight: semiBold),
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  cartProvider.removeCart(cart.id.toInt());
                  Get.snackbar('', '',
                      margin: EdgeInsets.only(
                          top: 20, left: defaultMargin, right: defaultMargin),
                      backgroundColor: greyColor.withOpacity(0.8),
                      titleText: Text(
                        'Sukses',
                        style: whiteTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 17),
                      ),
                      messageText: Text('1 produk terhapus',
                          style: whiteTextStyle.copyWith(fontSize: 14)),
                      colorText: Colors.white);
                },
                child: CircleAvatar(
                  radius: 16.0,
                  backgroundColor: dangerColor,
                  child: Center(
                    child: Icon(
                      Icons.delete,
                      size: 23,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      cartProvider.reduceQuantity(cart.id, cart.quantity - 1);
                    },
                    child: Image.asset(
                      'assets/icon_pengurangan.png',
                      width: 26,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    cart.quantity.toString(),
                    style: blackTextStyle.copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      cartProvider.addQuantity(cart.id, cart.quantity + 1);
                    },
                    child: Image.asset(
                      'assets/icon_penambahan.png',
                      width: 26,
                    ),
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
