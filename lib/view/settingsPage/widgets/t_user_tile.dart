import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/image_url.dart';
import 'package:qv_patient/view/settingsPage/widgets/t_circular_image.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const TCircularImage(
        backgroundcolor: Colors.transparent,
        image: TImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(
        'Shahinsh.pbr',
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.dark),
      ),
      subtitle: Text(
        'paramboorshahinsh@gmail.com',
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.dark),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Iconsax.edit),
      ),
    );
  }
}
