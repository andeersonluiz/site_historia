/// Widget responsável por exibir o conteúdo em quadros que possuam video.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library VideoViewer;
import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';


class VideoViewer extends StatefulWidget {
  final String urlVideo;
  VideoViewer(this.urlVideo);

  @override
  _VideoViewerState createState() => _VideoViewerState();
}

/// Caso seja um arquivo salvo ele utiliza o `chewieController` para capturar a url no banco de dados, caso
/// seja um vídeo do youtube, é utilizado um outro widget para exibi-lo.
class _VideoViewerState extends State<VideoViewer> {
  ChewieController? chewieController;
  bool playerIsNull = true;
  @override
  void initState() {
    super.initState();
    if (!widget.urlVideo.contains("youtube")) {
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
          "Assista ao vídeo:",
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
              width: 500,
              height: 500,
              margin: EdgeInsets.only(
                  left: 70.0, right: 70.0, top: 8.0, bottom: 8.0),
              child: ytPlayer(
                widget.urlVideo.split("https://www.youtube.com/watch?v=")[1],
              ),
            )
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showDialog(context, videoID) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return YoutubeViewer(
          videoID,
        );
      },
    );
  }

  Widget ytPlayer(videoID) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _showDialog(
            context,
            videoID,
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (kIsWeb && constraints.maxWidth > 800) {
                      return Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width / 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: new Image.network(
                            YoutubePlayerController.getThumbnail(
                                videoId: videoID,
                                // todo: get thumbnail quality from list
                                quality: ThumbnailQuality.max,
                                webp: false),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width * 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: new Image.network(
                            YoutubePlayerController.getThumbnail(
                                videoId: videoID,
                                // todo: get thumbnail quality from list
                                quality: ThumbnailQuality.max,
                                webp: false),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            Icon(
              Icons.play_circle_filled,
              color: Colors.white,
              size: 55.0,
            ),
          ],
        ),
      ),
    );
  }
}

class YoutubeViewer extends StatefulWidget {
  final String? videoID;
  YoutubeViewer(this.videoID);
  @override
  _YoutubeViewerState createState() => _YoutubeViewerState();
}

class _YoutubeViewerState extends State<YoutubeViewer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoID!, // livestream example
      params: YoutubePlayerParams(
        //startAt: Duration(minutes: 1, seconds: 5),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        autoPlay: true,
        enableCaption: true,
        showVideoAnnotations: false,
        enableJavaScript: true,
        privacyEnhanced: true,
        useHybridComposition: true,
        playsInline: false,
      ),
    )..listen((value) {
        if (value.isReady && !value.hasPlayed) {
          _controller
            ..hidePauseOverlay()
            ..play()
            ..hideTopMenu();
        }
        if (value.hasPlayed) {
          _controller..hideEndScreen();
        }
      });
    _controller.onExitFullscreen = () {
      Navigator.of(context).pop();
    };
  }

  @override
  Widget build(BuildContext context) {
    final player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      key: UniqueKey(),
      controller: _controller,
      child: AlertDialog(
        insetPadding: EdgeInsets.all(10),
        backgroundColor: Colors.black,
        content: player,
        contentPadding: EdgeInsets.all(0),
        actions: <Widget>[
          new Center(
            child: TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
