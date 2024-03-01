import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/tagihan/tagihan_bloc.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/tagihan_detail_page.dart';

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
                      style: whiteRdTextStyle.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Mudah',
                      style: orangeRdTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
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
            child: Row(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  color: greenColor,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  'Tagihan Terbaru',
                  style: darkRdBrownTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        BlocProvider(
          create: (context) => TagihanBloc()..add(TagihanGet()),
          child: BlocBuilder<TagihanBloc, TagihanState>(
            builder: (context, state) {
              if (state is TagihanSuccess) {
                if (state.data.isNotEmpty) {
                  return Column(
                    children: state.data
                        .map(
                          (tagihan) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TagihanDetailPage(tagihan: tagihan),
                                ),
                              );
                            },
                            child: tagihanTerbaru(
                              tagihan.nama.toString(),
                              int.parse(
                                tagihan.totalHarga.toString(),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      'Anda tidak memiliki tagihan',
                      style:
                          blueRdTextStyle.copyWith(fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              }

              if (state is TagihanFailed) {
                return const Column(
                  children: [
                    Text("Tidak dapat mengakses server"),
                  ],
                );
              }

              return Center(
                child:
                    LoadingAnimationWidget.inkDrop(color: mainColor, size: 24),
              );
            },
          ),
        )
      ],
    );
  }

  Widget tagihanTerbaru(
    String title,
    int totalHarga,
  ) {
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
                    title.toString(),
                    style: darkRdBrownTextStyle.copyWith(
                        fontSize: 12, fontWeight: semiBold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Bulanan',
                    style: greyRdTextStyle.copyWith(fontSize: 10),
                  )
                ],
              ),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              'Rp. $totalHarga',
              style: mainRdTextStyle.copyWith(fontWeight: bold, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
