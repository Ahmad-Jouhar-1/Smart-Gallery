import 'package:get_it/get_it.dart';
import 'package:smart_gallery/core/controllers/device_identifier_bloc/device_identifier_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<DeviceIdentifierBloc>(
    () => DeviceIdentifierBloc(),
  );
}
