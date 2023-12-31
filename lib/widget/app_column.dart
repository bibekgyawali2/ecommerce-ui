import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food/widget/small_text.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final String price;
  const AppColumn({Key? key, required this.text, required this.price})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        // Row(
        //   children: [
        //     Wrap(
        //       children: List.generate(5, (index) {
        //         return Icon(
        //           Icons.star,
        //           color: AppColors.mainColor,
        //           size: 15,
        //         );
        //       }),
        //     ),
        //     SizedBox(
        //       width: 10,
        //     ),
        //     SmallText(text: "4.5"),
        //     SizedBox(
        //       width: 10,
        //     ),
        //     SmallText(text: "1285"),
        //     SizedBox(
        //       width: 10,
        //     ),
        //     SmallText(text: "comments")
        //   ],
        // ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1),
            // IconAndTextWidget(
            //     icon: Icons.location_on,
            //     text: "1.7km",
            //     iconColor: AppColors.mainColor),
            IconAndTextWidget(
                icon: Icons.monetization_on,
                text: price,
                iconColor: AppColors.iconColor2),
          ],
        )
      ],
    );
  }
}
