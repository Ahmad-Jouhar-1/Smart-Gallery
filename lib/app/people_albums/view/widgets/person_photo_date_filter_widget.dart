import 'package:flutter/material.dart';
import 'package:smart_gallery/app/people_albums/models/person_photo_date_filter.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';

class PersonPhotoDateFilterWidget extends StatelessWidget {
  const PersonPhotoDateFilterWidget({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final PersonPhotoDateFilter selectedFilter;
  final ValueChanged<PersonPhotoDateFilter> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.0.hp,
      width: 9.0.wp,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.mp),
        scrollDirection: Axis.horizontal,
        itemCount: PersonPhotoDateFilter.values.length,
        separatorBuilder: (context, index) => SizedBox(width: AppDimensions.sp),
        itemBuilder: (context, index) {
          final filter = PersonPhotoDateFilter.values[index];
          final isSelected = filter == selectedFilter;

          return _FilterChip(
            label: filter.label,
            isSelected: isSelected,
            onTap: () => onFilterSelected(filter),
          );
        },
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20.0.wp,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.sp),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.accentBackgroundColor,
          borderRadius: BorderRadius.circular(AppDimensions.lbr),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            maxLines: 1,
            style: TextStyle(
              color: isSelected
                  ? AppColors.foregroundColor
                  : AppColors.accentTextColor,
              fontSize: AppDimensions.mfs,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
