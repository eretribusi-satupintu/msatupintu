import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';

class ErrorInfo extends StatelessWidget {
  final String? e;
  const ErrorInfo({super.key, this.e});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Image.asset(
            'assets/ic_no_connection.png',
            width: 30,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Maaf terjadi Kesalahan',
            style: darkRdBrownTextStyle.copyWith(fontWeight: semiBold),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            e ?? 'Mohon periksa koneksi internet anda atau coba lagi nanti',
            style: greyRdTextStyle.copyWith(fontSize: 10),
          )
        ],
      ),
    ));
  }
}
