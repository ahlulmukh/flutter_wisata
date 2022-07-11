import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/cart_model.dart';
import 'package:flutter_tugas_akhir/services/service.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:intl/intl.dart';

class CardCheckout extends StatelessWidget {
  final CartModel cart;
  const CardCheckout({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'ID', symbol: 'Rp. ', decimalDigits: 0);

    return Container(
      width: double.infinity,
      height: 90,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 2.0, color: Colors.black),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                image: DecorationImage(
                    image: NetworkImage(
                        Service.urlImage + cart.product!.image.toString()),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            width: 13,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.product!.name.toString(),
                  style: blackTextStyle.copyWith(fontWeight: semiBold),
                ),
                Text(
                  currencyFormatter.format(cart.product!.price),
                  style: blackTextStyle.copyWith(fontWeight: medium),
                )
              ],
            ),
          ),
          Text(
            cart.quantity.toString() + ' Item',
            style: blackTextStyle.copyWith(fontWeight: semiBold),
          )
        ],
      ),
    );
  }
}
