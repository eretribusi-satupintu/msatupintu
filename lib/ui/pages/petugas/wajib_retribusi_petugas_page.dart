import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/tagihan_manual/tagihan_manual_bloc.dart';
import 'package:satupintu_app/blocs/wajib_retribusi/wajib_retribusi_bloc.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/petugas/petugas_tagihan_list.dart';
import 'package:satupintu_app/ui/pages/petugas/tagihan_manual_detail_page.dart';

class TagihanPetugasPage extends StatefulWidget {
  final int petugasId;
  const TagihanPetugasPage({super.key, required this.petugasId});

  @override
  State<TagihanPetugasPage> createState() => _TagihanPetugasPageState();
}

class _TagihanPetugasPageState extends State<TagihanPetugasPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                WajibRetribusiBloc()..add(WajibRetribusiGet(widget.petugasId)),
          ),
          BlocProvider(
              create: (context) => TagihanManualBloc()..add(TagihanManualGet()))
        ],
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: mainColor, borderRadius: BorderRadius.circular(30)),
                child: TabBar(
                  unselectedLabelColor: whiteColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  labelColor: mainColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(30)),
                  dividerHeight: 0,
                  controller: tabController,
                  labelStyle: TextStyle(fontSize: 12, fontWeight: bold),
                  labelPadding: EdgeInsets.zero,
                  tabs: const [
                    Tab(
                      text: 'Terdaftar',
                    ),
                    Tab(
                      text: 'Tidak Terdaftar',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 12,
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
                              return SingleChildScrollView(
                                child: Column(
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
                                ),
                              );
                            }

                            return Text('Terjadi kesalahan');
                          },
                        )
                      ],
                    ),
                    BlocBuilder<TagihanManualBloc, TagihanManualState>(
                      builder: (context, state) {
                        if (state is TagihanManualLoading) {
                          return Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                                color: mainColor, size: 30),
                          );
                        }

                        if (state is TagihanManualSuccess) {
                          return SingleChildScrollView(
                            child: Column(
                                children: state.data
                                    .map((tagihanManual) => GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TagihanManualDetailPage(
                                                            tagihanModel:
                                                                tagihanManual)));
                                          },
                                          child: tagihanManualCardItem(
                                              '${tagihanManual.itemRetribusi!} ${tagihanManual.detailTagihan!}',
                                              tagihanManual.createdAt!,
                                              tagihanManual.price!),
                                        ))
                                    .toList()),
                          );
                        }

                        if (state is TagihanManualFailed) {
                          return Text(state.e);
                        }

                        return Text("Terjadi kesalahan");
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
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
