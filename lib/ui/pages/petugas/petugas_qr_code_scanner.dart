import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:satupintu_app/blocs/wajib_retribusi/wajib_retribusi_bloc.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/petugas/tagihan_list_page.dart';
import 'package:satupintu_app/ui/pages/petugas/wajib_retribusi_tagihan_list.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';

class PetugasScanQrCodePage extends StatefulWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  PetugasScanQrCodePage({super.key});
  @override
  State<PetugasScanQrCodePage> createState() => _PetugasScanQrCodePageState();
}

class _PetugasScanQrCodePageState extends State<PetugasScanQrCodePage> {
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan QR Code',
          style: mainRdTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop('refresh');
          },
          icon: Icon(
            Icons.chevron_left_rounded,
            size: 30,
            color: mainColor,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => WajibRetribusiBloc(),
        child: BlocConsumer<WajibRetribusiBloc, WajibRetribusiState>(
          listener: (context, state) {
            if (state is WajibRetribusiFailed) {
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
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            }

            if (state is WajibRetribusiPresent) {
              Navigator.pop(context);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WajibRetribusiTagihanListPage(
                          wajibRetribusiId: state.wajibRetribusiId)));
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  flex: 5,
                  child: QRView(
                    key: widget.qrKey,
                    formatsAllowed: const [BarcodeFormat.qrcode],
                    onQRViewCreated: (controller) {
                      this.controller = controller;
                      controller.scannedDataStream.listen((scanData) {
                        setState(() {
                          result = scanData;
                        });
                        print(result!.code!);
                        context.read<WajibRetribusiBloc>().add(
                            WajibRetribusiGetDetailFromScan(result!.code!));
                      });
                    },
                    overlay: QrScannerOverlayShape(
                      borderColor: mainColor,
                      borderRadius: 10,
                      borderLength: 60,
                      borderWidth: 20,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
                  child: Text(
                    'Lakukan scan pada QR Code wajib retribusi untuk mendapatkan tagihan',
                    style: greyRdTextStyle,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
