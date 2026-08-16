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
        _cluster = cluster;

        emit(ClusterLoaded(cluster: cluster));
      } on ServerException catch (e) {
        emit(ClusterFailed(errorMessage: e.errorModel.errorMessage));
      }
    });

    on<DeletePhotos>((event, emit) {
      if (_cluster == null) {
        return;
      }

      final bestPhotoId = _cluster!.bestPhoto.id;
      final photos = _cluster!.photos
          .where(
            (photo) =>
                photo.id == bestPhotoId || !event.ids.contains(photo.id),
          )
          .toList();

      _cluster = _cluster!.copyWith(photos: photos);
      emit(ClusterLoaded(cluster: _cluster!));
    });
  }

  ClusterModel? _cluster;
}
