import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:satupintu_app/blocs/user/user_bloc.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/widget/failed_info.dart';
import 'package:satupintu_app/ui/widget/laoding_info.dart';

class QrCodePage extends StatelessWidget {
  const QrCodePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return LoadingInfo();
        }

        if (state is UserSuccess) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 25),
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            image: state.data.photoProfile == null
                                ? AssetImage('assets/img_user.png')
                                : NetworkImage(
                                        'http://localhost:3000/${state.data.photoProfile}')
                                    as ImageProvider,
                            fit: BoxFit.fill),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      state.data.name!,
                      style: whiteRdTextStyle.copyWith(
                        fontWeight: bold,
                      ),
                    ),
                    Text(
                      state.data.nik!,
                      style: whiteRdTextStyle.copyWith(
                          fontSize: 12, fontWeight: medium),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    QrImageView(
                      gapless: false,
                      backgroundColor: whiteColor,
                      data: state.data.nik!,
                      version: QrVersions.auto,
                      size: 220.0,
                      padding: const EdgeInsets.all(20),
                      embeddedImage: const AssetImage(
                          'assets/img_logo_with_background.png'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Berikan QR Code anda diatas kepada petugas untuk melakukan pembayaran tunai',
                        style: whiteRdTextStyle.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          );
        }

        if (state is UserFailed) {
          return ErrorInfo(e: state.e);
        }

        return const ErrorInfo(e: 'Terjadi Kesalahan');
      },
    );
  }
}
