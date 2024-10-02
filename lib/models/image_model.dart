class ImageModel {
  final String url; // URL of the image
  final int width; // Width of the image
  final int height; // Height of the image
  final int likes; // Number of likes for the image
  final int views; // Number of views for the image

  ImageModel({
    required this.url,
    required this.width,
    required this.height,
    required this.likes,
    required this.views,
  });

  /// Factory method to create an ImageModel instance from JSON data.
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      url: json['webformatURL'], // webformatURL from the API response
      width: json['imageWidth'], // Width from the API response
      height: json['imageHeight'], // Height from the API response
      likes: json['likes'] ??
          0, // Provide a default value if likes are not available
      views: json['views'] ??
          0, // Provide a default value if views are not available
    );
  }
}
