
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/size.dart';
import 'package:qv_patient/model/globalvariable.dart';
import 'package:qv_patient/view/homepage/widgets/t_rounded_image.dart';

class DocCard extends StatelessWidget {
  const DocCard({
    super.key,
    required this.onTap,
    required this.name,
    required this.location,
    required this.department,
  });
  final VoidCallback onTap;
  final String name, location, department;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: TColors.light.withOpacity(.2),
            borderRadius: BorderRadius.circular(12)),
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const TRoundedImage(width: 100, imageurl: 'assets/image/doctor.jpg'),
              const SizedBox(
                width: Tsizes.defaultspace,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    department,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displayMedium!.apply(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(Iconsax.location),
                      Text(
                        location,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
