import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_gallery/app/base_url/controllers/fetch_base_url/fetch_base_url_bloc.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/constants/app_shadow.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';

class BaseUrlWidget extends StatelessWidget {
  const BaseUrlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.0.wp,
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.mp),
      decoration: BoxDecoration(
        color: AppColors.accentBackgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.lbr),
        boxShadow: AppShadow.boxShadow,
      ),
      child: Row(
        spacing: AppDimensions.mp,
        children: [
          Icon(
            Icons.link_rounded,
            color: AppColors.hintTextColor,
            size: AppDimensions.sis,
          ),
          Expanded(
            child: TextField(
              onChanged: (value) {
                context.read<FetchBaseUrlBloc>().add(
                  BaseUrlIsFetched(baseUrl: value.trim()),
                );
              },
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: AppDimensions.mfs,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'http://192.168.1.4:8000',
                hintStyle: TextStyle(
                  color: AppColors.hintTextColor,
                  fontSize: AppDimensions.mfs,
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.zero,
              ),
              cursorColor: AppColors.primaryTextColor,
              keyboardType: TextInputType.url,
              autocorrect: false,
              enableSuggestions: false,
            ),
          ),
        ],
      ),
    );
  }
}
