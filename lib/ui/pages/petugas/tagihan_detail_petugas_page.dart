import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/petugas/petugas_bloc.dart';
import 'package:satupintu_app/blocs/tagihan/tagihan_bloc.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/petugas/transaksi_petugas_success_page.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';
import 'package:satupintu_app/ui/widget/failed_info.dart';
import 'package:satupintu_app/ui/widget/laoding_info.dart';

class TagihanDetailPetugas extends StatefulWidget {
  final int tagihanId;
  final bool? isStored;

  const TagihanDetailPetugas({
    super.key,
    required this.tagihanId,
    this.isStored,
  });

  @override
  State<TagihanDetailPetugas> createState() => _TagihanDetailPetugasState();
}

class _TagihanDetailPetugasState extends State<TagihanDetailPetugas> {
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
        backgroundColor: mainColor,
        title: Text(
          'Detail Tagihan',
          style: whiteRdTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
              size: 18,
            )),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) =>
              TagihanBloc()..add(TagihanGetDetail(widget.tagihanId)),
          child: BlocBuilder<TagihanBloc, TagihanState>(
            builder: (context, state) {
              if (state is TagihanLoading) {
                return const LoadingInfo();
              }

              if (state is TagihanDetailSuccess) {
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 50, left: 18, right: 18),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: whiteColor,
                            // border: Border.all(
                            //     width: 6,
                            //     color: state.data.status == 'VERIFIED'
                            //         ? greenColor.withAlpha(60)
                            //         : lightBlueColor),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 27,
                              ),
                              Text(
                                state.data.kedinasanName!,
                                style:
                                    darkRdBrownTextStyle.copyWith(fontSize: 14),
                              ),
                              Text(
                                'Retribusi ${state.data.retribusiName!}',
                                style:
                                    darkRdBrownTextStyle.copyWith(fontSize: 14),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                formatCurrency(
                                    int.parse(state.data.price.toString())),
                                style: darkRdBrownTextStyle.copyWith(
                                    fontSize: 22, fontWeight: bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                state.data.invoiceNumber!,
                                style: greyRdTextStyle.copyWith(
                                  fontSize: 10,
                                  fontWeight: regular,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              DottedLine(
                                dashLength: 8,
                                lineThickness: 4.0,
                                dashColor: orangeColor,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              tagihanInfo('Tagihan', state.data.tagihanName!),
                              tagihanInfo('Item Retribusi',
                                  state.data.itemRetribusiName!),
                              tagihanInfo(
                                'Batas pembayaran',
                                DateFormat('dd MMMM yyyy')
                                    .format(DateTime.parse(state.data.dueDate!))
                                    .toString(),
                              ),
                              DateTime.parse(state.data.dueDate!)
                                          .isBefore(DateTime.now()) &&
                                      DateTime.parse(state.data.dueDate!)
                                              .difference(DateTime.now())
                                              .inDays !=
                                          0
                                  ? Text(
                                      '( Anda telah melebihi batas akhir pembayaran )',
                                      style: redRdTextStyle.copyWith(
                                          fontSize: 10, fontWeight: bold),
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 15,
                              ),
                              DottedLine(
                                dashLength: 8,
                                lineThickness: 2.0,
                                dashColor: lightGreyColor,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              state.data.status == 'VERIFIED'
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Pembayaran Berhasil!',
                                          style: mainRdTextStyle.copyWith(
                                              fontWeight: bold, fontSize: 18),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          stringToDateTime(
                                              state.data.paymentTime!,
                                              'EEEE dd MMMM yyyy: hh:mm WIB',
                                              false),
                                          style: greyRdTextStyle.copyWith(
                                              fontSize: 12),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Text(
                                          'Tagihan dilakukan pada tanggal',
                                          style: greyRdTextStyle.copyWith(
                                              fontSize: 12),
                                        ),
                                        Text(
                                          DateFormat('dd MMMM yyyy')
                                              .format(DateTime.now())
                                              .toString(),
                                          style: greyRdTextStyle.copyWith(
                                              fontSize: 12, fontWeight: bold),
                                        ),
                                      ],
                                    )
                            ],
                          ),
                        ),
                        state.data.status == 'VERIFIED'
                            ? Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: greenColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 6,
                                      color: whiteColor.withAlpha(80)),
                                ),
                                child: Icon(
                                  Icons.check_circle_outline_rounded,
                                  size: 40,
                                  color: whiteColor,
                                ),
                              )
                            : state.data.status == 'REQUEST'
                                ? Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: orangeColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 6, color: whiteColor),
                                    ),
                                    child: Icon(
                                      Icons.lock_clock,
                                      color: whiteColor,
                                      size: 32,
                                    ))
                                : Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: mainColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 6, color: whiteColor),
                                    ),
                                    child: Image.asset(
                                      'assets/ic_bill.png',
                                      width: 28,
                                      height: 27,
                                      color: whiteColor,
                                    ),
                                  )
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    state.data.status == 'VERIFIED'
                        ? Container(
                            margin: const EdgeInsets.symmetric(horizontal: 18),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline_rounded,
                                      color: greenColor,
                                    ),
                                    Text(
                                      'Tagihan ini telah dibayar secara tunai',
                                      style: greyRdTextStyle.copyWith(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                widget.isStored != true
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 36),
                                        decoration: BoxDecoration(
                                          color: redColor.withAlpha(40),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: TextButton(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.cancel_outlined,
                                                size: 20,
                                                color: redColor,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                'Batalkan Pembayaran',
                                                style: redRdTextStyle.copyWith(
                                                    fontWeight: medium),
                                              )
                                            ],
                                          ),
                                          onPressed: () =>
                                              _dialogBuilderCancelPayment(
                                                  context,
                                                  state.data.id!,
                                                  state
                                                      .data.wajibRetribusiName!,
                                                  state.data.price!),
                                        ),
                                      )
                                    : const SizedBox(),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      isSwitch == true
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        tips,
                                                        style:
                                                            darkRdBrownTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        10),
                                                      ),
                                                      const Spacer(),
                                                      SizedBox(
                                                        child:
                                                            StreamBuilder<bool>(
                                                          stream: bluetoothPrint
                                                              .isScanning,
                                                          initialData: false,
                                                          builder:
                                                              (c, snapshot) {
                                                            if (snapshot.data ==
                                                                true) {
                                                              return TextButton(
                                                                style: ButtonStyle(
                                                                    padding: const MaterialStatePropertyAll(
                                                                        EdgeInsets
                                                                            .zero),
                                                                    backgroundColor:
                                                                        MaterialStatePropertyAll(
                                                                            redColor)),
                                                                onPressed: () =>
                                                                    bluetoothPrint
                                                                        .stopScan(),
                                                                child: Icon(
                                                                  Icons.stop,
                                                                  color:
                                                                      whiteColor,
                                                                ),
                                                              );
                                                            } else {
                                                              return TextButton(
                                                                  style:
                                                                      ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStatePropertyAll(
                                                                            mainColor.withAlpha(30)),
                                                                    padding:
                                                                        const MaterialStatePropertyAll(
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              4,
                                                                          vertical:
                                                                              0),
                                                                    ),
                                                                  ),
                                                                  onPressed: () =>
                                                                      bluetoothPrint.startScan(
                                                                          timeout:
                                                                              const Duration(seconds: 4)),
                                                                  child: Icon(
                                                                    Icons
                                                                        .search,
                                                                    color:
                                                                        mainColor,
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
                                                        style: greyRdTextStyle
                                                            .copyWith(
                                                                fontSize: 12),
                                                      ),
                                                      const Spacer(),
                                                      LoadingAnimationWidget
                                                          .staggeredDotsWave(
                                                              color: mainColor,
                                                              size: 14)
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 150,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: StreamBuilder<
                                                          List<
                                                              BluetoothDevice>>(
                                                        stream: bluetoothPrint
                                                            .scanResults,
                                                        initialData: [],
                                                        builder:
                                                            (c, snapshot) =>
                                                                Column(
                                                          children:
                                                              snapshot.data!
                                                                  .map((d) =>
                                                                      ListTile(
                                                                        contentPadding:
                                                                            EdgeInsets.zero,
                                                                        title:
                                                                            Text(
                                                                          d.name ??
                                                                              '',
                                                                          style:
                                                                              darkRdBrownTextStyle.copyWith(fontSize: 12),
                                                                        ),
                                                                        subtitle: Text(
                                                                            d.address ??
                                                                                '',
                                                                            style:
                                                                                darkRdBrownTextStyle.copyWith(fontSize: 10)),
                                                                        onTap:
                                                                            () async {
                                                                          setState(
                                                                              () {
                                                                            _device =
                                                                                d;
                                                                          });
                                                                        },
                                                                        trailing: _device != null &&
                                                                                _device!.address == d.address
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      OutlinedButton(
                                                        child: Text('connect'),
                                                        onPressed: _connected
                                                            ? null
                                                            : () async {
                                                                if (_device !=
                                                                        null &&
                                                                    _device!.address !=
                                                                        null) {
                                                                  setState(() {
                                                                    tips =
                                                                        'connecting...';
                                                                  });
                                                                  await bluetoothPrint
                                                                      .connect(
                                                                          _device!);
                                                                } else {
                                                                  setState(() {
                                                                    tips =
                                                                        'please select device';
                                                                  });
                                                                  print(
                                                                      'please select device');
                                                                }
                                                              },
                                                      ),
                                                      const SizedBox(
                                                          width: 10.0),
                                                      OutlinedButton(
                                                        child:
                                                            Text('disconnect'),
                                                        onPressed: _connected
                                                            ? () async {
                                                                setState(() {
                                                                  tips =
                                                                      'disconnecting...';
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
                                            'Pengaturan\nbluetooth ',
                                            style:
                                                darkRdBrownTextStyle.copyWith(
                                                    fontWeight: bold,
                                                    fontSize: 12),
                                          ),
                                          const Spacer(),
                                          isSwitch == true
                                              ? Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .check_circle_outline_outlined,
                                                      color: greenColor,
                                                      size: 15,
                                                    ),
                                                    const SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text(
                                                      'Bluetooth aktif',
                                                      style:
                                                          darkRdBrownTextStyle
                                                              .copyWith(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      bold),
                                                    )
                                                  ],
                                                )
                                              : const SizedBox(),
                                          Switch(
                                            focusColor: mainColor,
                                            activeTrackColor: mainColor,
                                            inactiveThumbColor: mainColor,
                                            inactiveTrackColor:
                                                mainColor.withAlpha(40),
                                            trackOutlineColor:
                                                MaterialStatePropertyAll(
                                                    whiteColor),
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
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  mainColor),
                                        ),
                                        child: Text(
                                          'print receipt(esc)',
                                          style: whiteRdTextStyle.copyWith(
                                              fontWeight: bold),
                                        ),
                                        onPressed: _connected
                                            ? () async {
                                                Map<String, dynamic> config =
                                                    Map();
                                                config['width'] = 40;
                                                config['height'] = 70;
                                                config['gap'] = 2;

                                                List<LineText> list = [];
                                                list.add(LineText(
                                                    type: LineText.TYPE_TEXT,
                                                    content:
                                                        '-----------------------------',
                                                    weight: 5,
                                                    align:
                                                        LineText.ALIGN_CENTER,
                                                    linefeed: 1));
                                                list.add(LineText(
                                                    type: LineText.TYPE_TEXT,
                                                    content:
                                                        'Kedinasan ${state.data.kedinasanName} ',
                                                    weight: 5,
                                                    align:
                                                        LineText.ALIGN_CENTER,
                                                    linefeed: 1));
                                                list.add(LineText(
                                                    type: LineText.TYPE_TEXT,
                                                    content:
                                                        '-----------------------------',
                                                    weight: 8,
                                                    align:
                                                        LineText.ALIGN_CENTER,
                                                    linefeed: 1));
                                                list.add(LineText(
                                                    type: LineText.TYPE_TEXT,
                                                    content:
                                                        'Retribusi ${state.data.retribusiName} ',
                                                    weight: 5,
                                                    align:
                                                        LineText.ALIGN_CENTER,
                                                    linefeed: 1));
                                                list.add(LineText(
                                                    type: LineText.TYPE_TEXT,
                                                    content:
                                                        state.data.tagihanName,
                                                    align:
                                                        LineText.ALIGN_CENTER,
                                                    linefeed: 1));

                                                list.add(LineText(
                                                    type: LineText.TYPE_TEXT,
                                                    content:
                                                        '-----------------------------',
                                                    weight: 8,
                                                    align:
                                                        LineText.ALIGN_CENTER,
                                                    linefeed: 1));

                                                list.add(LineText(
                                                    type: LineText.TYPE_TEXT,
                                                    content:
                                                        'Wajib Retribusi :',
                                                    align: LineText.ALIGN_LEFT,
                                                    linefeed: 1));
                                                list.add(LineText(
                                                    type: LineText.TYPE_TEXT,
                                                    content: state.data
                                                        .wajibRetribusiName,
                                                    align: LineText.ALIGN_LEFT,
                                                    linefeed: 1));

                                                list.add(LineText(
                                                    type: LineText.TYPE_TEXT,
                                                    content: 'Item Retribusi :',
                                                    align: LineText.ALIGN_LEFT,
                                                    linefeed: 1));
                                                list.add(LineText(
                                                    type: LineText.TYPE_TEXT,
                                                    content: state
                                                        .data.itemRetribusiName,
                                                    align: LineText.ALIGN_LEFT,
                                                    linefeed: 1));

                                                list.add(LineText(
                                                    type: LineText.TYPE_TEXT,
                                                    content:
                                                        'Waktu Pembayaran :',
                                                    align: LineText.ALIGN_LEFT,
                                                    linefeed: 1));
                                                list.add(LineText(
                                                    type: LineText.TYPE_TEXT,
                                                    content: stringToDateTime(
                                                        state.data.paymentTime!,
                                                        'EEEE dd MMMM yyyy HH:mm WIB',
                                                        true),
                                                    align: LineText.ALIGN_LEFT,
                                                    linefeed: 1));

                                                list.add(LineText(
                                                    type: LineText.TYPE_TEXT,
                                                    content:
                                                        '-----------------------------',
                                                    weight: 5,
                                                    align:
                                                        LineText.ALIGN_CENTER,
                                                    linefeed: 1));
                                                list.add(LineText(
                                                    type: LineText.TYPE_TEXT,
                                                    content:
                                                        'Total: ${formatCurrency(state.data.price!)}',
                                                    weight: 4, // Bold
                                                    align: LineText.ALIGN_RIGHT,
                                                    linefeed: 1));

                                                list.add(LineText(linefeed: 1));

                                                await bluetoothPrint
                                                    .printReceipt(config, list);
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
                          )
                        : state.data.status == 'REQUEST'
                            ? Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 23, horizontal: 19),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.info_outline,
                                          color: mainColor,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Perhatian',
                                            style:
                                                darkRdBrownTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: bold,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Anda telah mengajukan pembatalan pembayaran untuk tagihan, dan sedang menunggu konfirmasi dari pihan admin',
                                      style: darkRdBrownTextStyle.copyWith(
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 23, horizontal: 19),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.info_outline,
                                          color: mainColor,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Perhatian',
                                            style:
                                                darkRdBrownTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: bold,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Pastikan anda telah menerima uang sesuai dengan nominal yang tertera',
                                      style: darkRdBrownTextStyle.copyWith(
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Total',
                                          style: blackInTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          formatCurrency(state.data.price!),
                                          style: mainRdTextStyle.copyWith(
                                            fontSize: 18,
                                            fontWeight: bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    state.data.status == 'WAITING'
                                        ? Text(
                                            'Tagihan sedang mengunggu konfirmasi admin untuk pembatalan pembayaran',
                                            style: orangeRdTextStyle.copyWith(
                                                fontWeight: bold),
                                            textAlign: TextAlign.center,
                                          )
                                        : CustomFilledButton(
                                            title: 'Konfirmasi Pembayaran',
                                            onPressed: () => _dialogBuilder(
                                                context,
                                                state.data.id!,
                                                state.data.wajibRetribusiName!,
                                                state.data.price!),
                                          )
                                  ],
                                ),
                              ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }

              if (state is TagihanFailed) {
                return Center(
                  child: ErrorInfo(
                    e: state.e,
                  ),
                );
              }

              return const ErrorInfo(
                e: "Terjadi Kesalahan",
              );
            },
          ),
        ),
      ),
    );
  }

  Widget tagihanInfo(String key, String value) {
    return Container(
      margin: const EdgeInsets.only(right: 12, left: 12, bottom: 15),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key.toString(),
            style: greyRdTextStyle.copyWith(fontSize: 10),
          ),
          Text(
            value.toString(),
            style: greyRdTextStyle.copyWith(
              fontSize: 12,
              fontWeight: bold,
            ),
          )
        ],
      ),
    );
  }

  Future<void> _dialogBuilder(
      BuildContext context, int tagihanId, String name, int price) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          title: Text(
            'Apakah and yakin?',
            style:
                darkRdBrownTextStyle.copyWith(fontSize: 18, fontWeight: bold),
          ),
          content: RichText(
              text: TextSpan(
            children: [
              const TextSpan(
                text:
                    'Anda akan melakukan konfirmasi untuk pembayaran tagihan ',
              ),
              TextSpan(text: name, style: TextStyle(fontWeight: bold)),
              const TextSpan(text: ' senilai '),
              TextSpan(
                text: formatCurrency(price),
                style: TextStyle(fontWeight: bold),
              )
            ],
            style: darkRdBrownTextStyle,
          )),
          actions: <Widget>[
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => PetugasBloc(),
                ),
              ],
              child: BlocConsumer<PetugasBloc, PetugasState>(
                listener: (context, state) async {
                  if (state is PetugasSuccess) {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SuccessPage(
                          message:
                              'Konfirmasi pembayaran tunai telah berhasil dilakukan',
                        ),
                      ),
                    );
                  }

                  if (state is PetugasFailed) {
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
                },
                builder: (context, state) {
                  if (state is PetugasLoading) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          LoadingAnimationWidget.staggeredDotsWave(
                              color: mainColor, size: 30),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Permintaan anda sedang diproses',
                            style: darkRdBrownTextStyle,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    );
                  }
                  return CustomFilledButton(
                      title: 'Lanjutkan',
                      onPressed: () {
                        context
                            .read<PetugasBloc>()
                            .add(PetugasBillPaid(tagihanId));
                      });
                },
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            CustomOutlinedButton(
                title: 'Batal',
                color: darkBrownColor,
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

  Future<void> _dialogBuilderCancelPayment(
      BuildContext context, int tagihanId, String name, int price) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          title: Text(
            'Apakah and yakin?',
            style:
                darkRdBrownTextStyle.copyWith(fontSize: 18, fontWeight: bold),
          ),
          content: RichText(
              text: TextSpan(
            children: [
              const TextSpan(
                text:
                    'Anda akan melakukan konfirmasi untuk membatalakan pembayaran tagihan ',
              ),
              TextSpan(text: name, style: TextStyle(fontWeight: bold)),
              const TextSpan(text: ' senilai '),
              TextSpan(
                text: formatCurrency(price),
                style: TextStyle(fontWeight: bold),
              )
            ],
            style: darkRdBrownTextStyle,
          )),
          actions: <Widget>[
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => PetugasBloc(),
                ),
                BlocProvider(
                  create: (context) => TagihanBloc(),
                ),
              ],
              child: BlocConsumer<PetugasBloc, PetugasState>(
                listener: (context, state) async {
                  if (state is PetugasSuccess) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SuccessPage(
                          message:
                              'Konfirmasi Pembatalan Pembayaran Tunai telah berhasdil dilakukan',
                        ),
                      ),
                    );
                  }

                  if (state is PetugasFailed) {
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
                },
                builder: (context, state) {
                  if (state is PetugasLoading) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LoadingAnimationWidget.staggeredDotsWave(
                              color: mainColor, size: 30),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Permintaan anda sedang diproses',
                            style: darkRdBrownTextStyle,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    );
                  }
                  return CustomFilledButton(
                      title: 'Lanjutkan',
                      onPressed: () {
                        context
                            .read<PetugasBloc>()
                            .add(PetugasBillPaidCancel(tagihanId));
                      });
                },
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            CustomOutlinedButton(
                title: 'Batal',
                color: darkBrownColor,
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }
}
