import 'package:flutter/material.dart';
import 'package:smart_gallery/app/people_albums/models/person_album_model.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/widgets/rename_dialog.dart';

class PersonAlbumWidget extends StatelessWidget {
  const PersonAlbumWidget({
    super.key,
    required this.person,
    required this.onTap,
    required this.onLongPress,
    required this.onRename,
    this.isSelecting = false,
    this.isSelected = false,
  });

  final PersonAlbumModel person;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final ValueChanged<String> onRename;
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
                    ClipOval(
                      child: Opacity(
                        opacity: isSelecting && !isSelected ? 0.55 : 1,
                        child: Image.asset(person.image, fit: BoxFit.cover),
                      ),
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

                    if (isSelecting)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: _SelectionCheck(isSelected: isSelected),
                      )
                    else
                      Positioned(
                        right: 0,
                        top: 0,
                        child: _EditButton(
                          onTap: () => showRenameDialog(
                            context,
                            currentName: person.name,
                            onRenamed: onRename,
                          ),
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
  const _EditButton({required this.onTap});

  final VoidCallback onTap;

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
        child: Icon(
          Icons.edit_outlined,
          color: AppColors.foregroundColor,
          size: AppDimensions.sfs,
        ),
      ),
    );
  }
}
