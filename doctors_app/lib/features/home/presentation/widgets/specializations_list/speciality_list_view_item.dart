import 'package:doctors_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/text_style.dart';
import '../../../data/models/specializations_response_model.dart';

class SpecialityListViewItem extends StatelessWidget {
  final SpecializationsData? specializationsData;
  final int itemIndex;
  final int selectedIndex;
  const SpecialityListViewItem({
    super.key,
    this.specializationsData,
    required this.itemIndex,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {

        // Fetch the image path based on the specialization name
    String imagePath = getImageForSpecialization(specializationsData?.name);
    return Padding(
      padding: EdgeInsetsDirectional.only(start: itemIndex == 0 ? 0 : 24.w),
      child: Column(
        children: [
          itemIndex == selectedIndex
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.darkBlue,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.lightBlue,
                    child: Image.asset(
                      imagePath,
                      height: 42.h,
                      width: 42.w,
                    ),
                  ),
                )
              : CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.lightBlue,
                  child: Image.asset(
                    imagePath,
                    height: 40.h,
                    width: 40.w,
                  ),
                ),
          SizedBox(height: 8.h),
          Text(
            specializationsData?.name ?? 'Specialization',
            style: itemIndex == selectedIndex
                ? TextStyles.font14DarkBlueBold
                : TextStyles.font12DarkBlueRegular,
          ),
        ],
      ),
    );
  }

  String getImageForSpecialization(String? specializationName) {
    if (specializationName == 'Cardiology')
    {
      return  'assets/images/temp_images/cardiology.png';
    }
    else if (specializationName == 'Dermatology')
    {
      return  'assets/images/temp_images/dermatology.png';
    }
    else if (specializationName == 'Neurology')
    {
      return  'assets/images/temp_images/neurology.png';
    }
    else if (specializationName == 'Orthopedics')
    {
      return  'assets/images/temp_images/orthopedics.png';
    }
    else if (specializationName == 'Pediatrics')
    {
      return  'assets/images/temp_images/pediatrics.png';
    }
    else if (specializationName == 'Gynecology')
    {
      return  'assets/images/temp_images/gynecology.png';
    }
    else if (specializationName == 'Ophthalmology')
    {
      return  'assets/images/temp_images/ophthalmology.png';
    }
    else if (specializationName == 'Urology')
    {
      return  'assets/images/temp_images/urology.png';
    }
    else if (specializationName == 'Gastroenterology')
    {
      return  'assets/images/temp_images/gastroenterology.png';
    }
    else if (specializationName == 'Psychiatry')
    {
      return  'assets/images/temp_images/psychiatry.png';
    }
    else
    {
      return  'assets/images/temp_images/cardiology.png';
    }

  }
}
