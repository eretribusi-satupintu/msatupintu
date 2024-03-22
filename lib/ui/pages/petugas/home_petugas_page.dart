import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';

class HomePetugasPage extends StatelessWidget {
  const HomePetugasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Petugas',
                        style: darkRdBrownTextStyle.copyWith(
                            fontSize: 20, fontWeight: bold),
                      ),
                      Text(
                        'Retribusi Sampah dan Daerah',
                        style: greyRdTextStyle.copyWith(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 21, vertical: 6),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.pin_drop_outlined,
                        size: 12,
                        color: greenColor,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Laguboti Pasar',
                        style: darkInBrownTextStyle.copyWith(
                            fontSize: 10, fontWeight: medium),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          margin: const EdgeInsets.symmetric(horizontal: 18),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
                image: AssetImage('assets/img_petugas_balance.png'),
                fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tagihan hari ini',
                style: whiteInTextStyle.copyWith(fontSize: 10),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                'Rp 253.000',
                style: whiteInTextStyle.copyWith(fontWeight: bold),
              ),
              const SizedBox(
                height: 22,
              ),
              Text(
                'Total tagihan',
                style: whiteInTextStyle.copyWith(fontSize: 10),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                'Rp 253.000',
                style:
                    whiteInTextStyle.copyWith(fontSize: 24, fontWeight: bold),
              ),
              const SizedBox(
                height: 10,
              ),
              DottedLine(
                dashColor: whiteColor,
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 127,
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.upload_rounded,
                        color: mainColor,
                        size: 18,
                      ),
                      Text(
                        'Setor Tagihan',
                        style: greyRdTextStyle.copyWith(
                            fontSize: 12, fontWeight: medium),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
