import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/retribusi_detail_page.dart';

class TagihanPage extends StatelessWidget {
  const TagihanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      tagihanCard(context),
      tagihanCard(context),
      tagihanCard(context)
    ]);
  }

  Widget tagihanCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RetribusiDetailPage(),
          ),
        );
        // print('test');
      },
      child: Container(
        margin: const EdgeInsets.only(
          right: 18,
          left: 18,
          bottom: 17,
        ),
        padding: const EdgeInsets.only(
          right: 18,
          left: 18,
          top: 13,
          bottom: 18,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/img_invoice_list.png',
                      width: 18,
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    Text(
                      'Retribusi Pasar',
                      style: darkInBrownTextStyle.copyWith(fontWeight: black),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              width: double.infinity,
              height: 2,
              decoration: BoxDecoration(color: lightGreyColor.withAlpha(70)),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Icon(
                  Icons.check_box,
                  size: 18,
                  color: blueColor,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  '2 item telah disewa pada retribusi ini',
                  style: greyRdTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Icon(
                  Icons.receipt_long,
                  size: 18,
                  color: orangeColor,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  '2 tagihan belum dibayar',
                  style: greyRdTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                const Spacer(),
                Container(
                    child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        '2',
                        style: whiteRdTextStyle.copyWith(fontSize: 10),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Tampilkan tagihan',
                      style: darkRdBrownTextStyle.copyWith(fontSize: 12),
                    ),
                  ],
                ))
              ],
            )
          ],
        ),
      ),
    );
  }

  
}
