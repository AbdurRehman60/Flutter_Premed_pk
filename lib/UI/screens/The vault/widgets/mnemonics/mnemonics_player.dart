import 'package:chewie/chewie.dart';
import 'package:flutter_svg/svg.dart';
import 'package:premedpk_mobile_app/models/mnemonics_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import '../../../../../constants/constants_export.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.mnemonicsModel});
  final MnemonicsModel mnemonicsModel;

  @override
  VideoScreenState createState() => VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _shareVideo() async {
    if (widget.mnemonicsModel.videoUrl!.isNotEmpty) {
      await Share.shareUri(Uri.parse(widget.mnemonicsModel.videoUrl!));
    }
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.mnemonicsModel.videoUrl!));
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showOptions: false,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _chewieController != null &&
                            _chewieController!
                                .videoPlayerController.value.isInitialized
                        ? Chewie(
                            controller: _chewieController!,
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.mnemonicsModel.subject} | ${widget.mnemonicsModel.topicName}',
                                    style: PreMedTextTheme().heading1.copyWith(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                  ),
                                  SizedBoxes.vertical3Px,
                                  Text(
                                    widget.mnemonicsModel.subTopicName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2, // Adjust as needed
                                    style: PreMedTextTheme().heading1.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: SvgPicture.asset(
                                  'assets/images/vault/Share Button.svg'),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                _shareVideo();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 11.0,
              right: 10.0,
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/images/vault/Close Button.svg',
                  height: 34,
                  width: 34,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
