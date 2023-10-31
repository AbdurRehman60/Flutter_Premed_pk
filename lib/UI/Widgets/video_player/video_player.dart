import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/widgets/video_player/simple_ui.dart';

class VideoScreen extends StatefulWidget {
  final String url;

  VideoScreen({required this.url});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final FijkPlayer player = FijkPlayer();

  _VideoScreenState();

  @override
  void initState() {
    super.initState();
    player.setOption(FijkOption.hostCategory, "enable-snapshot", 1);
    player.setOption(FijkOption.playerCategory, "mediacodec-all-videos", 1);
    startPlay();
  }

  void startPlay() async {
    await player.setOption(FijkOption.hostCategory, "request-screen-on", 1);
    await player.setOption(FijkOption.hostCategory, "request-audio-focus", 1);
    await player.setDataSource(widget.url, autoPlay: true).catchError((e) {
      print("setDataSource error: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: FijkView(
        player: player,
        // panelBuilder: fijkPanel2Builder(snapShot: true),
        fsFit: FijkFit.fill,
        // panelBuilder: simplestUI,
        panelBuilder: (FijkPlayer player, FijkData data, BuildContext context,
            Size viewSize, Rect texturePos) {
          return CustomFijkPanel(
              player: player,
              data: data,
              buildContext: context,
              viewSize: viewSize,
              texturePos: texturePos);
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }
}























// class VideoPlayerView extends StatefulWidget {
//   const VideoPlayerView({
//     super.key,
//     required this.url,
//     required this.dataSourceType,
//   });

//   final String url;

//   final DataSourceType dataSourceType;

//   @override
//   State<VideoPlayerView> createState() => _VideoPlayerViewState();
// }

// class _VideoPlayerViewState extends State<VideoPlayerView> {
//   VideoPlayerController? _videoPlayerController;

//   ChewieController? _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     var a = Uri.parse(widget.url);
//     print("😂: ${a}");
//     switch (widget.dataSourceType) {
//       case DataSourceType.asset:
//         _videoPlayerController = VideoPlayerController.asset(widget.url);
//         break;
//       case DataSourceType.network:
//         _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
//             "https://ik.imagekit.io/jmy6cvdju/030b6e25-b5c8-4016-a0d5-866843ab205c.mp4"));
//         break;
//       case DataSourceType.file:
//         _videoPlayerController = VideoPlayerController.file(File(widget.url));
//         break;
//       case DataSourceType.contentUri:
//         _videoPlayerController =
//             VideoPlayerController.contentUri(Uri.parse(widget.url));
//         break;
//     }

//     _videoPlayerController?.initialize().then(
//           (_) => setState(
//             () => _chewieController = ChewieController(
//               videoPlayerController: _videoPlayerController!,
//               aspectRatio: 16 / 9,
//             ),
//           ),
//         );
//   }

//   @override
//   void dispose() {
//     _videoPlayerController?.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         AspectRatio(
//             aspectRatio: 16 / 9,
//             child: _chewieController != null && _videoPlayerController != null
//                 ? Chewie(controller: _chewieController!)
//                 : Center(child: Text('loading'))),
//       ],
//     );
//   }
// }
