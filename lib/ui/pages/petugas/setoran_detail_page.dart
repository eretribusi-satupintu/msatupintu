import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:satupintu_app/model/setoran_model.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/petugas/setoran_edit_page.dart';

class SetoranDetailPage extends StatelessWidget {
  final SetoranModel setoran;
  const SetoranDetailPage({super.key, required this.setoran});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(setoran.waktuSetoran!);
    String formattedTanggalPenyetoran =
        DateFormat('dd MMMM yyyy').format(dateTime).toUpperCase();
    String formattedWaktuPenyetoran = DateFormat('HH:mm ').format(dateTime);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Detail Setoran',
            style: mainRdTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_left_rounded,
              size: 30,
              color: mainColor,
            ),
          ),
          actions: [
            setoran.status != 'DITERIMA'
                ? IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SetoranEditPage(setoran: setoran)));
                    },
                    icon: Icon(
                      Icons.mode_edit_outlined,
                      color: greyColor,
                    ))
                : const SizedBox()
          ],
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 12,
            ),
            setoran.status! == 'MENUNGGU'
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        color: orangeColor.withAlpha(45),
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.pending_actions_rounded,
                          color: orangeColor,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Text(
                            'Setoran anda sedang menungggu konfirmasi',
                            style:
                                darkRdBrownTextStyle.copyWith(fontWeight: bold),
                          ),
                        )
                      ],
                    ),
                  )
                : setoran.status! == 'DITERIMA'
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 18),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            color: greenColor.withAlpha(45),
                            borderRadius: BorderRadius.circular(6)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline_rounded,
                              color: greenColor,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                'Setoran anda sudah disetujui',
                                style: darkRdBrownTextStyle.copyWith(
                                    fontWeight: bold),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 18),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            color: redColor.withAlpha(45),
                            borderRadius: BorderRadius.circular(6)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.cancel_outlined,
                              color: redColor,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                'Pengajuan setoran anda ditolak',
                                style: darkRdBrownTextStyle.copyWith(
                                    fontWeight: bold),
                              ),
                            )
                          ],
                        ),
                      ),
            const SizedBox(
              height: 18,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            color: mainColor.withAlpha(40),
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(
                          Icons.date_range_outlined,
                          color: mainColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Tanggal\npenyetoran',
                        style: mainRdTextStyle.copyWith(fontSize: 12),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            formattedTanggalPenyetoran,
                            style:
                                darkRdBrownTextStyle.copyWith(fontWeight: bold),
                          ),
                          Text(
                            '$formattedWaktuPenyetoran WIB',
                            style: greyRdTextStyle.copyWith(fontSize: 12),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DottedLine(
                    dashColor: mainColor,
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Text(
                    'Informasi',
                    style: darkRdBrownTextStyle.copyWith(fontWeight: bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Nominal Setoran',
                        style: greyRdTextStyle,
                      ),
                      const Spacer(),
                      Text(
                        formatCurrency(setoran.total!),
                        style: mainRdTextStyle.copyWith(
                            fontWeight: bold, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      Text(
                        'Lokasi peneyetoran',
                        style: greyRdTextStyle,
                      ),
                      const Spacer(),
                      Text(
                        setoran.lokasiSetoran!,
                        style: mainRdTextStyle.copyWith(
                          fontWeight: bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Text(
                    'Keterangan',
                    style: darkRdBrownTextStyle.copyWith(fontWeight: bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    setoran.keterangan!,
                    style: darkRdBrownTextStyle.copyWith(
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Text(
                    'Bukti Peneyetoran',
                    style: darkRdBrownTextStyle.copyWith(fontWeight: bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: mainColor),
                    ),
                    child: Image.network(
                        'http://localhost:3000/${setoran.buktiSetoran!}'),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
