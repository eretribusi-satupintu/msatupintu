import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/tagihan/tagihan_bloc.dart';
import 'package:satupintu_app/model/kontrak_item_retribusi_model.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/tagihan_detail_page.dart';
import 'package:satupintu_app/ui/pages/template_page.dart';

class KontrakDetailPage extends StatelessWidget {
  final KontrakItemRetribusiModel itemRetribusi;
  const KontrakDetailPage({super.key, required this.itemRetribusi});

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
              ),
              child: Row(children: [
                Image.asset(
                  'assets/logo_kopenaker_humbahas.png',
                  width: 42,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemRetribusi.kedinasanName!,
                        style: darkInBrownTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 28,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Kontrak',
                style: darkRdBrownTextStyle.copyWith(fontWeight: bold),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: kontrakCard(),
            ),
            const SizedBox(
              height: 28,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Tagihan',
                style: darkRdBrownTextStyle.copyWith(fontWeight: bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocProvider(
              create: (context) =>
                  TagihanBloc()..add(TagihanRetribusiGet(itemRetribusi.id!)),
              child: BlocBuilder<TagihanBloc, TagihanState>(
                builder: (context, state) {
                  if (state is TagihanLoading) {
                    return Center(
                      child: LoadingAnimationWidget.inkDrop(
                          color: mainColor, size: 20),
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
                                            builder: (context) =>
                                                TagihanDetailPage(
                                                    tagihan: tagihan)));
                                  },
                                  child: tagihanCard(
                                      tagihan.nama!,
                                      tagihan.dueDate!,
                                      tagihan.totalHarga!,
                                      tagihan.status!),
                                ))
                            .toList(),
                      );
                    }
                    return Center(
                        child: Text(
                      'Tidak ada tagihan',
                      style: lightGreyRdTextStyle.copyWith(fontWeight: medium),
                    ));
                  }

                  if (state is TagihanFailed) {
                    Text(state.e);
                  }

                  return Center(
                      child: Text(
                    'Tidak ada tagihan',
                    style: lightGreyRdTextStyle.copyWith(fontWeight: medium),
                  ));
                },
              ),
            ),
          ],
        ));
  }

  Widget kontrakCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(width: 0.8, color: lightGreyColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('assets/ic_kontrak.png', width: 20, height: 13),
              const SizedBox(
                width: 4,
              ),
              Text(
                'Retribusi Sampah',
                style: blackInTextStyle.copyWith(
                  fontSize: 10,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: orangeColor.withAlpha(25),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: Text(
                  itemRetribusi.status!,
                  style:
                      orangeRdTextStyle.copyWith(fontSize: 8, fontWeight: bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Surat Kontrak ${itemRetribusi.categoryName}',
            style: darkRdBrownTextStyle.copyWith(
                fontWeight: semiBold, fontSize: 16),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'Item yang disewa : DBA-II-1',
            style: greyRdTextStyle.copyWith(fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget tagihanCard(String name, String dueDate, String price, String status) {
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
              status == 'VERIFIED'
                  ? Icon(
                      Icons.check_circle_outline,
                      size: 15,
                      color: greenColor,
                    )
                  : Icon(
                      Icons.circle_outlined,
                      size: 15,
                      color: lightGreyColor,
                    ),
              DottedLine(
                lineLength: 75, // Take all available height
                direction: Axis.vertical,
                dashColor: status == 'VERIFIED' ? greenColor : lightGreyColor,
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
                      name,
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
                          iso8601toDateTime(dueDate),
                          style: mainRdTextStyle.copyWith(
                              fontSize: 12, fontWeight: medium),
                        )
                      ],
                    ),
                    const Spacer(),
                    Text(
                      formatCurrency(int.parse(price)),
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
