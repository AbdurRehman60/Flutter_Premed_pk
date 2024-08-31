import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import 'package:premedpk_mobile_app/UI/widgets/vlc_player/controls_overlay.dart';
import 'package:provider/provider.dart';

import '../../../constants/color_theme.dart';
import '../../../providers/vaultProviders/premed_provider.dart';

typedef OnStopRecordingCallback = void Function(String);

class VlcPlayerWithControls extends StatefulWidget {
  const VlcPlayerWithControls({
    required this.controller,
    this.showControls = true,
    this.onStopRecording,
    super.key,
  });
  final VlcPlayerController controller;
  final bool showControls;
  final OnStopRecordingCallback? onStopRecording;

  @override
  VlcPlayerWithControlsState createState() => VlcPlayerWithControlsState();
}

class VlcPlayerWithControlsState extends State<VlcPlayerWithControls> {
  static const _playerControlsBgColor = Colors.black87;
  static const _recordingPositionOffset = 10.0;
  static const _positionedBottomSpace = 7.0;
  static const _positionedRightSpace = 3.0;
  static const _overlayWidth = 100.0;
  static const _elevation = 4.0;
  static const _aspectRatio = 16 / 9;

  final double initSnapshotRightPosition = 10;
  final double initSnapshotBottomPosition = 10;

  // ignore: avoid-late-keyword
  late VlcPlayerController _controller;

  //
  OverlayEntry? _overlayEntry;

  //
  double sliderValue = 0.0;
  double volumeValue = 50;
  String position = '';
  String duration = '';
  int numberOfCaptions = 0;
  int numberOfAudioTracks = 0;
  bool validPosition = false;

