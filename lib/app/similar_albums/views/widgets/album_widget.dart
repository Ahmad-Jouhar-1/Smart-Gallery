import 'package:flutter/material.dart';
import 'package:smart_gallery/app/similar_albums/models/album_model.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/widgets/rename_dialog.dart';

class AlbumWidget extends StatelessWidget {
  const AlbumWidget({
    super.key,
    required this.album,
    required this.onTap,
    required this.onRename,
    required this.isRenaming,
  });

  final AlbumModel album;
  final VoidCallback onTap;
  final ValueChanged<String> onRename;
  final bool isRenaming;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppDimensions.sp,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                _AlbumImage(image: album.image),
                _EditButton(
                  isLoading: isRenaming,
                  onTap: isRenaming
                      ? null
                      : () {
                          showRenameDialog(
                            context,
                            currentName: album.name,
                            onRenamed: onRename,
                          );
                        },
                ),
              ],
            ),
          ),
          _AlbumInfo(name: album.name, count: album.count),
        ],
      ),
    );
  }
}

class _AlbumImage extends StatelessWidget {
  const _AlbumImage({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.sbr),
      child: image.startsWith('http')
          ? Image.network(image, fit: BoxFit.cover)
          : Image.asset(image, fit: BoxFit.cover),
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({required this.onTap, required this.isLoading});

  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AppDimensions.sp,
      right: AppDimensions.sp,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: AppDimensions.mis,
          height: AppDimensions.mis,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.transparentBlackColor,
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
      ),
    );
  }
}

class _AlbumInfo extends StatelessWidget {
  const _AlbumInfo({required this.name, required this.count});

  final String name;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppDimensions.sfs,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$count photo',
          maxLines: 1,
          style: TextStyle(
            color: AppColors.accentTextColor,
            fontSize: AppDimensions.sfs,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
