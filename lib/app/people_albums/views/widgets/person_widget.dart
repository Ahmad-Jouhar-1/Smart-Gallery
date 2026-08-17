import 'package:flutter/material.dart';
import 'package:smart_gallery/app/people_albums/models/person_model.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/widgets/rename_dialog.dart';

class PersonWidget extends StatelessWidget {
  const PersonWidget({
    super.key,
    required this.person,
    required this.onTap,
    required this.onLongPress,
    required this.onRename,
    required this.isRenaming,
    this.isSelecting = false,
    this.isSelected = false,
  });

  final PersonModel person;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final ValueChanged<String> onRename;
  final bool isRenaming;
  final bool isSelecting;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _PersonImage(
                      image: person.image,
                      opacity: isSelecting && !isSelected ? 0.55 : 1,
                    ),
                    if (isSelecting)
                      DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(
                                  color: AppColors.primaryColor,
                                  width: 3,
                                )
                              : null,
                        ),
                      ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: isSelecting
                          ? _SelectionCheck(isSelected: isSelected)
                          : _EditButton(
                              isLoading: isRenaming,
                              onTap: isRenaming
                                  ? null
                                  : () {
                                      showRenameDialog(
                                        context,
                                        currentName: person.name,
                                        onRenamed: onRename,
                                      );
                                    },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: AppDimensions.sm),
          Text(
            person.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppDimensions.mfs,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${person.count} Photos',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.accentTextColor,
              fontSize: AppDimensions.sfs,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonImage extends StatelessWidget {
  const _PersonImage({required this.image, required this.opacity});

  final String image;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Opacity(
        opacity: opacity,
        child: image.startsWith('http')
            ? Image.network(image, fit: BoxFit.cover)
            : Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }
}

class _SelectionCheck extends StatelessWidget {
  const _SelectionCheck({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.mis,
      height: AppDimensions.mis,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected
            ? AppColors.primaryColor
            : AppColors.transparentBlackColor,
        border: Border.all(color: AppColors.foregroundColor, width: 1.5),
      ),
      child: isSelected
          ? Icon(
              Icons.check,
              color: AppColors.foregroundColor,
              size: AppDimensions.mfs,
            )
          : null,
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({required this.onTap, required this.isLoading});

  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppDimensions.mis,
        height: AppDimensions.mis,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.transparentBlackColor,
          border: Border.all(color: AppColors.foregroundColor, width: 1.5),
        ),
        child: isLoading
            ? Padding(
                padding: const EdgeInsets.all(6),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.foregroundColor,
                ),
              )
            : Icon(
                Icons.edit_outlined,
                color: AppColors.foregroundColor,
                size: AppDimensions.sfs,
              ),
      ),
    );
  }
}
