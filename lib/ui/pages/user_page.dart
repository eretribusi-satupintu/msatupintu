import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/auth/auth_bloc.dart';
import 'package:satupintu_app/blocs/user/user_bloc.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/user_edit_profile_page.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';
import 'package:satupintu_app/ui/widget/failed_info.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserBloc()..add(UserGet()),
        child:
            // if (state is AuthInitial) {
            //   Navigator.pushNamedAndRemoveUntil(
            //       context, '/login', (route) => false);
            // }

            Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              SizedBox(
                child: BlocBuilder<UserBloc, UserState>(
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
                                  image: NetworkImage(
                                      'http://localhost:3000/${state.data.photoProfile}'),
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
              profileMenu(
                'assets/ic_key.png',
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
        ));
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
              const SizedBox(
                height: 4,
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
