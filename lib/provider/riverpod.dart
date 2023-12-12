import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maio_test/database/data/photos.dart';

class PhotosNotifier extends StateNotifier<List<Photos>> {
  PhotosNotifier(super.state);

  void equalJsonData(List<Photos> memoryData) {
    state = memoryData;
  }
}

final List<Photos> dummyData = [];
