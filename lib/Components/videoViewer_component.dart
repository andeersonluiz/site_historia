import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Components/customText_component.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoViewer extends StatefulWidget {
  final String urlVideo;
  VideoViewer(this.urlVideo);

  @override
  _VideoViewerState createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  ChewieController? chewieController;
  YoutubePlayerController? _youtubePlayerController;
  bool playerIsNull = true;
  @override
  void initState() {
    super.initState();
    if (widget.urlVideo.contains("youtube")) {
      _youtubePlayerController = YoutubePlayerController(
        initialVideoId:
            widget.urlVideo.split("https://www.youtube.com/watch?v=")[1],
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          desktopMode: true,
          privacyEnhanced: true,
          useHybridComposition: true,
        ),
      );
    } else {
      chewieController = ChewieController(
          autoPlay: false,
          allowFullScreen: false,
          aspectRatio: 16 / 9,
          videoPlayerController: VideoPlayerController.network(
            widget.urlVideo,
          )..initialize().then((_) {
              // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
              setState(() {
                playerIsNull = false;
              });
            }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(key: Key(widget.urlVideo), children: [
      Padding(
        padding: const EdgeInsets.only(
            left: 8.0, right: 8.0, top: 8.0, bottom: 40.0),
        child: CustomText(
          "Assita ao video:",
          style: Theme.of(context).textTheme.headline5!,
        ),
      ),
      !widget.urlVideo.contains("youtube")
          ? Container(
              margin: EdgeInsets.only(
                  left: 60.0, right: 60.0, top: 8.0, bottom: 8.0),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: !playerIsNull
                    ? Chewie(
                        controller: chewieController!,
                      )
                    : CustomLoading(),
              ),
            )
          : Container(
              margin: EdgeInsets.only(
                  left: 70.0, right: 70.0, top: 8.0, bottom: 8.0),
              child: YoutubePlayerControllerProvider(
                  controller: _youtubePlayerController!,
                  child: YoutubePlayerIFrame(),
              ),
            )
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
