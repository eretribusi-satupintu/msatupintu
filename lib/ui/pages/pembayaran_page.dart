import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/doku_payment/doku_payment_bloc.dart';
import 'package:satupintu_app/blocs/pembayaran/pembayaran_bloc.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/doku_payment_va_page.dart';
import 'package:satupintu_app/ui/pages/tagihan_detail_page.dart';
import 'package:satupintu_app/ui/widget/failed_info.dart';

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({super.key});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late String pembayaranStatus;

  @override
  void initState() {
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    pembayaranStatus = 'SUCCESS';
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PembayaranBloc()..add(PembayaranGet(pembayaranStatus)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: BlocBuilder<PembayaranBloc, PembayaranState>(
            builder: (context, state) {
              if (state is PembayaranLoading) {
                return Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: mainColor, size: 30),
                );
              }

              if (state is PembayaranSuccess) {
                return Column(
                  children: state.data
                      .map((pembayaran) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) => TagihanDetailPage(
                                          tagihanId: pembayaran.tagihanId!,
                                          status: 'VERIFIED')));
                            },
                            child: paymentCard(
                                pembayaran.name!,
                                pembayaran.retributionItemName!,
                                pembayaran.paymentMethod!,
                                pembayaran.date!,
                                pembayaran.status!,
                                pembayaran.amount.toString()),
                          ))
                      .toList(),
                );
              }

              if (state is PembayaranFailed) {
                return ErrorInfo(
                  e: state.e,
                );
              }

              return Text('Memuat...');
            },
          ),
        ),
        // Column(
        //   children: [
        //     const SizedBox(
        //       height: 18,
        //     ),
        //     Container(
        //       width: MediaQuery.of(context).size.width,
        //       decoration: BoxDecoration(
        //           color: whiteColor, borderRadius: BorderRadius.circular(5)),
        //       child: Column(
        //         children: [
        //           Container(
        //             height: 50,
        //             child: TabBar(
        //               unselectedLabelColor: mainColor,
        //               padding: const EdgeInsets.symmetric(
        //                   vertical: 6, horizontal: 8),
        //               labelColor: whiteColor,
        //               indicatorSize: TabBarIndicatorSize.tab,
        //               indicator: BoxDecoration(
        //                   color: mainColor,
        //                   borderRadius: BorderRadius.circular(30)),
        //               dividerHeight: 0,
        //               controller: tabController,
        //               labelStyle: TextStyle(fontSize: 12, fontWeight: bold),
        //               labelPadding: EdgeInsets.zero,
        //               onTap: (idx) {
        //                 if (idx == 0) {
        //                   setState(() {
        //                     pembayaranStatus == 'SUCCESS';
        //                   });
        //                 }

        //                 if (idx == 1) {
        //                   setState(() {
        //                     pembayaranStatus == 'WAITING';
        //                   });
        //                 }

        //                 if (idx == 2) {
        //                   setState(() {
        //                     pembayaranStatus == 'CANCEL';
        //                   });
        //                 }
        //               },
        //               tabs: const [
        //                 Tab(
        //                   text: 'Berhasil',
        //                 ),
        //                 Tab(
        //                   text: 'Menunggu',
        //                 ),
        //                 Tab(
        //                   text: 'Batal',
        //                 )
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     Expanded(
        //         child: TabBarView(
        //       controller: tabController,
        //       children: [
        //         SingleChildScrollView(
        //           child: BlocBuilder<PembayaranBloc, PembayaranState>(
        //             builder: (context, state) {
        //               if (state is PembayaranLoading) {
        //                 return Center(
        //                   child: LoadingAnimationWidget.inkDrop(
        //                       color: mainColor, size: 30),
        //                 );
        //               }

        //               if (state is PembayaranSuccess) {
        //                 return Column(
        //                   children: state.data
        //                       .map((pembayaran) => GestureDetector(
        //                             onTap: () {
        //                               Navigator.push(
        //                                   context,
        //                                   MaterialPageRoute(
        //                                       builder: (contex) =>
        //                                           TagihanDetailPage(
        //                                               tagihanId:
        //                                                   pembayaran.tagihanId!,
        //                                               status: 'VERIFIED')));
        //                             },
        //                             child: paymentCard(
        //                                 pembayaran.name!,
        //                                 pembayaran.retributionItemName!,
        //                                 pembayaran.paymentMethod!,
        //                                 pembayaran.date!,
        //                                 pembayaran.status!,
        //                                 pembayaran.amount.toString()),
        //                           ))
        //                       .toList(),
        //                 );
        //               }

        //               if (state is PembayaranFailed) {
        //                 return ErrorInfo(
        //                   e: state.e,
        //                 );
        //               }

        //               return Text('Memuat...');
        //             },
        //           ),
        //         ),
        //         Text('ext2'),
        //         Text('ext23'),
        //         // PembayaranCancelTab(),
        //       ],
        //     ))
        //   ],
        // ),
      ),
    );
  }

  Widget paymentCard(
    String title,
    String retributionItemName,
    String payment,
    String date,
    String status,
    String amount,
  ) {
    Color colorStatus = mainColor;
    String icon = "";

    switch (status) {
      case 'SUCCESS':
        colorStatus = greenColor;
        break;
      case 'FAILED':
        colorStatus = redColor;
        break;
      default:
        colorStatus = orangeColor;
    }

    switch (payment) {
      case 'VA':
        payment = "VIRTUAL ACCOUNT";
        icon = 'assets/ic_va_payment.png';
        break;
      case 'QRIS':
        payment = "QRIS";
        icon = 'assets/ic_va_payment.png';
        break;
      case 'CASH':
        payment = "CASH";
        icon = 'assets/ic_va_payment.png';
        break;
      default:
        payment = "UNKNOWN";
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
              blurRadius: 8,
              color: lightBlueColor.withAlpha(30),
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          payment != "UNKNOWN"
                              ? Image.asset(icon, width: 24)
                              : const SizedBox(),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            payment,
                            style: darkInBrownTextStyle.copyWith(
                                fontWeight: bold, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  )),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: colorStatus,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Text(
                  status,
                  style:
                      whiteInTextStyle.copyWith(fontSize: 8, fontWeight: bold),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          retributionItemName,
                          style: blackRdTextStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          title,
                          style: blackRdTextStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              size: 14,
                              color: greyColor,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              iso8601toDateTime(date),
                              style: greyRdTextStyle.copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      'Rp $amount',
                      style: blueRdTextStyle.copyWith(
                          fontWeight: bold, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
