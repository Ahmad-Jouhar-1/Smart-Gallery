part of 'rename_person_bloc.dart';

@immutable
sealed class RenamePersonEvent {}

final class RenamePerson extends RenamePersonEvent {
  final int id;
  final String newName;

  RenamePerson({required this.id, required this.newName});
}
