import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:satupintu_app/shared/theme.dart';

class EmptyData extends StatelessWidget {
  final String message;
  const EmptyData({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              Icon(
                Icons.folder_off_outlined,
                color: lightBlueColor,
                size: 45,
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                message,
                style: lightGreyRdTextStyle,
                textAlign: TextAlign.center,
              )
            ],
          )),
    );
  }
}
