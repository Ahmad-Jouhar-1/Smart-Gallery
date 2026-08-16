import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smart_gallery/app/main_navigation/view/screens/main_navigation_screen.dart';
import 'package:smart_gallery/app/upload_consent/controllers/analyze_album/analyze_album_bloc.dart';
import 'package:smart_gallery/app/upload_consent/models/studio_album_model.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';

class AlbumAnalysisScreen extends StatelessWidget {
  const AlbumAnalysisScreen({super.key, required this.album});

  final StudioAlbumModel album;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AnalyzeAlbumBloc()..add(StartAnalyzingAlbum(albumId: album.id)),
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
