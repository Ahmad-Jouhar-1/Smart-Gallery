import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:smart_gallery/app/image_evaluation/controllers/report_bloc/report_bloc.dart';
import 'package:smart_gallery/app/image_evaluation/views/widgets/report_view.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/widgets/app_bar_widget.dart';
import 'package:smart_gallery/core/widgets/loading_widget.dart';
import 'package:smart_gallery/app/similar_album/models/photo_model.dart';
import 'package:smart_gallery/app/image_evaluation/views/widgets/report_failed_widget.dart';
class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key, required this.photo});

  final PhotoModel photo;

  Future<void> _onRefresh(BuildContext context) async {
    context.read<ReportBloc>().add(FetchReport(imageId: photo.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ReportBloc()..add(FetchReport(imageId: photo.id)),
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        appBar: AppBarWidget(
          title: "Image Evaluation",
          subtitle: "Quality Analysis",
          icon: Icons.arrow_forward_ios_rounded,
          onTap: Get.back,
        ),
        body: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              color: AppColors.primaryColor,
              backgroundColor: AppColors.accentBackgroundColor,
              child: BlocBuilder<ReportBloc, ReportState>(
                builder: (context, state) {
                  switch (state) {
                    case ReportLoading():
                      return LoadingWidget();
                    case ReportLoaded():
                      return ReportView(
                        photo: photo,
                        report: state.report,
                      );
                    case ReportFailed():
                      return ReportFailedWidget(
                        image: "assets/images/similar_empty.png",
                        title: "Something Went Wrong",
                        subtitle: state.errorMessage,
                        onTryAgain: () => _onRefresh(context),
                      );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
