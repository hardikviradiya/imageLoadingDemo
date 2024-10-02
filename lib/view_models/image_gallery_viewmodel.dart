import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_loading_demo/models/image_model.dart';
import 'package:image_loading_demo/services/image_service.dart';

class ImageGalleryViewModel extends ChangeNotifier {
  final ImageService _imageService;
  final List<ImageModel> _images = [];
  bool _isLoading = false;
  int _page = 1;

  List<ImageModel> get images => _images;
  bool get isLoading => _isLoading;

  ImageGalleryViewModel(this._imageService);

  Future<void> fetchImages() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newImages = await _imageService.fetchImages(_page);
      _images.addAll(newImages);
      _page++;
    } catch (e) {
      log('Error fetching images: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
