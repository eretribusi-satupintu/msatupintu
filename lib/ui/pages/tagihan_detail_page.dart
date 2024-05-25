import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/auth/auth_bloc.dart';
import 'package:satupintu_app/blocs/doku_payment/doku_payment_bloc.dart';
import 'package:satupintu_app/blocs/doku_qris/doku_qris_bloc.dart';
import 'package:satupintu_app/blocs/tagihan/tagihan_bloc.dart';
import 'package:satupintu_app/model/doku_qris_model.dart';
import 'package:satupintu_app/model/payment_qris_model.dart';
import 'package:satupintu_app/model/payment_va_model.dart';
import 'package:satupintu_app/model/tagihan_model.dart';
import 'package:satupintu_app/shared/method.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/doku_payment_qris_page.dart';
import 'package:satupintu_app/ui/pages/doku_payment_va_page.dart';
import 'package:satupintu_app/ui/pages/qr_code_page.dart';
import 'package:satupintu_app/ui/pages/template_page.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';
import 'package:satupintu_app/ui/widget/draggable_scrollable_modal.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:satupintu_app/ui/widget/failed_info.dart';
import 'package:satupintu_app/ui/widget/laoding_info.dart';

class TagihanDetailPage extends StatefulWidget {
  final int tagihanId;
  final String status;
  const TagihanDetailPage({
    super.key,
    required this.tagihanId,
    required this.status,
  });

  @override
  State<TagihanDetailPage> createState() => _TagihanDetailPageState();
}

class _TagihanDetailPageState extends State<TagihanDetailPage> {
  String selectedBank = "";
  bool isBankSelected = false;
  String erm = "";
  List<String> bankList = ['bri', 'bca', 'mandiri'];
  // late String isPaid;

