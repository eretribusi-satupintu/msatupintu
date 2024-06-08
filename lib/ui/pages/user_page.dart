import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/auth/auth_bloc.dart';
import 'package:satupintu_app/blocs/doku_payment/doku_payment_bloc.dart';
import 'package:satupintu_app/blocs/user/user_bloc.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/shared/values.dart';
import 'package:satupintu_app/ui/pages/doku_payment_va_page.dart';
import 'package:satupintu_app/ui/pages/update_password_page.dart';
import 'package:satupintu_app/ui/pages/user_edit_profile_page.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';
import 'package:satupintu_app/ui/widget/failed_info.dart';
import 'package:satupintu_app/ui/widget/laoding_info.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int? roleId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserBloc()..add(UserGet()),
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: BlocConsumer<UserBloc, UserState>(
                    listener: (context, state) {
                      if (state is UserSuccess) {
                        setState(() {
                          roleId = state.data.role;
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                              color: mainColor, size: 30),
                        );
                      }

                      if (state is UserSuccess) {
                        return Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.data.name!,
                                  style: darkRdBrownTextStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'NIK : ${state.data.nik}',
                                  style: darkRdBrownTextStyle.copyWith(
                                      fontWeight: bold, fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    state.data.role_id == 1
                                        ? 'Wajib Retribusi'
                                        : 'Petugas',
                                    style: whiteRdTextStyle.copyWith(
                                        fontWeight: bold, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                    image: state.data.photoProfile != null
                                        ? NetworkImage(
                                            '$publicUrl/${state.data.photoProfile}')
                                        : const AssetImage(
                                                'assets/img_user_guest.png')
                                            as ImageProvider,
                                    fit: BoxFit.cover),
                              ),
                              // child: Image.network(
                              //     'http://localhost:3000/public/user_profile/img_user_1.png'),
                            ),
                          ],
                        );
                      }

                      return const ErrorInfo(
                        e: 'Terjadi Kesalahan',
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                roleId != null
                    ? roleId == 1
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Informasi penting',
                                    style: darkRdBrownTextStyle.copyWith(
                                        fontWeight: medium),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    Icons.info_outline_rounded,
                                    size: 16,
                                    color: mainColor,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              BlocProvider(
                                create: (context) =>
                                    DokuPaymentBloc()..add(DokuVaList()),
                                child: BlocBuilder<DokuPaymentBloc,
                                    DokuPaymentState>(
                                  builder: (context, state) {
                                    if (state is DokuPaymentLoading) {
                                      return const LoadingInfo();
                                    }

                                    if (state is DokuPaymentListSuccess) {
                                      if (state.data.isNotEmpty) {
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                              children: state.data
                                                  .map(
                                                    (va) => GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                DokuPaymentVaPage(
                                                                    virtualAccount:
                                                                        va),
                                                          ),
                                                        );
                                                      },
                                                      child: vaPaymentCard(
                                                          va.bank!,
                                                          va.createdDate!),
                                                    ),
                                                  )
                                                  .toList()),
                                        );
                                      } else {
                                        return const Text('-');
                                      }
                                    }

                                    if (state is DokuPaymentFailed) {
                                      return const ErrorInfo(
                                        e: 'Terjadi Kesalahan',
                                      );
                                    }

                                    return const ErrorInfo(
                                      e: 'Terjadi Kesalahan',
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 28,
                              ),
                            ],
                          )
                        : const SizedBox()
                    : const SizedBox(),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return LoadingAnimationWidget.staggeredDotsWave(
                          color: mainColor, size: 30);
                    }

                    if (state is UserSuccess) {
                      if (state.data.role_id == 1) {
                        return profileMenu(
                          context,
                          'assets/img_kontrak.png',
                          'Kontrak Saya',
                          'Daftar email dan progres tagihan',
                          () {
                            Navigator.pushNamed(
                                context, '/wajib-retribusi-kontrak');
                          },
                        );
                      }
                    }

                    return const SizedBox();
                  },
                ),
                profileMenu(
                  context,
                  'assets/ic_user_profile.png',
                  'Ubah Profile',
                  'Ubah Email dan No Handphone anda',
                  () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserEditProfilePage()));
                  },
                ),
                profileMenu(
                  context,
                  'assets/ic_key.png',
                  'Ganti Password',
                  'Perbarui password akun anda',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpdatePasswordPage(),
                      ),
                    );
                  },
                ),
                BlocProvider(
                  create: (context) => AuthBloc(),
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthInitial) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      }

                      if (state is AuthFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: CustomSnackbar(
                              message: 'Terjadi kesalahan',
                              status: 'failed',
                            ),
                            behavior: SnackBarBehavior.fixed,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const LoadingInfo();
                      }
                      return profileMenu(
                        context,
                        'assets/ic_logout.png',
                        'Logout',
                        'Keluar dari akun anda saat ini',
                        () {
                          context.read<AuthBloc>().add(AuthLogout());
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget profileMenu(
    BuildContext context,
    String icon,
    String title,
    String description,
    VoidCallback? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        margin: const EdgeInsets.only(bottom: 21),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: lightBlueColor.withAlpha(30),
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Container(
          child: Row(children: [
            Image.asset(
              icon,
              width: 20,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: darkRdBrownTextStyle.copyWith(fontWeight: semiBold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    description,
                    style: greyRdTextStyle.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget vaPaymentCard(String bank, String createdAt) {
    return Container(
      width: 127,
      margin: const EdgeInsets.only(right: 8),
      child: Column(children: [
        Stack(
          children: [
            Container(
              width: 127,
              height: 108,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: const BorderRadiusDirectional.only(
                    topStart: Radius.circular(15),
                    topEnd: Radius.circular(15),
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    greenColor,
                    mainColor,
                  ],
                ),
                borderRadius: const BorderRadiusDirectional.only(
                  topStart: Radius.circular(15),
                  topEnd: Radius.circular(15),
                  bottomStart: Radius.circular(15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    color: whiteColor,
                    size: 16,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Menuggu Pembayaran VA',
                    style: whiteRdTextStyle.copyWith(
                        fontSize: 12, fontWeight: bold),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    bank == 'bri'
                        ? 'BRI'
                        : bank == 'mandiri'
                            ? 'MANDIRI'
                            : bank == 'bca'
                                ? 'BCA'
                                : 'Tidak diketahui',
                    style: whiteRdTextStyle.copyWith(fontSize: 8),
                  ),
                  Text(
                    stringToDateTime(
                        createdAt, 'EEEE, dd MMMM  yyyy HH:mm WIB', false),
                    style: whiteRdTextStyle.copyWith(fontSize: 8),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
          height: 43,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(15),
              bottomStart: Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Text(
                'Lanjutkan',
                style: mainRdTextStyle.copyWith(fontSize: 12, fontWeight: bold),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: mainColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 12,
                  color: mainColor,
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
