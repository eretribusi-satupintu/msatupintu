import 'dart:convert';
import 'dart:typed_data';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/services.dart';
import 'package:satupintu_app/model/tagihan_manual_model.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';

class TagihanManualDetailPage extends StatefulWidget {
  final TagihanManualModel tagihanModel;
  const TagihanManualDetailPage({super.key, required this.tagihanModel});

  @override
  State<TagihanManualDetailPage> createState() =>
      _TagihanManualDetailPageState();
}

class _TagihanManualDetailPageState extends State<TagihanManualDetailPage> {
  bool isSwitch = false;
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  bool _connected = false;
  BluetoothDevice? _device;
  String tips = 'no device connect';

  Future<void> enableBT() async {
    var result = await BluetoothEnable.enableBluetooth;

    if (result == "true") {
      print("Bluetooth enabled");
    } else {
      print("Bluetooth enabling failed");
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 4));

    bool isConnected = await bluetoothPrint.isConnected ?? false;

    bluetoothPrint.state.listen((state) {
      print('******************* cur device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'connect success';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'disconnect success';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        title: Text(
          'Detail Tagihan Manual',
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
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Center(
                      child: TicketWidget(
                        width: 350,
                        height: 400,
                        isCornerRounded: true,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/img_logo_with_background.png',
                                  width: 80,
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      stringToDateTime(
                                          widget.tagihanModel.createdAt!,
                                          'EEEE, dd MMMM  yyyy',
                                          true),
                                      style: greyRdTextStyle.copyWith(
                                          fontSize: 12),
                                    ),
                                    Text(
                                      stringToDateTime(
                                          widget.tagihanModel.createdAt!,
                                          'HH:mm',
                                          true),
                                      style: greyRdTextStyle.copyWith(
                                          fontSize: 12),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              '${widget.tagihanModel.itemRetribusi} ${widget.tagihanModel.detailTagihan}',
                              style: darkRdBrownTextStyle.copyWith(
                                  fontSize: 16, fontWeight: bold),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            DottedLine(
                              dashColor: greyColor,
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Petugas',
                                          style: greyRdTextStyle.copyWith(
                                              fontSize: 12),
                                        ),
                                        // const Spacer(),
                                        Text(
                                          widget.tagihanModel.petugas!,
                                          style: darkRdBrownTextStyle.copyWith(
                                              fontWeight: medium),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Wilayah',
                                          style: greyRdTextStyle.copyWith(
                                              fontSize: 12),
                                        ),
                                        Text(
                                          widget.tagihanModel.subwilayah!,
                                          style: darkRdBrownTextStyle.copyWith(
                                              fontWeight: medium),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    DottedLine(
                                      dashColor: greyColor,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Harga',
                                          style: greyRdTextStyle,
                                        ),
                                        const Spacer(),
                                        Text(
                                          formatCurrency(
                                              widget.tagihanModel.price!),
                                          style: darkInBrownTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: semiBold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                isSwitch == true
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Row(
                              children: [
                                Text(
                                  tips,
                                  style: darkRdBrownTextStyle.copyWith(
                                      fontSize: 10),
                                ),
                                const Spacer(),
                                SizedBox(
                                  child: StreamBuilder<bool>(
                                    stream: bluetoothPrint.isScanning,
                                    initialData: false,
                                    builder: (c, snapshot) {
                                      if (snapshot.data == true) {
                                        return TextButton(
                                          style: ButtonStyle(
                                              padding:
                                                  const MaterialStatePropertyAll(
                                                      EdgeInsets.zero),
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      redColor)),
                                          onPressed: () =>
                                              bluetoothPrint.stopScan(),
                                          child: Icon(
                                            Icons.stop,
                                            color: whiteColor,
                                          ),
                                        );
                                      } else {
                                        return TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      mainColor.withAlpha(30)),
                                              padding:
                                                  const MaterialStatePropertyAll(
                                                EdgeInsets.symmetric(
                                                    horizontal: 4, vertical: 0),
                                              ),
                                            ),
                                            onPressed: () =>
                                                bluetoothPrint.startScan(
                                                    timeout: const Duration(
                                                        seconds: 4)),
                                            child: Icon(
                                              Icons.search,
                                              color: mainColor,
                                            ));
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Perangkat yang tersedia',
                                  style: greyRdTextStyle.copyWith(fontSize: 12),
                                ),
                                const Spacer(),
                                LoadingAnimationWidget.staggeredDotsWave(
                                    color: mainColor, size: 14)
                              ],
                            ),
                            SizedBox(
                              height: 150,
                              child: SingleChildScrollView(
                                child: StreamBuilder<List<BluetoothDevice>>(
                                  stream: bluetoothPrint.scanResults,
                                  initialData: [],
                                  builder: (c, snapshot) => Column(
                                    children: snapshot.data!
                                        .map((d) => ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(
                                                d.name ?? '',
                                                style: darkRdBrownTextStyle
                                                    .copyWith(fontSize: 12),
                                              ),
                                              subtitle: Text(d.address ?? '',
                                                  style: darkRdBrownTextStyle
                                                      .copyWith(fontSize: 10)),
                                              onTap: () async {
                                                setState(() {
                                                  _device = d;
                                                });
                                              },
                                              trailing: _device != null &&
                                                      _device!.address ==
                                                          d.address
                                                  ? const Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                    )
                                                  : null,
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                OutlinedButton(
                                  child: Text('connect'),
                                  onPressed: _connected
                                      ? null
                                      : () async {
                                          if (_device != null &&
                                              _device!.address != null) {
                                            setState(() {
                                              tips = 'connecting...';
                                            });
                                            await bluetoothPrint
                                                .connect(_device!);
                                          } else {
                                            setState(() {
                                              tips = 'please select device';
                                            });
                                            print('please select device');
                                          }
                                        },
                                ),
                                const SizedBox(width: 10.0),
                                OutlinedButton(
                                  child: Text('disconnect'),
                                  onPressed: _connected
                                      ? () async {
                                          setState(() {
                                            tips = 'disconnecting...';
                                          });
                                          await bluetoothPrint.disconnect();
                                        }
                                      : null,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            DottedLine(
                              dashColor: mainColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ])
                    : const SizedBox(),
                Row(
                  children: [
                    Text(
                      'Bluetooth',
                      style: darkRdBrownTextStyle.copyWith(fontWeight: bold),
                    ),
                    const Spacer(),
                    isSwitch == true
                        ? Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline_outlined,
                                color: greenColor,
                                size: 15,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                'Bluetooth aktif',
                                style: darkRdBrownTextStyle.copyWith(
                                    fontSize: 10, fontWeight: bold),
                              )
                            ],
                          )
                        : const SizedBox(),
                    Switch(
                      focusColor: mainColor,
                      activeTrackColor: mainColor,
                      inactiveThumbColor: mainColor,
                      inactiveTrackColor: mainColor.withAlpha(40),
                      trackOutlineColor: MaterialStatePropertyAll(whiteColor),
                      value: isSwitch,
                      onChanged: (value) {
                        setState(() {
                          isSwitch = value;
                        });
                        if (value = true) {
                          enableBT();
                        }
                      },
                    ),
                  ],
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(mainColor),
                  ),
                  child: Text(
                    'print receipt(esc)',
                    style: whiteRdTextStyle.copyWith(fontWeight: bold),
                  ),
                  onPressed: _connected
                      ? () async {
                          Map<String, dynamic> config = Map();
                          config['width'] = 40; // 标签宽度，单位mm
                          config['height'] = 70; // 标签高度，单位mm
                          config['gap'] = 2;

                          List<LineText> list = [];
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '-----------------------------',
                              weight: 5, // Assuming 'weight: 1' means bold
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content:
                                  '${widget.tagihanModel.itemRetribusi} ${widget.tagihanModel.detailTagihan}',
                              weight: 5, // Assuming 'weight: 1' means bold
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '-----------------------------',
                              weight: 8, // Assuming 'weight: 1' means bold
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: stringToDateTime(
                                  widget.tagihanModel.createdAt!,
                                  'EEEE, dd MMMM  yyyy',
                                  true), // Replace 'harga' with the actual price
                              weight: 1,
                              size: 4, // Bold
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '-----------------------------',
                              weight: 5, // Assuming 'weight: 1' means bold
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'Petugas :',
                              align: LineText.ALIGN_LEFT,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: widget.tagihanModel.petugas,
                              align: LineText.ALIGN_LEFT,
                              linefeed: 1));

                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'Wilayah :',
                              align: LineText.ALIGN_LEFT,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: widget.tagihanModel.subwilayah,
                              align: LineText.ALIGN_LEFT,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '-----------------------------',
                              weight: 5, // Assuming 'weight: 1' means bold
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content:
                                  'Total: Rp. 500000', // Replace 'harga' with the actual price
                              weight: 4, // Bold
                              align: LineText.ALIGN_RIGHT,
                              linefeed: 1));

                          // List<LineText> list1 = [];
                          // ByteData data =
                          //     await rootBundle.load("assets/img_logo.png");
                          // List<int> imageBytes = data.buffer.asUint8List(
                          //     data.offsetInBytes, data.lengthInBytes);
                          // String base64Image = base64Encode(imageBytes);
                          // list1.add(LineText(
                          //   type: LineText.TYPE_IMAGE,
                          //   x: 10,
                          //   y: 10,
                          //   content: base64Image,
                          // ));

                          list.add(LineText(linefeed: 1));

                          await bluetoothPrint.printReceipt(config, list);
                          // await bluetoothPrint.printReceipt(config, list1);
                        }
                      : null,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
