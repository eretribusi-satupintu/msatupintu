import 'dart:async';
import 'dart:convert';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satupintu_app/blocs/subwilayah/subwilayah_bloc.dart';
import 'package:satupintu_app/shared/theme.dart';

class BuktiBayarPrintPage extends StatefulWidget {
  const BuktiBayarPrintPage({super.key});

  @override
  State<BuktiBayarPrintPage> createState() => _BuktiBayarPrintPageState();
}

class _BuktiBayarPrintPageState extends State<BuktiBayarPrintPage> {
  // BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  // bool _connected = false;
  // BluetoothDevice? _device;
  // String tips = 'no device connect';

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initBluetooth() async {
  //   bluetoothPrint.startScan(timeout: Duration(seconds: 4));

  //   bool isConnected = await bluetoothPrint.isConnected ?? false;

  //   bluetoothPrint.state.listen((state) {
  //     print('******************* cur device status: $state');

  //     switch (state) {
  //       case BluetoothPrint.CONNECTED:
  //         setState(() {
  //           _connected = true;
  //           tips = 'connect success';
  //         });
  //         break;
  //       case BluetoothPrint.DISCONNECTED:
  //         setState(() {
  //           _connected = false;
  //           tips = 'disconnect success';
  //         });
  //         break;
  //       default:
  //         break;
  //     }
  //   });

  //   if (!mounted) return;

  //   if (isConnected) {
  //     setState(() {
  //       _connected = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Cetak bukti bayar',
            style: mainRdTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
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
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 4,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Daftar sub wilayah',
                style: darkRdBrownTextStyle.copyWith(fontWeight: bold),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: BlocProvider(
                create: (context) =>
                    SubwilayahBloc()..add(GetPetugasSubWilayah()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: mainColor.withAlpha(40)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        'Laguboti',
                        style: darkRdBrownTextStyle.copyWith(fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
