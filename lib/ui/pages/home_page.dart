import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satupintu_app/blocs/auth/auth_bloc.dart';
import 'package:satupintu_app/blocs/tagihan/tagihan_bloc.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/tagihan_detail_page.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';
import 'package:satupintu_app/ui/widget/empty_data_info.dart';
import 'package:satupintu_app/ui/widget/failed_info.dart';
import 'package:satupintu_app/ui/widget/shimmer_card.dart';

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
                  color: mainColor,
                  size: 18,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  'Tagihan Terbaru',
                  style: darkRdBrownTextStyle.copyWith(
                    fontWeight: bold,
                  ),
                ),
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        BlocProvider(
          create: (context) => TagihanBloc()..add(TagihanNewestGet()),
          child: BlocConsumer<TagihanBloc, TagihanState>(
            listener: (context, state) {
              if (state is TagihanFailed) {
                if (state.e == 'Unauthorized') {
                  Navigator.pushNamed(context, '/timesout');
                }
              }
            },
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
                                  builder: (context) => TagihanDetailPage(
                                      tagihanId: tagihan.id!,
                                      status: tagihan.status!),
                                ),
                              );
                            },
                            child: tagihanTerbaru(
                              tagihan.tagihanName!,
                              tagihan.price!,
                            ),
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return const EmptyData(
                      message: 'Anda belum memiliki tagihan');
                }
              }

              if (state is AuthFailed) {
                return const ErrorInfo();
              }

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: ShimmerCard(length: 3),
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
