import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/provider/category_provider.dart';
import 'package:flutter_tugas_akhir/provider/product_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_tugas_akhir/widget/card_product_home.dart';
import 'package:flutter_tugas_akhir/widget/card_store_home.dart';
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

  List imageCaraousel = [
    'assets/images/home.png',
    'assets/img.png',
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(), () {
      getProductLimit();
      getCategories();
    });
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
  }

  Future<void> getProductLimit() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .getProductLimit();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getCategories() async {
    await Provider.of<CategoryProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider? productProvider = Provider.of<ProductProvider>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    int index = -1;

    Widget shimmerProduct() {
      return Container(
        height: 260,
        width: MediaQuery.of(context).size.width * 0.5,
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
        color: whiteColor,
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: greyColor, width: 2),
                    borderRadius: BorderRadius.circular(defaultRadius)),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.search,
                        color: greyColor,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 11),
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: TextFormField(
                        decoration: InputDecoration.collapsed(
                            hintText: "Cari produk...",
                            hintStyle: greyTextStyle.copyWith(
                                fontSize: 14, fontWeight: semiBold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/cart-page');
                },
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 25,
                  color: Colors.grey,
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
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              item,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                            ),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      aspectRatio: 2.5,
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
        margin: const EdgeInsets.only(top: 18),
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
                            children: [
                              shimmerCategory(),
                              shimmerCategory(),
                              shimmerCategory(),
                              shimmerCategory(),
                              shimmerCategory(),
                            ],
                          )
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
        margin: const EdgeInsets.only(top: 16),
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
                  ? Row(
                      children: [
                        shimmerProduct(),
                        shimmerProduct(),
                        shimmerProduct(),
                      ],
                    )
                  : Row(
                      children: productProvider.product
                          .map((product) => CardProductHome(
                                product: product!,
                              ))
                          .toList()),
            ),
          ],
        ),
      );
    }

    Widget store() {
      return Container(
          margin: const EdgeInsets.only(top: 16, bottom: 15),
          child: Column(children: [
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
                    Navigator.pushNamed(context, '/category-page');
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
              child: Row(
                children: const [
                  CardStoreHome(),
                  CardStoreHome(),
                  CardStoreHome()
                ],
              ),
            )
          ]));
    }

    Widget content() {
      return Container(
          margin: const EdgeInsets.only(top: 38),
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
        body: ListView(
          children: [
            header(),
            content(),
          ],
        ));
  }
}
