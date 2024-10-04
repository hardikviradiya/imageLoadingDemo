import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_loading_demo/models/image_model.dart';
import 'package:shimmer/shimmer.dart';

class FullImage extends StatelessWidget {
  final ImageModel imageData;

  const FullImage({super.key, required this.imageData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: const Text("Full Image"),
          centerTitle: true,
        ),
        body: Center(
          child: AspectRatio(
              aspectRatio: imageData.width /
                  imageData.height, // Maintain original aspect ratio
              child: CachedNetworkImage(
                imageUrl: imageData.url,
                fit: BoxFit.cover, // Cover the available space
                placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors
                          .grey[300], // The placeholder color during loading
                    )),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )),
        ));
  }
}
