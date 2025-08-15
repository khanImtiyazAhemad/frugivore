import 'dart:io';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/custom.dart';

import 'package:image_picker/image_picker.dart';

import 'package:frugivore/models/help/subTopicDetail.dart';

import 'package:frugivore/controllers/help/helpDetail.dart';

class PickerController extends GetxController {
  final picker = ImagePicker();
  void openGallery(image) async {
    final image0 =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    image = File(image0!.path);
    if (Get.currentRoute.contains("/help-detail")) {
      final instance = HelpDetailController();
      await instance.sendAttachment(image);
    }
    Get.close(1);
  }

  void openCamera(image) async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    String currentRoute = Get.currentRoute;
    Navigator.push(
        Get.context!,
        MaterialPageRoute(
            builder: (context) =>
                TakePictureScreen(camera: firstCamera, pageUrl: currentRoute)));
  }


  @override
  void onClose() {
    super.dispose();
  }
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  final String pageUrl;
  final int? index;
  final List<Object>? images;

  const TakePictureScreen(
      {super.key, 
      required this.camera,
      required this.pageUrl,
      this.index,
      this.images});

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final scale = 1 /
                (_controller.value.aspectRatio *
                    MediaQuery.of(context).size.aspectRatio);
            return Transform.scale(
              scale: scale,
              alignment: Alignment.topCenter,
              child: CameraPreview(_controller),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DisplayPictureScreen(
                        imagePath: image.path,
                        pageUrl: widget.pageUrl,
                        index: widget.index,
                        images: widget.images)));
          } catch (e) {
            throw Exception(e.toString());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final String pageUrl;
  final int? index;
  final List<Object>? images;

  const DisplayPictureScreen(
      {super.key, required this.imagePath, required this.pageUrl, this.index, this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.file(File(imagePath), fit: BoxFit.fitHeight),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 40,
                  padding: plr10,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: customElevatedButton(darkGrey, whiteColor),
                      onPressed: () => Get.back(),
                      child: Text("Take New")),
                ),
                SizedBox(height: 20),
                Container(
                  height: 40,
                  padding: plr10,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: customElevatedButton(pinkColor, whiteColor),
                      onPressed: () async {
                        Get.close(2);
                        if (pageUrl.contains("/help-detail")) {
                          final instance = HelpDetailController();
                          await instance.sendAttachment(File(imagePath));
                        } else if (pageUrl.contains("/help-subtopic-detail")) {
                          ImageUploadModel imageUpload = ImageUploadModel();
                          imageUpload.isUploaded = false;
                          imageUpload.uploading = false;
                          imageUpload.imageFile = File(imagePath);
                          imageUpload.imageUrl = imagePath;
                          imageUpload.productName = images![index!].toString();
                          images!.replaceRange(index!, index! + 1, [imageUpload]);
                        }
                        Get.close(1);
                      },
                      child: Text("Upload Image")),
                ),
                SizedBox(height: 10)
              ],
            ),
          ],
        ));
  }
}
