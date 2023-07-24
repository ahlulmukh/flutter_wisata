import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/models/product_model.dart';
import 'package:flutter_tugas_akhir/page/home/main_page.dart';
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
    PageProvider pageProvider = Provider.of<PageProvider>(context);

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
              Image.asset(
                'assets/empty.png',
                width:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? MediaQuery.of(context).size.width * 0.6
                        : MediaQuery.of(context).size.width * 0.8,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Produk tidak ditemukan',
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
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Hasil pencarian Tiket ',
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
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60.0,
        backgroundColor: whiteColor,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Get.to(() => const MainPage(),
                  arguments: pageProvider.currentIndex = 0);
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        elevation: 0,
        title: Text(
          'Hasil Pencarian',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 5.0,
                color: Colors.green,
              ),
            )
          : ListView(
              children: [
                content(),
              ],
            ),
    );
  }
}
