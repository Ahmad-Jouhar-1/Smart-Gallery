import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:smart_gallery/app/upload_consent/view/screens/upload_consent_screen.dart';
import 'package:smart_gallery/core/controllers/device_identifier_bloc/device_identifier_bloc.dart';
import 'package:smart_gallery/core/services/app_bloc_observer/app_bloc_observer.dart';
import 'package:smart_gallery/core/services/service_locator/service_locator_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  setup();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create:
              (context) =>
                  getIt<DeviceIdentifierBloc>()
                    ..add(DeviceIdentifierIsInitialized()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: UploadConsentScreen(),
    );
  }
}
