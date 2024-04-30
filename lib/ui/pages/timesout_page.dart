import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satupintu_app/blocs/auth/auth_bloc.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';

class TimesoutPage extends StatelessWidget {
  const TimesoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomSnackbar(
                message: state.e.toString(),
                status: 'failed',
              ),
              behavior: SnackBarBehavior.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          );
        }

        if (state is AuthInitial) {
          Navigator.pushNamed(context, '/login');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: whiteColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ic_timesout.png',
                  width: 105,
                ),
                const SizedBox(height: 12),
                Text(
                  'Maaf sesi anda telah berakhir!',
                  style: darkRdBrownTextStyle.copyWith(
                      fontSize: 18, fontWeight: bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Jangan kawatir anda hanya perlu login ulang',
                  style: greyRdTextStyle.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 45),
                  child: CustomFilledButton(
                      title: 'Masuk Kembali',
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLogout());
                      }),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
