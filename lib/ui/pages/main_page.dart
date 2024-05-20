import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/auth/auth_bloc.dart';
import 'package:satupintu_app/blocs/user/user_bloc.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/home_page.dart';
import 'package:satupintu_app/ui/pages/petugas/home_petugas_page.dart';
import 'package:satupintu_app/ui/pages/pembayaran_page.dart';
import 'package:satupintu_app/ui/pages/petugas/pembayaran_page.dart';
import 'package:satupintu_app/ui/pages/petugas/wajib_retribusi_petugas_page.dart';
import 'package:satupintu_app/ui/pages/qr_code_page.dart';
import 'package:satupintu_app/ui/pages/tagihan_list_page.dart';
import 'package:satupintu_app/ui/pages/user_page.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:satupintu_app/ui/widget/failed_info.dart';
import 'package:satupintu_app/ui/widget/laoding_info.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int selectedPage = 0;
  late AnimationController _controller;
  bool auth = false;

  @override
  void initState() {
    // BlocProvider.of<UserBloc>(context).add(UserCheckRequested());

    super.initState();
    _controller = AnimationController(
        value: 0.0,
        duration: const Duration(seconds: 25),
        upperBound: 1,
        lowerBound: -1,
        vsync: this)
      ..repeat();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed to avoid memory leaks
    _controller.dispose();
    super.dispose();
  }

  // final items =
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy MMMM dd').format(now);

    return
        // BlocProvider(
        //   create: (context) => AuthBloc()..add(AuthGetCurrentUser()),
        //   child:

        SafeArea(
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserFailed) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          }
        },
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size(double.infinity, 100),
                child: Stack(
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
                        color: mainColor,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      child: Row(
                        children: [
                          BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                            if (state is UserSuccess) {
                              if (selectedPage != 0) {
                                print({"role": state.data.role});
                                return getTitlePage(
                                    selectedPage, state.data.role!);
                              } else {
                                return getHomeProfile(formattedDate,
                                    state.data.name!, state.data.photoProfile);
                              }
                            }
                            if (state is UserFailed) {
                              return Text(state.e);
                            }
                            return Text(
                              '-',
                              style: whiteRdTextStyle.copyWith(
                                  fontSize: 20, fontWeight: bold),
                            );
                          }),
                        ],
                      ),
                    )
                  ],
                )),
            backgroundColor: lightWhite,
            bottomNavigationBar: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  return CurvedNavigationBar(
                    height: 50,
                    backgroundColor: Colors.transparent,
                    animationDuration: const Duration(milliseconds: 300),
                    index: selectedPage,
                    items: getBottomBaritem(state.user.role!),
                    onTap: (index) {
                      if (state.user.role == 2 && index == 2) {
                        Navigator.pushNamed(context, '/petugas-scan-qr-code');
                      } else {
                        setState(() {
                          selectedPage = index;
                        });
                      }
                    },
                  );
                }

                return const SizedBox();
              },
            ),
            body: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoading) {
                  const LoadingInfo();
                }

                if (state is AuthFailed) {
                  // const ErrorInfo(e: 'Tidak dapat mengidentifikasi pengguna');
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: mainColor, size: 30),
                  );
                }
                if (state is AuthSuccess) {
                  if (state.user.role == 1) {
                    return getSelectedPage(index: selectedPage);
                  } else if (state.user.role == 2) {
                    return getSelectedPagePetugas(
                        selectedPage, state.user.roleId!);
                  }
                }

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      const ErrorInfo(
                          e: 'Tidak dapat mengidentifikasi pengguna'),
                      CustomFilledButton(
                          title: "Muat ulang",
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/login', (route) => false);
                          })
                    ],
                  ),
                );
              },
            )),
      ),
    );
    // );
  }

  List<Widget> getBottomBaritem(int role) {
    if (role == 1) {
      return [
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
              Icons.payments_outlined,
              size: 20,
              color: greenColor,
            ),
            Text(
              'Pembayaran',
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
      ];
    } else if (role == 2) {
      return [
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
                Icons.qr_code_scanner_outlined,
                size: 30,
                color: whiteColor,
              ),
              Text(
                'SCAN QR',
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
              Icons.payments_outlined,
              size: 20,
              color: greenColor,
            ),
            Text(
              'Pembayaran',
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
      ];
    }

    return [const SizedBox()];
  }

  Widget getSelectedPagePetugas(int index, int petugasId) {
    Widget widget;

    switch (index) {
      case 0:
        widget = const HomePetugasPage();
        break;
      case 1:
        widget = TagihanPetugasPage(
          petugasId: petugasId,
        );
        break;
      case 3:
        widget = const PembayaranPetugasPage();
        break;
      case 4:
        widget = const UserPage();
        break;
      default:
        widget = const HomePetugasPage();
    }

    return widget;
  }

  Widget getSelectedPage({required int index}) {
    Widget widget;

    switch (index) {
      case 0:
        widget = const HomePage();
        break;
      case 1:
        widget = const TagihanListPage();
        break;
      case 2:
        widget = const QrCodePage();
        break;
      case 3:
        widget = const PembayaranPage();
        break;
      case 4:
        widget = const UserPage();
        break;
      default:
        widget = const HomePage();
    }

    return widget;
  }

  Widget getHomeProfile(
    String formattedDate,
    String name,
    String? profilePhotoUrl,
  ) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                  image: profilePhotoUrl != null
                      ? NetworkImage(
                          'http://localhost:3000/$profilePhotoUrl',
                        )
                      : const AssetImage(
                          'assets/img_user_guest.png',
                        ) as ImageProvider,
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                'Hai, ${name.split(' ')[0]}',
                style:
                    whiteInTextStyle.copyWith(fontSize: 14, fontWeight: bold),
                // maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getTitlePage(int index, int role) {
    String title = '-';

    if (role == 1) {
      switch (index) {
        case 1:
          title = 'Tagihan';
          break;
        case 2:
          title = 'QR Code';
          break;
        case 3:
          title = 'Pembayaran';
          break;
        case 4:
          title = 'User';
          break;
        default:
          'Page';
      }
    }

    if (role == 2) {
      switch (index) {
        case 1:
          title = 'Tagihan';
          break;
        case 2:
          title = 'Scan';
          break;
        case 3:
          title = 'Pembayaran';
          break;
        case 4:
          title = 'User';
          break;
        default:
          'Page';
      }
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
