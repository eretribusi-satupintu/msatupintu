import 'package:flutter/material.dart';
import 'package:satupintu_app/blocs/auth/auth_bloc.dart';
import 'package:satupintu_app/model/login_form_model.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';
import 'package:satupintu_app/ui/widget/inputs.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController(text: '');
  final passswordController = TextEditingController(text: '');

  bool validate() {
    if (emailController.text.isEmpty || passswordController.text.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailed) {
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

            if (state is AuthSuccess) {
              if (state.user.role == 2) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/subwilayah-select', (route) => false);
              } else {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              }
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.staggeredDotsWave(
                      color: mainColor, size: 60),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Memasuki SatuPintu',
                    style: darkRdBrownTextStyle,
                  )
                ],
              )
                  // CircularProgressIndicator(),
                  );
            }

            return Stack(
              children: [
                SvgPicture.asset(
                  'assets/img_geometri.svg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 90,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img_pay_auth.png',
                            width: 150,
                            height: 170,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selamat Datang',
                                style: whiteRdTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                'Lakukan pendaftaran melalui\nkedinasan terkait untuk wajib\nretribusi terdaftar',
                                style: whiteRdTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: regular,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Log in',
                                      style: blackRdTextStyle.copyWith(
                                          fontSize: 32, fontWeight: black),
                                    ),
                                    Text(
                                      'Silahkan input email dan password anda',
                                      style: greyRdTextStyle.copyWith(
                                          fontSize: 10),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              CustomInput(
                                hintText: "masukkan email disini",
                                controller: emailController,
                              ),
                              CustomInput(
                                hintText: "masukkan password disini",
                                obscure: true,
                                controller: passswordController,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     TextButton(
                              //       onPressed: () {},
                              //       child: Text(
                              //         'Lupa password',
                              //         style: mainRdTextStyle.copyWith(
                              //           fontSize: 12,
                              //           fontWeight: light,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomFilledButton(
                                title: 'Masuk',
                                onPressed: () {
                                  if (validate()) {
                                    context.read<AuthBloc>().add(
                                          AuthLogin(
                                            LoginFormModel(
                                              email: emailController.text,
                                              password:
                                                  passswordController.text,
                                            ),
                                          ),
                                        );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: CustomSnackbar(
                                          message:
                                              'Anda harus memasukkan email dan password',
                                          status: 'failed',
                                        ),
                                        behavior: SnackBarBehavior.fixed,
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                      ),
                                    );
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/img_logo.png',
                                    width: 50,
                                  ),
                                  Text(
                                    'by Institut Teknologi Del',
                                    style:
                                        greyRdTextStyle.copyWith(fontSize: 8),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
