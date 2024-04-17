import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/petugas/pembayaran_tabs/pembayaran_success_tab.dart';
import 'package:satupintu_app/ui/pages/petugas/pembayaran_tabs/pembayaran_waiting_tab.dart';

class PembayaranPetugasPage extends StatefulWidget {
  const PembayaranPetugasPage({super.key});

  @override
  State<PembayaranPetugasPage> createState() => _PembayaranPetugasPageState();
}

class _PembayaranPetugasPageState extends State<PembayaranPetugasPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(
                height: 18,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: whiteColor, borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    TabBar(
                      unselectedLabelColor: mainColor,
                      labelColor: whiteColor,
                      dividerHeight: 0,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(5)),
                      controller: tabController,
                      labelStyle: TextStyle(fontSize: 12, fontWeight: bold),
                      tabs: [
                        Tab(
                          text: 'Berhasil',
                        ),
                        Tab(
                          text: 'Menunggu',
                        ),
                        // Tab(
                        //   text: 'Batal',
                        // )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                controller: tabController,
                children: const [
                  PembayaranSuccessTab(),
                  PembayaranWaitingTab(),
                  // PembayaranCancelTab(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
