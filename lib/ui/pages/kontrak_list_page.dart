import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/kontrak/kontrak_bloc.dart';
import 'package:satupintu_app/blocs/tagihan/tagihan_bloc.dart';
import 'package:satupintu_app/model/kontrak_item_retribusi_model.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/kontrak_detail_page.dart';
import 'package:satupintu_app/ui/pages/template_page.dart';

class KontrakListPage extends StatefulWidget {
  const KontrakListPage({super.key});

  @override
  State<KontrakListPage> createState() => _KontrakListPageState();
}

class _KontrakListPageState extends State<KontrakListPage> {
  @override
  Widget build(BuildContext context) {
    return TemplateMain(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: BlocProvider(
                create: (context) => KontrakBloc()..add(KontrakGet()),
                child: BlocBuilder<KontrakBloc, KontrakState>(
                  builder: (context, state) {
                    if (state is KontrakLoading) {
                      return Center(
                        child: LoadingAnimationWidget.inkDrop(
                            color: mainColor, size: 30),
                      );
                    }

                    if (state is KontrakListSuccess) {
                      List<KontrakItemRetribusiModel> kontrakList = state.data;
                      return Column(
                          children: kontrakList
                              .map(
                                (kontrak) => GestureDetector(
                                  onTap: () async {
                                    var kontrakBloc =
                                        context.read<KontrakBloc>();

                                    final isRefresh = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => KontrakDetailPage(
                                            itemRetribusi: kontrak),
                                      ),
                                    );

                                    if (mounted && isRefresh == 'refresh') {
                                      kontrakBloc.add(KontrakGet());
                                    }
                                  },
                                  child: kontrakCard(
                                    kontrak,
                                  ),
                                ),
                              )
                              .toList());
                    }

                    if (state is KontrakFailed) {
                      return Center(
                        child: Text(state.e),
                      );
                    }

                    return const Center(
                      child: Text('Gagal memuat...'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        title: 'Daftar Kontrak');
  }

  Widget kontrakCard(KontrakItemRetribusiModel kontrak) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 7),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
              Text(
                kontrak.categoryName!,
                style: blueRdTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: kontrak.status! == 'DITERIMA'
                      ? greenColor.withAlpha(25)
                      : kontrak.status! == 'DIPROSES'
                          ? orangeColor.withAlpha(25)
                          : redColor.withAlpha(25),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: Text(
                  kontrak.status!,
                  style: kontrak.status! == 'DITERIMA'
                      ? greenRdTextStyle.copyWith(fontSize: 8, fontWeight: bold)
                      : kontrak.status! == 'DIPROSES'
                          ? orangeRdTextStyle.copyWith(
                              fontSize: 8, fontWeight: bold)
                          : redRdTextStyle.copyWith(
                              fontSize: 8, fontWeight: bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            kontrak.categoryName!,
            style: darkInBrownTextStyle.copyWith(
                fontWeight: semiBold, fontSize: 14),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            'Item yang disewa : ${kontrak.categoryName}',
            style: greyRdTextStyle.copyWith(fontSize: 12),
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Image.asset(
                'assets/logo_kopenaker_humbahas.png',
                width: 12,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                kontrak.kedinasanName!,
                style: greyRdTextStyle.copyWith(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
