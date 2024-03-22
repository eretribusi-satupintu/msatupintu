import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/pembayaran/pembayaran_bloc.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';

class KontrakPage extends StatefulWidget {
  const KontrakPage({super.key});

  @override
  State<KontrakPage> createState() => _KontrakPageState();
}

class _KontrakPageState extends State<KontrakPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: SizedBox(
          child: Column(
            children: [
              TabBar(
                labelStyle:
                    mainRdTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                unselectedLabelColor: greyColor,
                indicatorColor: mainColor,
                padding: EdgeInsets.zero,
                labelPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                // dividerHeight: 12,
                tabAlignment: TabAlignment.start,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 4),
                tabs: const [
                  Tab(
                    text: 'Semua',
                  ),
                  Tab(
                    text: 'Belum dibayar',
                  ),
                  Tab(
                    text: 'Sudah dibayar',
                  ),
                  Tab(
                    text: 'Dibatalkan',
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                height: MediaQuery.of(context)
                    .size
                    .height, // Adjust the height as needed
                child: TabBarView(
                  children: [
                    BlocProvider(
                        create: (context) =>
                            PembayaranBloc()..add(PembayaranGet()),
                        child: BlocBuilder<PembayaranBloc, PembayaranState>(
                          builder: (context, state) {
                            if (state is PembayaranLoading) {
                              return LoadingAnimationWidget.inkDrop(
                                  color: mainColor, size: 24);
                            }
                            if (state is PembayaranSuccess) {
                              if (state.data.isNotEmpty) {
                                return Column(
                                  children: state.data
                                      .map(
                                        (pembayaran) => GestureDetector(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         DokuPaymentVaPage(
                                            //             virtualAccount: pembayaran.
                                            //                 ),
                                            //   ),
                                            // );
                                          },
                                          child: paymentCard(
                                            pembayaran.name.toString(),
                                            pembayaran.retributionItemName
                                                .toString(),
                                            pembayaran.paymentMethod.toString(),
                                            pembayaran.date.toString(),
                                            pembayaran.status.toString(),
                                            pembayaran.amount.toString(),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                );
                              } else {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  child: Text(
                                    'Anda tidak memiliki pembayaran',
                                    style: blueRdTextStyle.copyWith(
                                        fontStyle: FontStyle.italic),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }
                            }

                            return Column(
                              children: [
                                Text(
                                  'Gagal memuat',
                                  style: greyRdTextStyle,
                                ),
                              ],
                            );
                          },
                        )),
                    const Center(
                      child: Text('Menu 2'),
                    ),
                    const Center(
                      child: Text('Menu 3'),
                    ),
                    const Center(
                      child: Text('Menu '),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
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
