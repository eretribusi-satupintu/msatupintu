import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DokuQrisPage extends StatefulWidget {
  final String url;
  const DokuQrisPage({super.key, required this.url});

  @override
  State<DokuQrisPage> createState() => _DokuQrisPageState();
}

class _DokuQrisPageState extends State<DokuQrisPage> {
  double webProgress = 0;
  bool isDone = false;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) => setState(() {
            webProgress = progress / 100;
          }),
          onPageStarted: (String url) {},
          onPageFinished: (String url) => setState(() {
            isDone = true;
          }),
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text(
            'Pembayran QRIS',
            style: whiteRdTextStyle.copyWith(fontSize: 16, fontWeight: bold),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                webProgress < 1
                    ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: LinearProgressIndicator(
                          value: webProgress,
                          backgroundColor: whiteColor,
                          color: mainColor,
                          minHeight: 6,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ))
                    : const SizedBox(),
                Expanded(child: WebViewWidget(controller: controller))
              ],
            ),
            isDone == false
                ? Center(
                    child: Container(
                      height: 100,
                      padding: const EdgeInsets.only(
                        top: 8,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          LoadingAnimationWidget.staggeredDotsWave(
                              color: mainColor, size: 45),
                          const SizedBox(
                            height: 6,
                          ),
                          Text('Permintaan ansa sedang diproses',
                              style: darkRdBrownTextStyle),
                        ],
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
