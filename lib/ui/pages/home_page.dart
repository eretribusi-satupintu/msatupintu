import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satupintu_app/blocs/auth/auth_bloc.dart';
import 'package:satupintu_app/blocs/tagihan/tagihan_bloc.dart';
import 'package:satupintu_app/shared/method.dart';
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
                              context,
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
    BuildContext context,
    String title,
    int totalHarga,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/img_invoice.png',
            width: 30,
          ),
          const SizedBox(
            width: 6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: darkRdBrownTextStyle.copyWith(
                    fontWeight: medium, fontSize: 12),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Text(
                    formatCurrency(totalHarga),
                    style: mainRdTextStyle.copyWith(fontSize: 10),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
