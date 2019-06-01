import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

// A screen that takes in a list of Cameras and the Directory to store images.
class TakePicturePage extends StatefulWidget {
  CameraDescription camera;

/*
  const TakePicturePage({
    Key key,
    @required this.camera,
  }) : super(key: key);
*/

  @override
  TakePicturePageState createState() => TakePicturePageState();
}

class TakePicturePageState extends State<TakePicturePage> {
  // Add two variables to the state class to store the CameraController and
  // the Future
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Obtain a list of the available cameras on the device.
    availableCameras().then((cameras) {
      // Get a specific camera from the list of available cameras
      final firstCamera = cameras.first;

      // In order to display the current output from the Camera, you need to
      // create a CameraController.
      _controller = CameraController(
        // Get a specific camera from the list of available cameras
        firstCamera,
        // Define the resolution to use
        ResolutionPreset.medium,
        enableAudio: false,
      );

      // Next, you need to initialize the controller. This returns a Future
      _initializeControllerFuture = _controller.initialize();

      // If we need to rebuild the widget with the resulting data,
      // make sure to use `setState`
      setState(() {
        widget.camera = firstCamera;
      });
    });
  }

  @override
  void dispose() {
    // Make sure to dispose of the controller when the Widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // You must wait until the controller is initialized before displaying the
    // camera preview. Use a FutureBuilder to display a loading spinner until the
    // controller has finished initializing
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview
          return CameraPreview(_controller);
        } else {
          // Otherwise, display a loading indicator
          return Center(child: CircularProgressIndicator());
        }
      },
    );    
  }
}