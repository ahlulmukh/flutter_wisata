import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/product_model.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';
import 'package:flutter_tugas_akhir/provider/auth_provider.dart';
import 'package:flutter_tugas_akhir/provider/cart_provider.dart';
import 'package:flutter_tugas_akhir/provider/wishlist_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CardWishlist extends StatelessWidget {
  final ProductModel product;
  const CardWishlist({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'ID', symbol: 'Rp. ', decimalDigits: 0);

    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.user;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.image.toString(),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name.toString(),
                      style: blackTextStyle.copyWith(fontWeight: semiBold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      currencyFormatter.format(product.price),
                      style: greyTextStyle.copyWith(fontWeight: medium),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  wishlistProvider.setProduct(product);
                  if (!wishlistProvider.isWishlist(product)) {
                    Get.snackbar('', '',
                        margin: EdgeInsets.only(
                            top: 20, left: defaultMargin, right: defaultMargin),
                        backgroundColor: dangerColor,
                        titleText: Text(
                          'Sukses',
                          style: whiteTextStyle.copyWith(
                              fontWeight: semiBold, fontSize: 17),
                        ),
                        messageText: Text('Berhasil dihapus dari wishlist',
                            style: whiteTextStyle.copyWith(fontSize: 14)),
                        colorText: Colors.white);
                  }
                },
                child: Image.asset(
                  wishlistProvider.isWishlist(product)
                      ? 'assets/icon_love_on.png'
                      : 'assets/icon_love_off.png',
                  width: 50,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              cartProvider.addtoCart(
                  userId: user!.id.toString(),
                  productId: product.id.toString(),
                  quantity: cartProvider.cart!.quantity);
              wishlistProvider.setProduct(product);
              Get.snackbar('', '',
                  backgroundColor: secondaryColor.withOpacity(0.8),
                  titleText: Text(
                    'Berhasil',
                    style: whiteTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 17),
                  ),
                  messageText: Text('Berhasil ditambah ke book',
                      style: whiteTextStyle.copyWith(fontSize: 14)),
                  colorText: Colors.white);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(6)),
              child: Text(
                'Tambah keranjang',
                textAlign: TextAlign.center,
                style:
                    whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
