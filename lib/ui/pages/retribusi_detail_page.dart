import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/template_page.dart';

class RetribusiDetailPage extends StatelessWidget {
  const RetribusiDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateMain(
        title: 'Detail Retribusi',
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 19,
              ),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(
                //   width: 1,
                //   color: greyColor.withAlpha(50),
                // ),
              ),
              child: Row(children: [
                Image.asset(
                  'assets/ic_user_role.png',
                  width: 24,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rizki Okto S',
                      style: darkInBrownTextStyle.copyWith(fontSize: 12),
                    ),
                    Text(
                      '1200109120010002',
                      style: darkRdBrownTextStyle,
                    ),
                    // Text(
                    //   '+62812-6481-2864',
                    //   style: greenRdTextStyle.copyWith(
                    //       fontSize: 10, fontWeight: medium),
                    // )
                  ],
                ),
              ]),
            ),
            const SizedBox(
              height: 28,
            ),
            Text(
              'Kontrak',
              style: darkRdBrownTextStyle.copyWith(fontWeight: bold),
            ),
            const SizedBox(
              height: 12,
            ),
            kontrakCard(),
            const SizedBox(
              height: 28,
            ),
            Text(
              'Tagihan',
              style: darkRdBrownTextStyle.copyWith(fontWeight: bold),
            ),
            const SizedBox(
              height: 12,
            ),
            tagihanCard(),
            tagihanCard(),
            tagihanCard(),
            tagihanCard(),
          ],
        ));
  }

  Widget kontrakCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        right: 18,
        left: 18,
        top: 13,
        bottom: 18,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('assets/ic_kontrak.png', width: 25, height: 18),
              Text(
                'Retribusi Sampah',
                style: blackInTextStyle.copyWith(
                  fontWeight: bold,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: orangeColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: Text(
                  'Belum dikonfirmasi',
                  style:
                      whiteRdTextStyle.copyWith(fontSize: 8, fontWeight: bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Surat Kontrak Humbang 1',
            style: blueRdTextStyle.copyWith(fontSize: 16, fontWeight: bold),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            'DBA-II-1',
            style: greyRdTextStyle.copyWith(fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget tagihanCard() {
    return Container(
      margin: const EdgeInsets.only(
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
                    style: blackInTextStyle.copyWith(fontWeight: bold),
                  )
                ],
              ),
              const Spacer(),
              SizedBox(
                height: Checkbox.width,
                width: Checkbox.width,
                child: Checkbox(
                  value: false,
                  onChanged: (bool? value) {},
                  activeColor: mainColor,
                  side: BorderSide.none,
                  fillColor: MaterialStatePropertyAll(lightBlueColor),
                ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'INV-123123123',
                    style: greyRdTextStyle.copyWith(fontSize: 10),
                  ),
                  Text(
                    'Harian',
                    style: mainRdTextStyle.copyWith(
                        fontSize: 10, fontWeight: bold),
                  )
                ],
              ),
              const Spacer(),
              Text(
                'Rp. 15.000',
                style:
                    greenRdTextStyle.copyWith(fontSize: 14, fontWeight: bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
