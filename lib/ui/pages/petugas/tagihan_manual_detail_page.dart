import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/services.dart';
import 'package:satupintu_app/blocs/tagihan_manual/tagihan_manual_bloc.dart';
import 'package:satupintu_app/model/tagihan_manual_model.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/shared/values.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';
import 'package:satupintu_app/ui/widget/laoding_info.dart';
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
  XFile? image;
  String paymentImage = "";

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

  Future getImage(String media) async {
    final ImagePicker picker = ImagePicker();

    switch (media) {
      case 'galery':
        final XFile? imagePicker =
            await picker.pickImage(source: ImageSource.gallery);
        setImage(imagePicker!);

        break;
      case 'camera':
        final XFile? imagePicker = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
          maxWidth: 300,
          maxHeight: 500,
        );
        setImage(imagePicker!);
      default:
        return;
    }
  }

  void setImage(XFile file) {
    setState(() {
      Navigator.pop(context, 'refresh');
      image = file;
    });
  }

  @override
  void initState() {
    super.initState();
    paymentImage = widget.tagihanModel.paymentImage ?? "";
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
                                // Image.asset(
                                //   'assets/img_logo_with_background.png',
                                //   width: 80,
                                // ),
                                Text(
                                  widget.tagihanModel.paymentMethod!,
                                  style: mainRdTextStyle.copyWith(
                                    fontWeight: bold,
                                    fontSize: 18,
                                  ),
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
          widget.tagihanModel.paymentMethod == "QRIS"
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: paymentImage != ""
                      ? GestureDetector(
                          onTap: () {
                            paymentImageDialog(context, paymentImage);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  color: mainColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Tampilkan bukti bayar',
                                  style: greyRdTextStyle,
                                )
                              ],
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            mediaChooseDialog(context);
                          },
                          child: Column(
                            children: [
                              Text(
                                'Upload bukti bayar',
                                style: darkRdBrownTextStyle.copyWith(
                                  fontWeight: bold,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: mainColor.withAlpha(90),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: image == null
                                    ? Center(
                                        child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/ic_image_upload.png',
                                            width: 70,
                                          ),
                                          Text(
                                            'Pilih File',
                                            style: mainRdTextStyle,
                                          )
                                        ],
                                      ))
                                    : Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.file(
                                            File(image!.path),
                                            height: 450,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 14, vertical: 6),
                                            decoration: BoxDecoration(
                                                color: mainColor.withAlpha(50),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Text(
                                              'Ketuk untuk mengganti file',
                                              style: mainRdTextStyle.copyWith(
                                                  fontWeight: bold),
                                            ),
                                          )
                                        ],
                                      ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              BlocProvider(
                                create: (context) => TagihanManualBloc(),
                                child: Center(
                                  child: BlocConsumer<TagihanManualBloc,
                                      TagihanManualState>(
                                    listener: (context, state) {
                                      if (state
                                          is TagihanManualUploadImageSuccess) {
                                        print(state.image);
                                        setState(() {
                                          paymentImage = state.image;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: CustomSnackbar(
                                              message:
                                                  "Berhasil menggunggah bukti bayar",
                                              status: 'success',
                                            ),
                                            behavior: SnackBarBehavior.fixed,
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                          ),
                                        );
                                      }

                                      if (state is TagihanManualFailed) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
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
                                    },
                                    builder: (context, state) {
                                      if (state is TagihanManualLoading) {
                                        return LoadingInfo();
                                      }
                                      return CustomFilledButton(
                                          title: "Upload bukti bayar",
                                          onPressed: () {
                                            context
                                                .read<TagihanManualBloc>()
                                                .add(TagihanManualImagePost(
                                                  widget.tagihanModel.id!,
                                                  base64Encode(
                                                    File(image!.path)
                                                        .readAsBytesSync(),
                                                  ),
                                                ));
                                          });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10)),
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
                                                            mainColor
                                                                .withAlpha(30)),
                                                    padding:
                                                        const MaterialStatePropertyAll(
                                                      EdgeInsets.symmetric(
                                                          horizontal: 4,
                                                          vertical: 0),
                                                    ),
                                                  ),
                                                  onPressed: () =>
                                                      bluetoothPrint.startScan(
                                                          timeout:
                                                              const Duration(
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
                                        style: greyRdTextStyle.copyWith(
                                            fontSize: 12),
                                      ),
                                      const Spacer(),
                                      LoadingAnimationWidget.staggeredDotsWave(
                                          color: mainColor, size: 14)
                                    ],
                                  ),
                                  SizedBox(
                                    height: 150,
                                    child: SingleChildScrollView(
                                      child:
                                          StreamBuilder<List<BluetoothDevice>>(
                                        stream: bluetoothPrint.scanResults,
                                        initialData: [],
                                        builder: (c, snapshot) => Column(
                                          children: snapshot.data!
                                              .map((d) => ListTile(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    title: Text(
                                                      d.name ?? '',
                                                      style:
                                                          darkRdBrownTextStyle
                                                              .copyWith(
                                                                  fontSize: 12),
                                                    ),
                                                    subtitle: Text(
                                                        d.address ?? '',
                                                        style:
                                                            darkRdBrownTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        10)),
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
                                                    tips =
                                                        'please select device';
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
                                                await bluetoothPrint
                                                    .disconnect();
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
                            'Pengaturan\nBluetooth',
                            style:
                                darkRdBrownTextStyle.copyWith(fontWeight: bold),
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
                            trackOutlineColor:
                                MaterialStatePropertyAll(whiteColor),
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
                          'Cetak Bukti Bayar',
                          style: whiteRdTextStyle.copyWith(fontWeight: bold),
                        ),
                        onPressed: _connected
                            ? () async {
                                Map<String, dynamic> config = Map();
                                config['width'] = 40;
                                config['height'] = 70;
                                config['gap'] = 2;

                                List<LineText> list = [];
                                list.add(LineText(
                                    type: LineText.TYPE_TEXT,
                                    content: '-----------------------------',
                                    weight: 5,
                                    align: LineText.ALIGN_CENTER,
                                    linefeed: 1));
                                list.add(LineText(
                                    type: LineText.TYPE_TEXT,
                                    content:
                                        '${widget.tagihanModel.itemRetribusi} ${widget.tagihanModel.detailTagihan}',
                                    weight: 5,
                                    align: LineText.ALIGN_CENTER,
                                    linefeed: 1));
                                list.add(LineText(
                                    type: LineText.TYPE_TEXT,
                                    content: '-----------------------------',
                                    weight: 8,
                                    align: LineText.ALIGN_CENTER,
                                    linefeed: 1));
                                list.add(LineText(
                                    type: LineText.TYPE_TEXT,
                                    content: stringToDateTime(
                                        widget.tagihanModel.createdAt!,
                                        'EEEE, dd MMMM  yyyy',
                                        true),
                                    weight: 1,
                                    size: 4,
                                    align: LineText.ALIGN_CENTER,
                                    linefeed: 1));
                                list.add(LineText(
                                    type: LineText.TYPE_TEXT,
                                    content: '-----------------------------',
                                    weight: 5,
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
                                    weight: 5,
                                    align: LineText.ALIGN_CENTER,
                                    linefeed: 1));
                                list.add(LineText(
                                    type: LineText.TYPE_TEXT,
                                    content:
                                        'Total: ${formatCurrency(widget.tagihanModel.price!)}',
                                    weight: 4, // Bold
                                    align: LineText.ALIGN_RIGHT,
                                    linefeed: 1));

                                list.add(LineText(linefeed: 1));

                                await bluetoothPrint.printReceipt(config, list);
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Future<void> mediaChooseDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            'Pilih Media',
            style: mainRdTextStyle.copyWith(fontSize: 14, fontWeight: bold),
            textAlign: TextAlign.center,
          ),
          content: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  await getImage('camera');
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: mainColor.withAlpha(80),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/ic_camera.png',
                        width: 45,
                        height: 45,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Kamera',
                        style: darkRdBrownTextStyle.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  await getImage('galery');
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: mainColor.withAlpha(80),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/ic_galery.png',
                        width: 45,
                        height: 45,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Galery',
                        style: darkRdBrownTextStyle.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> paymentImageDialog(BuildContext context, String image) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: SizedBox(
            child: Image.network(
              "$publicUrl/$image",
            ),
          ),
        );
      },
    );
  }
}
