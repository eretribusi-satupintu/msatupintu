import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';

class CustomModalBottomSheet {
  static void show(BuildContext context, Widget content) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => DraggableScrollableSheet(
          snap: true,
          initialChildSize: 0.8,
          builder: (_, controller) {
            return Container(
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: ListView(
                controller: controller,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 4,
                        width: 49,
                        color: mainColor,
                      ),
                      content
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
