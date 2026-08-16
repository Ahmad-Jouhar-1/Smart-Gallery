part of 'cluster_bloc.dart';

@immutable
sealed class ClusterEvent {}

final class FetchCluster extends ClusterEvent {
  final int clusterId;

  FetchCluster({required this.clusterId});
}

final class DeletePhotos extends ClusterEvent {
  final Set<int> ids;

  DeletePhotos({required this.ids});
}
