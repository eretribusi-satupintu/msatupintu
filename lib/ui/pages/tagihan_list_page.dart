import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/tagihan/tagihan_bloc.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/tagihan_detail_page.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/widget/empty_data_info.dart';
import 'package:satupintu_app/ui/widget/failed_info.dart';

class TagihanListPage extends StatelessWidget {
  const TagihanListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TagihanBloc()..add(TagihanWajibRetribusiMasyarakatGet()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 18),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
            decoration: BoxDecoration(
              color: blueColor.withAlpha(25),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "Cari item retribusi...",
                  style: greyRdTextStyle.copyWith(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const Spacer(), // Use Expanded instead of Spacer
                Icon(
                  Icons.search,
                  size: 20,
                  color: mainColor,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              'Daftar Tagihan',
              style: darkRdBrownTextStyle.copyWith(fontWeight: semiBold),
            ),
          ),
          BlocConsumer<TagihanBloc, TagihanState>(
            listener: (context, state) {
              if (state is TagihanFailed) {
                if (state.e == 'Unauthorized') {
                  Navigator.pushNamed(context, '/timesout');
                }
              }
            },
            builder: (context, state) {
              if (state is TagihanLoading) {
                return Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: mainColor, size: 30),
                );
              }

              if (state is TagihanSuccess) {
                if (state.data.isNotEmpty) {
                  return Column(
                    children: state.data
                        .map((tagihan) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TagihanDetailPage(
                                              tagihanId: tagihan.id!,
                                              status: tagihan.status!,
                                            )));
                              },
                              child: tagihanCard(
                                  tagihan.itemRetribusiName!,
                                  tagihan.tagihanName!,
                                  tagihan.dueDate!,
                                  tagihan.price!),
                            ))
                        .toList(),
                  );
                }
                return const EmptyData(message: 'Anda belum memiliki tagihan');
              }

              return const ErrorInfo();
            },
          )
        ],
      ),
    );
  }

  Widget tagihanCard(
      String kontrakName, String tagihanName, String dueDate, int price) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: lightGreyColor.withAlpha(65),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/img_invoice.png',
                width: 18,
              ),
              const SizedBox(
                width: 7,
              ),
              Text(
                kontrakName,
                style: greyRdTextStyle.copyWith(fontSize: 12),
              )
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            children: [
              Text(
                tagihanName,
                style: blackInTextStyle.copyWith(
                  fontWeight: semiBold,
                ),
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
                    iso8601toDateTime(dueDate),
                    style: mainRdTextStyle.copyWith(
                        fontSize: 12, fontWeight: medium),
                  )
                ],
              ),
              const Spacer(),
              Text(
                formatCurrency(price),
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
