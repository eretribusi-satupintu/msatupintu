import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:satupintu_app/blocs/firebase_auth/firebase_auth_bloc.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/update_forgot_password_page.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';
import 'package:satupintu_app/ui/widget/laoding_info.dart';

class PhoneOtpVerificationPage extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const PhoneOtpVerificationPage(
      {super.key, required this.verificationId, required this.phoneNumber});

  @override
  State<PhoneOtpVerificationPage> createState() =>
      _PhoneOtpVerificationPageState();
}

class _PhoneOtpVerificationPageState extends State<PhoneOtpVerificationPage> {
  final otpCodeController = TextEditingController(text: '');
  bool isError = false;
  FirebaseAuthBloc firebaseAuthBloc = FirebaseAuthBloc(FirebaseAuthInitial());

  bool validate() {
    if (otpCodeController.value.text.length < 6) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          leadingWidth: 0,
          //  IconButton(
          //   onPressed: () {
          //     Navigator.of(context).pop('refresh');
          //   },
          //   icon: Icon(
          //     Icons.chevron_left_rounded,
          //     size: 30,
          //     color: mainColor,
          //   ),
          // ),
        ),
        body: Column(
          children: [
            Image.asset(
              'assets/ic_phone_otp.png',
              width: 80,
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Verifiaksi OTP",
                      style: darkRdBrownTextStyle.copyWith(
                          fontWeight: black, fontSize: 28),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                        "Masukkan kode verifikasi OTP yang telah kami kirim ke no handphone anda",
                        style: greyRdTextStyle),
                    const SizedBox(
                      height: 18,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Kode telah dikirim ke',
                                style: greyRdTextStyle,
                              ),
                              Text(
                                ' +62${widget.phoneNumber}',
                                style: darkRdBrownTextStyle.copyWith(
                                    fontWeight: bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Pinput(
                            controller: otpCodeController,
                            length: 6,
                            defaultPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: mainRdTextStyle.copyWith(
                                  fontWeight: black, fontSize: 24),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromRGBO(234, 239, 243, 1)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Belum menerima kode?",
                            style: greyRdTextStyle,
                          ),
                          BlocConsumer<FirebaseAuthBloc, FirebaseAuthState>(
                            bloc: firebaseAuthBloc,
                            listener: (context, state) {
                              // if (state is PhoneAuthFailed) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //       content: CustomSnackbar(
                              //         message: state.e.toString(),
                              //         status: 'failed',
                              //       ),
                              //       behavior: SnackBarBehavior.fixed,
                              //       backgroundColor: Colors.transparent,
                              //       elevation: 0,
                              //     ),
                              //   );
                              // }
                              if (state is PhoneAuthCodeSentSuccess) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PhoneOtpVerificationPage(
                                      verificationId: state.verificationId,
                                      phoneNumber: widget.phoneNumber,
                                    ),
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: () {
                                  firebaseAuthBloc.add(SendOtpPhoneEvent(
                                      '+62${widget.phoneNumber}'));
                                },
                                child: Text(
                                  'Kirim ulang',
                                  style: mainRdTextStyle.copyWith(
                                    fontWeight: bold,
                                    decoration: TextDecoration.underline,
                                    decorationColor: mainColor, // optional
                                    decorationThickness: 2,
                                    // optional
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocConsumer<FirebaseAuthBloc, FirebaseAuthState>(
              bloc: firebaseAuthBloc,
              listener: (context, state) {
                if (state is PhoneAuthFailed) {
                  print(state.e);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: CustomSnackbar(
                        message: state.e.toString(),
                        status: 'failed',
                      ),
                      behavior: SnackBarBehavior.fixed,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  );
                }

                if (state is PhoneAuthSuccess) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateForgotPasswordPage(
                          phoneNumber: state.phoneNumber,
                        ),
                      ),
                      (route) => false);
                }
              },
              builder: (context, state) {
                if (state is PhoneNumberVerifyLoading) {
                  return const LoadingInfo();
                } else {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    child: CustomFilledButton(
                        title: "Verifikasi",
                        onPressed: () {
                          if (validate() == true) {
                            firebaseAuthBloc.add(VerifySentOtp(
                                otpCodeController.value.text,
                                widget.verificationId,
                                widget.phoneNumber));
                          } else {
                            print('otp code :${otpCodeController.value.text}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: CustomSnackbar(
                                  message: "Masukkan kode OTP",
                                  status: 'failed',
                                ),
                                behavior: SnackBarBehavior.fixed,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                            );
                          }
                        }),
                  );
                }
              },
            ),
            const SizedBox(
              height: 14,
            ),
          ],
        ),
      ),
    );
  }
}
