import 'dart:async';
import 'dart:math';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:premedpk_mobile_app/export.dart';

class CustomFijkPanel extends StatefulWidget {
  final FijkPlayer player;
  final FijkData data;
  final BuildContext buildContext;
  final Size viewSize;
  final Rect texturePos;

  const CustomFijkPanel({
    required this.player,
    required this.data,
    required this.buildContext,
    required this.viewSize,
    required this.texturePos,
  });

  @override
  _CustomFijkPanelState createState() => _CustomFijkPanelState();
}

class _CustomFijkPanelState extends State<CustomFijkPanel> {
  FijkPlayer get player => widget.player;
  bool _playing = false;
  double _sliderValue = 0.0;
  double _sliderMax = 0.0; // Maximum slider value
  late Timer _sliderUpdateTimer;

  @override
  void initState() {
    super.initState();
    widget.player.addListener(_playerValueChanged);
  }

  void _playerValueChanged() {
    FijkValue value = player.value;

    bool playing = (value.state == FijkState.started);
    if (playing != _playing) {
      setState(() {
        _sliderValue = player.currentPos.inMilliseconds.toDouble();
        _playing = playing;
      });
    }

    if (_sliderMax == 0.0 && value.prepared) {
      // Set the maximum slider value when you have the duration information.
      setState(() {
        _sliderMax = value.duration.inMilliseconds.toDouble();
      });
    }
  }

  void skipForward() {
    final currentPosition = player.currentPos.inMilliseconds;
    final targetPosition =
        currentPosition + 10000; // 10 seconds in milliseconds
    player.seekTo(targetPosition);
  }

  void skipBackward() {
    final currentPosition = player.currentPos.inMilliseconds;
    final targetPosition =
        currentPosition - 10000; // 10 seconds in milliseconds
    player.seekTo(targetPosition);
  }

  @override
  Widget build(BuildContext context) {
    Rect rect = Rect.fromLTRB(
        max(0.0, widget.texturePos.left),
        max(0.0, widget.texturePos.top),
        min(widget.viewSize.width, widget.texturePos.right),
        min(widget.viewSize.height, widget.texturePos.bottom));

    return Positioned.fromRect(
      rect: rect,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            child: IconButton(
              icon: Icon(
                _playing ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () {
                _playing ? widget.player.pause() : widget.player.start();
              },
            ),
          ),

          // Slider(
          //   value: _sliderValue,
          //   min: 0.0,
          //   max: _sliderMax, // Set the maximum slider value
          //   onChanged: (double value) {
          //     setState(() {
          //       _sliderValue = value;
          //     });
          //   },
          //   onChangeEnd: (double value) {
          //     final positionInMilliseconds = value.toInt();
          //     player.seekTo(positionInMilliseconds);
          //   },
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     IconButton(
          //       icon: Icon(
          //         Icons.replay_10, // Icon for skip backward
          //         color: Colors.red,
          //       ),
          //       onPressed: skipBackward,
          //     ),
          //     IconButton(
          //       icon: Icon(
          //         _playing ? Icons.pause : Icons.play_arrow,
          //         color: const Color.fromRGBO(255, 255, 255, 1),
          //       ),
          //       onPressed: () {
          //         _playing ? widget.player.pause() : widget.player.start();
          //       },
          //     ),
          //     IconButton(
          //       icon: Icon(
          //         Icons.forward_10, // Icon for skip forward
          //         color: Colors.red,
          //       ),
          //       onPressed: skipForward,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.removeListener(_playerValueChanged);
    _sliderUpdateTimer.cancel();
  }
}
