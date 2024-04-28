import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/tagihan/tagihan_bloc.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/petugas/tagihan_detail_petugas_page.dart';
import 'package:satupintu_app/ui/pages/tagihan_detail_page.dart';

class PembayaranSuccessTab extends StatelessWidget {
  const PembayaranSuccessTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: BlocProvider(
        create: (context) =>
            TagihanBloc()..add(const PetugasPaidTagihanGet('VERIFIED')),
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            BlocBuilder<TagihanBloc, TagihanState>(
              builder: (context, state) {
                if (state is TagihanLoading) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          LoadingAnimationWidget.staggeredDotsWave(
                              color: mainColor, size: 30),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Loading...',
                            style: darkRdBrownTextStyle,
                          )
                        ],
                      ),
                    ),
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
                                    builder: (context) => TagihanDetailPetugas(
                                      tagihanId: tagihan.id!,
                                    ),
                                  ),
                                );
                              },
                              child: pembayaranCard(tagihan.udpatedDate!,
                                  tagihan.wajibRetribusiName!, tagihan.price!),
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
                  child: Text('Tidak kesalahan'),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }

  Widget pembayaranCard(String date, String name, int price) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(width: 0.5, color: lightGreyColor),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/ic_payment_success.png',
            width: 26,
          ),
          const SizedBox(
            width: 18,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                iso8601toDateTime(date),
                style: darkRdBrownTextStyle.copyWith(fontSize: 10),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                name,
                style: darkRdBrownTextStyle.copyWith(
                    fontSize: 14, fontWeight: bold),
              )
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.check_circle_outlined,
                    size: 12,
                    color: greenColor,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    'Berhasil',
                    style: greenRdTextStyle.copyWith(
                        fontWeight: bold, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                formatCurrency(price),
                style: darkRdBrownTextStyle,
              )
            ],
          )
        ],
      ),
    );
  }
}
