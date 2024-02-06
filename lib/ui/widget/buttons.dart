import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';

class CustomFilledButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomFilledButton(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          title.toString(),
          style: whiteRdTextStyle.copyWith(fontSize: 16),
        ),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final String title;
  final Color? color;

  const CustomOutlinedButton({super.key, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: BorderSide(width: 2, color: color ?? mainColor),
        ),
        child: Text(
          "Get Started",
          style: TextStyle(fontSize: 16, color: color),
        ),
      ),
    );
  }
}
