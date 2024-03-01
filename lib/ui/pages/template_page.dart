import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';

class TemplateMain extends StatelessWidget {
  final String title;
  final Widget body;

  const TemplateMain({super.key, required this.body, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          title: Text(
            title.toString(),
            style: whiteInTextStyle.copyWith(fontWeight: bold, fontSize: 18),
          ),
          toolbarHeight: 50,
          iconTheme: IconThemeData(color: whiteColor),
          backgroundColor: mainColor,
          elevation: null,
          centerTitle: true,
        ),
        body: ListView(
          // padding: const EdgeInsets.symmetric(horizontal: 18),
          children: [
            Stack(
              // alignment: AlignmentDirectional.center,
              children: [
                Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    padding:
                        const EdgeInsets.only(top: 20, left: 18, right: 18),
                    decoration: BoxDecoration(
                      color: lightBlueColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: body),
              ],
            ),
          ],
        ));
  }
}
