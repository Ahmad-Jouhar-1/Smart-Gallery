part of 'fetch_people_bloc.dart';

@immutable
sealed class FetchPeopleEvent {}

final class FetchPeople extends FetchPeopleEvent {}

final class SearchPeople extends FetchPeopleEvent {
  final String searchWord;

  SearchPeople({required this.searchWord});
}

final class PersonNameIsUpdated extends FetchPeopleEvent {
  final int id;
  final String newName;

  PersonNameIsUpdated({required this.id, required this.newName});
}
