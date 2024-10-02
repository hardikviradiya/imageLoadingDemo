import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/image_service.dart';
import '../view_models/image_gallery_viewmodel.dart';
import '../views/image_gallery.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ImageGalleryViewModel(ImageService()),
        ),
      ],
      child: MaterialApp(
        title: 'Image Gallery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ImageGallery(),
      ),
    );
  }
}
