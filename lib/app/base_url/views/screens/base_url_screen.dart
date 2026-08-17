import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:smart_gallery/app/base_url/controllers/fetch_base_url/fetch_base_url_bloc.dart';
import 'package:smart_gallery/app/base_url/views/widgets/base_url_widget.dart';
import 'package:smart_gallery/app/upload_consent/view/screens/upload_consent_screen.dart';
import 'package:smart_gallery/core/api/end_points.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/constants/app_shadow.dart';
import 'package:smart_gallery/core/controllers/device_identifier_bloc/device_identifier_bloc.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';

class BaseUrlScreen extends StatelessWidget {
  const BaseUrlScreen({super.key});

  static const Color _buttonColor = Color(0xFF1DB9AA);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchBaseUrlBloc(),
      child: BlocListener<DeviceIdentifierBloc, DeviceIdentifierState>(
        listener: (context, state) {
          if (state is DeviceIdentifierInitialized) {
            Get.offAll(() => UploadConsentScreen());
          } else if (state is DeviceIdentifierFailed) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF4F4F4),
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.all(AppDimensions.mp),
              children: [
                SizedBox(
                  height: 43.0.hp,
                  child: Image.asset(
                    'assets/images/Pharmacist-amico.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.dns_rounded,
                        color: _buttonColor,
                        size: 28.0.wp,
                      );
                    },
                  ),
                ),
                Text(
                  'Set your base url',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: AppDimensions.lfs,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppDimensions.mp),
                Text(
                  'Open your terminal and run the command ipconfig.\n'
                  'Find the IPv4 Address in the output, then enter it in '
                  'this text field in the following format:\n'
                  'http://<IPv4 Address>:8000',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.hintTextColor,
                    fontSize: AppDimensions.sfs,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: AppDimensions.mp),
                BaseUrlWidget(),
                SizedBox(height: AppDimensions.mp),
                BlocBuilder<FetchBaseUrlBloc, FetchBaseUrlState>(
                  builder: (context, urlState) {
                    return BlocBuilder<
                      DeviceIdentifierBloc,
                      DeviceIdentifierState
                    >(
                      builder: (context, deviceState) {
                        final isLoading =
                            deviceState is DeviceIdentifierLoading;

                        return _ConfirmButton(
                          isEnabled: urlState.isValid && !isLoading,
                          isLoading: isLoading,
                          onTap: () {
                            EndPoints.setBaseUrl(urlState.baseUrl);
                            context.read<DeviceIdentifierBloc>().add(
                              DeviceIdentifierIsInitialized(),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton({
    required this.isEnabled,
    required this.isLoading,
    required this.onTap,
  });

  final bool isEnabled;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        height: 14.0.wp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              isEnabled ? BaseUrlScreen._buttonColor : AppColors.hintTextColor,
          borderRadius: BorderRadius.circular(AppDimensions.lbr),
          boxShadow: AppShadow.boxShadow,
        ),
        child:
            isLoading
                ? SizedBox(
                  width: AppDimensions.sis,
                  height: AppDimensions.sis,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.foregroundColor,
                  ),
                )
                : Text(
                  'Confirm',
                  style: TextStyle(
                    color: AppColors.foregroundColor,
                    fontSize: AppDimensions.mfs,
                    fontWeight: FontWeight.bold,
                  ),
                ),
      ),
    );
  }
}
