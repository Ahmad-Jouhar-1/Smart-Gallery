part of 'rename_person_bloc.dart';

@immutable
sealed class RenamePersonState {}

final class RenamePersonInitial extends RenamePersonState {}

final class RenamePersonLoading extends RenamePersonState {
  final int personId;

  RenamePersonLoading({required this.personId});
}

final class RenamePersonLoaded extends RenamePersonState {
  final PersonModel person;

  RenamePersonLoaded({required this.person});
}

final class RenamePersonFailed extends RenamePersonState {
  final String errorMessage;

  RenamePersonFailed({required this.errorMessage});
}
