import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:smart_gallery/app/main_navigation/view/screens/main_navigation_screen.dart';
import 'package:smart_gallery/app/upload_consent/controllers/bloc/analyze_album_bloc.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';

class AlbumAnalysisScreen extends StatelessWidget {
  const AlbumAnalysisScreen({super.key, required this.album});

  final AssetPathEntity album;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AnalyzeAlbumBloc()..add(StartAnalyzingAlbum(album: album)),
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        body: SafeArea(
          child: BlocConsumer<AnalyzeAlbumBloc, AnalyzeAlbumState>(
            listener: (context, state) {
              if (state is AnalyzeAlbumCompleted) {
                Get.offAll(() => const MainNavigationScreen());
              }
            },
            builder: (context, state) {
              if (state is AnalyzeAlbumFailed) {
                return _AnalyzeAlbumFailedWidget(
                  errorMessage: state.errorMessage,
                  onTryAgain: () => context.read<AnalyzeAlbumBloc>().add(
                    StartAnalyzingAlbum(album: album),
                  ),
                );
              }

              final progress = state is AnalyzeAlbumInProgress
                  ? state.progress
                  : 100;

              return Padding(
                padding: EdgeInsets.all(AppDimensions.xlp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 22.0.wp,
                      lineWidth: AppDimensions.sm,
                      percent: progress / 100,
                      animation: true,
                      animateFromLastPercent: true,
                      backgroundColor: AppColors.transparentPrimaryColor,
                      progressColor: AppColors.primaryColor,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        "$progress%",
                        style: TextStyle(
                          color: AppColors.primaryTextColor,
                          fontSize: AppDimensions.xlfs,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: AppDimensions.lp),

                    Text(
                      "Analyzing \"${album.name}\"",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: AppDimensions.lfs,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: AppDimensions.sm),

                    Text(
                      "Uploading and analyzing your photos securely...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.accentTextColor,
                        fontSize: AppDimensions.mfs,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AnalyzeAlbumFailedWidget extends StatelessWidget {
  const _AnalyzeAlbumFailedWidget({
    required this.errorMessage,
    required this.onTryAgain,
  });

  final String errorMessage;
  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.xlp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: AppColors.accentTextColor,
            size: AppDimensions.lis,
          ),

          SizedBox(height: AppDimensions.mp),

          Text(
            "Upload Failed",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppDimensions.lfs,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: AppDimensions.sm),

          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.accentTextColor,
              fontSize: AppDimensions.mfs,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: AppDimensions.lp),

          GestureDetector(
            onTap: onTryAgain,
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
                "Try Again",
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
    );
  }
}
