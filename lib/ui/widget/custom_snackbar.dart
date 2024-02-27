import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';

class CustomSnackbar extends StatelessWidget {
  final String message;
  const CustomSnackbar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: lightBlueColor,
              offset: const Offset(2.0, 4.0),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/ic_cross_circle.png',
              width: 40,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Gagal Masuk',
              style: redRdTextStyle.copyWith(fontSize: 20, fontWeight: bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              message.toString(),
              style: greyRdTextStyle,
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
