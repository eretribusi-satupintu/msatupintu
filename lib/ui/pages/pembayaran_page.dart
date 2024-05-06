import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/pembayaran/pembayaran_bloc.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/tagihan_detail_page.dart';
import 'package:satupintu_app/ui/widget/empty_data_info.dart';
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
    pembayaranStatus = 'SUCCESS';
    super.initState();
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
                if (state.data.isNotEmpty) {
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
                } else {
                  return const EmptyData(message: "Tidak ada pembayaran");
                }
              }

              if (state is PembayaranFailed) {
                return ErrorInfo(
                  e: state.e,
                );
              }

              return const Text('Memuat...');
            },
          ),
        ),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: blackRdTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
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
                        const Spacer(),
                        Text(
                          'Rp $amount',
                          style: blueRdTextStyle.copyWith(
                              fontWeight: bold, fontSize: 16),
                        ),
                      ],
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
