import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/item_retribusi/item_retribusi_bloc.dart';
import 'package:satupintu_app/blocs/tagihan_manual/tagihan_manual_bloc.dart';
import 'package:satupintu_app/model/item_retribusi_model.dart';
import 'package:satupintu_app/model/tagihan_manual_form_model.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/petugas/tagihan_manual_detail_page.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';

class TagihanAddPage extends StatefulWidget {
  const TagihanAddPage({super.key});

  @override
  State<TagihanAddPage> createState() => _TagihanAddPageState();
}

class _TagihanAddPageState extends State<TagihanAddPage> {
  int? categoryId;
  int? price;
  final keteranganController = TextEditingController(text: '');
  bool invalidData = false;

  bool validate() {
    if (categoryId == null ||
        price == null ||
        keteranganController.value.text.length < 8) {
      print({
        "kat": categoryId,
        "har": price,
        "ket": keteranganController.value.text
      });
      invalidData = true;
      return false;
    } else {
      invalidData = false;
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Tagihan Manual',
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
            create: (context) => ItemRetribusiBloc()..add(ItemRetribusiGet()),
          ),
          BlocProvider(
            create: (context) => TagihanManualBloc(),
          ),
        ],
        child: BlocConsumer<TagihanManualBloc, TagihanManualState>(
          listener: (context, state) {
            if (state is TagihanManualDetailSuccess) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TagihanManualDetailPage(tagihanModel: state.data)));
            }

            if (state is TagihanManualFailed) {
              print(state.e);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                          color: greenColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: greenColor,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: Text(
                            'Pastikan anda mengenerate tagihan yang akan dibayarkan',
                            style: darkRdBrownTextStyle.copyWith(
                                fontSize: 12, fontWeight: bold),
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Text(
                                'Pilih kategori',
                                style: darkRdBrownTextStyle.copyWith(
                                    fontWeight: semiBold),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                              height: 50,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: mainColor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: BlocBuilder<ItemRetribusiBloc,
                                  ItemRetribusiState>(
                                builder: (context, state) {
                                  if (state is ItemRetribusiLoading) {
                                    return Center(
                                      child: LoadingAnimationWidget
                                          .staggeredDotsWave(
                                              color: mainColor, size: 30),
                                    );
                                  }

                                  if (state is ItemRetribusiFailed) {
                                    return Text(state.e);
                                  }

                                  if (state is ItemRetribusiSuccess) {
                                    return DropdownMenu(
                                      selectedTrailingIcon:
                                          const Icon(Icons.cancel_outlined),
                                      label: Text(
                                        'Kategori tagihan',
                                        style: mainRdTextStyle.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                      inputDecorationTheme:
                                          const InputDecorationTheme(
                                              enabledBorder: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 0)),
                                      expandedInsets:
                                          const EdgeInsets.symmetric(
                                              horizontal: 0),
                                      onSelected: (value) {
                                        // print(jsonDecode(value.toString()));
                                        if (value != null &&
                                            value is ItemRetribusiModel) {
                                          print({
                                            "harga": value.price!.toString()
                                          });
                                          setState(() {
                                            categoryId = value.id!;
                                            price = value.price!;
                                          });
                                        } else {
                                          print("test");
                                        }
                                      },
                                      menuStyle: MenuStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  whiteColor),
                                          shadowColor: MaterialStatePropertyAll(
                                              whiteColor),
                                          surfaceTintColor:
                                              MaterialStatePropertyAll(
                                                  mainColor)),
                                      dropdownMenuEntries: state.data.isNotEmpty
                                          ? state.data
                                              .map(
                                                (itemRetribusi) =>
                                                    DropdownMenuEntry(
                                                  value: itemRetribusi,
                                                  label: itemRetribusi
                                                      .categoryName!,
                                                ),
                                              )
                                              .toList()
                                          : const [
                                              DropdownMenuEntry(
                                                  value: '',
                                                  label:
                                                      'Kategori retribusi tidak tersedia',
                                                  enabled: false)
                                            ],
                                    );
                                  }

                                  return Text('gagal memuat...');
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  price != null
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Harga',
                                              style:
                                                  darkRdBrownTextStyle.copyWith(
                                                      fontWeight: semiBold),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              price.toString(),
                                              style: darkRdBrownTextStyle
                                                  .copyWith(fontSize: 18),
                                            )
                                          ],
                                        )
                                      : const SizedBox()

                                  // CustomInput(
                                  //   hintText: "Total harga",
                                  //   controller: priceController,
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18),
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
                                onSaved: (String? value) {},
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Text(
                                '* Mohon menambahkan keterangan terkait tagihan ex: nama penyewa, lokasi, dll',
                                style: darkInBrownTextStyle.copyWith(
                                    fontStyle: FontStyle.italic, fontSize: 10),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            invalidData == true
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Perhatian',
                                            style:
                                                darkInBrownTextStyle.copyWith(
                                                    fontSize: 10,
                                                    fontWeight: bold)),
                                        const SizedBox(height: 6),
                                        Text(
                                            ' * Pastikan anda telah memilih kategori tagihan',
                                            style: redRdTextStyle.copyWith(
                                                fontSize: 10)),
                                        Text(
                                            ' * Pastikan harga telah tergenerate',
                                            style: redRdTextStyle.copyWith(
                                                fontSize: 10)),
                                        Text(
                                            ' * Pastikan anda telah memasukkan keterangan tagihan min 8 karakter',
                                            style: redRdTextStyle.copyWith(
                                                fontSize: 10)),
                                      ],
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        children: [
                          CustomFilledButton(
                              title: 'Buat Tagihan',
                              onPressed: () {
                                if (validate() == true) {
                                  context.read<TagihanManualBloc>().add(
                                      TagihanManualPost(TagihanManualFormModel(
                                          detailTagihan:
                                              keteranganController.value.text,
                                          itemRetribusiId: categoryId,
                                          price: price)));
                                } else {
                                  setState(() {
                                    invalidData = true;
                                  });
                                  print("gagal");
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
                state is TagihanManualLoading
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: mainColor.withAlpha(50),
                        child: Center(
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 10,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                LoadingAnimationWidget.staggeredDotsWave(
                                    color: mainColor, size: 45),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text('Permintaan anda sedang diproses',
                                    style: darkRdBrownTextStyle),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            );
          },
        ),
      ),
    );
  }
}
