import 'package:flutter/material.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Size get preferredSize => Size.fromHeight(18.0.wp);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.accentBackgroundColor,
      surfaceTintColor: AppColors.transparentColor,
      toolbarHeight: preferredSize.height,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.mp),
        child: Row(
          children: [
            _AiButton(),

            SizedBox(width: AppDimensions.mp),

            _AppBarTitle(title: title, subtitle: subtitle),

            Spacer(),

            _TrailingButton(icon: icon, onTap: onTap),
          ],
        ),
      ),
    );
  }
}

class _TrailingButton extends StatelessWidget {
  const _TrailingButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppDimensions.lis,
        height: AppDimensions.lis,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.transparentPrimaryColor,
        ),
        child: Icon(
          icon,
          color: AppColors.primaryColor,
          size: AppDimensions.sis,
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppDimensions.xlfs,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: AppColors.accentTextColor,
            fontSize: AppDimensions.sfs,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _AiButton extends StatelessWidget {
  const _AiButton();

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
        Icons.auto_awesome_outlined,
        color: AppColors.foregroundColor,
        size: AppDimensions.sis,
      ),
    );
  }
}
