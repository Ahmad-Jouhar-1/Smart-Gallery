import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_gallery/app/similar_album/models/cluster_model.dart';
import 'package:smart_gallery/core/api/dio_consumer.dart';
import 'package:smart_gallery/core/api/end_points.dart';
import 'package:smart_gallery/core/errors/exceptions.dart';

part 'cluster_event.dart';
part 'cluster_state.dart';

class ClusterBloc extends Bloc<ClusterEvent, ClusterState> {
  ClusterBloc() : super(ClusterLoading()) {
    DioConsumer api = DioConsumer(dio: Dio());

    on<FetchCluster>((event, emit) async {
      emit(ClusterLoading());

      try {
        final response = await api.get(EndPoints.cluster(event.clusterId));
        final cluster = ClusterModel.fromJson(
          response as Map<String, dynamic>,
        );
        emit(ClusterLoaded(cluster: cluster));
      } on ServerException catch (e) {
        emit(ClusterFailed(errorMessage: e.errorModel.errorMessage));
      }
    });

  }
}
