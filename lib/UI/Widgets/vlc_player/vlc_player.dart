import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import 'package:path_provider/path_provider.dart';
import 'package:premedpk_mobile_app/UI/widgets/vlc_player/vlc_player_with_controls.dart';

class CustomVLCPlayer extends StatefulWidget {
  const CustomVLCPlayer({super.key, required this.url});

  final String url;
  @override
  _CustomVLCPlayerState createState() => _CustomVLCPlayerState();
}

class _CustomVLCPlayerState extends State<CustomVLCPlayer> {
  static const _networkCachingMs = 2000;
  static const _subtitlesFontSize = 30;
  static const _height = 400.0;

  final _key = GlobalKey<VlcPlayerWithControlsState>();

  // ignore: avoid-late-keyword
  late final VlcPlayerController _controller;

  //

  int selectedVideoIndex = 0;

  Future<File> _loadVideoToFs() async {
    final videoData = await rootBundle.load('assets/sample.mp4');
    final videoBytes = Uint8List.view(videoData.buffer);
    final dir = (await getTemporaryDirectory()).path;
    final temp = File('$dir/temp.file');
    temp.writeAsBytesSync(videoBytes);

    return temp;
  }

  @override
  void initState() {
    super.initState();

    //

    _controller = VlcPlayerController.network(
      widget.url,
      hwAcc: HwAcc.full,
      options: VlcPlayerOptions(
        advanced: VlcAdvancedOptions([
          VlcAdvancedOptions.networkCaching(_networkCachingMs),
        ]),
        subtitle: VlcSubtitleOptions([
          VlcSubtitleOptions.boldStyle(true),
          VlcSubtitleOptions.fontSize(_subtitlesFontSize),
          VlcSubtitleOptions.outlineColor(VlcSubtitleColor.yellow),
          VlcSubtitleOptions.outlineThickness(VlcSubtitleThickness.normal),
          // works only on externally added subtitles
          VlcSubtitleOptions.color(VlcSubtitleColor.navy),
        ]),
        http: VlcHttpOptions([
          VlcHttpOptions.httpReconnect(true),
        ]),
        rtp: VlcRtpOptions([
          VlcRtpOptions.rtpOverRtsp(true),
        ]),
      ),
    );

    _controller.addOnInitListener(() async {
      await _controller.startRendererScanning();
    });
    _controller.addOnRendererEventListener((type, id, name) {
      debugPrint('OnRendererEventListener $type $id $name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: VlcPlayerWithControls(
        key: _key,
        controller: _controller,
        // onStopRecording: (recordPath) {
        //   setState(() {
        //     listVideos.add(
        //       VideoData(
        //         name: 'Recorded Video',
        //         path: recordPath,
        //         type: VideoType.recorded,
        //       ),
        //     );
        //   });
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //       content: Text(
        //         'The recorded video file has been added to the end of list.',
        //       ),
        //     ),
        //   );
        // },
      ),
    );
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _controller.stopRecording();
    await _controller.stopRendererScanning();
    await _controller.dispose();
  }
}
