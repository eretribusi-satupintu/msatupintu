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
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(30)),
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
                        text: 'Berhasil',
                      ),
                      Tab(
                        text: 'Menunggu',
                      ),
                    ],
                  ),
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
    );
  }
}
