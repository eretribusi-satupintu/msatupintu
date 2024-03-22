import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:satupintu_app/model/doku_va_model.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/template_page.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class DokuPaymentVaPage extends StatelessWidget {
  final DokuVaModel virtualAccount;
  const DokuPaymentVaPage({super.key, required this.virtualAccount});

  @override
  Widget build(BuildContext context) {
    // print(jsonEncode(virtualAccount));
    return TemplateMain(
      body: Column(
        children: [
          Column(
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
                        iso8601toDateTime(virtualAccount.expiredDate!),
                        style: darkRdBrownTextStyle.copyWith(
                            fontWeight: bold, fontSize: 12),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Text(
                  //   '00:59:12',
                  //   style: orangeRdTextStyle.copyWith(fontWeight: bold),
                  // )
                  Countdown(
                    seconds: 60,
                    build: (BuildContext context, double time) {
                      // Calculate minutes and seconds from the remaining time
                      int minutes = (time / 60).floor();
                      int seconds = (time % 60).floor();

                      // Format the remaining time as mm:ss
                      String minutesStr = minutes.toString().padLeft(2, '0');
                      String secondsStr = seconds.toString().padLeft(2, '0');

                      return Text('$minutesStr:$secondsStr',
                          style: orangeRdTextStyle.copyWith(
                              fontSize: 24, fontWeight: bold));
                    },
                    interval: Duration(seconds: 1), // Update every second
                    onFinished: () {
                      return Text(
                        '00:00',
                        style: redRdTextStyle,
                      );
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.yellow.withAlpha(40),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_outlined, color: orangeColor),
                    const SizedBox(
                      width: 12,
                    ),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Yuk, buruan selesaikan pembayaranmu',
                            style: darkRdBrownTextStyle.copyWith(
                                fontWeight: bold, fontSize: 12),
                          ),
                          Text(
                            'Segera bayarkan tagihan anda sebelum batas\nwaktu berakhir',
                            style: darkRdBrownTextStyle.copyWith(fontSize: 10),
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
                    'Virtual Account BRI',
                    style: darkRdBrownTextStyle.copyWith(
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/img_bri.png',
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
                        virtualAccount.virtualAccountNumber.toString(),
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
                      '20.000',
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
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          CustomFilledButton(
            title: 'Cek Status Pembayaran',
            onPressed: () {},
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
      title: 'Virtual Account Number',
    );
  }
}
