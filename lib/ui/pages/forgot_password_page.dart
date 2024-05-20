import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satupintu_app/blocs/firebase_auth/firebase_auth_bloc.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/pages/phone_otp_verification_page.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';
import 'package:satupintu_app/ui/widget/laoding_info.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final phoneNumberController = TextEditingController(text: '');
  FirebaseAuthBloc firebaseAuthBloc = FirebaseAuthBloc(FirebaseAuthInitial());

  bool validate() {
    if (phoneNumberController.value.text.length < 8) {
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
        body: Column(
          children: [
            Image.asset(
              'assets/ic_forgot_password.png',
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
                      "Lupa Password",
                      style: darkRdBrownTextStyle.copyWith(
                          fontWeight: black, fontSize: 28),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                        "Mohon masukkan nomor handphone anda untuk mendapatkan OTP",
                        style: greyRdTextStyle),
                    const SizedBox(
                      height: 18,
                    ),
                    phoneNumberInput(
                        "Masukkan no handphone anda", phoneNumberController)
                  ],
                ),
              ),
            ),
            BlocConsumer<FirebaseAuthBloc, FirebaseAuthState>(
              bloc: firebaseAuthBloc,
              listener: (context, state) {
                if (state is PhoneAuthFailed) {
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

                if (state is PhoneAuthCodeSentSuccess) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhoneOtpVerificationPage(
                          verificationId: state.verificationId,
                          phoneNumber: phoneNumberController.value.text,
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
                        title: "Kirim kode verifikasi",
                        onPressed: () async {
                          if (validate() == true) {
                            firebaseAuthBloc.add(SendOtpPhoneEvent(
                                '+62${phoneNumberController.value.text}'));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: CustomSnackbar(
                                  message: 'No handpone tidak sesuai',
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

  Widget phoneNumberInput(
    String hintText,
    TextEditingController? controller,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          decoration: BoxDecoration(
              border: Border.all(width: 4, color: blueColor.withAlpha(20)),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Image.asset('assets/ic_indonesia_flag.png'),
              const SizedBox(
                width: 4,
              ),
              const Text("+62"),
            ],
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: blueColor.withAlpha(20),
              suffixStyle: TextStyle(color: mainColor),
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 12,
                color: blueColor.withAlpha(90),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]')), // Only allow numeric input
            ],
            keyboardType: TextInputType.number,
            style: blueRdTextStyle.copyWith(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
