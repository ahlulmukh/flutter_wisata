// ignore_for_file: prefer_is_empty, avoid_returning_null_for_void

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/page/get_search_product_page.dart';
import 'package:flutter_tugas_akhir/provider/cart_provider.dart';
import 'package:flutter_tugas_akhir/provider/category_provider.dart';
import 'package:flutter_tugas_akhir/provider/product_provider.dart';
import 'package:flutter_tugas_akhir/provider/toko_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_tugas_akhir/widget/card_product.dart';
import 'package:flutter_tugas_akhir/widget/card_market.dart';
import 'package:flutter_tugas_akhir/widget/category_item.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  bool isLoading = true;
  bool isDisabled = true;
  final seachController = TextEditingController();

  List imageCaraousel = [
    'assets/images/home.png',
    'assets/img.png',
  ];

  @override
  void dispose() {
    seachController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(), () {
        refreshData();
        // getProfil();
      });
    });
  }

  Future refreshData() async {
    getProductLimit();
    getCategories();
    getMarketLimits();
    fetchCart();
  }

  Future<void> fetchCart() async {
    await Provider.of<CartProvider>(context, listen: false).getCartList();
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    // await cartProvider.getCartList();
    print(cartProvider.cartList!.length);
  }

  Future<void> getProductLimit() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .getProductLimit();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getMarketLimits() async {
    await Provider.of<TokoProvider>(context, listen: false).getMarketsLimit();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getCategories() async {
    await Provider.of<CategoryProvider>(context, listen: false).getCategories();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider? productProvider = Provider.of<ProductProvider>(context);
    CategoryProvider? categoryProvider = Provider.of<CategoryProvider>(context);
    TokoProvider? tokoProvider = Provider.of<TokoProvider>(context);
    CartProvider? cartProvider = Provider.of<CartProvider>(context);
    int index = -1;

    Widget shimmerMarket() {
      return Container(
        width: MediaQuery.of(context).orientation == Orientation.landscape
            ? 181
            : MediaQuery.of(context).size.width * 0.4,
        height: 200,
        margin: const EdgeInsets.only(right: 5, left: 5),
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(defaultRadius)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.vertical(
                    top: Radius.circular(12),
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
                  Shimmer.fromColors(
                    child: Container(
                      width: double.infinity,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor),
                    ),
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Shimmer.fromColors(
                    child: Container(
                      width: double.infinity,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor),
                    ),
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget shimmerProduct() {
      return Container(
        height: 260,
        width: MediaQuery.of(context).orientation == Orientation.landscape
            ? MediaQuery.of(context).size.width * 0.3
            : MediaQuery.of(context).size.width * 0.5,
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(defaultRadius)),
        child: Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(defaultRadius)),
                    color: whiteColor),
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
                  Shimmer.fromColors(
                    child: Container(
                      width: double.infinity,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor),
                    ),
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Shimmer.fromColors(
                    child: Container(
                      width: double.infinity,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor),
                    ),
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Shimmer.fromColors(
                    child: Container(
                      width: double.infinity,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor),
                    ),
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget shimmerCategory() {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          margin: const EdgeInsets.only(right: 10, bottom: 10),
          width: 90,
          height: 30,
          decoration: BoxDecoration(
            color: backgroundColor3,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }

    Widget shimmerCaraousel() {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(defaultRadius))),
        ),
      );
    }

    Widget header() {
      return Container(
        color: primaryColor,
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(defaultRadius),
                  topLeft: Radius.circular(defaultRadius),
                ),
              ),
              padding: const EdgeInsets.all(6),
              child: GestureDetector(
                onTap: () {
                  if (seachController.text.length > 0) {
                    Get.to(
                      () => GetSearchProduct(
                        data: seachController.text,
                      ),
                    )!
                        .then(
                      (value) => seachController.clear(),
                    );
                  }
                  return null;
                },
                child: Icon(
                  Icons.search,
                  color: whiteColor,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 14),
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(defaultRadius),
                      bottomRight: Radius.circular(defaultRadius),
                    )),
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 7.5),
                child: TextFormField(
                  controller: seachController,
                  decoration: InputDecoration.collapsed(
                      hintText: "Cari produk...",
                      hintStyle: greyTextStyle.copyWith(
                          fontSize: 12, fontWeight: semiBold)),
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/cart-page');
                },
                child: cartProvider.cartList!.length == 0
                    ? const Icon(
                        Icons.shopping_cart_outlined,
                        size: 25,
                        color: Colors.white,
                      )
                    : Badge(
                        animationType: BadgeAnimationType.slide,
                        animationDuration: const Duration(seconds: 2),
                        badgeColor: dangerColor,
                        padding: const EdgeInsets.all(6),
                        position: const BadgePosition(bottom: 9.0, start: 12.0),
                        badgeContent: Text(
                            cartProvider.cartList!.length.toString(),
                            style: whiteTextStyle.copyWith(
                                fontSize: 14, fontWeight: semiBold)),
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                      ))
          ],
        ),
      );
    }

    Widget indicator(int indexIndicator) {
      return Container(
        margin: const EdgeInsets.only(top: 10, right: 5),
        width: currentIndex == indexIndicator ? 10 : 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == indexIndicator ? secondaryColor : greyColor,
            borderRadius: BorderRadius.circular(10)),
      );
    }

    Widget indicatorImage() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageCaraousel.map((e) {
          index++;
          return indicator(index);
        }).toList(),
      );
    }

    Widget caraouselAndIndicator() {
      return Container(
        child: isLoading
            ? shimmerCaraousel()
            : Column(
                children: [
                  CarouselSlider(
                    items: imageCaraousel
                        .map(
                          (item) => ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              item,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: 190,
                            ),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      aspectRatio: 2.2,
                      viewportFraction: 1,
                      initialPage: 0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),
                  indicatorImage(),
                ],
              ),
      );
    }

    Widget category() {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Semua Kategori',
              style:
                  blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:
                                List.generate(5, (_) => shimmerCategory()))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: categoryProvider.categories
                                .map((categories) =>
                                    CategoryItem(categories: categories!))
                                .toList(),
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget product() {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Produk',
                  style: blackTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/all-product');
                  },
                  child: Text(
                    'Semua Produk',
                    style: blackTextStyle.copyWith(fontSize: 12),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: isLoading
                  ? Row(children: List.generate(4, (_) => shimmerProduct()))
                  : Row(
                      children: productProvider.product
                          .map((product) => CardProduct(
                                product: product!,
                              ))
                          .toList(),
                    ),
            ),
          ],
        ),
      );
    }

    Widget store() {
      return Container(
          margin: const EdgeInsets.only(top: 16, bottom: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Toko',
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/all-market');
                    },
                    child: Text(
                      'Semua Toko',
                      style: blackTextStyle.copyWith(fontSize: 12),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: isLoading
                    ? Row(children: List.generate(4, (_) => shimmerMarket()))
                    : Row(
                        children: tokoProvider.markets
                            .map((market) => CardMarket(
                                  toko: market!,
                                ))
                            .toList(),
                      ),
              ),
            ],
          ));
    }

    Widget content() {
      return Container(
          margin: const EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              caraouselAndIndicator(),
              category(),
              product(),
              store(),
            ],
          ));
    }

    return Scaffold(
        backgroundColor: backgroundColor1,
        body: RefreshIndicator(
          edgeOffset: 20.0,
          backgroundColor: secondaryColor,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          strokeWidth: 3.0,
          color: whiteColor,
          displacement: 20.0,
          onRefresh: refreshData,
          child: ListView(
            children: [
              header(),
              content(),
            ],
          ),
        ));
  }
}
