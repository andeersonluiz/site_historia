import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';

class AudioViewer extends StatefulWidget {
  final urlAudio;
  AudioViewer(this.urlAudio);

  @override
  _AudioViewerState createState() => _AudioViewerState();
}

class _AudioViewerState extends State<AudioViewer> {
  final _player = AudioPlayer();

  late Stream<DurationState> _durationState;

  @override
  void initState() {
    super.initState();
    _player.setUrl(widget.urlAudio);
    _durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        _player.positionStream,
        _player.playbackEventStream,
        (position, playbackEvent) => DurationState(
              progress: position,
              buffered: playbackEvent.bufferedPosition,
              total: playbackEvent.duration!,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 128.0),
      padding: EdgeInsets.all(8.0),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 8.0, bottom: 40.0),
          child: CustomText(
            "Ouça o audio:",
            style: Theme.of(context).textTheme.headline5!,
          ),
        ),
        StreamBuilder<DurationState>(
          stream: _durationState,
          builder: (context, snapshot) {
            final durationState = snapshot.data;
            final progress = durationState?.progress ?? Duration.zero;
            final buffered = durationState?.buffered ?? Duration.zero;
            final total = durationState?.total ?? Duration.zero;
            return ProgressBar(
              progress: progress,
              buffered: buffered,
              total: total,
              timeLabelTextStyle: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Theme.of(context).primaryColor),
              bufferedBarColor: Theme.of(context).selectedRowColor,
              progressBarColor: Theme.of(context).primaryColor,
              thumbColor: Theme.of(context).primaryColor,
              onSeek: (duration) {
                _player.seek(duration);
              },
            );
          },
        ),
        StreamBuilder<PlayerState>(
          stream: _player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return CustomLoading();
            } else if (playing != true) {
              return IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  color: Theme.of(context).primaryColor,
                ),
                iconSize: 32.0,
                onPressed: _player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: Icon(
                  Icons.pause,
                  color: Theme.of(context).primaryColor,
                ),
                iconSize: 32.0,
                onPressed: _player.pause,
              );
            } else {
              return IconButton(
                icon: Icon(
                  Icons.replay,
                  color: Theme.of(context).primaryColor,
                ),
                iconSize: 32.0,
                onPressed: () async {
                  await _player.seek(Duration.zero);
                  _player.setUrl(widget.urlAudio);
                },
              );
            }
          },
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}

class DurationState {
  const DurationState(
      {required this.progress, required this.buffered, this.total});
  final Duration progress;
  final Duration buffered;
  final Duration? total;
}
