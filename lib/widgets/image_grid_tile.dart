import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_loading_demo/models/image_model.dart';
import 'package:shimmer/shimmer.dart';

class ImageGridTile extends StatelessWidget {
  final ImageModel image;

  const ImageGridTile({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio:
            image.width / image.height, // Maintain original aspect ratio
        child: Stack(children: [
          CachedNetworkImage(
            imageUrl: image.url,
            fit: BoxFit.cover, // Cover the available space
            placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color:
                      Colors.grey[300], // The placeholder color during loading
                )),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ), // Positioned like and views overlay
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.5)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.favorite,
                                color: Colors.red, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${image.likes}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Row(children: [
                          const Icon(Icons.visibility,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text('${image.views}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ))
                        ])
                      ])))
        ]));
  }
}
