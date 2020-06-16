import 'dart:io';

import 'package:Valoguide/core/constants/adMob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class VideoPlayer extends StatefulWidget {
  final String clipID;

  const VideoPlayer({Key key, @required this.clipID}) : super(key: key);
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  PlayerState _playerState;
  YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  YoutubeMetaData _videoMetaData;

  final GlobalKey<_VideoPlayerState> playerGlobalKey = new GlobalKey();
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        controlsVisibleAtStart: false,
      ),
    )..addListener(listener);
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = YoutubeMetaData();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.only(left: 10, right: 10),
      width: MediaQuery.of(context).size.width,
      color: Colors.black45.withOpacity(0.8),
      child: YoutubePlayer(
        thumbnail: Image.asset('assets/images/background/loading.png'),
        controller: _controller,
        onReady: () {
          _isPlayerReady = true;
          _controller.addListener(listener);
          _controller.load(widget.clipID);
        },
        onEnded: (data) {
          _controller.reset();
          DefaultCacheManager().emptyCache();
          Ads?.showInterstitialAd();
          Navigator.pop(context);
        },
        showVideoProgressIndicator: false,
      ),
    );
  }
}
