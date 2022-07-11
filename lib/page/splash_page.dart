import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/provider/auth_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      checkToken();
    });
  }

  Future checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    if (token != null) {
      if (await authProvider.getProfile()) {
        Get.toNamed('/main-page');
      }
    } else {
      Get.toNamed('/sign-in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 300,
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}
