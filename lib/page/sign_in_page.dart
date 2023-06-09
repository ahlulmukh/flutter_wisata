import 'package:flutter/material.dart';
import 'package:flutter_tugas_akhir/page/home/main_page.dart';
import 'package:flutter_tugas_akhir/provider/auth_provider.dart';
import 'package:flutter_tugas_akhir/provider/page_provider.dart';
import 'package:flutter_tugas_akhir/theme.dart';
import 'package:flutter_tugas_akhir/widget/button_loading.dart';
import 'package:flutter_tugas_akhir/widget/custom_button.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController emailCon = TextEditingController(text: '');
  TextEditingController passCon = TextEditingController(text: '');

  @override
  void dispose() {
    emailCon.clear();
    passCon.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    handleSignIn() async {
      setState(() {
        isLoading = true;
      });

      if (_formKey.currentState!.validate()) {
        if (await authProvider.login(
          email: emailCon.text,
          password: passCon.text,
        )) {
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  child: const MainPage(),
                  type: PageTransitionType.rightToLeft,
                  curve: Curves.easeIn,
                  settings:
                      RouteSettings(arguments: pageProvider.currentIndex = 0)),
              (route) => false);
          // Get.offAllNamed('/main-page',
          //     arguments: pageProvider.currentIndex = 0);
        } else {
          Get.snackbar('Gagal Login', "Silahkan isi dengan benar",
              margin: EdgeInsets.only(
                  top: 20, left: defaultMargin, right: defaultMargin),
              colorText: Colors.white,
              backgroundColor: Colors.red[900],
              icon: const Icon(
                Icons.error,
                size: 25,
                color: Colors.white,
              ));
        }
      }
      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Text(
          'MARKETTANI',
          style: whiteTextStyle.copyWith(
              fontSize: 40, letterSpacing: 8.2, fontWeight: bold),
        ),
      );
    }

    Widget inputEmail() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, bottom: 10),
        child: Center(
          child: TextFormField(
            controller: emailCon,
            style: whiteTextStyle.copyWith(fontSize: 14),
            showCursor: true,
            validator: (value) => value!.isEmpty ? 'Isikan Email' : null,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 4),
                borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 4),
                  borderRadius: BorderRadius.circular(14)),
              errorStyle: whiteTextStyle.copyWith(
                  fontWeight: bold, fontSize: 14, color: Colors.red),
              labelText: 'Email',
              hintText: "Masukan Email",
              hintStyle: whiteTextStyle,
              labelStyle:
                  whiteTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              prefixIcon: const Icon(
                Icons.email_rounded,
                color: Colors.white,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(14)),
              floatingLabelStyle:
                  whiteTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: whiteColor, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      );
    }

    Widget inputPassword() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, bottom: 20),
        child: TextFormField(
          controller: passCon,
          style: whiteTextStyle,
          showCursor: true,
          validator: (value) => value!.isEmpty ? 'Isikan Password' : null,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 4),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 4),
                borderRadius: BorderRadius.circular(14)),
            errorStyle: whiteTextStyle.copyWith(
                fontWeight: bold, fontSize: 14, color: Colors.red),
            labelText: 'Password',
            hintText: "Masukan Password",
            hintStyle: whiteTextStyle.copyWith(fontSize: 14),
            labelStyle:
                whiteTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.white,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(14)),
            floatingLabelStyle:
                whiteTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: whiteColor, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      );
    }

    Widget submitButton() {
      return CustomButton(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        title: 'Masuk',
        onPressed: handleSignIn,
      );
    }

    Widget footer() {
      return Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum punya akun?',
              style: whiteTextStyle,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/sign-up');
              },
              child: Text(
                ' Daftar',
                style: whiteTextStyle.copyWith(
                    color: lightColor, fontWeight: bold),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor2,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            header(),
            inputEmail(),
            const SizedBox(
              height: 10,
            ),
            inputPassword(),
            isLoading == true ? const ButtonLoading() : submitButton(),
            const Spacer(),
            footer(),
            const SizedBox(
              height: 13,
            )
          ],
        ),
      ),
    );
  }
}
