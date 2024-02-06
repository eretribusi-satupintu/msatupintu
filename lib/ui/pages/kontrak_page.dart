import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';

class KontrakPage extends StatelessWidget {
  const KontrakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [kontrakCard(), kontrakCard(), kontrakCard()],
    );
  }

  Widget kontrakCard() {
    return Container(
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
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       'Surat Kontrak Humbang 1',
          //       style: darRdBrownTextStyle.copyWith(
          //         fontWeight: bold,
          //       ),
          //     ),
          //     Text(
          //       'DBA-II-1',
          //       style: blueRdTextStyle.copyWith(fontSize: 12),
          //     ),
          //     const Spacer(),
          //     Container(
          //       color: orangeColor,
          //       padding: const EdgeInsets.symmetric(horizontal: 4.5),
          //       child: Text(
          //         'Sudah diverifikasi',
          //         style: whiteInTextStyle.copyWith(
          //           fontSize: 8,
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          // const Spacer(),
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
}
