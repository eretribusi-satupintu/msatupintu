import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:satupintu_app/ui/widget/inputs.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SvgPicture.asset(
              'assets/img_geometri.svg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 90,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img_pay_auth.png',
                        width: 150,
                        height: 170,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat Datang',
                            style: whiteRdTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'Lakukan pendaftaran melalui\nkedinasan terkait untuk wajib\nretribusi terdaftar',
                            style: whiteRdTextStyle.copyWith(
                              fontSize: 10,
                              fontWeight: regular,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Log in',
                                  style: blackRdTextStyle.copyWith(
                                      fontSize: 32, fontWeight: black),
                                ),
                                Text(
                                  'Silahkan input email dan password anda',
                                  style: greyRdTextStyle.copyWith(fontSize: 10),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const CustomInput(hintText: "masukkan email disini"),
                          const CustomInput(hintText: "masukkan email disini"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Lupa password',
                                  style: mainRdTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: light,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomFilledButton(
                            title: 'Masuk',
                            onPressed: () {
                              Navigator.pushNamed(context, '/home');
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/img_logo.png',
                                width: 50,
                              ),
                              Text(
                                'by Institut Teknologi Del',
                                style: greyRdTextStyle.copyWith(fontSize: 8),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
