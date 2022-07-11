import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/order_item_model.dart';
import 'package:flutter_tugas_akhir/services/service.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:intl/intl.dart';

class OrderItemList extends StatelessWidget {
  final OrderItemModel orderItem;
  const OrderItemList({Key? key, required this.orderItem}) : super(key: key);

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
                        Service.urlImage + orderItem.product!.image.toString()),
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
                  orderItem.product!.name.toString(),
                  style: blackTextStyle.copyWith(fontWeight: semiBold),
                ),
                Text(
                  currencyFormatter.format(orderItem.product!.price),
                  style: blackTextStyle.copyWith(fontWeight: medium),
                )
              ],
            ),
          ),
          Text(
            orderItem.quantity.toString() + ' Item',
            style: blackTextStyle.copyWith(fontWeight: semiBold),
          )
        ],
      ),
    );
  }
}
