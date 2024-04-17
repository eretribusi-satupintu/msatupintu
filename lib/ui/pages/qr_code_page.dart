import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:satupintu_app/shared/theme.dart';

class QrCodePage extends StatelessWidget {
  const QrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
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
                  image: const DecorationImage(
                      image: AssetImage('assets/img_user.png'),
                      fit: BoxFit.fill),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Rizki Okto S',
                style: whiteRdTextStyle.copyWith(
                  fontWeight: bold,
                ),
              ),
              Text(
                '1101231231027310273',
                style:
                    whiteRdTextStyle.copyWith(fontSize: 12, fontWeight: medium),
              ),
              const SizedBox(
                height: 20,
              ),
              QrImageView(
                gapless: false,
                backgroundColor: whiteColor,
                data: '1101231231027310273',
                version: QrVersions.auto,
                size: 220.0,
                padding: const EdgeInsets.all(20),
                embeddedImage:
                    const AssetImage('assets/img_logo_with_background.png'),
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
}
