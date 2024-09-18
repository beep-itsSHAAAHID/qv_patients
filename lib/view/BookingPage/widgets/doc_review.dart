import 'package:flutter/material.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/responsive.dart';

class DocReview extends StatelessWidget {
  const DocReview({
    super.key,
    required this.icons,
    required this.titlenum,
    required this.title,
  });

  final IconData icons;
  final String titlenum;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: Responsive.width(context, 0.2),
          width: Responsive.width(context, 0.4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: TColors.black,
          ),
          margin: EdgeInsets.symmetric(horizontal: 0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icons,
                  color: TColors.light,
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(color: TColors.darkGrey),
                    ),
                    Text(
                      titlenum,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: TColors.darkGrey),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
