import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/theme.dart';

class StoreInformationPage extends StatelessWidget {
  const StoreInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        centerTitle: true,
        toolbarHeight: 60.0,
        backgroundColor: whiteColor,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Navigator.pop(context);
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
          'Informasi Aplikasi',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon_leaf.png',
              width: 100,
              height: 100,
            ),
            Text(
              'MARKETTANI',
              style: greenTextStyle.copyWith(
                  fontSize: 30, letterSpacing: 7.2, fontWeight: bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'v 1.0',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 20,
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          header(),
          content(),
        ],
      ),
    );
  }
}
