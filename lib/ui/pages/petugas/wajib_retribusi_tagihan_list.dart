import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/tagihan/tagihan_bloc.dart';
import 'package:satupintu_app/blocs/wajib_retribusi/wajib_retribusi_bloc.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/petugas/tagihan_detail_petugas_page.dart';
import 'package:satupintu_app/ui/pages/template_page.dart';

class WajibRetribusiTagihanListPage extends StatelessWidget {
  final int wajibRetribusiId;
  const WajibRetribusiTagihanListPage(
      {super.key, required this.wajibRetribusiId});

  @override
  Widget build(BuildContext context) {
    return TemplateMain(
      title: 'Daftar Tagihan',
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                TagihanBloc()..add(TagihanWajibRetribusiGet(wajibRetribusiId)),
          ),
          BlocProvider(
            create: (context) => WajibRetribusiBloc()
              ..add(WajibRetribusiGetDetail(wajibRetribusiId)),
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(
                          Icons.apps,
                          color: whiteColor,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      BlocBuilder<WajibRetribusiBloc, WajibRetribusiState>(
                        builder: (context, state) {
                          if (state is WajibRetribusiLoading) {
                            return Center(
                              child: LoadingAnimationWidget.inkDrop(
                                  color: mainColor, size: 30),
                            );
                          }
                          if (state is WajibRetribusiSuccessDetail) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${state.data.jumlahKontrak} Tagihan',
                                  style: orangeRdTextStyle.copyWith(
                                      fontSize: 12, fontWeight: bold),
                                ),
                                Text(
                                  state.data.name!,
                                  style: darkRdBrownTextStyle.copyWith(
                                      fontWeight: bold, fontSize: 16),
                                )
                              ],
                            );
                          }

                          if (state is WajibRetribusiFailed) {
                            return Center(
                              child: Text(state.e),
                            );
                          }

                          return const Center(
                            child: Text('Terjadi Kesalahan'),
                          );
                        },
                      ),
                    ],
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
            BlocBuilder<TagihanBloc, TagihanState>(
              builder: (context, state) {
                if (state is TagihanLoading) {
                  return Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: mainColor, size: 24),
                  );
                }

                if (state is TagihanSuccess) {
                  return Column(
                    children: state.data
                        .map((tagihan) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TagihanDetailPetugas(
                                              tagihanId: tagihan.id!,
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

                if (state is TagihanFailed) {
                  return Center(
                    child: Text(state.e),
                  );
                }

                return const Center(
                  child: Text('Terjadi kesalahan'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget tagihanCard(
      String kontrakName, String tagihanName, String dueDate, int price) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 2, color: mainColor.withAlpha(50)),
      ),
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
                style:
                    blackInTextStyle.copyWith(fontWeight: medium, fontSize: 16),
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
