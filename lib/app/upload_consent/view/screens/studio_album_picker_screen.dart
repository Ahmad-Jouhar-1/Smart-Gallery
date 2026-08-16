import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:smart_gallery/app/upload_consent/view/widgets/studio_albums_widget.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/widgets/app_bar_widget.dart';
import 'package:smart_gallery/core/widgets/subtitle_widget.dart';

class StudioAlbumPickerScreen extends StatefulWidget {
  const StudioAlbumPickerScreen({super.key});

  @override
  State<StudioAlbumPickerScreen> createState() =>
      _StudioAlbumPickerScreenState();
}

class _StudioAlbumPickerScreenState extends State<StudioAlbumPickerScreen> {
  bool _loading = true;
  bool _permissionDenied = false;
  List<AssetPathEntity> _albums = [];

  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  Future<void> _loadAlbums() async {
    final permission = await PhotoManager.requestPermissionExtend();

    if (!permission.isAuth && !permission.hasAccess) {
      setState(() {
        _permissionDenied = true;
        _loading = false;
      });
      return;
    }

    final albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: false,
    );

    setState(() {
      _albums = albums;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBarWidget(
        title: "Studio",
        subtitle: "Select an Album",
        icon: Icons.arrow_forward_ios_rounded,
        onTap: Get.back,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_permissionDenied) {
      return _PermissionDeniedView(onRetry: _loadAlbums);
    }

    return ListView(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.mp),
      children: [
        SubtitleWidget(subtitle: "${_albums.length} Albums Found"),

        SizedBox(height: AppDimensions.mp),

        StudioAlbumsWidget(studioAlbums: _albums),
      ],
    );
  }
}

class _PermissionDeniedView extends StatelessWidget {
  const _PermissionDeniedView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.xlp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_library_outlined,
              color: AppColors.accentTextColor,
              size: AppDimensions.lis,
            ),

            SizedBox(height: AppDimensions.mp),

            Text(
              "We need access to your photos to show your albums here.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: AppDimensions.mfs,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: AppDimensions.mp),

            GestureDetector(
              onTap: () async {
                await PhotoManager.openSetting();
                onRetry();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.lp,
                  vertical: AppDimensions.sp,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryColor, AppColors.secondaryColor],
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.mbr),
                ),
                child: Text(
                  "Open Settings",
                  style: TextStyle(
                    color: AppColors.foregroundColor,
                    fontSize: AppDimensions.mfs,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
