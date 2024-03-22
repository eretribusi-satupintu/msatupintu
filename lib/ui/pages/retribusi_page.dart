import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:satupintu_app/blocs/retribusi/retribusi_bloc.dart';
import 'package:satupintu_app/model/retribusi_model.dart';
import 'package:satupintu_app/services/item_retribusi_service.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/item_retribusi_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class RetribusiPage extends StatelessWidget {
  const RetribusiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: BlocProvider(
        create: (context) => RetribusiBloc()..add(RetribusiGet()),
        child: BlocBuilder<RetribusiBloc, RetribusiState>(
          builder: (context, state) {
            if (state is RetribusiSuccess) {
              if (state.data.isNotEmpty) {
                return Column(
                  children: state.data
                      .map((retribusi) => retribusiCard(context, retribusi))
                      .toList(),
                );
              }
            } else {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  'Anda belum memiliki tagihan',
                  style: blueRdTextStyle.copyWith(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.transparent,
                    highlightColor: whiteColor,
                    period: const Duration(seconds: 1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: lightGreyColor.withAlpha(90),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 15,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: lightGreyColor.withAlpha(90),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Container(
                                height: 15,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: lightGreyColor.withAlpha(90),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.transparent,
                    highlightColor: whiteColor,
                    period: const Duration(seconds: 1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: lightGreyColor.withAlpha(90),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 15,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: lightGreyColor.withAlpha(90),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Container(
                                height: 15,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: lightGreyColor.withAlpha(90),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.transparent,
                    highlightColor: whiteColor,
                    period: const Duration(seconds: 1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: lightGreyColor.withAlpha(90),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 15,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: lightGreyColor.withAlpha(90),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Container(
                                height: 15,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: lightGreyColor.withAlpha(90),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget retribusiCard(BuildContext context, RetribusiModel retribusi) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemRetribusiPage(
                        retribusiId: retribusi.id!,
                      )));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/ic_ticket.png',
                width: 45,
                height: 51,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      retribusi.name!,
                      style:
                          darkInBrownTextStyle.copyWith(fontWeight: semiBold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.assured_workload_outlined,
                          size: 12,
                          color: blueColor,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          retribusi.kedinasanName!,
                          style: greyRdTextStyle.copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: mainColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(children: [
                            Icon(
                              Icons.apps_outage_outlined,
                              size: 14,
                              color: mainColor,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              '${retribusi.itemRetribusiTotal} item telah disewa',
                              style: mainRdTextStyle.copyWith(
                                  fontWeight: bold, fontSize: 12),
                            )
                          ]),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
