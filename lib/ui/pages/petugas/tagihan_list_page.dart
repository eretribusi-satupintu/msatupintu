import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/petugas/tagihan_detail_petugas_page.dart';
import 'package:satupintu_app/ui/pages/template_page.dart';

class TagihanListPetugas extends StatelessWidget {
  const TagihanListPetugas({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateMain(
      title: 'Daftar Tagihan',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Image.asset(
                  'assets/img_user.png',
                  width: 38,
                  height: 38,
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Togar Daniel Siregar',
                      style: darkRdBrownTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                    Text(
                      '081287653645',
                      style: greyRdTextStyle.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tagihan',
                  style: greyRdTextStyle.copyWith(fontSize: 12),
                ),
                Text(
                  'Sampah Warung atau Restaurant',
                  style: darkRdBrownTextStyle.copyWith(
                      fontWeight: bold, fontSize: 16),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TagihanDetailPetugas()));
            },
            child: wajibRetribusiTagihanCard(),
          ),
          wajibRetribusiTagihanCard(),
          wajibRetribusiTagihanCard(),
          wajibRetribusiTagihanCard(),
          wajibRetribusiTagihanCard(),
        ],
      ),
    );
  }

  Widget wajibRetribusiTagihanCard() {
    return Container(
      padding: const EdgeInsets.only(
        right: 18,
        left: 18,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 15,
                color: greenColor,
              ),
              DottedLine(
                lineLength: 75, // Take all available height
                direction: Axis.vertical,
                dashColor: lightGreyColor,
                dashLength: 5,
                lineThickness: 2,
              ),
            ],
          ),
          const SizedBox(
            width: 7,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/img_invoice.png',
                      width: 24,
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    Text(
                      'Tagihan 1',
                      style: blackInTextStyle.copyWith(fontWeight: medium),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: lightGreyColor,
                      size: 18,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Batas pembayaran',
                          style: greyRdTextStyle.copyWith(fontSize: 10),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          '12 Maret 2022',
                          style: mainRdTextStyle.copyWith(
                              fontSize: 12, fontWeight: medium),
                        )
                      ],
                    ),
                    const Spacer(),
                    Text(
                      'Rp 12.000',
                      style: greenRdTextStyle.copyWith(
                          fontSize: 14, fontWeight: bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
