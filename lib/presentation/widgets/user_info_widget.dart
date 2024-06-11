import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:btp/constants/color_constant.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //Avatar
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ColorConstant.primary),
                    borderRadius: BorderRadius.circular(60 / 2)),
                child: Image.asset('assets/images/User1.png'),
              ),
              const Gap(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alex Somay',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: const Color(0xFF0D1220)),
                  ),
                  const Gap(6),
                  Text(
                    'Penyewa',
                    style: GoogleFonts.inter(
                        fontSize: 14, color: const Color.fromARGB(255, 48, 52, 59)),
                  ),
                ],
              )
            ],
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/svgs/notification.svg')),
          )
        ],
      ),
    );
  }
}
