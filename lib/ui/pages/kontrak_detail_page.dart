import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/kontrak/kontrak_bloc.dart';
import 'package:satupintu_app/blocs/tagihan/tagihan_bloc.dart';
import 'package:satupintu_app/model/kontrak_item_retribusi_model.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:satupintu_app/ui/widget/draggable_scrollable_modal.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'synfusi'

class KontrakDetailPage extends StatefulWidget {
  final KontrakItemRetribusiModel itemRetribusi;
  const KontrakDetailPage({super.key, required this.itemRetribusi});

  @override
  State<KontrakDetailPage> createState() => _KontrakDetailPageState();
}

class _KontrakDetailPageState extends State<KontrakDetailPage> {
  late String statusKontrak;
  @override
  void initState() {
    super.initState();
    setState(() {
      statusKontrak = widget.itemRetribusi.status!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kontrak ${widget.itemRetribusi.categoryName}',
          style: mainRdTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          overflow: TextOverflow.ellipsis,
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
        children: [
          GestureDetector(
            onTap: () {
              CustomModalBottomSheet.show(
                context,
                BlocProvider(
                  create: (context) => TagihanBloc()
                    ..add(TagihanWajibRetribusiMasyarakatProgressGet(
                        widget.itemRetribusi.id!)),
                  child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Daftar Tagihan',
                            style: darkRdBrownTextStyle.copyWith(
                                fontWeight: semiBold),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          BlocBuilder<TagihanBloc, TagihanState>(
                            builder: (context, state) {
                              if (state is TagihanLoading) {
                                return Center(
                                    child: LoadingAnimationWidget.inkDrop(
                                        color: mainColor, size: 30));
                              }

                              if (state is TagihanSuccess) {
                                return Column(
                                  children: state.data
                                      .map((tagihan) => tagihanCard(
                                          tagihan.tagihanName!,
                                          tagihan.dueDate!,
                                          tagihan.price.toString(),
                                          tagihan.status!))
                                      .toList(),
                                );
                              }

                              if (state is TagihanFailed) {
                                return Center(child: Text(state.e));
                              }

                              return Center(
                                child: Text('Gagal memuat...'),
                              );
                            },
                          ),
                        ],
                      )),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: lightBlueColor.withAlpha(50),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.receipt_long_rounded,
                    color: greenColor,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Tampilkan progress Tagihan',
                    style: darkInBrownTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 12),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_drop_down_outlined)
                ],
              ),
            ),
          ),
          Expanded(
            child: SfPdfViewer.network(
              'https://d1wqtxts1xzle7.cloudfront.net/31029505/index.htm-libre.pdf?1392227636=&response-content-disposition=inline%3B+filename%3DOptimalisasi_Pajak_Daerah_dan_Retribusi.pdf&Expires=1712645435&Signature=GCNke1tC228q9VOrTE7dknz4CWpAb3sIORXLVqCK~C7wBFoJAc1X0SmhKx41AXeMwV5A8otAsSMXcL-53qmpGWCV66BBr7omrsvrGANNx7Hw-q-2bKsojJZZgfbheKVqmFL3kmETFXBie8XXhXOPLAyh8X9fyKlNtYvN3CzVl46q6yFekuJoOQ859mGw68Rlk4aO88DYrH~Zu2pBxT1HOMP05yq-eEHn3Qk19fHgnWcA5ZMd~tXjKXMLnftlVgDSWslvUzrYPZ2v5eHuuscDs5FyBG6D1F68o7mZDQc8B5GYZUxlrNo7ByvRRH8i9LDzfipBMwsSgHigGNd3tKZphw__&Key-Pair-Id=APKAJLOHF5GGSLRBV4ZA',
            ),
          ),
          BlocProvider(
            create: (context) => KontrakBloc(),
            child: BlocConsumer<KontrakBloc, KontrakState>(
              listener: (context, state) {
                if (state is KontrakSuccess) {
                  setState(() {
                    statusKontrak = state.kontrak.status!;
                  });
                  print(statusKontrak);
                }
              },
              builder: (context, state) {
                if (state is KontrakLoading) {
                  return Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: mainColor, size: 30),
                  );
                }

                if (state is KontrakFailed) {
                  return Center(
                    child: Text(state.e),
                  );
                }

                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: lightBlueColor.withAlpha(70),
                      ),
                    ],
                  ),
                  child: statusKontrak == 'DITERIMA'
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle_outline_outlined,
                                  color: greenColor,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  'Anda telah menyetujui kontrak ini',
                                  style: darkInBrownTextStyle.copyWith(
                                      fontWeight: bold),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outlined,
                                  color: mainColor,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'Info',
                                  style: darkInBrownTextStyle.copyWith(
                                      fontWeight: bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              statusKontrak == 'DIPROSES'
                                  ? 'Kontrak masih menunggu konfirmasi dari anda, konfirmasi persetujuan jika kontrak sudah sesuai $statusKontrak'
                                  : 'Kontrak sedang diperbarui, mohon menunggu hingga tombol konfirmasi aktif kembali',
                              style: greyRdTextStyle.copyWith(fontSize: 12),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            statusKontrak == 'DIPROSES'
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          context.read<KontrakBloc>().add(
                                                KontrakUpdateStatus(
                                                    widget.itemRetribusi.id!,
                                                    'DITOLAK'),
                                              );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 8),
                                          decoration: BoxDecoration(
                                              color: whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                  width: 2, color: mainColor)),
                                          child: Text(
                                            'Belum sesuai',
                                            style: mainRdTextStyle.copyWith(
                                                fontWeight: semiBold),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          context.read<KontrakBloc>().add(
                                              KontrakUpdateStatus(
                                                  widget.itemRetribusi.id!,
                                                  'DITERIMA'));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 8),
                                          decoration: BoxDecoration(
                                              color: mainColor,
                                              border: Border.all(
                                                  width: 2, color: mainColor),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: Text(
                                            'Sudah Sesuai',
                                            style: whiteRdTextStyle.copyWith(
                                                fontWeight: semiBold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox()
                          ],
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget tagihanCard(
    String name,
    String dueDate,
    String price,
    String status,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              status == 'VERIFIED'
                  ? Icon(
                      Icons.check_circle_outline,
                      size: 15,
                      color: greenColor,
                    )
                  : Icon(
                      Icons.circle_outlined,
                      size: 15,
                      color: lightGreyColor,
                    ),
              DottedLine(
                lineLength: 75, // Take all available height
                direction: Axis.vertical,
                dashColor: status == 'VERIFIED' ? greenColor : lightGreyColor,
                dashLength: 5,
                lineThickness: 2,
              ),
            ],
          ),
          const SizedBox(
            width: 7,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 100,
                      child: Text(
                        name,
                        style: blackInTextStyle.copyWith(
                          fontWeight: bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: lightGreyColor,
                      size: 18,
                    )
                  ],
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
                          'Batas pembayaran',
                          style: greyRdTextStyle.copyWith(fontSize: 10),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          iso8601toDateTime(dueDate),
                          style: mainRdTextStyle.copyWith(
                              fontSize: 12, fontWeight: medium),
                        )
                      ],
                    ),
                    const Spacer(),
                    Text(
                      formatCurrency(int.parse(price)),
                      style: greenRdTextStyle.copyWith(
                          fontSize: 14, fontWeight: bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
