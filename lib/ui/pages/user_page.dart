import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rizki Okto S',
                      style: darRdBrownTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'NIK : 1912100210001',
                      style: darRdBrownTextStyle.copyWith(
                          fontWeight: bold, fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          )),
                      child: Text(
                        'Wajib Retribusi',
                        style: whiteRdTextStyle.copyWith(
                            fontWeight: bold, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  child: Image.asset('assets/img_user.png'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          profileMenu('assets/ic_user.png', 'Ubah Profile',
              'Ubah Email dan No Handphone anda'),
          profileMenu('assets/ic_password.png', 'Ganti Password',
              'Ubah password anda untuk menjaga keamanan akun'),
          Container(
            padding: const EdgeInsets.only(bottom: 21),
            decoration: BoxDecoration(),
            child: Row(children: [
              Image.asset(
                'assets/ic_logout.png',
                color: redColor,
                width: 20,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Keluar',
                    style: redRdTextStyle.copyWith(fontWeight: semiBold),
                  ),
                ],
              )
            ]),
          )
        ],
      ),
    );
  }

  Widget profileMenu(String icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.only(bottom: 21),
      decoration: BoxDecoration(),
      child: Row(children: [
        Image.asset(
          icon,
          color: darkBrownColor,
          width: 20,
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: blackRdTextStyle.copyWith(fontWeight: semiBold),
            ),
            Text(
              description,
              style: greyRdTextStyle.copyWith(fontSize: 10),
            ),
          ],
        )
      ]),
    );
  }
}
