import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/auth/auth_bloc.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomSnackbar(
                message: state.e.toString(),
              ),
              behavior: SnackBarBehavior.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          );
        }

        if (state is AuthInitial) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Center(
            child: LoadingAnimationWidget.inkDrop(color: mainColor, size: 24),
          );
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rizki Okto S',
                          style: darkRdBrownTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: bold,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          'NIK : 1912100210001',
                          style: darkRdBrownTextStyle.copyWith(
                              fontWeight: bold, fontSize: 12),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              )),
                          child: Text(
                            'Wajib Retribusi',
                            style: whiteRdTextStyle.copyWith(
                                fontWeight: bold, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      child: Image.asset('assets/img_user.png'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              profileMenu(
                'assets/ic_key.png',
                'Ubah Profile',
                'Ubah Email dan No Handphone anda',
                () {},
              ),
              profileMenu(
                'assets/ic_user_profile.png',
                'Ganti Password',
                'Ubah password anda untuk menjaga keamanan akun',
                () {},
              ),
              profileMenu(
                'assets/ic_logout.png',
                'Keluar',
                'Anda akan keluar dari akun anda saat ini',
                () {
                  context.read<AuthBloc>().add(AuthLogout());
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget profileMenu(
    String icon,
    String title,
    String description,
    VoidCallback? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        margin: const EdgeInsets.only(bottom: 21),
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          Image.asset(
            icon,
            width: 20,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: darkRdBrownTextStyle.copyWith(fontWeight: semiBold),
              ),
              Text(
                description,
                style: greyRdTextStyle.copyWith(fontSize: 10),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
