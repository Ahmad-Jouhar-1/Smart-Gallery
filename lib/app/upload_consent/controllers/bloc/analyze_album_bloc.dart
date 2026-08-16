import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:smart_gallery/app/upload_consent/controllers/service/upload_images_batch_service.dart';
import 'package:smart_gallery/app/upload_consent/models/upload_images_model.dart';
import 'package:smart_gallery/core/errors/exceptions.dart';
import 'package:smart_gallery/core/services/shared_preferences/shared_preference_service.dart';

part 'analyze_album_event.dart';
part 'analyze_album_state.dart';

class AnalyzeAlbumBloc extends Bloc<AnalyzeAlbumEvent, AnalyzeAlbumState> {
  AnalyzeAlbumBloc({UploadImagesBatchService? uploadImagesBatchService})
    : _uploadImagesBatchService =
          uploadImagesBatchService ?? UploadImagesBatchService(),
      super(AnalyzeAlbumInProgress(progress: 0)) {
    on<StartAnalyzingAlbum>((event, emit) async {
      emit(AnalyzeAlbumInProgress(progress: 0));

      try {
        final assetCount = await event.album.assetCountAsync;
        final assets = await event.album.getAssetListRange(
          start: 0,
          end: assetCount,
        );

        final files = <File>[];
        final captureTimes = <DateTime?>[];

        for (final asset in assets) {
          final file = await asset.file;
          if (file == null) continue;

          files.add(file);
          captureTimes.add(asset.createDateTime);
        }

        if (files.isEmpty) {
          log(
            'AnalyzeAlbumBloc: no readable files in "${event.album.name}", '
            'UploadImagesBatchService will NOT be called.',
          );
          emit(
            AnalyzeAlbumFailed(
              errorMessage: 'No photos could be read from this album.',
            ),
          );
          return;
        }

        final deviceIdentifier =
            await SharedPreferencesService.getDeviceIdentifier();
        log(
          'AnalyzeAlbumBloc: device identifier saved = '
          '${deviceIdentifier != null} (${deviceIdentifier ?? "none"})',
        );

        if (deviceIdentifier == null) {
          emit(
            AnalyzeAlbumFailed(
              errorMessage:
                  'Device is not registered yet. Please restart the app and try again.',
            ),
          );
          return;
        }

        final uploadImagesModel = UploadImagesModel(
          files: files,
          captureTimes: captureTimes,
        );

        log(
          'AnalyzeAlbumBloc: calling UploadImagesBatchService.uploadImages '
          'with ${files.length} file(s) for album "${event.album.name}"',
        );

        await _uploadImagesBatchService.uploadImages(
          uploadImagesModel: uploadImagesModel,
          onSendProgress: (sent, total) {
            if (total <= 0 || isClosed) return;

            emit(
              AnalyzeAlbumInProgress(
                progress: ((sent / total) * 100).round(),
              ),
            );
          },
        );

        log(
          'AnalyzeAlbumBloc: UploadImagesBatchService.uploadImages call '
          'completed successfully for album "${event.album.name}"',
        );

        emit(AnalyzeAlbumCompleted());
      } on ServerException catch (e) {
        emit(AnalyzeAlbumFailed(errorMessage: e.errorModel.errorMessage));
      }
    });
  }

  final UploadImagesBatchService _uploadImagesBatchService;
}