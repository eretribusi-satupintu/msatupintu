import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:satupintu_app/model/tagihan_model.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:dotted_line/dotted_line.dart';

class TagihanDetailPage extends StatefulWidget {
  final TagihanModel tagihan;
  const TagihanDetailPage({super.key, required this.tagihan});

  @override
  State<TagihanDetailPage> createState() => _TagihanDetailPageState();
}

class _TagihanDetailPageState extends State<TagihanDetailPage> {
  String selectedBank = "";
  bool isBankSelected = false;
  List<String> bankList = ['bri', 'bni', 'mandiri'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          title: Text(
            'Detail Tagihan',
            style: whiteInTextStyle.copyWith(fontWeight: bold, fontSize: 18),
          ),
          toolbarHeight: 50,
          iconTheme: IconThemeData(color: whiteColor),
          backgroundColor: mainColor,
          elevation: null,
          centerTitle: true,
        ),
        body: ListView(
          // padding: const EdgeInsets.symmetric(horizontal: 18),
          children: [
            Stack(
              // alignment: AlignmentDirectional.center,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: lightBlueColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: Column(children: [
                    const SizedBox(
                      height: 22,
                    ),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 50),
                            width: 284,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: whiteColor,
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 27,
                                ),
                                Text(
                                  'Rp. 15.000',
                                  style: darRdBrownTextStyle.copyWith(
                                      fontSize: 22, fontWeight: bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'INV-123123123123',
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
                                tagihanInfo('Tagihan', 'Retribsui Pasar'),
                                tagihanInfo('Pasar', 'Balige'),
                                tagihanInfo('No unit', 'AIIK04'),
                                DottedLine(
                                  dashLength: 8,
                                  lineThickness: 2.0,
                                  dashColor: lightGreyColor,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Total',
                                      style: blackRdTextStyle.copyWith(
                                          fontSize: 10, fontWeight: bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '15.000',
                                      style: blackRdTextStyle.copyWith(
                                          fontSize: 16, fontWeight: bold),
                                    ),
                                    const SizedBox(
                                      height: 48,
                                    ),
                                  ],
                                ),
                                Text(
                                  'TagihaN dilakukan pada tanggal',
                                  style: greyRdTextStyle.copyWith(fontSize: 12),
                                ),
                                Text(
                                  '15 Januari 2024',
                                  style: greyRdTextStyle.copyWith(
                                      fontSize: 12, fontWeight: bold),
                                ),
                              ],
                            )),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: mainColor,
                            shape: BoxShape.circle,
                            border: Border.all(width: 6, color: lightBlueColor),
                          ),
                          child: Image.asset(
                            'assets/ic_bill.png',
                            width: 28,
                            height: 27,
                            color: whiteColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                  ]),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18),
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
                        Text(
                          'Pastikan nominl tagihan sudah sesuai dengan kesepakatan dan ketentuan',
                          style: darRdBrownTextStyle.copyWith(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 21,
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
                              'Rp. 100.000',
                              style: blackInTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomFilledButton(
                          title: 'Bayar Non Tunai',
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => DraggableScrollableSheet(
                                  snap: true,
                                  initialChildSize: 0.8,
                                  builder: (_, controller) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 16),
                                      child: ListView(
                                        controller: controller,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 4,
                                                width: 49,
                                                color: mainColor,
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Text(
                                                'Pilih Metode Pembayaran',
                                                style:
                                                    blackRdTextStyle.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: bold),
                                              ),
                                              const SizedBox(
                                                height: 44,
                                              ),
                                              ExpansionTile(
                                                title: Text(
                                                  'Virtual Account',
                                                  style:
                                                      mainRdTextStyle.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: bold),
                                                ),
                                                collapsedShape: Border.all(
                                                    width: 2,
                                                    color: mainColor
                                                        .withAlpha(25)),
                                                subtitle: Text(
                                                  'Pilih pembayaran dengan va number melalui bank',
                                                  style: greyRdTextStyle
                                                      .copyWith(fontSize: 10),
                                                ),
                                                children: [
                                                  StatefulBuilder(builder:
                                                      (BuildContext context,
                                                          StateSetter
                                                              setState) {
                                                    return Container(
                                                      width: double.infinity,
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('Pilih Bank',
                                                              style: darRdBrownTextStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          bold),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Column(
                                                            children: bankList
                                                                .map(
                                                                  (String bank) => bankItem(
                                                                      'assets/img_$bank.png',
                                                                      bank,
                                                                      'VIA ' +
                         
                         
                         
                                                                          bank
                                                                              .toUpperCase(),
                                                                      selectedBank,
                                                                      (String?
                                                                          data) {
                                                                    Future.delayed(
                                                                        Duration(
                                                                            milliseconds:
                                                                                100),
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        selectedBank =
                                                                            data!;
                                                                        print(
                                                                            selectedBank);
                                                                      });
                                                                    });
                                                                  }),
                                                                )
                                                                .toList(),
                                                          ),

                                                          // bankItem(
                                                          //     'assets/img_bri.png',
                                                          //     'bri',
                                                          //     'VIA BRI',
                                                          //     'asdfasd',
                                                          //     (String? data) {
                                                          //   setState(() {
                                                          //     selectedBank =
                                                          //         data!;
                                                          //   });
                                                          // }),
                                                          // bankItem(
                                                          //     'assets/img_bni.png',
                                                          //     'bni',
                                                          //     'VIA BNI',
                                                          //     'asdfasdf',
                                                          //     (String? data) {
                                                          //   setState(() {
                                                          //     selectedBank =
                                                          //         data!;
                                                          //   });
                                                          // }),
                                                          // bankItem(
                                                          //     'assets/img_mandiri.png',
                                                          //     'mandiri',
                                                          //     'VIA Mandiri',
                                                          //     'asdfa123sdf',
                                                          //     (String? data) {
                                                          //   setState(() {
                                                          //     selectedBank =
                                                          //         data!;
                                                          //   });
                                                          // }),
                                                          // Row(
                                                          //   children: [
                                                          //     Image.asset(
                                                          //       'assets/img_bni.png',
                                                          //       width: 36,
                                                          //     ),
                                                          //     const SizedBox(
                                                          //       width: 12,
                                                          //     ),
                                                          //     Text(
                                                          //       'VA BNI',
                                                          //       style: darRdBrownTextStyle
                                                          //           .copyWith(
                                                          //               fontWeight:
                                                          //                   medium),
                                                          //     ),
                                                          //     const Spacer(),
                                                          //     Radio<String>(
                                                          //       value: 'bni',
                                                          //       groupValue:
                                                          //           selectedBank,
                                                          //       onChanged:
                                                          //           (bank) =>
                                                          //               setBank(
                                                          //                   bank),
                                                          //     )
                                                          //   ],
                                                          // ),
                                                          // Row(
                                                          //   children: [
                                                          //     Image.asset(
                                                          //       'assets/img_mandiri.png',
                                                          //       width: 36,
                                                          //     ),
                                                          //     const SizedBox(
                                                          //       width: 12,
                                                          //     ),
                                                          //     Text(
                                                          //       'VA Mandiri',
                                                          //       style: darRdBrownTextStyle
                                                          //           .copyWith(
                                                          //               fontWeight:
                                                          //                   medium),
                                                          //     ),
                                                          //     const Spacer(),
                                                          //     Radio<String>(
                                                          //       value:
                                                          //           'mandiri',
                                                          //       groupValue:
                                                          //           selectedBank,
                                                          //       onChanged:
                                                          //           (bank) =>
                                                          //               setBank(
                                                          //                   bank),
                                                          //     )
                                                          //   ],
                                                          // ),

                                                          Visibility(
                                                              visible:
                                                                  selectedBank
                                                                      .isNotEmpty,
                                                              child: Column(
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  CustomFilledButton(
                                                                    title:
                                                                        'Lanjutkan',
                                                                    onPressed:
                                                                        () {
                                                                      print(
                                                                          selectedBank);
                                                                    },
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  )
                                                                ],
                                                              ))
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              ExpansionTile(
                                                title: Text(
                                                  'QRIS',
                                                  style:
                                                      mainRdTextStyle.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: bold),
                                                ),
                                                collapsedShape: Border.all(
                                                    width: 2,
                                                    color: mainColor
                                                        .withAlpha(25)),
                                                subtitle: Text(
                                                  'Pilih pembayaran dengan dcan kode QR',
                                                  style: greyRdTextStyle
                                                      .copyWith(fontSize: 10),
                                                ),
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                        'Trailiung expansion'),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        CustomOutlinedButton(
                          title: 'Bayar Tunai',
                          color: mainColor,
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
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

  Widget bankItem(String image, String bank, String title, String group,
      void Function(String?) onChanged) {
    return Row(
      children: [
        Image.asset(
          image.toString(),
          width: 36,
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          title.toString(),
          style: darRdBrownTextStyle.copyWith(fontWeight: medium),
        ),
        const Spacer(),
        Radio<String>(
          value: bank,
          groupValue: group,
          onChanged: onChanged,
        )
      ],
    );
  }
}
