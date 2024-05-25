import 'dart:async';
import 'dart:convert';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satupintu_app/blocs/rekapitulasi/rekapitulasi_bloc.dart';
import 'package:satupintu_app/blocs/subwilayah/subwilayah_bloc.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/petugas/tagihan_detail_petugas_page.dart';
import 'package:satupintu_app/ui/pages/petugas/tagihan_manual_detail_page.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';
import 'package:satupintu_app/ui/widget/empty_data_info.dart';
import 'package:satupintu_app/ui/widget/failed_info.dart';
import 'package:satupintu_app/ui/widget/inputs.dart';
import 'package:satupintu_app/ui/widget/laoding_info.dart';

class RekapitulasiPembayaranPage extends StatefulWidget {
  const RekapitulasiPembayaranPage({super.key});

  @override
  State<RekapitulasiPembayaranPage> createState() =>
      _RekapitulasiPembayaranPageState();
}

class _RekapitulasiPembayaranPageState
    extends State<RekapitulasiPembayaranPage> {
  @override
  void initState() {
    super.initState();
    context.read<RekapitulasiBloc>().add(TagihanKontrakGet());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Cetak bukti bayar',
            style: mainRdTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop('refresh');
            },
            icon: Icon(
              Icons.chevron_left_rounded,
              size: 30,
              color: mainColor,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 4,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Jenis tagihan',
                style: darkRdBrownTextStyle.copyWith(fontWeight: bold),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: darkBrownColor),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownMenu(
                selectedTrailingIcon: const Icon(Icons.cancel_outlined),
                inputDecorationTheme: const InputDecorationTheme(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0)),
                expandedInsets: const EdgeInsets.symmetric(horizontal: 0),
                onSelected: (value) {
                  // setState(() {
                  if (value == 'KONTRAK') {
                    context.read<RekapitulasiBloc>().add(TagihanKontrakGet());
                  } else if (value == 'MANUAL') {
                    context.read<RekapitulasiBloc>().add(TagihanManualGet());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: CustomSnackbar(
                          message: 'Tidak dapat mengenali opsi',
                          status: 'failed',
                        ),
                        behavior: SnackBarBehavior.fixed,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  }
                  // });
                },
                initialSelection: 'KONTRAK',
                menuStyle: MenuStyle(
                  backgroundColor: MaterialStatePropertyAll(whiteColor),
                  shadowColor: MaterialStatePropertyAll(whiteColor),
                ),
                dropdownMenuEntries: const [
                  DropdownMenuEntry(
                    value: 'KONTRAK',
                    label: 'Tagihan Kontrak',
                  ),
                  DropdownMenuEntry(
                    value: 'MANUAL',
                    label: 'Tagihan Manual',
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<RekapitulasiBloc, RekapitulasiState>(
              listener: (context, state) {
                if (state is RekapitulasiInitial) {}
              },
              builder: (context, state) {
                if (state is RekapitulasiLoading) {
                  return const LoadingInfo();
                }

                if (state is RekapitulasiTagihanKontrakSuccess) {
                  return Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 18),
                      decoration: BoxDecoration(
                          color: mainColor.withAlpha(10),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          )),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 18),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              color: greenColor,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Icon(
                                              Icons.receipt_long,
                                              color: whiteColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Jumlah tagihan',
                                                style: greyRdTextStyle.copyWith(
                                                  fontSize: 10,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                state.jumlahTagihan.toString(),
                                                style: darkRdBrownTextStyle
                                                    .copyWith(
                                                        fontWeight: bold,
                                                        fontSize: 18),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 18),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              color: mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Icon(
                                              Icons.money,
                                              color: whiteColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Total nominal tagihan ',
                                                style: greyRdTextStyle.copyWith(
                                                  fontSize: 10,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                formatCurrency(
                                                    state.totalNominalTagihan),
                                                style: darkRdBrownTextStyle
                                                    .copyWith(
                                                        fontWeight: bold,
                                                        fontSize: 18),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            state.data.isNotEmpty
                                ? Column(
                                    children: state.data
                                        .map(
                                          (tagihanKontrak) => GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TagihanDetailPetugas(
                                                    tagihanId:
                                                        tagihanKontrak.id!,
                                                    isStored: true,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: tagihanCard(
                                                tagihanKontrak
                                                    .itemRetribusiName!,
                                                tagihanKontrak.tagihanName!,
                                                tagihanKontrak.paymentTime!,
                                                tagihanKontrak.price!),
                                          ),
                                        )
                                        .toList(),
                                  )
                                : const EmptyData(
                                    message: "Tidak ada Tagihan Kontrak"),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                if (state is RekapitulasiTagihanManualSuccess) {
                  return Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 18),
                      decoration: BoxDecoration(
                          color: mainColor.withAlpha(10),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          )),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 18),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              color: greenColor,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Icon(
                                              Icons.receipt_long,
                                              color: whiteColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Jumlah tagihan',
                                                style: greyRdTextStyle.copyWith(
                                                  fontSize: 10,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                state.jumlahTagihan.toString(),
                                                style: darkRdBrownTextStyle
                                                    .copyWith(
                                                        fontWeight: bold,
                                                        fontSize: 18),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 18),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              color: mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Icon(
                                              Icons.money,
                                              color: whiteColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Total nominal tagihan ',
                                                style: greyRdTextStyle.copyWith(
                                                  fontSize: 10,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                formatCurrency(
                                                    state.totalNominalTagihan),
                                                style: darkRdBrownTextStyle
                                                    .copyWith(
                                                        fontWeight: bold,
                                                        fontSize: 18),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            state.data.isNotEmpty
                                ? Column(
                                    children: state.data
                                        .map(
                                          (tagihanKontrak) => GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TagihanManualDetailPage(
                                                              tagihanModel:
                                                                  tagihanKontrak)));
                                            },
                                            child: tagihanManualCardItem(
                                                '${tagihanKontrak.itemRetribusi!} ${tagihanKontrak.detailTagihan!}',
                                                tagihanKontrak.createdAt!,
                                                tagihanKontrak.price!),
                                          ),
                                        )
                                        .toList(),
                                  )
                                : const EmptyData(
                                    message: "Tidak ada Tagihan Kontrak"),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                if (state is RekapitulasiFailed) {
                  return ErrorInfo(e: state.e);
                }

                return const ErrorInfo(
                  e: 'Terjadi kesalahan',
                );
              },
            ),
            const SizedBox(
              height: 20,
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: whiteColor,
          // border: Border.all(color: lightGreyColor, width: 0.5),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: lightGreyColor.withAlpha(45),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/img_invoice.png',
                width: 10,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                kontrakName,
                style: greyRdTextStyle.copyWith(fontSize: 10),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            tagihanName,
            style:
                blackInTextStyle.copyWith(fontWeight: semiBold, fontSize: 12),
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
                    'Waktu pembayaran ',
                    style: greyRdTextStyle.copyWith(fontSize: 8),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    stringToDateTime(
                        dueDate, 'EEEE, dd MMMM  yyyy hh:mm WIB', false),
                    style: mainRdTextStyle.copyWith(
                        fontSize: 10, fontWeight: medium),
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

  Widget tagihanManualCardItem(String itemRetribusi, String date, int price) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: greyColor.withAlpha(12),
              blurRadius: 5,
              spreadRadius: 2,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemRetribusi,
            style:
                darkRdBrownTextStyle.copyWith(fontSize: 12, fontWeight: bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Text(
                date,
                style: darkInBrownTextStyle.copyWith(fontSize: 10),
              ),
              const Spacer(),
              Text(
                formatCurrency(price),
                style: mainRdTextStyle.copyWith(fontWeight: bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
