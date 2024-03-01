import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:satupintu_app/model/tagihan_model.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/template_page.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:satupintu_app/ui/widget/draggable_scrollable_modal.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
    return TemplateMain(
      title: 'Detail Tagihan',
      body: Column(children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              width: 284,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: whiteColor,
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 27,
                  ),
                  Text(
                    formatCurrency(
                      int.parse(widget.tagihan.totalHarga!),
                    ),
                    style: darkRdBrownTextStyle.copyWith(
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
                  tagihanInfo('Tagihan', widget.tagihan.nama!),
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
                        formatCurrency(
                          int.parse(widget.tagihan.totalHarga!),
                        ),
                        style: blackRdTextStyle.copyWith(
                            fontSize: 16, fontWeight: bold),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                    ],
                  ),
                  Text(
                    'Tagihan dilakukan pada tanggal',
                    style: greyRdTextStyle.copyWith(fontSize: 12),
                  ),
                  Text(
                    DateFormat('dd MMMM yyyy')
                        .format(DateTime.now())
                        .toString(),
                    style: greyRdTextStyle.copyWith(
                        fontSize: 12, fontWeight: bold),
                  ),
                  // +++++++
                ],
              ),
            ),
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
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 19),
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
                  style: darkRdBrownTextStyle.copyWith(
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
                      formatCurrency(
                        int.parse(widget.tagihan.totalHarga!),
                      ),
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
                    CustomModalBottomSheet.show(
                      context,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Pilih Metode Pembayaran',
                            style: darkRdBrownTextStyle.copyWith(
                                fontSize: 16, fontWeight: bold),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Silahkan  pilih metode pembayaran yang akan anda gunakan untuk membayar tagihan',
                            style: greyRdTextStyle.copyWith(fontSize: 10),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          ExpansionTile(
                            title: Row(
                              children: [
                                Image.asset(
                                  'assets/img_payment.png',
                                  width: 20,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  'Virtual Account',
                                  style: darkInBrownTextStyle.copyWith(
                                      fontSize: 14, fontWeight: bold),
                                )
                              ],
                            ),
                            collapsedShape: Border.all(
                                width: 2, color: mainColor.withAlpha(25)),
                            subtitle: Text(
                              'Pilih pembayaran dengan va number melalui bank',
                              style: greyRdTextStyle.copyWith(fontSize: 10),
                            ),
                            children: [
                              StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Pilih Bank',
                                          style: darkRdBrownTextStyle.copyWith(
                                              fontSize: 12, fontWeight: bold),
                                          textAlign: TextAlign.left),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        children: bankList
                                            .map(
                                              (String bank) => bankItem(
                                                  'assets/img_$bank.png',
                                                  bank,
                                                  'VIA ' + bank.toUpperCase(),
                                                  selectedBank, (String? data) {
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 100), () {
                                                  setState(() {
                                                    selectedBank = data!;
                                                    print(selectedBank);
                                                  });
                                                });
                                              }),
                                            )
                                            .toList(),
                                      ),
                                      Visibility(
                                          visible: selectedBank.isNotEmpty,
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              CustomFilledButton(
                                                title: 'Lanjutkan',
                                                onPressed: () {
                                                  print(selectedBank);
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
                            title: Row(
                              children: [
                                Image.asset(
                                  'assets/img_qris.png',
                                  width: 20,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  'QRIS',
                                  style: darkInBrownTextStyle.copyWith(
                                      fontSize: 14, fontWeight: bold),
                                )
                              ],
                            ),
                            collapsedShape: Border.all(
                                width: 2, color: mainColor.withAlpha(25)),
                            subtitle: Text(
                              'Pilih pembayaran dengan dcan kode QR',
                              style: greyRdTextStyle.copyWith(fontSize: 10),
                            ),
                            children: const [
                              ListTile(
                                title: Text('Trailiung expansion'),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 11,
                ),
                CustomOutlinedButton(
                  title: 'Bayar Tunai',
                  color: mainColor,
                  onPressed: () {
                    CustomModalBottomSheet.show(
                        context,
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Kode SatuPintu ',
                                style: darkRdBrownTextStyle.copyWith(
                                    fontSize: 16, fontWeight: bold),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Perlihatkan kode anda dibawah ini kepada petugas untuk menyelesaikan pembayaran',
                                style: greyRdTextStyle.copyWith(fontSize: 10),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 50),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/img_qris_background.png'),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: QrImageView(
                                    gapless: false,
                                    backgroundColor: whiteColor,
                                    data: '123123123',
                                    version: QrVersions.auto,
                                    size: 300.0,
                                    padding: const EdgeInsets.all(20),
                                    embeddedImage: const AssetImage(
                                        'assets/img_logo_with_background.png'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.shield_outlined,
                                    color: mainColor,
                                  ),
                                  Text(
                                    'Penting!',
                                    style: darkRdBrownTextStyle.copyWith(
                                        fontWeight: bold),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Mohon mencek status pembayaran tagihan anda secara berkala untuk memastikan tagihan telah dibayarkan kepada petugas, sebelum petugas pergi',
                                style: greyRdTextStyle.copyWith(
                                    fontSize: 10, fontStyle: FontStyle.italic),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ));
                  },
                )
              ],
            ),
          ),
        )
      ]),
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
          style: darkInBrownTextStyle.copyWith(fontWeight: semiBold),
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
