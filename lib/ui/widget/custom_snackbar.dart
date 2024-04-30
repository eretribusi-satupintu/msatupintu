import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';

class CustomSnackbar extends StatelessWidget {
  final String status;
  final String message;
  const CustomSnackbar(
      {super.key, required this.message, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
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
              status == 'failed'
                  ? 'assets/ic_cross_circle.png'
                  : status == 'success'
                      ? 'assets/ic_success.png'
                      : 'assets/ic_info.png',
              width: 40,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              status == 'failed'
                  ? 'Permintaan Gagal'
                  : status == 'success'
                      ? 'Permintaan Berhasil'
                      : 'Info',
              style: darkRdBrownTextStyle.copyWith(
                  fontSize: 16, fontWeight: semiBold),
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
