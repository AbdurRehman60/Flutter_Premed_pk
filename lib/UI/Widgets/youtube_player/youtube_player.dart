import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyYoutubePlayer extends StatefulWidget {
  const MyYoutubePlayer({super.key});

  @override
  State<MyYoutubePlayer> createState() => _MyYoutubePlayerState();
}

class _MyYoutubePlayerState extends State<MyYoutubePlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'POOAMMej1xU',
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          topActions: [],
          progressIndicatorColor: PreMedColorTheme().primaryColorRed,
          progressColors: ProgressBarColors(
            playedColor: PreMedColorTheme().primaryColorRed,
            handleColor: PreMedColorTheme().primaryColorRed100,
          ),
          onReady: () {
            _controller.addListener(() {});
          },
        ),
        builder: (context, player) => player,
      ),
    );
  }
}
