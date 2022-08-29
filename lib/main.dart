import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/page/all_market_page.dart';
import 'package:flutter_tugas_akhir/page/all_product_page.dart';
import 'package:flutter_tugas_akhir/page/checkout_page.dart';
import 'package:flutter_tugas_akhir/page/checkout_success_page.dart';
import 'package:flutter_tugas_akhir/page/edit_profil_page.dart';
import 'package:flutter_tugas_akhir/page/cart_page.dart';
import 'package:flutter_tugas_akhir/page/home/main_page.dart';
import 'package:flutter_tugas_akhir/page/new_order_page.dart';
import 'package:flutter_tugas_akhir/page/registration_store_page.dart';
import 'package:flutter_tugas_akhir/page/sign_in_page.dart';
import 'package:flutter_tugas_akhir/page/sign_up_page.dart';
import 'package:flutter_tugas_akhir/page/splash_page.dart';
import 'package:flutter_tugas_akhir/page/store_information_page.dart';
import 'package:flutter_tugas_akhir/page/home/wishlist_page.dart';
import 'package:flutter_tugas_akhir/page/using_guide_app_page.dart';
import 'package:flutter_tugas_akhir/provider/auth_provider.dart';
import 'package:flutter_tugas_akhir/provider/cart_provider.dart';
import 'package:flutter_tugas_akhir/provider/category_provider.dart';
import 'package:flutter_tugas_akhir/provider/checkout_provider.dart';
import 'package:flutter_tugas_akhir/provider/order_provider.dart';
import 'package:flutter_tugas_akhir/provider/page_provider.dart';
import 'package:flutter_tugas_akhir/provider/product_provider.dart';
import 'package:flutter_tugas_akhir/provider/toko_provider.dart';
import 'package:flutter_tugas_akhir/provider/wishlist_provider.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TokoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckoutProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
      ],
      child: GetMaterialApp(
        home: const SplashPage(),
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(
            name: '/',
            page: () => const SplashPage(),
          ),
          GetPage(
            name: '/sign-in',
            page: () => const SignInPage(),
          ),
          GetPage(
            name: '/sign-up',
            page: () => const SignUpPage(),
          ),
          GetPage(
            name: '/main-page',
            page: () => const MainPage(),
          ),
          GetPage(
            name: '/edit-profile',
            page: () => const EditProfilPage(),
          ),
          GetPage(
            name: '/registration-store',
            page: () => const RegistrationStorePage(),
          ),
          GetPage(
            name: '/information-store',
            page: () => const StoreInformationPage(),
          ),
          GetPage(
            name: '/wishlist-page',
            page: () => const WishlistPage(),
          ),
          GetPage(
            name: '/cart-page',
            page: () => const CartPage(),
          ),
          GetPage(
            name: '/all-product',
            page: () => const AllProductPage(),
          ),
          GetPage(
            name: '/all-market',
            page: () => const AllMarketPage(),
          ),
          GetPage(
            name: '/checkout',
            page: () => const CheckoutPage(),
          ),
          GetPage(
            name: '/checkout-success',
            page: () => const CheckoutSuccessPage(),
          ),
          GetPage(
            name: '/newOrder-page',
            page: () => const NewOrderPage(),
          ),
          GetPage(
            name: '/guide-app',
            page: () => const UsingGuideAppPage(),
          ),
        ],
      ),
    );
  }
}
