import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/tagihan_local/tagihan_local_bloc.dart';
import 'package:satupintu_app/model/tagihan_local_amount_model.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';
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
  int billTotal = 0;
  List<int> tagihanLocalIds = [];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    context.read<TagihanLocalBloc>().add(TagihanLocalGet());
    context.read<TagihanLocalBloc>().add(TagihanBillAmount());
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              'Sinkronisasi Tagihan',
              style:
                  mainRdTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
            leadingWidth: 100,
            leading: TextButton(
              onPressed: () => _dialogBuilderConfirmationExit(context),
              child: Text(
                'Kembali',
                style: mainRdTextStyle.copyWith(fontWeight: bold),
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocConsumer<TagihanLocalBloc, TagihanLocalState>(
                listener: (context, state) {
                  if (state is TagihanLocalDetailSuccess) {
                    print(state.data);
                  }

                  if (state is TagihanLocalPaymentConfirmationSuccess) {
                    context.read<TagihanLocalBloc>().add(TagihanLocalGet());
                    context.read<TagihanLocalBloc>().add(TagihanBillAmount());

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: CustomSnackbar(
                          message: 'Konfirmasi pembayaran berhasil',
                          status: 'success',
                        ),
                        behavior: SnackBarBehavior.fixed,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  }

                  if (state is TagihanLocalFetchSuccess) {
                    context.read<TagihanLocalBloc>().add(TagihanLocalGet());
                    context.read<TagihanLocalBloc>().add(TagihanBillAmount());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: CustomSnackbar(
                          message: 'Berhasil memperbarui tagihan',
                          status: 'success',
                        ),
                        behavior: SnackBarBehavior.fixed,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  }

                  if (state is TagihanLocalFetchFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: CustomSnackbar(
                          message: 'Tidak dapat memperbaharui tagihan',
                          status: 'failed',
                        ),
                        behavior: SnackBarBehavior.fixed,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );

                    context.read<TagihanLocalBloc>().add(TagihanLocalGet());
                  }

                  if (state is TagihanBillAmountnSuccess) {
                    context.read<TagihanLocalBloc>().add(TagihanLocalGet());
                    print({"total tagihan": state.data.tagihanLocalId});
                    billTotal = state.data.amount!;
                    tagihanLocalIds = state.data.tagihanLocalId!;
                  }

                  if (state is TagihanLocalDeleteSuccess) {
                    context.read<TagihanLocalBloc>().add(TagihanLocalGet());

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: CustomSnackbar(
                          message: 'Tidak dapat memperbaharui tagihan',
                          status: 'success',
                        ),
                        behavior: SnackBarBehavior.fixed,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  }

                  if (state is TagihanLocalSynchronizeSuccess) {
                    Navigator.of(context).pop();
                    // context.read<TagihanLocalBloc>().add(TagihanLocalGet());
                    // context.read<TagihanLocalBloc>().add(TagihanBillAmount());

                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //     content: CustomSnackbar(
                    //       message: 'Konfirmasi pembayaran berhasil',
                    //       status: 'success',
                    //     ),
                    //     behavior: SnackBarBehavior.fixed,
                    //     backgroundColor: Colors.transparent,
                    //     elevation: 0,
                    //   ),
                    // );
                  }
                },
                builder: (context, state) {
                  if (state is TagihanLocalLoading) {
                    return const LoadingInfo();
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 18),
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
                              formatCurrency(billTotal),
                              style: darkRdBrownTextStyle.copyWith(
                                  fontSize: 16, fontWeight: bold),
                            ),
                          ],
                        ),
                        const Spacer(),
                        state is TagihanLocalLoading
                            ? LoadingAnimationWidget.staggeredDotsWave(
                                color: mainColor, size: 30)
                            : GestureDetector(
                                onTap: () {
                                  // Navigator.of(context).pop();
                                  context.read<TagihanLocalBloc>().add(
                                      TagihanLocalSynchronization(
                                          TagihanLocalAmountModel(
                                              tagihanLocalId: tagihanLocalIds,
                                              amount: billTotal)));
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
                                    style: whiteRdTextStyle.copyWith(
                                        fontWeight: bold),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 12),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: mainColor.withAlpha(18),
                        borderRadius: BorderRadius.circular(12)),
                    child: SingleChildScrollView(
                      child: BlocBuilder<TagihanLocalBloc, TagihanLocalState>(
                        builder: (context, state) {
                          if (state is TagihanLocalInitial) {
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
                                    .map((tagihan) => tagihan.status == false
                                        ? tagihanItem(
                                            context,
                                            tagihan.tagihanId!,
                                            tagihan.tagihanName!,
                                            tagihan.wajibRetribusiName!,
                                            tagihan.subwilayah!,
                                            tagihan.dueDate!,
                                            tagihan.price!,
                                            tagihan.status!,
                                            false)
                                        : const SizedBox())
                                    .toList());
                          }

                          return Container();
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 12),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: mainColor.withAlpha(18),
                        borderRadius: BorderRadius.circular(12)),
                    child: SingleChildScrollView(
                      child: BlocBuilder<TagihanLocalBloc, TagihanLocalState>(
                        builder: (context, state) {
                          if (state is TagihanLocalInitial) {
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
                                    .map((tagihan) => tagihan.status == true
                                        ? tagihanItem(
                                            context,
                                            tagihan.tagihanId!,
                                            tagihan.tagihanName!,
                                            tagihan.wajibRetribusiName!,
                                            tagihan.subwilayah!,
                                            tagihan.dueDate!,
                                            tagihan.price!,
                                            tagihan.status!,
                                            true)
                                        : const SizedBox())
                                    .toList());
                          }

                          return Container();
                        },
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _dialogBuilderConfirmationRefresh(context)
            // context.read<TagihanLocalBloc>().add(TagihanLocalFromServerStore());
            ,
            backgroundColor: greenColor,
            elevation: 0,
            label: Text(
              'Muat ulang tagihan',
              style: whiteRdTextStyle,
            ),
            icon: Icon(
              Icons.refresh_outlined,
              color: whiteColor,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget tagihanItem(
      BuildContext context,
      int tagihanId,
      String tagihanName,
      String wajibRetribusiname,
      String subwilayah,
      String dueDate,
      int price,
      bool status,
      bool isPaid) {
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
                          '$tagihanName ${status == false ? 'Blom' : 'Sudah'}',
                          style:
                              darkRdBrownTextStyle.copyWith(fontWeight: bold),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          // CustomModalBottomSheet.show(
                          //   context,
                          //   const Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       SizedBox(
                          //         height: 30,
                          //       ),
                          //       SizedBox(
                          //         height: 20,
                          //       ),
                          //     ],
                          //   ),
                          //   // },
                          //   // ),
                          // );
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 400,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                decoration: const BoxDecoration(
                                    // color: redColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      height: 4,
                                      width: 49,
                                      color: mainColor,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            tagihanName,
                                            style: darkRdBrownTextStyle
                                                .copyWith(fontWeight: medium),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          DottedLine(dashColor: greyColor),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Wajib retribusi : ',
                                                style: greyRdTextStyle.copyWith(
                                                    fontSize: 12),
                                              ),
                                              const Spacer(),
                                              Text(
                                                wajibRetribusiname,
                                                style: darkRdBrownTextStyle
                                                    .copyWith(
                                                        fontSize: 12,
                                                        fontWeight: bold),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Wilayah : ',
                                                style: greyRdTextStyle.copyWith(
                                                    fontSize: 12),
                                              ),
                                              const Spacer(),
                                              Text(
                                                subwilayah,
                                                style: darkRdBrownTextStyle
                                                    .copyWith(
                                                        fontSize: 12,
                                                        fontWeight: bold),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Batas pembayaran : ',
                                                style: greyRdTextStyle.copyWith(
                                                    fontSize: 12),
                                              ),
                                              const Spacer(),
                                              Text(
                                                iso8601toDateTime(dueDate),
                                                style: darkRdBrownTextStyle
                                                    .copyWith(
                                                        fontSize: 12,
                                                        fontWeight: bold),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 18,
                                          ),
                                          Row(children: [
                                            Text(
                                              'Total : ',
                                              style: greyRdTextStyle.copyWith(
                                                  fontSize: 12),
                                            ),
                                            const Spacer(),
                                            Text(
                                              formatCurrency(price),
                                              style:
                                                  darkRdBrownTextStyle.copyWith(
                                                      fontWeight: bold,
                                                      fontSize: 18),
                                            )
                                          ]),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          isPaid
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .check_circle_outline_outlined,
                                                      size: 18,
                                                      color: mainColor,
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      'Tagihan telah dibayar',
                                                      style: mainRdTextStyle
                                                          .copyWith(
                                                              fontWeight: bold),
                                                    )
                                                  ],
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    CustomFilledButton(
                                        title: !isPaid
                                            ? 'Konfirmasi pembayaran'
                                            : 'Batalkan Konfirmasi Pembayaran',
                                        onPressed: () {
                                          if (!isPaid) {
                                            context.read<TagihanLocalBloc>().add(
                                                TagihanLocalPaymentConfirmation(
                                                    tagihanId, 1));
                                          } else {
                                            context.read<TagihanLocalBloc>().add(
                                                TagihanLocalPaymentConfirmation(
                                                    tagihanId, 0));
                                          }
                                          Navigator.of(context).pop();
                                        }),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              );
                            },
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
        // Align(
        //   alignment: Alignment.topRight,
        //   child: Container(
        //     margin: const EdgeInsets.only(top: 45, right: 20),
        //     width: MediaQuery.of(context).size.width / 2,
        //     // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        //     decoration: BoxDecoration(
        //         color: whiteColor,
        //         borderRadius: BorderRadius.circular(6),
        //         boxShadow: [
        //           BoxShadow(
        //             color: greyColor.withAlpha(70),
        //             blurRadius: 8,
        //           )
        //         ]),
        //     child: Column(
        //       children: [
        //         GestureDetector(
        //           onTap: () {
        //             context
        //                 .read<TagihanLocalBloc>()
        //                 .add(TagihanLocalDelete(tagihanId));
        //           },
        //           child: Container(
        //               // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        //               // color: whiteColor,
        //               // child: Row(
        //               //   children: [
        //               //     Icon(
        //               //       Icons.delete_outlined,
        //               //       size: 14,
        //               //       color: greyColor,
        //               //     ),
        //               //     const SizedBox(
        //               //       width: 4,
        //               //     ),
        //               //     Text(
        //               //       'Hapus Tagihan',
        //               //       style: greyRdTextStyle.copyWith(fontSize: 12),
        //               //     )
        //               //   ],
        //               // ),
        //               ),
        //         ),
        //         const SizedBox(
        //           height: 6,
        //         ),
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }

  Future<void> _dialogBuilderConfirmationExit(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: SizedBox(
              height: 90,
              child: Column(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: orangeColor,
                  ),
                  Text(
                    'Apakah anda yakin?',
                    style: darkRdBrownTextStyle.copyWith(
                        fontSize: 18, fontWeight: bold),
                  ),
                  Text(
                    'Apakah anda ingin keluar dari mode sinkronisasi',
                    style:
                        greyRdTextStyle.copyWith(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              CustomFilledButton(
                  title: 'Setuju dan Lanjutkan',
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  }),
              const SizedBox(
                height: 8,
              ),
              CustomOutlinedButton(
                title: 'Batal',
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: darkBrownColor,
              )
            ]);
      },
    );
  }

  Future<void> _dialogBuilderConfirmationRefresh(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            // backgroundColor: whiteColor,
            // title: Text(
            //   'Apakah anda yakin?',
            //   style:
            //       darkRdBrownTextStyle.copyWith(fontSize: 18, fontWeight: bold),
            // ),

            content: SizedBox(
              height: 130,
              child: Column(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: orangeColor,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Apakah anda yakin?',
                    style: darkRdBrownTextStyle.copyWith(
                        fontSize: 18, fontWeight: bold),
                  ),
                  Text(
                    'Apakah anda yakin ingin memuat ulang semua tagihan saat ini?',
                    style:
                        greyRdTextStyle.copyWith(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              CustomFilledButton(
                  title: 'Setuju dan Lanjutkan',
                  onPressed: () {
                    context
                        .read<TagihanLocalBloc>()
                        .add(TagihanLocalFromServerStore());
                    Navigator.of(context).pop();
                  }),
              const SizedBox(
                height: 8,
              ),
              CustomOutlinedButton(
                title: 'Batal',
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: darkBrownColor,
              )
            ]);
      },
    );
  }
}
