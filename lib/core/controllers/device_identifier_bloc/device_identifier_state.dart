part of 'device_identifier_bloc.dart';

@immutable
sealed class DeviceIdentifierState {}

final class DeviceIdentifierInitial extends DeviceIdentifierState {}

final class DeviceIdentifierInitialized extends DeviceIdentifierState {
  final String deviceIdentifier;

  DeviceIdentifierInitialized({required this.deviceIdentifier});
}

final class DeviceIdentifierFailed extends DeviceIdentifierState {
  final String errorMessage;

  DeviceIdentifierFailed({required this.errorMessage});
}
