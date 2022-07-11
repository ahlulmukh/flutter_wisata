import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/page/home/account_page.dart';
import 'package:flutter_tugas_akhir/page/home/home_page.dart';
import 'package:flutter_tugas_akhir/page/home/transaction_page.dart';
import 'package:flutter_tugas_akhir/page/home/wishlist_page.dart';
import 'package:flutter_tugas_akhir/provider/page_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Widget customNavigationBar() {
      return Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(14),
          ),
        ),
        child: SalomonBottomBar(
            currentIndex: pageProvider.currentIndex,
            onTap: (value) {
              // ignore: avoid_print
              print(value);
              pageProvider.currentIndex = value;
            },
            items: [
              SalomonBottomBarItem(
                  icon: const Icon(Icons.home),
                  title: const Text("Home"),
                  selectedColor: whiteColor,
                  unselectedColor: whiteColor),

              /// Likes
              SalomonBottomBarItem(
                  icon: const Icon(Icons.list_alt),
                  title: const Text("Transaksi"),
                  selectedColor: whiteColor,
                  unselectedColor: whiteColor),

              /// Search
              SalomonBottomBarItem(
                  icon: const Icon(Icons.favorite),
                  title: const Text("Wishlist"),
                  selectedColor: whiteColor,
                  unselectedColor: whiteColor),

              /// Profile
              SalomonBottomBarItem(
                  icon: const Icon(Icons.account_circle_rounded),
                  title: const Text("Profil"),
                  selectedColor: whiteColor,
                  unselectedColor: whiteColor),
            ]),
      );
    }

    Widget body() {
      switch (pageProvider.currentIndex) {
        case 0:
          return const HomePage();
        case 1:
          return const TransactionPage();
        case 2:
          return const WishlistPage();
        case 3:
          return const AccountPage();
        default:
          return const HomePage();
      }
    }

    return Scaffold(
      body: body(),
      bottomNavigationBar: customNavigationBar(),
    );
  }
}
