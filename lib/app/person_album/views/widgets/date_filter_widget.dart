import 'package:flutter/material.dart';
import 'package:smart_gallery/app/person_album/models/date_filter.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';

class DateFilterWidget extends StatelessWidget {
  const DateFilterWidget({
    super.key,
    required this.filter,
    required this.onSelected,
  });

  final DateFilter filter;
  final ValueChanged<DateFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.0.hp,
      width: 9.0.wp,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.mp),
        scrollDirection: Axis.horizontal,
        itemCount: DateFilter.values.length,
        separatorBuilder: (context, index) => SizedBox(width: AppDimensions.sp),
        itemBuilder: (context, index) {
          final item = DateFilter.values[index];

          return _FilterChip(
            label: item.label,
            isSelected: item == filter,
            onTap: () => onSelected(item),
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
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.mp),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.accentBackgroundColor,
          borderRadius: BorderRadius.circular(AppDimensions.lbr),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? AppColors.foregroundColor
                : AppColors.accentTextColor,
            fontSize: AppDimensions.sfs,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
