import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satupintu_app/blocs/wajib_retribusi/wajib_retribusi_bloc.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/petugas/kontrak_list_page.dart';
import 'package:satupintu_app/ui/pages/petugas/tagihan_list_page.dart';
import 'package:satupintu_app/ui/pages/petugas/wajib_retribusi_tagihan_list.dart';

class TagihanPetugasPage extends StatelessWidget {
  final int petugasId;
  const TagihanPetugasPage({super.key, required this.petugasId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WajibRetribusiBloc()..add(WajibRetribusiGet(petugasId)),
      child: Column(
        children: [
          DefaultTabController(
            length: 2,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  child: TabBar(tabs: [
                    Tab(
                      text: 'Terdaftar ',
                    ),
                    Tab(
                      text: 'Tidak Terdaftar',
                    )
                  ]),
                ),
                SizedBox(
                  height: 500,
                  child: TabBarView(children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 18),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 11),
                            decoration: BoxDecoration(
                              color: blueColor.withAlpha(25),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Cari wajib retribusi...",
                                  style: greyRdTextStyle.copyWith(
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.search,
                                  size: 20,
                                  color: mainColor,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          BlocBuilder<WajibRetribusiBloc, WajibRetribusiState>(
                            builder: (context, state) {
                              if (state is WajibRetribusiSuccess) {
                                return Column(
                                  children: state.data
                                      .map((wajibRetribusi) => GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        WajibRetribusiTagihanListPage(
                                                          wajibRetribusiId:
                                                              wajibRetribusi
                                                                  .id!,
                                                        )),
                                              );
                                            },
                                            child: wajibRetribusiCardItem(
                                                wajibRetribusi.name!,
                                                wajibRetribusi.jumlahKontrak!),
                                          ))
                                      .toList(),
                                );
                              }

                              if (state is WajibRetribusiFailed) {
                                return Center(
                                  child: Text('Gagal memeuat data'),
                                );
                              }

                              return Center(
                                child: Text('Tidak ada wajib retribusi'),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const Column(
                      children: [Text('test')],
                    )
                  ]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget wajibRetribusiCardItem(String name, int billTotal) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: greyColor.withAlpha(10),
                blurRadius: 10,
                offset: const Offset(0.2, 1))
          ]),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: Text(
              name,
              style: darkRdBrownTextStyle.copyWith(fontWeight: bold),
            ),
          ),
          const Spacer(),
          Text(
            '$billTotal Kontrak',
            style: greenRdTextStyle.copyWith(fontWeight: bold),
          )
        ],
      ),
    );
  }
}
