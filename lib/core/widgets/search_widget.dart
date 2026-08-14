import 'package:flutter/material.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, required this.hintText, this.onChanged});

  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16.0.wp,
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.mm),
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.mp),
      decoration: BoxDecoration(
        color: AppColors.accentBackgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.sbr),
      ),
      child: Row(
        spacing: AppDimensions.sp,
        children: [
          _SearchIcon(),

          _SearchTextField(hintText: hintText, onChanged: onChanged),

          _ImageSearchButton(),
        ],
      ),
    );
  }
}

class _SearchIcon extends StatelessWidget {
  const _SearchIcon();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.search,
      color: AppColors.accentTextColor,
      size: AppDimensions.sis,
    );
  }
}

class _SearchTextField extends StatelessWidget {
  const _SearchTextField({required this.hintText, this.onChanged});

  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        onChanged: onChanged,
        cursorColor: AppColors.primaryColor,
        style: TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: AppDimensions.mfs,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.accentTextColor,
            fontSize: AppDimensions.mfs,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class _ImageSearchButton extends StatelessWidget {
  const _ImageSearchButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.lis,
      height: AppDimensions.lis,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
        ),
      ),
      child: Icon(
        Icons.add_photo_alternate_outlined,
        color: AppColors.foregroundColor,
        size: AppDimensions.sis,
      ),
    );
  }
}
