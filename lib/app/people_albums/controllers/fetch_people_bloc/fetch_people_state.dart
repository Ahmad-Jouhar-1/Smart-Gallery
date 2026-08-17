part of 'fetch_people_bloc.dart';

@immutable
sealed class FetchPeopleState {}

final class FetchPeopleLoading extends FetchPeopleState {}

final class FetchPeopleLoaded extends FetchPeopleState {
  final List<PersonModel> people;

  FetchPeopleLoaded({required this.people});
}

final class FetchPeopleLoadedEmpty extends FetchPeopleState {}

final class FetchPeopleFailed extends FetchPeopleState {
  final String errorMessage;

  FetchPeopleFailed({required this.errorMessage});
}
