import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:satupintu_app/blocs/auth/auth_bloc.dart";
import "package:satupintu_app/blocs/doku_payment/doku_payment_bloc.dart";
import "package:satupintu_app/blocs/tagihan/tagihan_bloc.dart";
import "package:satupintu_app/blocs/tagihan_local/tagihan_local_bloc.dart";
import "package:satupintu_app/blocs/user/user_bloc.dart";
import "package:satupintu_app/ui/pages/login_page.dart";
import "package:satupintu_app/ui/pages/main_page.dart";
import "package:satupintu_app/ui/pages/kontrak_list_page.dart";
import "package:satupintu_app/ui/pages/petugas/petugas_qr_code_scanner.dart";
import "package:satupintu_app/ui/pages/petugas/select_wilayah_page.dart";
import "package:satupintu_app/ui/pages/petugas/setoran_list_page.dart";
import "package:satupintu_app/ui/pages/splash_page.dart";
import "package:satupintu_app/ui/pages/timesout_page.dart";

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()
            ..add(
              AuthGetCurrentUser(),
            ),
        ),
        BlocProvider<DokuPaymentBloc>(
          create: (context) => DokuPaymentBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc()..add(UserGet()),
        ),
        BlocProvider(create: (context) => TagihanLocalBloc()),
        BlocProvider(create: (context) => TagihanBloc())
        // ..add(TagihanLocalFromServerStore()))
      ],
      child: BlocListener<TagihanLocalBloc, TagihanLocalState>(
        listener: (context, state) {
          // if (state is TagihanLocalSuccess) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: CustomSnackbar(
          //         message: 'Konfirmasi pembayaran berhasil',
          //         status: 'success',
          //       ),
          //       behavior: SnackBarBehavior.fixed,
          //       backgroundColor: Colors.transparent,
          //       elevation: 0,
          //     ),
          //   );
          // }
          // if (state is TagihanLocalFetchFailed) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: CustomSnackbar(
          //         message: 'Gagal memperbarui tagihan',
          //         status: 'failed',
          //       ),
          //       behavior: SnackBarBehavior.fixed,
          //       backgroundColor: Colors.transparent,
          //       elevation: 0,
          //     ),
          //   );
          // }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const SplashPage(),
            '/home': (context) => const MainPage(),
            '/login': (context) => const LoginPage(),
            '/subwilayah-select': (context) => const SelectSubWilayahPage(),
            '/petugas-scan-qr-code': (context) => PetugasScanQrCodePage(),
            '/setoran': (context) => const SetoranListPage(),
            '/wajib-retribusi-kontrak': (context) => const KontrakListPage(),
            '/timesout': (context) => const TimesoutPage(),
          },
        ),
      ),
    );
  }
}
