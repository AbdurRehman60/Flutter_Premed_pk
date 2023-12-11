import 'package:chewie/chewie.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoLink;

  const VideoPlayerWidget({
    super.key,
    required this.videoLink,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    // Initialize the video player controller using networkUrl
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
          "https://premedpk-cdn.sgp1.digitaloceanspaces.com/Videos/2d42438a-d47b-4b47-8ab5-77437120930b.mp4"),
    );

    // Initialize the Chewie controller
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(errorMessage),
        );
      },
    );

    _videoPlayerController.initialize().then((_) {
      // Ensure the first frame is shown, even before the video starts playing.
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: _chewieController);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
