import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/setoran/setoran_bloc.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/petugas/setoran_add_page.dart';
import 'package:satupintu_app/ui/pages/petugas/setoran_detail_page.dart';
import 'package:satupintu_app/ui/pages/template_page.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';

class SetoranListPage extends StatefulWidget {
  const SetoranListPage({super.key});

  @override
  State<SetoranListPage> createState() => _SetoranListPageState();
}

class _SetoranListPageState extends State<SetoranListPage> {
  late Bloc setoranBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TemplateMain(
      title: 'Daftar Setoran',
      body: BlocProvider(
        create: (context) => SetoranBloc()..add(SetoranGet()),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
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
                            "Cari item retribusi...",
                            style: greyRdTextStyle.copyWith(
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const Spacer(), // Use Expanded instead of Spacer
                          Icon(
                            Icons.search,
                            size: 20,
                            color: mainColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        'Daftar Setoran',
                        style:
                            darkRdBrownTextStyle.copyWith(fontWeight: semiBold),
                      ),
                    ),
                    BlocConsumer<SetoranBloc, SetoranState>(
                      listener: (context, state) {
                        if (state is SetoranSuccess) {
                          setState(() {
                            setoranBloc = context.read<SetoranBloc>();
                          });
                        }
                      },
                      builder: (context, state) {
                        if (state is SetoranLoading) {
                          return Center(
                            child: LoadingAnimationWidget.inkDrop(
                                color: mainColor, size: 30),
                          );
                        }

                        if (state is SetoranSuccess) {
                          return Column(
                              children: state.data
                                  .map(
                                    (setoran) => GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SetoranDetailPage(
                                              setoran: setoran,
                                            ),
                                          ),
                                        );
                                      },
                                      child: setoranCard(
                                          setoran.waktuSetoran!,
                                          setoran.lokasiSetoran!,
                                          setoran.status!),
                                    ),
                                  )
                                  .toList());
                        }

                        if (state is SetoranFailed) {
                          return Center(child: Text(state.e));
                        }

                        return const Center(
                          child: Text('Gagal memuat setoran...'),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: whiteColor,
                boxShadow: [
                  BoxShadow(color: lightBlueColor),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Klik tombol dibawah ini jika anda ingin menambahkan bukti setoran baru.',
                    style: darkRdBrownTextStyle.copyWith(
                        fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFilledButton(
                      title: 'Tambah Setoran',
                      onPressed: () async {
                        final isRefresh = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SetoranAddPage(),
                          ),
                        );

                        if (mounted && isRefresh == 'refresh') {
                          print(isRefresh);
                          // setoranBloc.add(SetoranGet());
                          return setoranBloc.add(SetoranGet());
                        }
                      })
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget setoranCard(
    String tanggalSetoran,
    String lokasiSetoran,
    String status,
  ) {
    DateTime dateTime = DateTime.parse(tanggalSetoran);
    String formattedTanggalPenyetoran =
        DateFormat('dd MMM yyyy').format(dateTime).toUpperCase();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 18),
      decoration: BoxDecoration(
        border: Border.all(width: 0.2, color: mainColor),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.date_range_outlined, color: mainColor, size: 20),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedTanggalPenyetoran,
                style: darkRdBrownTextStyle.copyWith(
                    fontSize: 12, fontWeight: bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                lokasiSetoran,
                style: darkRdBrownTextStyle.copyWith(
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
                color: status == 'MENUNGGU'
                    ? orangeColor
                    : status == 'DITERIMA'
                        ? greenColor
                        : redColor,
                borderRadius: BorderRadius.circular(100)),
            child: Text(
              status,
              style: whiteRdTextStyle.copyWith(fontSize: 8, fontWeight: bold),
            ),
          ),
          Icon(
            Icons.keyboard_arrow_right,
            color: mainColor,
          )
        ],
      ),
    );
  }
}
