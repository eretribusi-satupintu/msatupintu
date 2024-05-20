import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/shared/theme.dart';

class LoadingInfo extends StatelessWidget {
  final String? message;
  const LoadingInfo({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            LoadingAnimationWidget.staggeredDotsWave(
                color: mainColor, size: 30),
            const SizedBox(
              height: 4,
            ),
            Text(
              message ?? 'Loading...',
              style: darkRdBrownTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
