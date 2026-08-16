import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_gallery/app/upload_consent/view/screens/studio_album_picker_screen.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';

class UploadConsentScreen extends StatelessWidget {
  const UploadConsentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.xlp),
          child: Column(
            children: [
              Spacer(),

              _CloudIcon(),

              SizedBox(height: AppDimensions.lp),

              Text(
                "Analyze Your Gallery",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryTextColor,
                  fontSize: AppDimensions.xlfs,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: AppDimensions.mp),

              Text(
                "To organize your photos into albums and people, we need to "
                "upload them to our secure server for analysis.\n\n"
                "Don't worry — your photos are encrypted and kept private.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.accentTextColor,
                  fontSize: AppDimensions.mfs,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),

              Spacer(),

              _AllowButton(
                onTap: () => Get.to(
                  () => const StudioAlbumPickerScreen(),
                  transition: Transition.circularReveal,
                ),
              ),

              SizedBox(height: AppDimensions.mp),
            ],
          ),
        ),
      ),
    );
  }
}

class _CloudIcon extends StatelessWidget {
  const _CloudIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28.0.wp,
      height: 28.0.wp,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
        ),
      ),
      child: Icon(
        Icons.cloud_upload_outlined,
        color: AppColors.foregroundColor,
        size: 14.0.wp,
      ),
    );
  }
}

class _AllowButton extends StatelessWidget {
  const _AllowButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: AppDimensions.mp),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
          ),
          borderRadius: BorderRadius.circular(AppDimensions.mbr),
        ),
        alignment: Alignment.center,
        child: Text(
          'Allow',
          style: TextStyle(
            color: AppColors.foregroundColor,
            fontSize: AppDimensions.mfs,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
