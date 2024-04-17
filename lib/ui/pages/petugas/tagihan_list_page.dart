import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satupintu_app/blocs/kontrak/kontrak_bloc.dart';
import 'package:satupintu_app/blocs/tagihan/tagihan_bloc.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/petugas/tagihan_detail_petugas_page.dart';
import 'package:satupintu_app/ui/pages/template_page.dart';

class TagihanListPetugas extends StatelessWidget {
  final int kontrakId;
  const TagihanListPetugas({super.key, required this.kontrakId});

  @override
  Widget build(BuildContext context) {
    return Text('maintanance');
    // TemplateMain(
    //   title: 'Daftar Tagihan',
    //   body: MultiBlocProvider(
    //     providers: [
    //       BlocProvider(
    //         create: (context) =>
    //             TagihanBloc()..add(TagihanRetribusiGet(kontrakId)),
    //       ),
    //       BlocProvider(
    //         create: (context) =>
    //             KontrakBloc()..add(KontrakGetDetail(kontrakId)),
    //       ),
    //     ],
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Container(
    //           margin: const EdgeInsets.symmetric(horizontal: 18),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Row(
    //                 children: [
    //                   Container(
    //                     width: 25,
    //                     height: 25,
    //                     decoration: BoxDecoration(
    //                         color: mainColor,
    //                         borderRadius: BorderRadius.circular(100)),
    //                     child: Icon(
    //                       Icons.apps,
    //                       color: whiteColor,
    //                       size: 15,
    //                     ),
    //                   ),
    //                   const SizedBox(
    //                     width: 12,
    //                   ),
    //                   BlocBuilder<KontrakBloc, KontrakState>(
    //                     builder: (context, state) {
    //                       if (state is KontrakSuccess) {
    //                         return Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Text(
    //                               '${state.kontrak.billTotal} Tagihan',
    //                               style: orangeRdTextStyle.copyWith(
    //                                   fontSize: 12, fontWeight: bold),
    //                             ),
    //                             Text(
    //                               state.kontrak.categoryName!,
    //                               style: darkRdBrownTextStyle.copyWith(
    //                                   fontWeight: bold, fontSize: 16),
    //                             )
    //                           ],
    //                         );
    //                       }

    //                       return const Center(
    //                         child: Text('Gagal memuat!'),
    //                       );
    //                     },
    //                   )
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 16,
    //         ),
    //         BlocBuilder<TagihanBloc, TagihanState>(
    //           builder: (context, state) {
    //             if (state is TagihanSuccess) {
    //               return Column(
    //                   children: state.data
    //                       .map((tagihan) => GestureDetector(
    //                             onTap: () {
    //                               Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                       builder: (context) =>
    //                                           TagihanDetailPetugas(
    //                                             tagihanId: tagihan.id!,
    //                                             // status: tagihan.status!,
    //                                           )));
    //                             },
    //                             child: wajibRetribusiTagihanCard(
    //                                 'tagihan.name!',
    //                                 tagihan.dueDate!,
    //                                 'tagihan.totalHarga!',
    //                                 tagihan.status!),
    //                           ))
    //                       .toList());
    //             }
    //             return Text('memeuat');
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget wajibRetribusiTagihanCard(
      String name, String dueDate, String price, String status) {
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
              status == 'NEW'
                  ? Icon(
                      Icons.circle_outlined,
                      size: 15,
                      color: lightGreyColor,
                    )
                  : Icon(
                      Icons.check_circle_outline,
                      size: 15,
                      color: greenColor,
                    ),
              DottedLine(
                lineLength: 75, // Take all available height
                direction: Axis.vertical,
                dashColor: status == 'NEW' ? lightGreyColor : greenColor,
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
