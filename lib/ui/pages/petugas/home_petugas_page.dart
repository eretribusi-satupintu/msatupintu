import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satupintu_app/blocs/petugas/petugas_bloc.dart';
import 'package:satupintu_app/blocs/subwilayah/subwilayah_bloc.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/petugas/rekapitulasi_pembayaran_page.dart';
import 'package:satupintu_app/ui/pages/petugas/tagihan_manual_add_page.dart';
import 'package:satupintu_app/ui/pages/petugas/tagihan_sinkronisasi_page.dart';
import 'package:satupintu_app/ui/widget/laoding_info.dart';

class HomePetugasPage extends StatelessWidget {
  const HomePetugasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SubwilayahBloc()..add(GetSelectedPetugasSubWilayah()),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Petugas',
                          style: darkRdBrownTextStyle.copyWith(
                              fontSize: 24, fontWeight: bold),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<SubwilayahBloc, SubwilayahState>(
                    builder: (context, state) {
                      if (state is SubwilayahLoading) {
                        return const LoadingInfo();
                      }
                      if (state is SubwilayahFailed) {
                        return Text(
                          state.e,
                          style: darkRdBrownTextStyle.copyWith(fontSize: 8),
                        );
                      }

                      if (state is SelectedSubwilayahSuccess) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/subwilayah-select');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 21, vertical: 6),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.pin_drop_outlined,
                                  size: 16,
                                  color: greenColor,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  state.data.name!,
                                  style: darkInBrownTextStyle.copyWith(
                                      fontSize: 12, fontWeight: medium),
                                )
                              ],
                            ),
                          ),
                        );
                      }

                      return const Text('Memuat..');
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            BlocProvider(
              create: (context) => PetugasBloc()..add(PetugasBillAmountGet()),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 18),
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: AssetImage('assets/img_petugas_balance.png'),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Total Tagihan',
                          style: whiteInTextStyle.copyWith(fontSize: 12),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        BlocBuilder<PetugasBloc, PetugasState>(
                          builder: (context, state) {
                            if (state is PetugasLoading) {
                              return Text('Loading...',
                                  style: whiteInTextStyle);
                            }

                            if (state is PetugasFailed) {
                              return Text(state.e, style: whiteInTextStyle);
                            }

                            if (state is PetugasBillAmountSuccess) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    formatCurrency(state.data.total +
                                        state.data.totalTagihanManual),
                                    style: whiteInTextStyle.copyWith(
                                        fontSize: 24, fontWeight: bold),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  DottedLine(
                                    dashColor: whiteColor,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Tagihan Kontrak',
                                              style: whiteRdTextStyle.copyWith(
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              formatCurrency(state.data.total),
                                              style: whiteRdTextStyle.copyWith(
                                                  fontWeight: bold,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Tagihan Manual',
                                              style: whiteRdTextStyle.copyWith(
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              formatCurrency(state
                                                  .data.totalTagihanManual),
                                              style: whiteRdTextStyle.copyWith(
                                                  fontWeight: bold,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }

                            return Text(
                              'Gagal memuat total tagihan...',
                              style: whiteInTextStyle,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 20,
                    margin: const EdgeInsets.symmetric(horizontal: 26),
                    decoration: BoxDecoration(
                      color: mainColor.withAlpha(70),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/ic_menu.png',
                      width: 18,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Menu pengelolaan dan setoran',
                      style:
                          darkInBrownTextStyle.copyWith(fontWeight: semiBold),
                    ),
                  ],
                )),
            const SizedBox(
              height: 18,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RekapitulasiPembayaranPage()));
                      },
                      child: homeMenuItem(
                          'Rekapitulasi', 'assets/img_rekapitulasi.png')),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/setoran');
                      },
                      child: homeMenuItem(
                          'Ungggah Setoran', 'assets/ic_deposit.png')),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TagihanSinkronisasiPage()));
                    },
                    child: homeMenuItem(
                        'Mode Sinkronisasi', 'assets/ic_sinkronisasi.png'),
                  ),
                  // homeMenuItem('Cetak\nBukti Bayar', 'assets/ic_print.png'),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TagihanAddPage()));
                    },
                    child: homeMenuItem(
                        'Tagihan Manual', 'assets/img_invoice_list.png'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget homeMenuItem(String name, String icon) {
    return Container(
      width: 90,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              color: lightBlueColor.withAlpha(40),
              spreadRadius: 8,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 30,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            name,
            style: darkInBrownTextStyle.copyWith(
                fontSize: 10, fontWeight: semiBold),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
