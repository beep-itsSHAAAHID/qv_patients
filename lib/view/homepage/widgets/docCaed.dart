import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/size.dart';
import 'package:qv_patient/helper/doc_helper_function.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/view/homepage/widgets/fav_icon_button.dart';
import 'package:qv_patient/view/homepage/widgets/t_rounded_image.dart';

class DocCard extends StatelessWidget {
  const DocCard({
    super.key,
    required this.onTap,
    required this.name,
    required this.location,
    required this.department,
    required this.rating,
    required this.ratingnumber,
    required this.peoplerated,
  });

  final VoidCallback onTap;
  final String name, location, department;
  final double rating;
  final double ratingnumber;
  final int peoplerated;

  @override
  Widget build(BuildContext context) {
    final dark = DocHelperFunctions.isDarkMode(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue,
                const Color.fromARGB(255, 212, 211, 211),
              ]),
          borderRadius: BorderRadius.circular(12),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              const TRoundedImage(
                width: 100,
                imageurl: 'assets/image/doctor.jpg',
              ),
              const SizedBox(
                width: Tsizes.defaultspace - 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: TColors.light.withOpacity(.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Icon(
                                    Iconsax.verify4,
                                    color: Colors.blue,
                                    size: 15,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Professional Doctor",
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ), // Reduced font size
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      name,
                      style: Theme.of(context).textTheme.headlineSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      department,
                      style: Theme.of(context).textTheme.labelMedium!.apply(),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < rating.floor()
                                  ? Icons.star
                                  : index < rating
                                      ? Icons.star_half
                                      : Icons.star_border,
                              color: Colors.amber,
                              size: Responsive.width(context, 0.04),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          ratingnumber.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "  |  ",
                          style: TextStyle(
                              fontSize: Responsive.width(context, 0.03)),
                        ),
                        Text(
                          peoplerated.toString(),
                          style: TextStyle(
                              fontSize: Responsive.width(context, 0.03)),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          "Reviews",
                          style: TextStyle(
                              fontSize: Responsive.width(context, 0.03)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const FavoriteIconButton(), // Moved to the end of the row
            ],
          ),
        ),
      ),
    );
  }
}
