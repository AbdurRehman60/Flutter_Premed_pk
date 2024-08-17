import 'package:chewie/chewie.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../../../../constants/constants_export.dart';
import '../../../../../models/mnemonics_model.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    super.key,
    required this.mnemonicsModels,
    required this.initialIndex,
  });

  final List<MnemonicsModel> mnemonicsModels;
  final int initialIndex;

  @override
  VideoScreenState createState() => VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: widget.mnemonicsModels.length,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return VideoPlayerWidget(
              mnemonicsModel: widget.mnemonicsModels[index],
            );
          },
        ),
      ),
    );
  }
}


class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key, required this.mnemonicsModel});
  final MnemonicsModel mnemonicsModel;

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
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

  Future<void> _shareVideo() async {
    final String videoUrl = widget.mnemonicsModel.videoUrl ?? '';
    final String urlToShare = videoUrl.isNotEmpty
        ? videoUrl
        : widget.mnemonicsModel.thumbnailUrl;

    final String videoName = widget.mnemonicsModel.subTopicName;
    final String message = 'Check out this video: $videoName\n$urlToShare';
    await Share.share(message);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: widget.mnemonicsModel.videoUrl!.isNotEmpty
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _chewieController != null &&
                    _chewieController!.videoPlayerController.value
                        .isInitialized
                    ? Chewie(
                  controller: _chewieController!,
                )
                    : const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              _buildVideoInfo(context),
            ],
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.network(
                    widget.mnemonicsModel.thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _buildVideoInfo(context),
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
    );
  }

  Widget _buildVideoInfo(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.6),
            Colors.transparent,
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
                      maxLines: 2,
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
    );
  }
}

