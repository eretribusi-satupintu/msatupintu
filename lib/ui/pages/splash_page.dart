import 'package:flutter/material.dart';
import 'package:satupintu_app/blocs/auth/auth_bloc.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satupintu_app/ui/pages/petugas/tagihan_sinkronisasi_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              }

              if (state is AuthPetugasFailed) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TagihanSinkronisasiPage()));
              }

              if (state is AuthFailed) {
                print(state.e);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              }
            },
            child: Center(
              child: Text(
                "Aplikasi Retribusi",
                style: mainRdTextStyle.copyWith(fontWeight: bold, fontSize: 24),
              ),
            )
            // Center(
            //     child: Container(
            //   width: 175,
            //   height: 70,
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(image: AssetImage('assets/img_logo.png')),
            //   ),
            // )),
            ));
  }
}
