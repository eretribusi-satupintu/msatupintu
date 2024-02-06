import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';

class TagihanPage extends StatelessWidget {
  const TagihanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [tagihanCard(), tagihanCard(), tagihanCard()]);
  }

  Widget tagihanCard() {
    return Container(
      margin: const EdgeInsets.only(
        right: 18,
        left: 18,
        bottom: 17,
      ),
      padding: const EdgeInsets.only(
        right: 18,
        left: 18,
        top: 13,
        bottom: 18,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/img_invoice_list.png',
                    width: 18,
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  Text(
                    'Retribusi Pasar',
                    style: blackInTextStyle.copyWith(fontWeight: bold),
                  )
                ],
              ),
              const Spacer(),
              SizedBox(
                height: Checkbox.width,
                width: Checkbox.width,
                child: Checkbox(
                  value: false,
                  onChanged: (bool? value) {},
                  activeColor: mainColor,
                  side: BorderSide.none,
                  fillColor: MaterialStatePropertyAll(lightBlueColor),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'INV-123123123',
                    style: greyRdTextStyle.copyWith(fontSize: 10),
                  ),
                  Text(
                    'Harian',
                    style: mainRdTextStyle.copyWith(
                        fontSize: 10, fontWeight: bold),
                  )
                ],
              ),
              const Spacer(),
              Text(
                'Rp. 15.000',
                style:
                    greenRdTextStyle.copyWith(fontSize: 14, fontWeight: bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
