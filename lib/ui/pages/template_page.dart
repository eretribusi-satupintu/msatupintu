import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';

class TemplateMain extends StatelessWidget {
  final String title;
  final Widget body;

  const TemplateMain({super.key, required this.body, required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: mainColor,
          appBar: AppBar(
            title: Text(
              title.toString(),
              style: whiteInTextStyle.copyWith(fontWeight: bold, fontSize: 14),
            ),
            toolbarHeight: 50,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.chevron_left_outlined,
                size: 24,
              ),
            ),
            iconTheme: IconThemeData(color: whiteColor),
            backgroundColor: mainColor,
            elevation: null,
            centerTitle: true,
          ),
          body: ListView(
            children: [
              Stack(
                children: [
                  Container(
                      width: double.infinity,
                      height: (MediaQuery.of(context).size.height) - 77,
                      padding: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: body),
                ],
              ),
            ],
          )),
    );
  }
}
