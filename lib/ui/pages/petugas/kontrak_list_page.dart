import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/kontrak_%5Dretribusi_sewa/item_retribusi_sewa_bloc.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/petugas/tagihan_detail_petugas_page.dart';
import 'package:satupintu_app/ui/pages/petugas/tagihan_list_page.dart';
import 'package:satupintu_app/ui/pages/template_page.dart';

class KontrakListPage extends StatelessWidget {
  final int wajibRetribusiId;
  final int subWilayahId;
  const KontrakListPage(
      {super.key, required this.wajibRetribusiId, required this.subWilayahId});

  @override
  Widget build(BuildContext context) {
    return TemplateMain(
      title: 'Kontrak Wajib Retribusi',
      body: Column(
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
            height: 32,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              'Semua item retribusi',
              style: blueRdTextStyle.copyWith(
                fontSize: 14,
                fontWeight: medium,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: BlocProvider(
              create: (context) => ItemRetribusiSewaBloc()
                ..add(KontrakWajibRetribusiGet(wajibRetribusiId, subWilayahId)),
              child: BlocBuilder<ItemRetribusiSewaBloc, ItemRetribusiSewaState>(
                builder: (context, state) {
                  if (state is ItemRetribusiSewaLoading) {
                    return Center(
                      child: LoadingAnimationWidget.inkDrop(
                          color: mainColor, size: 24),
                    );
                  }
                  if (state is ItemRetribusiSewaSuccess) {
                    if (state.data.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: state.data
                            .map(
                              (itemRetribusi) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TagihanListPetugas()),
                                  );
                                },
                                child: itemRetribusiCard(
                                    itemRetribusi.categoryName!,
                                    itemRetribusi.billTotal!,
                                    itemRetribusi.billType!),
                              ),
                            )
                            .toList(),
                      );
                    }
                  }

                  if (state is ItemRetribusiSewaFailed) {
                    return Text(state.e);
                  }

                  return Text('Gagal Memuat data');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemRetribusiCard(
      String name, int? totalTagihan, String? paymentTerm) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Image.asset(
            'assets/img_invoice_list.png',
            width: 30,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: darkRdBrownTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 14,
                        color: orangeColor,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        '$totalTagihan tagihan tersisa',
                        style: greyRdTextStyle.copyWith(fontSize: 12),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.date_range,
                        size: 12,
                        color: mainColor,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        paymentTerm!,
                        style: mainRdTextStyle.copyWith(fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
