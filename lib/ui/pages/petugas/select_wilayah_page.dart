import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/subwilayah/subwilayah_bloc.dart';
import 'package:satupintu_app/model/subwilayah_model.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';

class SelectSubWilayahPage extends StatefulWidget {
  const SelectSubWilayahPage({super.key});

  @override
  State<SelectSubWilayahPage> createState() => _SelectSubWilayahPageState();
}

class _SelectSubWilayahPageState extends State<SelectSubWilayahPage> {
  SubWilayahModel? selectedSubWilayah;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sub Wilayah',
          style: darkRdBrownTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ),
      ),
      body: BlocProvider(
        create: (context) => SubwilayahBloc()..add(GetPetugasSubWilayah()),
        child: BlocBuilder<SubwilayahBloc, SubwilayahState>(
          builder: (context, state) {
            if (state is SubwilayahLoading) {
              return Center(
                child:
                    LoadingAnimationWidget.inkDrop(color: mainColor, size: 24),
              );
            }

            if (state is SubwilayahSuccess) {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          children: state.data
                              .map(
                                (subwilayah) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedSubWilayah = subwilayah;
                                    });
                                  },
                                  child: subWilayahCard(subwilayah.name!,
                                      subwilayah.id == selectedSubWilayah?.id),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  selectedSubWilayah == null
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.symmetric(horizontal: 18),
                          child: CustomFilledButton(
                              title: 'Lanjutkan ${selectedSubWilayah?.name}',
                              onPressed: () {
                                BlocProvider.of<SubwilayahBloc>(context).add(
                                    SelectPetugasSubWilayah(
                                        selectedSubWilayah!));

                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/home', (route) => false);
                              }),
                        ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              );
            }

            if (state is SubwilayahFailed) {
              return Center(
                child: Text(state.e),
              );
            }

            return const Center(
              child: Text('memuat...'),
            );
          },
        ),
      ),
    );
  }

  Widget subWilayahCard(String name, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        border:
            isSelected == true ? Border.all(width: 2, color: mainColor) : null,
        boxShadow: [
          BoxShadow(color: lightBlueColor, blurRadius: 1),
        ],
      ),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/ic_sub_region.png',
            width: 45,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: darkRdBrownTextStyle.copyWith(fontWeight: semiBold),
          )
        ],
      )),
    );
  }
}
