part of 'cluster_bloc.dart';

@immutable
sealed class ClusterState {}

final class ClusterLoading extends ClusterState {}

final class ClusterLoaded extends ClusterState {
  final ClusterModel cluster;

  ClusterLoaded({required this.cluster});
}

final class ClusterFailed extends ClusterState {
  final String errorMessage;

  ClusterFailed({required this.errorMessage});
}
