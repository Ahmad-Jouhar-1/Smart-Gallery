part of 'cluster_bloc.dart';

@immutable
sealed class ClusterEvent {}

final class FetchCluster extends ClusterEvent {
  final int clusterId;

  FetchCluster({required this.clusterId});
}
