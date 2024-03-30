// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/display_image_screen.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/main.dart';

class CameraScreen extends StatefulWidget {
  // final VoidCallback onConfirm;
  const CameraScreen({
    super.key,
    // required this.onConfirm,
  });

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? controller;
  // late Future<void> _initializeControllerFuture;
  File? _imageFile;
  // File? _videoFile;
  // Initial values
  bool _isCameraInitialized = false;
  bool _isCameraPermissionGranted = false;
  // bool _isRearCameraSelected = true;
  // bool _isVideoCameraSelected = false;
  bool _isRecordingInProgress = false;
  // double _minAvailableExposureOffset = 0.0;
  // double _maxAvailableExposureOffset = 0.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;

  // Current values
  double _currentZoomLevel = 1.0;
  // double _currentExposureOffset = 0.0;
  // FlashMode? _currentFlashMode;

  List<File> allFileList = [];
  final resolutionPresets = ResolutionPreset.values;

  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

  Future<void> getPermissionStatus() async {
    await Permission.camera.request();

    final status = await Permission.camera.status;

    if (status.isGranted) {
      print('Camera Permission: GRANTED');
      setState(() {
        _isCameraPermissionGranted = true;
      });

      onNewCameraSelected(cameras[0]);
      refreshAlreadyCapturedImages();
    } else {
      print('Camera Permission: DENIED');
    }
  }

  Future<void> refreshAlreadyCapturedImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> fileList = await directory.list().toList();
    allFileList.clear();
    final List<Map<int, dynamic>> fileNames = [];

    for (final file in fileList) {
      if (file.path.contains('.jpg') || file.path.contains('.mp4')) {
        allFileList.add(File(file.path));

        final String name = file.path.split('/').last.split('.').first;
        fileNames.add({0: int.parse(name), 1: file.path.split('/').last});
      }
    }

    if (fileNames.isNotEmpty) {
      final recentFile =
          fileNames.reduce((curr, next) => curr[0] > next[0] ? curr : next);
      final String recentFileName = recentFile[1];

      _imageFile = File('${directory.path}/$recentFileName');
    }

    setState(() {});
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;

    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }
  }

  // Future<void> _startVideoPlayer() async {
  //   if (_videoFile != null) {
  //     videoController = VideoPlayerController.file(_videoFile!);
  //     await videoController!.initialize().then((_) {
  //       // Ensure the first frame is shown after the video is initialized,
  //       // even before the play button has been pressed.
  //       setState(() {});
  //     });
  //     await videoController!.setLooping(true);
  //     await videoController!.play();
  //   }
  // }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = controller;

    if (controller!.value.isRecordingVideo) {
      // A recording has already started, do nothing.
      return;
    }

    try {
      await cameraController!.startVideoRecording();
      setState(() {
        _isRecordingInProgress = true;
        print(_isRecordingInProgress);
      });
    } on CameraException catch (e) {
      print('Error starting to record video: $e');
    }
  }

  Future<XFile?> stopVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // Recording is already is stopped state
      return null;
    }

    try {
      final XFile file = await controller!.stopVideoRecording();
      setState(() {
        _isRecordingInProgress = false;
      });
      return file;
    } on CameraException catch (e) {
      print('Error stopping video recording: $e');
      return null;
    }
  }

  Future<void> pauseVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // Video recording is not in progress
      return;
    }

    try {
      await controller!.pauseVideoRecording();
    } on CameraException catch (e) {
      print('Error pausing video recording: $e');
    }
  }

  Future<void> resumeVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // No video recording was in progress
      return;
    }

    try {
      await controller!.resumeVideoRecording();
    } on CameraException catch (e) {
      print('Error resuming video recording: $e');
    }
  }

  Future<void> resetCameraValues() async {
    _currentZoomLevel = 1.0;
    // _currentExposureOffset = 0.0;
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;

    final CameraController cameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await previousCameraController?.dispose();

    resetCameraValues();

    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    try {
      await cameraController.initialize();
      await Future.wait([
        // cameraController
        //     .getMinExposureOffset()
        //     .then((value) => _minAvailableExposureOffset = value),
        // cameraController
        //     .getMaxExposureOffset()
        //     .then((value) => _maxAvailableExposureOffset = value),
        cameraController
            .getMaxZoomLevel()
            .then((value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((value) => _minAvailableZoom = value),
      ]);

      // _currentFlashMode = controller!.value.flashMode;
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    controller!.setExposurePoint(offset);
    controller!.setFocusPoint(offset);
  }

  @override
  void initState() {
    getPermissionStatus();
    // refreshAlreadyCapturedImages();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    // videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _isCameraPermissionGranted
            ? _isCameraInitialized
                ? Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: CameraPreview(
                              controller!,
                              child: LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  return GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTapDown: (details) =>
                                        onViewFinderTap(details, constraints),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Center(
                      //   child: Image.asset(
                      //     'assets/camera_aim.png',
                      //     color: Colors.greenAccent,
                      //     width: 150,
                      //     height: 150,
                      //   ),
                      // ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16.0,
                            8.0,
                            16.0,
                            8.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Slider(
                                      value: _currentZoomLevel,
                                      min: _minAvailableZoom,
                                      max: _maxAvailableZoom,
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.white30,
                                      onChanged: (value) async {
                                        setState(() {
                                          _currentZoomLevel = value;
                                        });
                                        await controller!.setZoomLevel(value);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${_currentZoomLevel.toStringAsFixed(1)}x',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      XFile? rawImage;
                                      File imageFile;

                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );

                                      takePicture()
                                          .then((XFile? capturedImage) {
                                        rawImage = capturedImage;
                                        imageFile = File(rawImage!.path);

                                        final int currentUnix = DateTime.now()
                                            .millisecondsSinceEpoch;

                                        getApplicationDocumentsDirectory()
                                            .then((directory) {
                                          final String fileFormat =
                                              imageFile.path.split('.').last;

                                          imageFile
                                              .copy(
                                                  '${directory.path}/$currentUnix.$fileFormat')
                                              .then((_) {
                                            Navigator.of(context).pop();

                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DisplayImageScreen(
                                                  image: imageFile,
                                                ),
                                              ),
                                            );
                                          }).catchError((error) {
                                            print(
                                                'Error copying image: $error');
                                            Navigator.of(context).pop();
                                          });
                                        }).catchError((error) {
                                          print(
                                              'Error getting directory: $error');
                                          Navigator.of(context).pop();
                                        });
                                      }).catchError((error) {
                                        print('Error capturing image: $error');
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    child: const Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          color: Colors.white38,
                                          size: 80,
                                        ),
                                        Icon(
                                          Icons.circle,
                                          color: Colors.white,
                                          size: 65,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        SizedBoxes.verticalBig,
                        Text(
                          'LOADING',
                          style: PreMedTextTheme()
                              .heading4
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Permission denied',
                      style: PreMedTextTheme()
                          .heading4
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    SizedBoxes.verticalMedium,
                    CustomButton(
                      buttonText: 'Give permission',
                      onPressed: () {
                        getPermissionStatus();
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
