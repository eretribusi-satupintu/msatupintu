import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satupintu_app/blocs/tagihan_local/tagihan_local_bloc.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/widget/draggable_scrollable_modal.dart';
import 'package:satupintu_app/ui/widget/laoding_info.dart';

class TagihanSinkronisasiPage extends StatefulWidget {
  const TagihanSinkronisasiPage({super.key});

  @override
  State<TagihanSinkronisasiPage> createState() =>
      _TagihanSinkronisasiPageState();
}

class _TagihanSinkronisasiPageState extends State<TagihanSinkronisasiPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  // bool isRefresh = false;
  // Bloc tagihanLocalBloc = TagihanLocalBloc();

  // void refreshTagihan() {
  //   print("clicked");
  // }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    context.read<TagihanLocalBloc>().add(TagihanLocalGet());
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Sinkronisasi Tagihan',
            style: mainRdTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          ),
          leadingWidth: 0,
          leading: const SizedBox(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocConsumer<TagihanLocalBloc, TagihanLocalState>(
              listener: (context, state) {
                if (state is TagihanLocalDetailSuccess) {
                  print(state.data);
                }

                if (state is TagihanLocalFetchSuccess) {
                  context.read<TagihanLocalBloc>().add(TagihanLocalGet());
                }

                if (state is TagihanLocalDeleteSuccess) {
                  context.read<TagihanLocalBloc>().add(TagihanLocalGet());

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: whiteColor,
                      content: Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline_rounded,
                            color: greenColor,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Tagihan berhasil dihapus',
                            style: darkRdBrownTextStyle,
                          ),
                        ],
                      )));
                }
              },
              builder: (context, state) {
                if (state is TagihanLocalLoading) {
                  return const LoadingInfo();
                }
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                      color: greenColor.withAlpha(50),
                      // border: Border.all(width: 0.6, color: greyColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/ic_wallet.png',
                        width: 28,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total tagihan',
                            style: greyRdTextStyle.copyWith(fontSize: 8),
                          ),
                          Text(
                            'Rp 450.000',
                            style: darkRdBrownTextStyle.copyWith(
                                fontSize: 16, fontWeight: bold),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<TagihanLocalBloc>()
                              .add(TagihanLocalDeleteAll());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Sinkronisasi',
                            style: whiteRdTextStyle.copyWith(fontWeight: bold),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: mainColor, borderRadius: BorderRadius.circular(30)),
              child: TabBar(
                unselectedLabelColor: whiteColor,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                labelColor: mainColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    color: whiteColor, borderRadius: BorderRadius.circular(30)),
                dividerHeight: 0,
                controller: tabController,
                labelStyle: TextStyle(fontSize: 12, fontWeight: bold),
                labelPadding: EdgeInsets.zero,
                tabs: const [
                  Tab(
                    text: 'Menunggu',
                  ),
                  Tab(
                    text: 'Dibayar',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(controller: tabController, children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: mainColor.withAlpha(18),
                      borderRadius: BorderRadius.circular(12)),
                  child: SingleChildScrollView(
                    child: BlocBuilder<TagihanLocalBloc, TagihanLocalState>(
                      builder: (context, state) {
                        if (state is TagihanLocalInitial) {
                          // Dispatch the event to fetch local tagihan data
                          context
                              .read<TagihanLocalBloc>()
                              .add(TagihanLocalGet());
                        }
                        if (state is TagihanLocalLoading) {
                          return const LoadingInfo();
                        }

                        if (state is TagihanLocalSuccess) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: state.data
                                  .map((tagihan) => tagihanItem(
                                      context,
                                      tagihan.tagihanId!,
                                      tagihan.tagihanName!,
                                      tagihan.wajibRetribusiName!,
                                      tagihan.subwilayah!,
                                      tagihan.dueDate!,
                                      tagihan.price!))
                                  .toList());
                        }

                        return Container();
                      },
                    ),
                  ),
                ),
                Container(
                  child: Text("2"),
                ),
              ]),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.read<TagihanLocalBloc>().add(TagihanLocalFromServerStore());
            // setState(() {
            //   context.read<TagihanLocalBloc>().add(TagihanLocalGet());
            // });
            // setState(() {
            // refreshTagihan();
            // super.initState();
            // });

            // Then, dispatch TagihanLocalGet() after a delay (optional)
            // Future.delayed(const Duration(milliseconds: 500), () {
            //   BlocProvider.of<TagihanLocalBloc>(context).add(TagihanLocalGet());
            // });
            // BlocProvider.of<TagihanLocalBloc>(context)
            //     .add(TagihanLocalFromServerStore());

            // setState(() {
            //   isRefresh = true;
            // });
          },
          backgroundColor: whiteColor,
          elevation: 0,
          label: Text(
            'Refresh',
            style: mainRdTextStyle,
          ),
          icon: Icon(
            Icons.refresh_outlined,
            color: mainColor,
          ),
        ),
      ),
    );
  }

  Widget tagihanItem(BuildContext context, int tagihanId, String tagihanName,
      String wajibRetribusiname, String subwilayah, String dueDate, int price) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 6,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: mainColor.withAlpha(10),
                  blurRadius: 4,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 32,
                        child: Text(
                          tagihanName,
                          style:
                              darkRdBrownTextStyle.copyWith(fontWeight: bold),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          CustomModalBottomSheet.show(
                            context,
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            // },
                            // ),
                          );
                        },
                        child: Icon(
                          Icons.more_vert,
                          size: 18,
                          color: blueColor.withAlpha(130),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        size: 10,
                        color: mainColor,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(text: wajibRetribusiname),
                            const TextSpan(text: ' . '),
                            TextSpan(text: subwilayah),
                          ], style: greyRdTextStyle.copyWith(fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Batas Pembayaran : ',
                        style: darkRdBrownTextStyle.copyWith(
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        dueDate,
                        style: darkRdBrownTextStyle.copyWith(
                            fontSize: 10, fontWeight: bold),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        formatCurrency(price),
                        style: mainRdTextStyle.copyWith(
                            fontSize: 16, fontWeight: bold),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: const EdgeInsets.only(top: 45, right: 20),
            width: MediaQuery.of(context).size.width / 2,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: greyColor.withAlpha(70),
                    blurRadius: 8,
                  )
                ]),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    context
                        .read<TagihanLocalBloc>()
                        .add(TagihanLocalDelete(tagihanId));
                  },
                  child: SizedBox(
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outlined,
                          size: 14,
                          color: greyColor,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Hapus Tagihan',
                          style: greyRdTextStyle.copyWith(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
