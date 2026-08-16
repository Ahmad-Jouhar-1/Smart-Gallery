import 'package:flutter/material.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

Future<void> showRenameDialog(
  BuildContext context, {
  required String currentName,
  required ValueChanged<String> onRenamed,
}) {
  final controller = TextEditingController(text: currentName);

  return showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: AppColors.accentBackgroundColor,
      title: Text(
        "Rename",
        style: TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: AppDimensions.lfs,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: TextField(
        controller: controller,
        autofocus: true,
        cursorColor: AppColors.primaryColor,
        style: TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: AppDimensions.mfs,
        ),
        decoration: InputDecoration(
          hintText: "Enter a name",
          hintStyle: TextStyle(color: AppColors.hintTextColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.hintTextColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(
            "Cancel",
            style: TextStyle(color: AppColors.accentTextColor),
          ),
        ),
        TextButton(
          onPressed: () {
            final newName = controller.text.trim();
            Navigator.of(dialogContext).pop();

            if (newName.isNotEmpty && newName != currentName) {
              onRenamed(newName);
            }
          },
          child: Text(
            "Save",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
