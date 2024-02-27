import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscure;
  final String? errorText;
  final bool error;

  const CustomInput({
    super.key,
    required this.hintText,
    this.obscure = false,
    this.error = false,
    this.errorText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 48,
          child: TextFormField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
              filled: true,
              fillColor:
                  !error ? blueColor.withAlpha(20) : redColor.withAlpha(20),
              suffixStyle: TextStyle(color: !error ? mainColor : redColor),
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 12,
                color:
                    !error ? blueColor.withAlpha(90) : redColor.withAlpha(90),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
            style: !error
                ? blueRdTextStyle.copyWith(fontSize: 14)
                : redRdTextStyle.copyWith(fontSize: 14),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        error == true
            ? Row(
                children: [
                  Image.asset(
                    'assets/ic_cross_circle.png',
                    width: 18,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    errorText.toString(),
                    style: redRdTextStyle,
                  )
                  // Placeholder widget when error is false
                ],
              )
            : const SizedBox(), //
      ],
    );
  }
}
