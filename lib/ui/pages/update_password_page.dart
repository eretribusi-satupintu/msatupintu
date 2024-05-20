import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/user/user_bloc.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';
import 'package:satupintu_app/ui/widget/failed_info.dart';
import 'package:satupintu_app/ui/widget/inputs.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({
    super.key,
  });

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final oldPasswordController = TextEditingController(text: '');
  final newPasswordController = TextEditingController(text: '');
  final confirmationPasswordController = TextEditingController(text: '');

  XFile? image;

  bool validate() {
    if (newPasswordController.text == '' ||
        newPasswordController.text.length < 8 ||
        confirmationPasswordController.text == '') {
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          'Ganti Password',
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
      body: BlocProvider(
        create: (context) => UserBloc(),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: CustomSnackbar(message: state.e, status: "failed"),
                  behavior: SnackBarBehavior.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              );
            }

            if (state is UserUpdatePasswordSuccess) {
              setState(() {
                oldPasswordController.text = '';
                newPasswordController.text = '';
                confirmationPasswordController.text = '';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: CustomSnackbar(
                      message: "Password anda telah diperbarui",
                      status: "success"),
                  behavior: SnackBarBehavior.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              );
            }
          },
          builder: (context, state) {
            return BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return Center(
                    child: Column(
                      children: [
                        LoadingAnimationWidget.staggeredDotsWave(
                            color: mainColor, size: 30),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text('Memuat...')
                      ],
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          userInputForm('Password lama',
                              'Masukkan password lama', oldPasswordController),
                          const SizedBox(
                            height: 6,
                          ),
                          userInputForm('Password baru',
                              'Masukkan password baru', newPasswordController),
                          const SizedBox(
                            height: 6,
                          ),
                          userInputForm(
                              'Konfirmasi password',
                              'Konfirmasi password',
                              confirmationPasswordController),
                          const SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      child: CustomFilledButton(
                        title: 'Perbarui password',
                        onPressed: () {
                          if (validate() == true) {
                            print(
                                "${newPasswordController.value.text} ${confirmationPasswordController.value.text}");
                            context.read<UserBloc>().add(UserPasswordUpdate(
                                oldPasswordController.value.text,
                                newPasswordController.value.text,
                                confirmationPasswordController.value.text));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: CustomSnackbar(
                                  message:
                                      'Password harus terdiri dari min 8 karakter',
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
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    ));
  }

  Widget userInputForm(
      String label, String hint, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style:
                darkInBrownTextStyle.copyWith(fontWeight: bold, fontSize: 12),
          ),
          const SizedBox(
            height: 4,
          ),
          CustomInput(
            hintText: hint,
            controller: controller,
          )
        ],
      ),
    );
  }
}
