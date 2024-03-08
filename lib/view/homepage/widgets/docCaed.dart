import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/size.dart';
import 'package:qv_patient/helper/doc_helper_function.dart';
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
            color: dark
                ? TColors.light.withOpacity(.1)
                : TColors.dark.withOpacity(.1),
            borderRadius: BorderRadius.circular(12)),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const TRoundedImage(
                  width: 100, imageurl: 'assets/image/doctor.jpg'),
              const SizedBox(
                width: Tsizes.defaultspace - 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: TColors.light.withOpacity(.1),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Iconsax.verify4,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Proffesional Doctor",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .apply(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: Tsizes.defaultspace + 20,
                        ),
                        const FavoriteIconButton()
                      ],
                    ),
                  ),
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    department,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium!.apply(),
                  ),
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
                            size: 16,
                          ),
                        ),
                      ),
                      Text(ratingnumber.toString()),
                      const Text("  |  "),
                      Text(peoplerated.toString()),
                      const SizedBox(
                        width: 2,
                      ),
                      const Text("Reviews"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