  @override
  void initState() {
    super.initState();
    // isPaid = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          'Detail Tagihan',
          style: whiteRdTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
              size: 18,
            )),
      ),
      body: SingleChildScrollView(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  TagihanBloc()..add(TagihanGetDetail(widget.tagihanId)),
            ),
            BlocProvider(
              create: (context) => AuthBloc()..add(AuthGetCurrentUser()),
            ),
          ],
          child: BlocBuilder<TagihanBloc, TagihanState>(
            builder: (context, state) {
              if (state is TagihanLoading) {
                return const LoadingInfo();
              }

              if (state is TagihanDetailSuccess) {
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 50, left: 18, right: 18),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: whiteColor,
                            // border: Border.all(
                            //     width: 6,
                            //     color: isPaid == 'VERIFIED'
                            //         ? greenColor.withAlpha(60)
                            //         : lightBlueColor),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 27,
                              ),
                              Text(
                                state.data.kedinasanName!,
                                style:
                                    darkRdBrownTextStyle.copyWith(fontSize: 14),
                              ),
                              Text(
                                'Retribusi ${state.data.retribusiName!}',
                                style:
                                    darkRdBrownTextStyle.copyWith(fontSize: 14),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                formatCurrency(
                                    int.parse(state.data.price.toString())),
                                style: darkRdBrownTextStyle.copyWith(
                                    fontSize: 22, fontWeight: bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                state.data.invoiceNumber!,
                                style: greyRdTextStyle.copyWith(
                                  fontSize: 10,
                                  fontWeight: regular,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              DottedLine(
                                dashLength: 8,
                                lineThickness: 4.0,
                                dashColor: orangeColor,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              tagihanInfo('Tagihan', state.data.tagihanName!),
                              tagihanInfo('Item Retribusi',
                                  state.data.itemRetribusiName!),
                              tagihanInfo(
                                'Batas pembayaran',
                                DateFormat('dd MMMM yyyy')
                                    .format(DateTime.parse(state.data.dueDate!))
                                    .toString(),
                              ),
                              DateTime.parse(state.data.dueDate!)
                                          .isBefore(DateTime.now()) &&
                                      DateTime.parse(state.data.dueDate!)
                                              .difference(DateTime.now())
                                              .inDays !=
                                          0
                                  ? Text(
                                      '( Anda telah melebihi batas akhir pembayaran )',
                                      style: redRdTextStyle.copyWith(
                                          fontSize: 10, fontWeight: bold),
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 10,
                              ),
                              DottedLine(
                                dashLength: 8,
                                lineThickness: 2.0,
                                dashColor: lightGreyColor,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              state == 'VERIFIED'
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Pembayaran Berhasil!',
                                          style: mainRdTextStyle.copyWith(
                                              fontWeight: bold, fontSize: 18),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Pembayaran tagihan dilakukan pada',
                                          style: greyRdTextStyle.copyWith(
                                              fontSize: 12),
                                        ),
                                        Text(
                                          iso8601toDateTime(
                                              state.data.paymentTime!),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Text(
                                          'Tagihan dilakukan pada tanggal',
                                          style: greyRdTextStyle.copyWith(
                                              fontSize: 12),
                                        ),
                                        Text(
                                          DateFormat('dd MMMM yyyy')
                                              .format(DateTime.now())
                                              .toString(),
                                          style: greyRdTextStyle.copyWith(
                                              fontSize: 12, fontWeight: bold),
                                        ),
                                      ],
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        widget.status == 'VERIFIED'
                            ? Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: greenColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 6,
                                      color: whiteColor.withAlpha(80)),
                                ),
                                child: Icon(
                                  Icons.check_circle_outline_rounded,
                                  size: 40,
                                  color: whiteColor,
                                ),
                              )
                            : widget.status == 'REQUEST'
                                ? Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: orangeColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 6, color: whiteColor),
                                    ),
                                    child: Icon(
                                      Icons.lock_clock,
                                      color: whiteColor,
                                      size: 32,
                                    ))
                                : Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: mainColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 6, color: whiteColor),
                                    ),
                                    child: Image.asset(
                                      'assets/ic_bill.png',
                                      width: 28,
                                      height: 27,
                                      color: whiteColor,
                                    ),
                                  )
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 18),
                        padding: const EdgeInsets.symmetric(
                            vertical: 23, horizontal: 19),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: widget.status == 'VERIFIED'
                            ? Center(
                                child: Text(
                                  'Pembayaran telah berhasil dilakukan',
                                  style: mainRdTextStyle.copyWith(
                                      fontWeight: semiBold),
                                ),
                              )
                            : Column(
                                children: [
                                  Text(
                                    'Pastikan nominal tagihan sudah sesuai dengan kesepakatan dan ketentuan',
                                    style: darkRdBrownTextStyle.copyWith(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  const SizedBox(
                                    height: 21,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Total',
                                        style: blackInTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        formatCurrency(
                                          state.data.price!,
                                        ),
                                        style: blackInTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomFilledButton(
                                    title: 'Bayar Non Tunai',
                                    onPressed: () {
                                      CustomModalBottomSheet.show(
                                        context,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              'Pilih Metode Pembayaran',
                                              style:
                                                  darkRdBrownTextStyle.copyWith(
                                                      fontSize: 16,
                                                      fontWeight: bold),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              'Silahkan  pilih metode pembayaran yang akan anda gunakan untuk membayar tagihan',
                                              style: greyRdTextStyle.copyWith(
                                                  fontSize: 10),
                                              textAlign: TextAlign.justify,
                                            ),
                                            const SizedBox(
                                              height: 14,
                                            ),
                                            BlocConsumer<DokuPaymentBloc,
                                                DokuPaymentState>(
                                              listener: (context, dokuState) {
                                                if (dokuState
                                                    is DokuPaymentSuccess) {
                                                  print("test");
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DokuPaymentVaPage(
                                                              virtualAccount:
                                                                  dokuState
                                                                      .data),
                                                    ),
                                                  );
                                                }
                                              },
                                              builder: (context, dokuState) {
                                                if (dokuState
                                                    is DokuPaymentLoading) {
                                                  return Center(
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      decoration: BoxDecoration(
                                                          color: whiteColor,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8))),
                                                      child: Column(
                                                        children: [
                                                          LoadingAnimationWidget
                                                              .inkDrop(
                                                                  color:
                                                                      mainColor,
                                                                  size: 24),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                            'Sedang Diproses',
                                                            style: darkRdBrownTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        bold),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
                                                return ExpansionTile(
                                                  title: Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/img_payment.png',
                                                        width: 20,
                                                      ),
                                                      const SizedBox(
                                                        width: 6,
                                                      ),
                                                      Text(
                                                        'Virtual Account',
                                                        style:
                                                            darkInBrownTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        bold),
                                                      )
                                                    ],
                                                  ),
                                                  collapsedShape: Border.all(
                                                      width: 2,
                                                      color: mainColor
                                                          .withAlpha(25)),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Pilih pembayaran dengan va number melalui bank',
                                                        style: greyRdTextStyle
                                                            .copyWith(
                                                                fontSize: 10),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      dokuState
                                                              is DokuPaymentFailed
                                                          ? Text(
                                                              dokuState.e,
                                                              style: redRdTextStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          bold),
                                                            )
                                                          : const SizedBox()
                                                    ],
                                                  ),
                                                  children: [
                                                    StatefulBuilder(builder:
                                                        (BuildContext context,
                                                            StateSetter
                                                                setState) {
                                                      return Container(
                                                        width: double.infinity,
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 16),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text('Pilih Bank',
                                                                style: darkRdBrownTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            bold),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Column(
                                                              children: bankList
                                                                  .map(
                                                                    (String bank) => bankItem(
                                                                        'assets/img_$bank.png',
                                                                        bank,
                                                                        'VIA ${bank.toUpperCase()}',
                                                                        selectedBank,
                                                                        (String?
                                                                            data) {
                                                                      Future.delayed(
                                                                          const Duration(
                                                                              milliseconds: 100),
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          selectedBank =
                                                                              data!;
                                                                          print(
                                                                              selectedBank);
                                                                        });
                                                                      });
                                                                    }),
                                                                  )
                                                                  .toList(),
                                                            ),
                                                            Visibility(
                                                                visible:
                                                                    selectedBank
                                                                        .isNotEmpty,
                                                                child: Column(
                                                                  children: [
                                                                    const SizedBox(
                                                                      height:
                                                                          25,
                                                                    ),
                                                                    CustomFilledButton(
                                                                      title:
                                                                          'Lanjutkan',
                                                                      onPressed:
                                                                          () async {
                                                                        // Navigator.pop(
                                                                        //     context);
                                                                        // try {
                                                                        context
                                                                            .read<DokuPaymentBloc>()
                                                                            .add(
                                                                              DokuVaGet(
                                                                                state.data.id!,
                                                                                PaymentVaModel(
                                                                                  requestId: state.data.requestId,
                                                                                  bank: selectedBank,
                                                                                  invoiceNumber: state.data.invoiceNumber,
                                                                                  amount: double.parse(state.data.price.toString()),
                                                                                  expiredTime: 60,
                                                                                  reusableStatus: false,
                                                                                  info1: '',
                                                                                  name: state.data.tagihanName,
                                                                                  email: state.data.email,
                                                                                ),
                                                                              ),
                                                                            );
                                                                        // } catch (e) {

                                                                        // }

                                                                        // print(selectedBank);
                                                                      },
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    )
                                                                  ],
                                                                ))
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                  ],
                                                );
                                              },
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            BlocProvider(
                                              create: (context) =>
                                                  DokuQrisBloc(),
                                              child: BlocConsumer<DokuQrisBloc,
                                                  DokuQrisState>(
                                                listener: (context, qrisState) {
                                                  if (qrisState
                                                      is DokuQrisFailed) {
                                                    print(qrisState.e);
                                                  }

                                                  if (qrisState
                                                      is DokuQrisSuccess) {
                                                    print({
                                                      "success": qrisState.data
                                                    });

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DokuQrisPage(
                                                                    url: qrisState
                                                                        .data
                                                                        .url!)));
                                                  }
                                                },
                                                builder: (context, qrisState) {
                                                  if (qrisState
                                                      is DokuQrisLoading) {
                                                    return Center(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10),
                                                        decoration: BoxDecoration(
                                                            color: whiteColor,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                        child: Column(
                                                          children: [
                                                            LoadingAnimationWidget
                                                                .inkDrop(
                                                                    color:
                                                                        mainColor,
                                                                    size: 24),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(
                                                              'Sedang Diproses',
                                                              style: darkRdBrownTextStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          bold),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }

                                                  return ExpansionTile(
                                                    title: Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/img_qris.png',
                                                          width: 20,
                                                        ),
                                                        const SizedBox(
                                                          width: 6,
                                                        ),
                                                        Text(
                                                          'QRIS',
                                                          style:
                                                              darkInBrownTextStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          bold),
                                                        )
                                                      ],
                                                    ),
                                                    collapsedShape: Border.all(
                                                        width: 2,
                                                        color: mainColor
                                                            .withAlpha(25)),
                                                    subtitle: Text(
                                                      'Pilih pembayaran dengan dcan kode QR',
                                                      style: greyRdTextStyle
                                                          .copyWith(
                                                              fontSize: 10),
                                                    ),
                                                    children: [
                                                      ListTile(
                                                        title:
                                                            CustomFilledButton(
                                                          title:
                                                              'Lanjutkan pembayaran melalui QRIS',
                                                          onPressed: () {
                                                            // Navigator.pushNamed(
                                                            //     context,
                                                            //     '/qris-checkout');

                                                            context
                                                                .read<
                                                                    DokuQrisBloc>()
                                                                .add(
                                                                  DokuQrisGet(
                                                                    state.data
                                                                        .id!,
                                                                    PaymentQrisModel(
                                                                      requestId: state
                                                                          .data
                                                                          .requestId!,
                                                                      amount: state
                                                                          .data
                                                                          .price,
                                                                      invoiceNumber: state
                                                                          .data
                                                                          .invoiceNumber,
                                                                      paymentDueDate:
                                                                          60,
                                                                      paymentMethodTypes:
                                                                          "QRIS",
                                                                    ),
                                                                  ),
                                                                );
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                        // },
                                        // ),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 11,
                                  ),
                                  CustomOutlinedButton(
                                    title: 'Bayar Tunai',
                                    color: mainColor,
                                    onPressed: () {
                                      CustomModalBottomSheet.show(
                                        context,
                                        SizedBox(
                                          width: double.infinity,
                                          child:
                                              BlocBuilder<AuthBloc, AuthState>(
                                            builder: (context, state) {
                                              if (state is AuthLoading) {
                                                return Center(
                                                  child: LoadingAnimationWidget
                                                      .inkDrop(
                                                          color: mainColor,
                                                          size: 30),
                                                );
                                              }
                                              if (state is AuthSuccess) {
                                                if (state.user.nik != null) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Text(
                                                        'Kode SatuPintu ',
                                                        style:
                                                            darkRdBrownTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 6,
                                                      ),
                                                      Text(
                                                        'Perlihatkan kode anda dibawah ini kepada petugas untuk menyelesaikan pembayaran detail-${widget.tagihanId}-${state.user.nik!}',
                                                        style: greyRdTextStyle
                                                            .copyWith(
                                                                fontSize: 10),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 20,
                                                                vertical: 50),
                                                        decoration:
                                                            const BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/img_qris_background.png'),
                                                              fit: BoxFit.fill),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: QrImageView(
                                                            gapless: false,
                                                            backgroundColor:
                                                                whiteColor,
                                                            data:
                                                                'detail-${widget.tagihanId}-${state.user.nik!}',
                                                            version:
                                                                QrVersions.auto,
                                                            size: 300.0,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            embeddedImage:
                                                                const AssetImage(
                                                                    'assets/img_logo_with_background.png'),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 18,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .shield_outlined,
                                                            color: mainColor,
                                                          ),
                                                          Text(
                                                            'Penting!',
                                                            style: darkRdBrownTextStyle
                                                                .copyWith(
                                                                    fontWeight:
                                                                        bold),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 6,
                                                      ),
                                                      Text(
                                                        'Mohon mencek status pembayaran tagihan anda secara berkala untuk memastikan tagihan telah dibayarkan kepada petugas, sebelum petugas pergi',
                                                        style: greyRdTextStyle
                                                            .copyWith(
                                                                fontSize: 10,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ],
                                                  );
                                                }

                                                return Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const SizedBox(
                                                        height: 50,
                                                      ),
                                                      Text(
                                                        'NIK anda belum terdaftar',
                                                        style:
                                                            darkRdBrownTextStyle
                                                                .copyWith(
                                                                    fontWeight:
                                                                        bold),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      Text(
                                                        'Sistem tidak dapat mendeteksi NIK anda pastikan NIK anda sudah terdaftar',
                                                        style: greyRdTextStyle
                                                            .copyWith(
                                                                fontSize: 12),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ]);
                                              }

                                              if (state is AuthFailed) {
                                                return Center(
                                                  child: Text(state.e),
                                                );
                                              }

                                              return const Center(
                                                child: Text(
                                                    'Tidak dapat memuat qr code anda'),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }

              if (state is TagihanFailed) {
                return ErrorInfo(
                  e: state.e,
                );
              }

              return const ErrorInfo(
                e: 'Terjadi Kesalahan',
              );
            },
          ),
        ),
      ),
    );
  }

  Widget tagihanInfo(String key, String value) {
    return Container(
      margin: const EdgeInsets.only(right: 12, left: 12, bottom: 15),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key.toString(),
            style: greyRdTextStyle.copyWith(fontSize: 10),
          ),
          Text(
            value.toString(),
            style: greyRdTextStyle.copyWith(
              fontSize: 12,
              fontWeight: bold,
            ),
          )
        ],
      ),
    );
  }

  Widget bankItem(String image, String bank, String title, String group,
      void Function(String?) onChanged) {
    return Row(
      children: [
        Image.asset(
          image.toString(),
          width: 36,
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          title.toString(),
          style: darkInBrownTextStyle.copyWith(fontWeight: semiBold),
        ),
        const Spacer(),
        Radio<String>(
          value: bank,
          groupValue: group,
          onChanged: onChanged,
        )
      ],
    );
  }
}
