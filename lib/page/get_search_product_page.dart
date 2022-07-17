import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tugas_akhir/models/product_model.dart';
import 'package:flutter_tugas_akhir/provider/page_provider.dart';
import 'package:flutter_tugas_akhir/provider/product_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/card_product_category.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class GetSearchProduct extends StatefulWidget {
  final String data;
  const GetSearchProduct({Key? key, required this.data}) : super(key: key);

  @override
  State<GetSearchProduct> createState() => _GetSearchProductState();
}

class _GetSearchProductState extends State<GetSearchProduct> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getSeachBarProduct();
  }

  getSeachBarProduct() async {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    PageProvider pageProvider =
        Provider.of<PageProvider>(context, listen: false);
    await productProvider.getProductSeacrh(data: widget.data).catchError(
        (value) => Get.toNamed('/main-page',
            arguments: pageProvider.currentIndex = 0));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    Widget header() {
      return Container(
        height: 70,
        color: whiteColor,
        padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          right: defaultMargin,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
                Icons.chevron_left,
                size: 35,
                color: greyColor,
              ),
            ),
            Expanded(
                child: Center(
                    child: Text(
              'Hasil Pencarian Produk',
              style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
            )))
          ],
        ),
      );
    }

    Widget getGridViewProduct() {
      if (productProvider.product.isEmpty) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              SvgPicture.asset(
                'assets/images/no_box.svg',
                width:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? MediaQuery.of(context).size.width * 0.6
                        : MediaQuery.of(context).size.width * 0.8,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Tidak ada produk',
                style:
                    greyTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
              )
            ],
          ),
        );
      } else {
        return SizedBox(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 3
                      : 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 16,
              mainAxisExtent: 235, // here set custom Height You Want
            ),
            itemCount: productProvider.product.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return CardProductCategory(
                  product: productProvider.product[index] as ProductModel);
            },
          ),
        );
      }
    }

    Widget content() {
      return Container(
        margin: const EdgeInsets.only(top: 20, bottom: 30),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Hasil pencarian produk ',
                        style: blackTextStyle.copyWith(
                            fontSize: 16, fontWeight: medium)),
                    TextSpan(
                        text: widget.data,
                        style: blackTextStyle.copyWith(
                            fontSize: 17, fontWeight: bold)),
                  ]),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              getGridViewProduct(),
            ]),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 10.0,
                color: Colors.green,
              ),
            )
          : ListView(
              children: [
                header(),
                content(),
              ],
            ),
    );
  }
}
