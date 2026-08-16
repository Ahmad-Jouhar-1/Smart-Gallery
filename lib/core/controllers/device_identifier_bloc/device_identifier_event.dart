part of 'device_identifier_bloc.dart';

@immutable
sealed class DeviceIdentifierEvent {}

final class DeviceIdentifierIsInitialized extends DeviceIdentifierEvent {}
