import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/petugas/petugas_bloc.dart';
import 'package:satupintu_app/blocs/setoran/setoran_bloc.dart';
import 'package:satupintu_app/model/bill_amount_model.dart';
import 'package:satupintu_app/model/setoran_form_model.dart';
import 'package:satupintu_app/model/setoran_model.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/petugas/setoran_list_page.dart';
import 'package:satupintu_app/ui/pages/petugas/setoran_detail_page.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';

class SetoranEditPage extends StatefulWidget {
  final SetoranModel setoran;
  const SetoranEditPage({super.key, required this.setoran});

  @override
  State<SetoranEditPage> createState() => _SetoranEditPageState();
}

class _SetoranEditPageState extends State<SetoranEditPage> {
  DateTime now = DateTime.now();
  late TextEditingController keteranganController;
  // int totalSetoran = 0;
  // List<TransaksiPetugasModel> transaksiPetugasIdList = [];
  String lokasiSetoran = '';
  XFile? image;

  bool validate() {
    if (widget.setoran.buktiSetoran == '') {
      if (lokasiSetoran == '' || image == null) {
        return false;
      }
      return true;
    }
    return true;
  }

  Future getImage(String media) async {
    final ImagePicker picker = ImagePicker();

    switch (media) {
      case 'galery':
        final XFile? imagePicker =
            await picker.pickImage(source: ImageSource.gallery);
        setImage(imagePicker!);

        break;
      case 'camera':
        final XFile? imagePicker = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
          maxWidth: 300,
          maxHeight: 500,
        );
        setImage(imagePicker!);
      default:
        return;
    }
  }

  void setImage(XFile file) {
    setState(() {
      Navigator.pop(context, 'refresh');
      image = file;
    });
  }

  @override
  void initState() {
    super.initState();
    keteranganController =
        TextEditingController(text: widget.setoran.keterangan ?? '');
    lokasiSetoran = widget.setoran.lokasiSetoran!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Setoran ',
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
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => PetugasBloc()..add(PetugasBillAmountGet()),
            ),
            BlocProvider(
              create: (context) => SetoranBloc(),
            ),
          ],
          child: BlocConsumer<SetoranBloc, SetoranState>(
            listener: (context, state) {
              if (state is SetoranFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: CustomSnackbar(
                      message: state.e,
                      status: 'failed',
                    ),
                    behavior: SnackBarBehavior.fixed,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                );
              }

              if (state is SetoranDetailSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (contect) =>
                        SetoranDetailPage(setoran: state.data),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is SetoranLoading) {
                return Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: mainColor, size: 45),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 8),
                              decoration: BoxDecoration(
                                  color: mainColor.withAlpha(40),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/ic_date.png',
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Penyetoran ditetapkan pada tanggal ',
                                          style: darkInBrownTextStyle.copyWith(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          iso8601toDateTime(now.toString()),
                                          style: mainRdTextStyle.copyWith(
                                              fontWeight: semiBold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Total penyetoran',
                              style:
                                  darkInBrownTextStyle.copyWith(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              formatCurrency(widget.setoran.total!),
                              style: darkInBrownTextStyle.copyWith(
                                  fontWeight: bold, fontSize: 18),
                            ),
                            // BlocConsumer<PetugasBloc, PetugasState>(
                            //   listener: (context, state) {
                            //     if (state is PetugasBillAmountSuccess) {
                            //       setState(() {
                            //         totalSetoran = state.data.total;
                            //         transaksiPetugasIdList =
                            //             state.data.transaksiPetugas;
                            //       });
                            //     }
                            //   },
                            //   builder: (context, state) {
                            //     if (state is PetugasLoading) {
                            //       return LoadingAnimationWidget.inkDrop(
                            //           color: mainColor, size: 30);
                            //     }
                            //     return Text(
                            //       formatCurrency(totalSetoran),
                            //       style: darkInBrownTextStyle.copyWith(
                            //           fontWeight: bold, fontSize: 18),
                            //     );
                            //   },
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Upload Bukti',
                              style: mainRdTextStyle.copyWith(
                                fontWeight: bold,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                mediaChooseDialog(context);
                              },
                              child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: mainColor.withAlpha(90),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: image == null
                                      ? Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.network(
                                              'http://localhost:3000/${widget.setoran.buktiSetoran!}',
                                              height: 450,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                  color: mainColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Text(
                                                'Ketuk untuk mengganti file',
                                                style:
                                                    whiteRdTextStyle.copyWith(
                                                        fontWeight: bold,
                                                        fontSize: 10),
                                              ),
                                            )
                                          ],
                                        )
                                      // Center(
                                      //     child: Column(
                                      //     children: [
                                      //       Image.asset(
                                      //         'assets/ic_image_upload.png',
                                      //         width: 70,
                                      //       ),
                                      //       Text(
                                      //         'Pilih File',
                                      //         style: mainRdTextStyle,
                                      //       )
                                      //     ],
                                      //   ))
                                      : Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.file(
                                              File(image!.path),
                                              height: 450,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                  color: mainColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Text(
                                                'Ketuk untuk mengganti file',
                                                style:
                                                    whiteRdTextStyle.copyWith(
                                                        fontWeight: bold,
                                                        fontSize: 10),
                                              ),
                                            )
                                          ],
                                        )),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Container(
                              height: 100,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: mainColor.withAlpha(90),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                controller: keteranganController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: 'Keterangan...',
                                  hintStyle:
                                      TextStyle(fontSize: 12, color: mainColor),
                                  border: InputBorder.none,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 16),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: greyColor.withAlpha(30),
                              spreadRadius: 4,
                              blurRadius: 15,
                              offset: const Offset(0, 4))
                        ]),
                    child: Column(
                      children: [
                        Text(
                          'Sebelum mengklik tombol “Update Setoran” pastikan total, tanggal, dan tempat penyetoran sudah benar',
                          style: darkRdBrownTextStyle.copyWith(
                              fontSize: 12, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownMenu(
                            selectedTrailingIcon:
                                const Icon(Icons.cancel_outlined),
                            label: Text(
                              'Pilih lokasi penyetoran',
                              style: darkRdBrownTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: semiBold,
                              ),
                            ),
                            inputDecorationTheme: const InputDecorationTheme(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0)),
                            expandedInsets:
                                const EdgeInsets.symmetric(horizontal: 0),
                            onSelected: (value) {
                              setState(() {
                                lokasiSetoran = value!;
                              });
                            },
                            menuStyle: MenuStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(whiteColor),
                                shadowColor:
                                    MaterialStatePropertyAll(whiteColor),
                                surfaceTintColor:
                                    MaterialStatePropertyAll(mainColor)),
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(
                                value: 'KANTOR',
                                label: 'Kantor',
                              ),
                              DropdownMenuEntry(
                                value: 'TRANSFER_BANK',
                                label: 'Transfer Bank',
                              )
                            ],
                            initialSelection: widget.setoran.lokasiSetoran,
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        CustomFilledButton(
                            title: 'Update Setoran',
                            onPressed: () {
                              if (validate() == false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: CustomSnackbar(
                                      message:
                                          'Pastikan ada telah mengunggah bukti bayar dan lokasi setoran ${lokasiSetoran}',
                                      status: 'failed',
                                    ),
                                    behavior: SnackBarBehavior.fixed,
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  ),
                                );
                              } else {
                                context.read<SetoranBloc>().add(SetoranUpdate(
                                    widget.setoran.id!,
                                    SetoranFormModel(
                                        now.toString(),
                                        null,
                                        null,
                                        widget.setoran.total,
                                        lokasiSetoran,
                                        image != null
                                            ? base64Encode(
                                                File(image!.path)
                                                    .readAsBytesSync(),
                                              )
                                            : '',
                                        keteranganController.value.text
                                            .toString())));
                              }
                            })
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }

  Future<void> mediaChooseDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            'Pilih Media',
            style: mainRdTextStyle.copyWith(fontSize: 14, fontWeight: bold),
            textAlign: TextAlign.center,
          ),
          content: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  await getImage('camera');
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: mainColor.withAlpha(80),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/ic_camera.png',
                        width: 45,
                        height: 45,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Kamera',
                        style: darkRdBrownTextStyle.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  await getImage('galery');
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: mainColor.withAlpha(80),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/ic_galery.png',
                        width: 45,
                        height: 45,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Galery',
                        style: darkRdBrownTextStyle.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
