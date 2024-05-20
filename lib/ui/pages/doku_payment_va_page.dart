import 'dart:math';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satupintu_app/blocs/payment_instruction/payment_instruction_bloc.dart';
import 'package:satupintu_app/blocs/tagihan/tagihan_bloc.dart';
import 'package:satupintu_app/model/doku_va_model.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/tagihan_detail_page.dart';
import 'package:satupintu_app/ui/pages/template_page.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';
import 'package:satupintu_app/ui/widget/failed_info.dart';
import 'package:satupintu_app/ui/widget/laoding_info.dart';
import 'package:timer_count_down/timer_count_down.dart';

class DokuPaymentVaPage extends StatefulWidget {
  final DokuVaModel virtualAccount;
  const DokuPaymentVaPage({super.key, required this.virtualAccount});

  @override
  State<DokuPaymentVaPage> createState() => _DokuPaymentVaPageState();
}

class _DokuPaymentVaPageState extends State<DokuPaymentVaPage> {
  bool _isExpired = false;
  late Duration duration;

  @override
  void initState() {
    String dateString = widget.virtualAccount.expiredDate!;
    duration = DateTime.parse(
            stringToDateTime(dateString, 'yyyy-MM-dd HH:mm:ss', false))
        .difference(DateTime.now().toLocal());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(jsonEncode(virtualAccount));
    return TemplateMain(
      title: 'Pembayaran Virtual Account',
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        // cross
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Batas waktu pembayaran',
                                style: greyRdTextStyle.copyWith(
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                stringToDateTime(
                                    widget.virtualAccount.expiredDate!,
                                    'EEEE, dd MMMM  yyyy HH:mm ',
                                    false),
                                style: darkRdBrownTextStyle.copyWith(
                                    fontWeight: bold, fontSize: 12),
                              ),
                            ],
                          ),
                          const Spacer(),
                          _isExpired == true
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: redColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100)),
                                  ),
                                  child: Text(
                                    'Waktu habis',
                                    style: whiteRdTextStyle.copyWith(
                                        fontSize: 10,
                                        fontWeight: semiBold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                )
                              : Countdown(
                                  seconds: duration.inSeconds.ceil(),
                                  build: (BuildContext context, double time) {
                                    int minutes = (time / 60).floor();
                                    int seconds = (time % 60).floor();

                                    String minutesStr =
                                        minutes.toString().padLeft(2, '0');
                                    String secondsStr =
                                        seconds.toString().padLeft(2, '0');

                                    return Text('$minutesStr:$secondsStr',
                                        style: orangeRdTextStyle.copyWith(
                                            fontSize: 24, fontWeight: bold));
                                  },
                                  interval: const Duration(seconds: 1),
                                  onFinished: () {
                                    setState(() {
                                      _isExpired = true;
                                    });
                                  },
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      DottedLine(
                        dashLength: 8,
                        lineThickness: 2.0,
                        dashColor: lightGreyColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            color: _isExpired == true
                                ? redColor.withAlpha(40)
                                : Colors.yellow.withAlpha(40),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          children: [
                            Icon(Icons.warning_amber_outlined,
                                color: _isExpired == true
                                    ? redColor
                                    : orangeColor),
                            const SizedBox(
                              width: 12,
                            ),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _isExpired == true
                                        ? 'Masa berlaku telah berakhir'
                                        : 'Yuk, buruan selesaikan pembayaranmu',
                                    style: darkRdBrownTextStyle.copyWith(
                                        fontWeight: bold, fontSize: 12),
                                  ),
                                  Text(
                                    _isExpired == true
                                        ? 'Jika anda belum melakukan pembayaran\n silahkan konfirmasi pembayaran yang baru'
                                        : 'Segera bayarkan tagihan anda sebelum batas\nwaktu berakhir',
                                    style: darkRdBrownTextStyle.copyWith(
                                        fontSize: 10),
                                    textAlign: TextAlign.justify,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Virtual Account ${widget.virtualAccount.bank!.toUpperCase()}',
                            style: darkRdBrownTextStyle.copyWith(
                              fontWeight: bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Spacer(),
                          Image.asset(
                            'assets/img_${widget.virtualAccount.bank}.png',
                            width: 55,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nomor Virtual Account',
                                style: greyRdTextStyle.copyWith(
                                    fontSize: 12, fontWeight: medium),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.virtualAccount.virtualAccountNumber
                                    .toString(),
                                style: blackInTextStyle.copyWith(
                                    fontWeight: black, fontSize: 18),
                              ),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.copy,
                                  color: mainColor,
                                ),
                                Text(
                                  'copy',
                                  style: mainRdTextStyle.copyWith(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DottedLine(
                        dashLength: 8,
                        lineThickness: 4.0,
                        dashColor: lightGreyColor,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Anda akan melakukan pembayaran senilai:',
                              style: greyRdTextStyle.copyWith(
                                  fontSize: 12, fontWeight: medium),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              formatCurrency(widget.virtualAccount.amount!),
                              style: mainRdTextStyle.copyWith(
                                  fontWeight: black, fontSize: 22),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              decoration: const BoxDecoration(),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        color: greenColor,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        'Info',
                                        style: darkRdBrownTextStyle.copyWith(
                                            fontWeight: bold, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'Pastikan tagihan virtual account anda sesuai dengan yang tertera pada nominal diatas',
                                    style: greyRdTextStyle.copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: bold,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Petunjuk pembayaran',
                        style: darkRdBrownTextStyle.copyWith(fontWeight: bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocProvider(
                        create: (context) => PaymentInstructionBloc()
                          ..add(PaymentInstructionGet(
                              widget.virtualAccount.howToPayApi!)),
                        child: BlocConsumer<PaymentInstructionBloc,
                            PaymentInstructionState>(
                          listener: (context, state) {
                            if (state is PaymentInstructionSuccess) {
                              print(state.data);
                            }
                          },
                          builder: (context, state) {
                            if (state is PaymentInstructionLoading) {
                              return const LoadingInfo();
                            }

                            if (state is PaymentInstructionSuccess) {
                              return Column(
                                  children: state.data
                                      .map(
                                        (instruction) => Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                width: 0.5,
                                                color: lightBlueColor),
                                          ),
                                          child: ExpansionTile(
                                              shape: const Border(),
                                              tilePadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              title: Text(
                                                instruction.channel!,
                                                style: mainRdTextStyle.copyWith(
                                                    fontWeight: bold,
                                                    fontSize: 14),
                                              ),
                                              children: instruction.steps!
                                                  .map(
                                                    (steps) => ListTile(
                                                      // contentPadding: EdgeInsets.zero,
                                                      minLeadingWidth: 6,
                                                      leading: const Icon(
                                                        Icons.circle,
                                                        size: 6,
                                                      ),
                                                      title: Text(
                                                        steps,
                                                        style:
                                                            darkRdBrownTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        12),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ),
                                                  )
                                                  .toList()),
                                        ),
                                      )
                                      .toList());
                            }

                            if (state is PaymentInstructionFailed) {
                              print(state.e);
                              return ErrorInfo(e: "Terjadi Kesalahan");
                            }

                            return ErrorInfo(e: "Terjadi Kesalahan");
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              BlocProvider(
                create: (context) => TagihanBloc(),
                child: BlocConsumer<TagihanBloc, TagihanState>(
                  listener: (context, state) {
                    if (state is TagihanDetailSuccess) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TagihanDetailPage(
                                  tagihanId: state.data.id!,
                                  status: state.data.status!)));
                    }

                    if (state is TagihanFailed) {
                      print(state.e);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: CustomSnackbar(
                            message: 'Terjadi kesalahan',
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
                    if (state is TagihanLoading) {
                      return const LoadingInfo();
                    }

                    return CustomFilledButton(
                      title: 'Cek Status Pembayaran',
                      onPressed: () {
                        print(widget.virtualAccount.tagihanId!);
                        context.read<TagihanBloc>().add(
                            TagihanGetDetail(widget.virtualAccount.tagihanId!));
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
