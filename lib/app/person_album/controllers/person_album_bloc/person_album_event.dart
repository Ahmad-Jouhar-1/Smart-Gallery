part of 'person_album_bloc.dart';

@immutable
sealed class PersonAlbumEvent {}

final class FetchPersonAlbum extends PersonAlbumEvent {
  final int personId;

  FetchPersonAlbum({required this.personId});
}
