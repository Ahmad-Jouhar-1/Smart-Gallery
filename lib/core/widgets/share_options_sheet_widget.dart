import 'package:flutter/material.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class ShareOptionsSheetWidget extends StatelessWidget {
  const ShareOptionsSheetWidget({super.key, required this.onPicked});

  final VoidCallback onPicked;

  static void show(BuildContext context, {required VoidCallback onPicked}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.accentBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.mbr),
        ),
      ),
      builder: (context) => ShareOptionsSheetWidget(onPicked: onPicked),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.mp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Share via",
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: AppDimensions.lfs,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: AppDimensions.mp),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ShareOptionButton(
                  icon: Icons.chat,
                  color: Color(0xFF25D366),
                  label: "WhatsApp",
                  onTap: () {
                    Navigator.of(context).pop();
                    onPicked();
                  },
                ),
                _ShareOptionButton(
                  icon: Icons.send_rounded,
                  color: Color(0xFF29A9EA),
                  label: "Telegram",
                  onTap: () {
                    Navigator.of(context).pop();
                    onPicked();
                  },
                ),
                _ShareOptionButton(
                  icon: Icons.more_horiz,
                  color: AppColors.primaryColor,
                  label: "More",
                  onTap: () {
                    Navigator.of(context).pop();
                    onPicked();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ShareOptionButton extends StatelessWidget {
  const _ShareOptionButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppDimensions.sm,
        children: [
          Container(
            width: AppDimensions.xlp * 1.6,
            height: AppDimensions.xlp * 1.6,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Icon(icon, color: AppColors.foregroundColor),
          ),
          Text(
            label,
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppDimensions.sfs,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
