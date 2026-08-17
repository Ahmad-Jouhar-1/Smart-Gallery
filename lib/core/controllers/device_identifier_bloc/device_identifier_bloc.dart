import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_gallery/core/api/dio_consumer.dart';
import 'package:smart_gallery/core/api/end_points.dart';
import 'package:smart_gallery/core/errors/exceptions.dart';
import 'package:smart_gallery/core/services/shared_preferences/shared_preference_service.dart';
import 'package:uuid/uuid.dart';

part 'device_identifier_event.dart';
part 'device_identifier_state.dart';

class DeviceIdentifierBloc
    extends Bloc<DeviceIdentifierEvent, DeviceIdentifierState> {
  DeviceIdentifierBloc() : super(DeviceIdentifierInitial()) {
    on<DeviceIdentifierIsInitialized>((event, emit) async {
      emit(DeviceIdentifierLoading());

      try {
        String? deviceIdentifier =
            await SharedPreferencesService.getDeviceIdentifier();

        if (deviceIdentifier == null) {
          deviceIdentifier = const Uuid().v4();
          DioConsumer api = DioConsumer(dio: Dio());

          await api.post(
            EndPoints.registerDevice,
            data: {
              ApiKey.deviceIdentifierBody: deviceIdentifier,
            },
          );

          await SharedPreferencesService.saveDeviceIdentifier(
            deviceIdentifier,
          );
        }

        log(deviceIdentifier);

        emit(DeviceIdentifierInitialized(deviceIdentifier: deviceIdentifier));
      } on ServerException catch (e) {
        emit(
          DeviceIdentifierFailed(
            errorMessage: e.errorModel.errorMessage,
          ),
        );
      }
    });
  }
}
