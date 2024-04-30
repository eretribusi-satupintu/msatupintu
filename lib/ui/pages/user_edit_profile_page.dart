import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:satupintu_app/blocs/user/user_bloc.dart';
import 'package:satupintu_app/model/user_model.dart';
import 'package:satupintu_app/model/user_update_form_model.dart';
import 'package:satupintu_app/shared/theme.dart';
import 'package:satupintu_app/ui/widget/buttons.dart';
import 'package:satupintu_app/ui/widget/custom_snackbar.dart';
import 'package:satupintu_app/ui/widget/inputs.dart';

class UserEditProfilePage extends StatefulWidget {
  // final UserModel user;
  const UserEditProfilePage({
    super.key,
  });

  @override
  State<UserEditProfilePage> createState() => _UserEditProfilePageState();
}

class _UserEditProfilePageState extends State<UserEditProfilePage> {
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final noteleponController = TextEditingController();
  XFile? image;

  bool validate() {
    if (emailController.text == '' ||
        addressController.text == '' ||
        noteleponController.text == '') {
      return false;
    }

    return true;
  }

  Future getImage(String media) async {
    final ImagePicker picker = ImagePicker();

    switch (media) {
      case 'galery':
        final XFile? imagePicker =
            await picker.pickImage(source: ImageSource.gallery);
        setImage(imagePicker!);

        break;
      case 'camera':
        final XFile? imagePicker = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
          maxWidth: 300,
          maxHeight: 500,
        );
        setImage(imagePicker!);
      default:
        return;
    }
  }

  void setImage(XFile file) {
    setState(() {
      Navigator.pop(context, 'refresh');
      image = file;
    });
  }

  @override
  void initState() {
    super.initState();
    // emailController.text = widget.user.email!;
    // addressController.text = widget.user.address!;
    // noteleponController.text = widget.user.phoneNumber!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Ubah Profile',
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
        create: (context) => UserBloc()..add(UserGet()),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserSuccess) {
              setState(() {
                emailController.text = state.data.email!;
                addressController.text = state.data.address!;
                noteleponController.text = state.data.phoneNumber!;
              });
            }

            if (state is UserUpdateSuccess) {
              Navigator.of(context).pop();
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
                if (state is UserSuccess) {
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
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      mediaChooseDialog(context);
                                    },
                                    child: Container(
                                        width: 90,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: DecorationImage(
                                              image: image == null
                                                  ? NetworkImage(
                                                      'http://localhost:3000/${state.data.photoProfile}')
                                                  : FileImage(File(image!.path))
                                                      as ImageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: whiteColor,
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Icon(
                                              Icons.edit,
                                              size: 16,
                                              color: mainColor,
                                            ),
                                          ),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    state.data.name!,
                                    style: darkRdBrownTextStyle.copyWith(
                                        fontSize: 16, fontWeight: semiBold),
                                    textAlign: TextAlign.justify,
                                  ),
                                  Text(
                                    state.data.nik!,
                                    style: greyRdTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(),
                            userInputForm(
                                'Email', 'Masukkan email', emailController),
                            const SizedBox(
                              height: 6,
                            ),
                            userInputForm(
                                'Alamat', 'Masukkan Alamat', addressController),
                            const SizedBox(
                              height: 6,
                            ),
                            userInputForm('No Telepon', 'Masukkan No Telepon',
                                noteleponController)
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 18),
                        child: CustomFilledButton(
                          title: 'Perbarui',
                          onPressed: () {
                            if (validate() == true) {
                              // print(base64Encode(
                              //   File(image!.path).readAsBytesSync(),
                              // ));
                              context.read<UserBloc>().add(
                                    UserUpdate(
                                        UserUpdateFormModel(
                                          emailController.value.text,
                                          noteleponController.value.text,
                                          addressController.value.text,
                                          image != null
                                              ? base64Encode(
                                                  File(image!.path)
                                                      .readAsBytesSync(),
                                                )
                                              : '',
                                        ),
                                        state.data.id!),
                                  );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: CustomSnackbar(
                                    message:
                                        'Pastikan semua inputan telah terisi',
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
                }

                if (state is UserFailed) {
                  return Center(
                    child: Text(state.e),
                  );
                }

                return const Center(
                  child: Text("Terjadi kesalahan"),
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

  Future<void> mediaChooseDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            'Pilih Media',
            style: mainRdTextStyle.copyWith(fontSize: 14, fontWeight: bold),
            textAlign: TextAlign.center,
          ),
          content: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  await getImage('camera');
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: mainColor.withAlpha(80),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/ic_camera.png',
                        width: 45,
                        height: 45,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Kamera',
                        style: darkRdBrownTextStyle.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  await getImage('galery');
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: mainColor.withAlpha(80),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/ic_galery.png',
                        width: 45,
                        height: 45,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Galery',
                        style: darkRdBrownTextStyle.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
