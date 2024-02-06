import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 324,
          height: 148,
          margin: const EdgeInsets.symmetric(horizontal: 18),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img_bg_home_banner.png'),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Container(
            height: double.infinity,
            margin: const EdgeInsets.only(right: 18, left: 18),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bayar Retribusi\ndaerah kini makin',
                      style: whiteRdTextStyle.copyWith(fontSize: 18),
                    ),
                    Text(
                      'Mudah',
                      style: orangeRdTextStyle.copyWith(
                          fontSize: 18, fontWeight: bold),
                    )
                  ],
                ),
                const SizedBox(
                  width: 19,
                ),
                Image.asset(
                  'assets/img_banner_content.png',
                  width: 111,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 39,
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          child: Text(
            'Tagihan Terbaru',
            style: darRdBrownTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            tagihanTerbaru(),
            tagihanTerbaru(),
            tagihanTerbaru(),
          ],
        )
      ],
    );
  }

  Widget tagihanTerbaru() {
    return Container(
      width: double.infinity,
      // height: 86,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/img_invoice.png',
                width: 33,
              ),
              const SizedBox(
                width: 23,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Retribusi Pasar',
                    style: darRdBrownTextStyle.copyWith(
                        fontSize: 12, fontWeight: semiBold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Bulanan',
                    style: greyRdTextStyle.copyWith(fontSize: 10),
                  )
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.receipt_long,
                  //       size: 10,
                  //       color: greyColor,
                  //     ),
                  //     const SizedBox(
                  //       width: 5,
                  //     ),
                  //     Text(
                  //       'INV-101321231',
                  //       style: greyRdTextStyle.copyWith(fontSize: 10),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 4,
                  // ),
                  // Text(
                  //   'Rp. 5000',
                  //   style: blackRdTextStyle.copyWith(
                  //       fontSize: 16, fontWeight: bold),
                  // ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Align(
              alignment: Alignment.topRight,
              child: Text(
                'Rp. 5000',
                style: mainRdTextStyle.copyWith(fontWeight: bold, fontSize: 16),
              )
              // Container(
              //   width: 69,
              //   height: 26,
              //   decoration: BoxDecoration(
              //       color: orangeColor,
              //       borderRadius: const BorderRadius.all(Radius.circular(10))),
              //   child: TextButton(
              //     onPressed: () {},
              //     child: Text(
              //       'Bulanan',
              //       style:
              //           whiteRdTextStyle.copyWith(fontWeight: bold, fontSize: 8),
              //     ),
              //   ),
              // ),
              )
        ],
      ),
    );
  }
}