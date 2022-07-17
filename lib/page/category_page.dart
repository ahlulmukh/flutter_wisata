import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tugas_akhir/models/product_model.dart';
import 'package:flutter_tugas_akhir/provider/category_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/card_product_category.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  final int category;
  const CategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (timeStamp) {
        fetchCategory();
      },
    );
  }

  fetchCategory() async {
    CategoryProvider categoryProvider = Provider.of(context, listen: false);
    await categoryProvider.getCategory(id: widget.category);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);

    Widget header() {
      return AppBar(
        toolbarHeight: 60.0,
        centerTitle: true,
        backgroundColor: whiteColor,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 30,
              color: Colors.grey,
            ),
          ),
        ),
        elevation: 0,
        title: Text(
          categoryProvider.category!.name,
          textAlign: TextAlign.center,
          style: blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 20),
        ),
      );
    }

    Widget getGridViewProduct() {
      if (categoryProvider.category!.products.isEmpty) {
        return Center(
          child: Column(
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
              mainAxisExtent: 230, // here set custom Height You Want
            ),
            itemCount: categoryProvider.category!.products.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return CardProductCategory(
                  product: categoryProvider.category!.products[index]
                      as ProductModel);
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
              const SizedBox(
                height: 20,
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
                strokeWidth: 5.0,
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
