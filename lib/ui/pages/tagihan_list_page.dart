import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/tagihan/tagihan_bloc.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/tagihan_detail_page.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/widget/empty_data_info.dart';
import 'package:satupintu_app/ui/widget/failed_info.dart';
import 'package:satupintu_app/ui/widget/inputs.dart';
import 'package:satupintu_app/ui/widget/laoding_info.dart';

class TagihanListPage extends StatefulWidget {
  const TagihanListPage({
    super.key,
  });

  @override
  State<TagihanListPage> createState() => _TagihanListPageState();
}

class _TagihanListPageState extends State<TagihanListPage> {
  final searchController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TagihanBloc(),
      child: SingleChildScrollView(
        child: BlocConsumer<TagihanBloc, TagihanState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   width: double.infinity,
                //   margin: const EdgeInsets.symmetric(horizontal: 18),
                //   padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                //   decoration: BoxDecoration(
                //     color: blueColor.withAlpha(25),
                //     borderRadius: const BorderRadius.all(
                //       Radius.circular(10),
                //     ),
                //   ),
                //   child: Row(
                //     children: [
                //       Text(
                //         "Cari tagihan...",
                //         style: greyRdTextStyle.copyWith(
                //           fontSize: 10,
                //           fontStyle: FontStyle.italic,
                //         ),
                //       ),
                //       const Spacer(), // Use Expanded instead of Spacer
                //       Icon(
                //         Icons.search,
                //         size: 20,
                //         color: mainColor,
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  child: CustomInput(
                    controller: searchController,
                    hintText: 'Cari Tagihan ...',
                    onFieldSubmitted: (value) {
                      if (value.isNotEmpty) {
                        context.read<TagihanBloc>().add(
                            TagihanWajibRetribusiMasyarakatByTagihanNameGet(
                                value));
                        print({"value": value});
                      } else {
                        context
                            .read<TagihanBloc>()
                            .add(TagihanWajibRetribusiMasyarakatGet());
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'Daftar Tagihan',
                    style: darkRdBrownTextStyle.copyWith(fontWeight: semiBold),
                  ),
                ),
                BlocConsumer<TagihanBloc, TagihanState>(
                  listener: (context, state) {
                    if (state is TagihanFailed) {
                      if (state.e == 'Unauthorized') {
                        Navigator.pushNamed(context, '/timesout');
                      }
                    }

                    if (state is TagihanSuccess) {
                      print({"status": "succcess"});
                    }
                    if (state is TagihanFailed) {
                      print({"status": state.e});
                    }
                  },
                  builder: (context, state) {
                    if (state is TagihanInitial) {
                      context
                          .read<TagihanBloc>()
                          .add(TagihanWajibRetribusiMasyarakatGet());
                    }

                    if (state is TagihanLoading) {
                      return LoadingInfo();
                    }

                    if (state is TagihanSuccess) {
                      if (state.data.isNotEmpty) {
                        return Column(
                          children: state.data
                              .map((tagihan) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TagihanDetailPage(
                                                    tagihanId: tagihan.id!,
                                                    status: tagihan.status!,
                                                  )));
                                    },
                                    child: tagihanCard(
                                        tagihan.itemRetribusiName!,
                                        tagihan.tagihanName!,
                                        tagihan.dueDate!,
                                        tagihan.price!),
                                  ))
                              .toList(),
                        );
                      }
                      return const EmptyData(
                          message: 'Anda belum memiliki tagihan');
                    }
                    if (state is TagihanFailed) {
                      return ErrorInfo(e: state.e);
                    }
                    return const ErrorInfo();
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget tagihanCard(
      String kontrakName, String tagihanName, String dueDate, int price) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: lightGreyColor.withAlpha(65),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/img_invoice.png',
                width: 10,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                kontrakName,
                style: greyRdTextStyle.copyWith(fontSize: 10),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            tagihanName,
            style:
                blackInTextStyle.copyWith(fontWeight: semiBold, fontSize: 12),
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
                  Row(
                    children: [
                      Text(
                        'Batas pembayaran ',
                        style: greyRdTextStyle.copyWith(fontSize: 10),
                      ),
                      DateTime.parse(dueDate).isBefore(DateTime.now())
                          ? Text(
                              '( Terlambat )',
                              style: redRdTextStyle.copyWith(
                                  fontSize: 10, fontWeight: bold),
                            )
                          : const SizedBox()
                    ],
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    stringToDateTime(dueDate, 'EEEE, dd MMMM  yyyy', false),
                    style: DateTime.parse(dueDate).isBefore(DateTime.now())
                        ? redRdTextStyle.copyWith(
                            fontSize: 12, fontWeight: medium)
                        : mainRdTextStyle.copyWith(
                            fontSize: 12, fontWeight: medium),
                  )
                ],
              ),
              const Spacer(),
              Text(
                formatCurrency(price),
                style:
                    greenRdTextStyle.copyWith(fontSize: 14, fontWeight: bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