  double recordingTextOpacity = 0;
  DateTime lastRecordingShowTime = DateTime.now();
  bool isRecording = false;
  late bool isFullScreen;
  //
  List<double> playbackSpeeds = [1.0, 2.0];
  int playbackSpeedIndex = 1;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller.addListener(listener);
  }

  void listener() {
    if (!mounted) {
      return;
    }
    //
    if (_controller.value.isInitialized) {
      final oPosition = _controller.value.position;
      final oDuration = _controller.value.duration;
      if (oDuration.inHours == 0) {
        final strPosition = oPosition.toString().split('.').first;
        final strDuration = oDuration.toString().split('.').first;
        setState(() {
          position =
              "${strPosition.split(':')[1]}:${strPosition.split(':')[2]}";
          duration =
              "${strDuration.split(':')[1]}:${strDuration.split(':')[2]}";
        });
      } else {
        setState(() {
          position = oPosition.toString().split('.').first;
          duration = oDuration.toString().split('.').first;
        });
      }
      setState(() {
        validPosition = oDuration.compareTo(oPosition) >= 0;
        sliderValue = validPosition ? oPosition.inSeconds.toDouble() : 0;
      });
      setState(() {
        numberOfCaptions = _controller.value.spuTracksCount;
        numberOfAudioTracks = _controller.value.audioTracksCount;
      });

      if (_controller.value.isRecording && _controller.value.isPlaying) {
        if (DateTime.now().difference(lastRecordingShowTime).inSeconds >= 1) {
          setState(() {
            lastRecordingShowTime = DateTime.now();
            recordingTextOpacity = 1 - recordingTextOpacity;
          });
        }
      } else {
        setState(() => recordingTextOpacity = 0);
      }

      if (isRecording != _controller.value.isRecording) {
        setState(() => isRecording = _controller.value.isRecording);
        if (!isRecording) {
          widget.onStopRecording?.call(_controller.value.recordPath);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    isFullScreen = MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ColoredBox(
            color: Colors.black,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Center(
                  child: VlcPlayer(
                    controller: _controller,
                    aspectRatio: _aspectRatio,
                    placeholder:
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
                Positioned(
                  top: _recordingPositionOffset,
                  left: _recordingPositionOffset,
                  child: AnimatedOpacity(
                    opacity: recordingTextOpacity,
                    duration: const Duration(seconds: 1),
                    child: const Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(Icons.circle, color: Colors.red),
                        SizedBox(width: 5),
                        Text(
                          'REC',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ControlsOverlay(controller: _controller),
              ],
            ),
          ),
        ),
        Visibility(
          visible: widget.showControls,
          child: ColoredBox(
            color: _playerControlsBgColor,
            child: Row(
              children: [
                IconButton(
                  color: Colors.white,
                  icon: _controller.value.isPlaying
                      ? const Icon(Icons.pause_circle_outline)
                      : const Icon(Icons.play_circle_outline),
                  onPressed: _togglePlaying,
                ),
                Expanded(
                  child: Container(
                    color: _playerControlsBgColor,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.volume_down,
                          color: Colors.white,
                        ),
                        Expanded(
                          child: Slider(
                            activeColor: Provider.of<PreMedProvider>(context).isPreMed
                                ? PreMedColorTheme().red
                                : PreMedColorTheme().blue,
                            max: _overlayWidth,
                            value: volumeValue,
                            onChanged: _setSoundVolume,
                          ),
                        ),
                        const Icon(
                          Icons.volume_up,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.timer),
                      color: Colors.white,
                      onPressed: _cyclePlaybackSpeed,
                    ),
                    Positioned(
                      bottom: _positionedBottomSpace,
                      right: _positionedRightSpace,
                      child: IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(1),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 1,
                            horizontal: 2,
                          ),
                          child: Text(
                            '${playbackSpeeds.elementAt(playbackSpeedIndex)}x',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.fullscreen),
                  color: Colors.white,
                  onPressed: _toggleFullScreen,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.removeListener(listener);
    super.dispose();
  }

  Future<void> _cyclePlaybackSpeed() async {
    playbackSpeedIndex++;
    if (playbackSpeedIndex >= playbackSpeeds.length) {
      playbackSpeedIndex = 0;
    }

    return _controller
        .setPlaybackSpeed(playbackSpeeds.elementAt(playbackSpeedIndex));
  }

  void _setSoundVolume(double value) {
    setState(() {
      volumeValue = value;
    });
    _controller.setVolume(volumeValue.toInt());
  }

  Future<void> _togglePlaying() async {
    _controller.value.isPlaying
        ? await _controller.pause()
        : await _controller.play();
  }

  // ignore: unused_element
  void _onSliderPositionChanged(double progress) {
    setState(() {
      sliderValue = progress.floor().toDouble();
    });
    //convert to Milliseconds since VLC requires MS to set time
    _controller.setTime(sliderValue.toInt() * Duration.millisecondsPerSecond);
  }

  // ignore: unused_element
  Future<void> _createCameraImage() async {
    final snapshot = await _controller.takeSnapshot();

    _overlayEntry?.remove();
    _overlayEntry = _createSnapshotThumbnail(snapshot);

    if (!mounted) {
      return;
    }

    // ignore: avoid-non-null-assertion
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createSnapshotThumbnail(Uint8List snapshot) {
    double right = initSnapshotRightPosition;
    double bottom = initSnapshotBottomPosition;

    return OverlayEntry(
      builder: (context) => Positioned(
        right: right,
        bottom: bottom,
        width: _overlayWidth,
        child: Material(
          elevation: _elevation,
          child: GestureDetector(
            onTap: () async {
              _overlayEntry?.remove();
              _overlayEntry = null;
              await showDialog<void>(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    content: Image.memory(snapshot),
                  );
                },
              );
            },
            onVerticalDragUpdate: (dragUpdateDetails) {
              bottom -= dragUpdateDetails.delta.dy;
              _overlayEntry?.markNeedsBuild();
            },
            onHorizontalDragUpdate: (dragUpdateDetails) {
              right -= dragUpdateDetails.delta.dx;
              _overlayEntry?.markNeedsBuild();
            },
            onHorizontalDragEnd: (dragEndDetails) {
              if ((initSnapshotRightPosition - right).abs() >= _overlayWidth) {
                _overlayEntry?.remove();
                _overlayEntry = null;
              } else {
                right = initSnapshotRightPosition;
                _overlayEntry?.markNeedsBuild();
              }
            },
            onVerticalDragEnd: (dragEndDetails) {
              if ((initSnapshotBottomPosition - bottom).abs() >=
                  _overlayWidth) {
                _overlayEntry?.remove();
                _overlayEntry = null;
              } else {
                bottom = initSnapshotBottomPosition;
                _overlayEntry?.markNeedsBuild();
              }
            },
            child: Image.memory(snapshot),
          ),
        ),
      ),
    );
  }

  Future<void> _toggleFullScreen() async {
    if (isFullScreen) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }

    setState(() {
      isFullScreen = !isFullScreen;
    });
  }
}
