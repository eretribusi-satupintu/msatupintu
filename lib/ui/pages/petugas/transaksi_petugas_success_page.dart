import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';

class SuccessPage extends StatelessWidget {
  final String message;
  const SuccessPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/img_success_status.gif', width: 85),
              Text(
                'Berhasil',
                style: darkInBrownTextStyle.copyWith(
                    fontSize: 24, fontWeight: bold),
              ),
              Text(
                message,
                style: darkInBrownTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 200,
                  child: Center(
                    child: Text(
                      'Kembali',
                      style: whiteRdTextStyle.copyWith(
                          fontSize: 16, fontWeight: medium),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
