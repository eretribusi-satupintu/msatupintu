import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/home_page.dart';
import 'package:satupintu_app/ui/pages/kontrak_page.dart';
import 'package:satupintu_app/ui/pages/qr_code_page.dart';
import 'package:satupintu_app/ui/pages/tagihan_page.dart';
import 'package:satupintu_app/ui/pages/user_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int selectedPage = 1;
  late AnimationController _controller;
  bool auth = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        value: 0.0,
        duration: const Duration(seconds: 25),
        upperBound: 1,
        lowerBound: -1,
        vsync: this)
      ..repeat();
  }

  // final items =
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy MMMM dd').format(now);

    return Scaffold(
      backgroundColor: lightBlueColor,
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 300),
        index: selectedPage,
        items: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.home_outlined,
                size: 20,
                color: greenColor,
              ),
              Text(
                'Home',
                style: greenRdTextStyle.copyWith(fontSize: 8),
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 20,
                color: greenColor,
              ),
              Text(
                'Tagihan',
                style: greenRdTextStyle.copyWith(fontSize: 8),
              )
            ],
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: greenColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code_2_outlined,
                  size: 30,
                  color: whiteColor,
                ),
                Text(
                  'QR CODE',
                  style: whiteRdTextStyle.copyWith(
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.dashboard_customize_outlined,
                size: 20,
                color: greenColor,
              ),
              Text(
                'Kontrak',
                style: greenRdTextStyle.copyWith(fontSize: 8),
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.perm_identity,
                size: 30,
                color: greenColor,
              ),
              Text(
                'User',
                style: greenRdTextStyle.copyWith(fontSize: 8),
              ),
            ],
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedPage = index;
            print(selectedPage);
          });
        },
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return ClipPath(
                    clipper: CustomClipPath(_controller.value),
                    child: Container(
                      height: 90,
                      color: mainColor.withAlpha(80),
                    ),
                  );
                },
              ),
              ClipPath(
                clipper: CustomClipPath2(),
                child: Container(
                  height: 90,
                  color: mainColor.withAlpha(75),
                ),
              ),
              ClipPath(
                clipper: CustomClipPath3(),
                child: Container(
                  height: 90,
                  color: mainColor.withAlpha(98),
                ),
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Row(
                  children: [
                    selectedPage != 0
                        ? getTitlePage(selectedPage)
                        : getHomeProfile(formattedDate),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.history,
                          color: whiteColor,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 17,
                        ),
                        Icon(
                          Icons.notifications,
                          color: whiteColor,
                          size: 20,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            child: getSelectedPage(index: selectedPage),
          )
        ],
      ),
    );
  }

  Widget getSelectedPage({required int index}) {
    Widget widget;

    switch (index) {
      case 0:
        widget = const HomePage();
        break;
      case 1:
        widget = const TagihanPage();
        break;
      case 2:
        widget = const QrCodePage();
        break;
      case 3:
        widget = const KontrakPage();
        break;
      case 4:
        widget = const UserPage();
        break;
      default:
        widget = const HomePage();
    }

    return widget;
  }

  Widget getHomeProfile(String formattedDate) {
    return Container(
      child: Row(
        children: [
          Image.asset(
            'assets/img_user.png',
            width: 30,
            height: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.sunny,
                    size: 9,
                    color: whiteColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    formattedDate,
                    style: whiteInTextStyle.copyWith(fontSize: 10),
                  )
                ],
              ),
              Text(
                'Hai, Leonardo',
                style:
                    whiteInTextStyle.copyWith(fontSize: 18, fontWeight: bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getTitlePage(int index) {
    String title = 'Tagihan';

    switch (index) {
      case 1:
        title = 'Tagihan';
        break;
      case 2:
        title = 'QR Code';
        break;
      case 3:
        title = 'Kontrak';
        break;
      case 4:
        title = 'User';
        break;
      default:
        'Page';
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        title,
        style: whiteRdTextStyle.copyWith(fontSize: 16, fontWeight: medium),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  double move = 9;
  CustomClipPath(this.move);

  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    print(move);
    Path path_0 = Path();
    path_0.moveTo(w * -0.0016667, h * -0.0014286);
    path_0.lineTo(0, h * 0.6095429);
    path_0.quadraticBezierTo(
        w * 0.2164000, h * 0.9824714, w * 0.4645500, h * 0.5830857);
    path_0.cubicTo(w * 0.5815000, h * 0.8464143, w * 0.6232833, h * 0.6709714,
        w * 0.7318750, h * 0.7059286);
    path_0.quadraticBezierTo(
        w * 0.8601417, h * 0.8677286, w * 1.0004750, h * 0.6384857);
    path_0.lineTo(w * 1.0008333, h * -0.0042857);
    path_0.lineTo(w * -0.0016667, h * -0.0014286);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class CustomClipPath2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    Path path_0 = Path();
    path_0.moveTo(w * -0.0025000, h * -0.0014286);
    path_0.lineTo(w * -0.0016667, h * 0.4807429);
    path_0.quadraticBezierTo(
        w * 0.2307833, h * 0.9121857, w * 0.5422500, h * 0.4240714);
    path_0.quadraticBezierTo(
        w * 0.7744833, h * 0.6447571, w * 1.0016417, h * 0.4271429);
    path_0.lineTo(w * 1.0008333, h * -0.0014286);
    path_0.lineTo(w * -0.0025000, h * -0.0014286);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class CustomClipPath3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    Path path_0 = Path();
    path_0.moveTo(w * -0.0025000, h * -0.0014286);
    path_0.lineTo(w * -0.0006833, h * 0.7788571);
    path_0.quadraticBezierTo(
        w * 0.1538333, h * 0.4559000, w * 0.5085333, h * 0.8141286);
    path_0.cubicTo(w * 0.6832083, h * 0.9817857, w * 0.8488667, h * 0.6319714,
        w * 1.0006583, h * 0.7359714);
    path_0.quadraticBezierTo(
        w * 1.0007000, h * 0.5639429, w * 1.0008333, h * -0.0014286);
    path_0.lineTo(w * -0.0025000, h * -0.0014286);

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
