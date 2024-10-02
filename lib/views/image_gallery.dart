import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../view_models/image_gallery_viewmodel.dart';
import '../widgets/image_grid_tile.dart';

class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key});

  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  bool _isInit = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      _isInit = false;

      // Schedule the loadImages call after the first frame is rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<ImageGalleryViewModel>(context, listen: false)
            .fetchImages();
      });

      // Set up pagination by listening to the scroll position
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          // Load more images when scrolled to the bottom
          Provider.of<ImageGalleryViewModel>(context, listen: false)
              .fetchImages();
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController
        .dispose(); // Always dispose the controller to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Gallery')),
      body: Consumer<ImageGalleryViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.images.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return MasonryGridView.count(
            crossAxisCount:
                _calculateCrossAxisCount(context), // Number of columns
            mainAxisSpacing: 4.0, // Space between rows
            crossAxisSpacing: 4.0,
            controller: _scrollController, // Attach the scroll controller
            itemCount: viewModel.images.length,
            itemBuilder: (context, index) {
              final image = viewModel.images[index];
              return ImageGridTile(image: image);
            },
          );
        },
      ),
    );
  }

  int _calculateCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 1200) return 5;
    if (screenWidth >= 900) return 4;
    if (screenWidth >= 600) return 3;
    return 2;
  }
}
