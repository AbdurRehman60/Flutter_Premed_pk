import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({
    super.key,
    required this.url,
    required this.dataSourceType,
  });

  final String url;

  final DataSourceType dataSourceType;

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  VideoPlayerController? _videoPlayerController;

  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    print("😂: ${Uri.parse(widget.url)}");
    switch (widget.dataSourceType) {
      case DataSourceType.asset:
        _videoPlayerController = VideoPlayerController.asset(widget.url);
        break;
      case DataSourceType.network:
        _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
            "https://premedpk-cdn.sgp1.cdn.digitaloceanspaces.com/Videos/015455df-7fc0-4da1-8e2b-23017382ad3e.mp4"));
        break;
      case DataSourceType.file:
        _videoPlayerController = VideoPlayerController.file(File(widget.url));
        break;
      case DataSourceType.contentUri:
        _videoPlayerController =
            VideoPlayerController.contentUri(Uri.parse(widget.url));
        break;
    }

    _videoPlayerController?.initialize().then(
          (_) => setState(
            () => _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController!,
              aspectRatio: 16 / 9,
            ),
          ),
        );
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
            aspectRatio: 16 / 9,
            child: _chewieController != null && _videoPlayerController != null
                ? Chewie(controller: _chewieController!)
                : Center(child: Text('loading'))),
      ],
    );
  }
}
