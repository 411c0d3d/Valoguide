import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerView extends StatefulWidget {
  final String clipID;
  final String thumbnail;

  const VideoPlayerView(
      {Key key, @required this.clipID, @required this.thumbnail})
      : super(key: key);
  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  final GlobalKey<_VideoPlayerViewState> playerGlobalKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.clipID);
    _chewieController = ChewieController(
      materialProgressColors: ChewieProgressColors(
          playedColor: Color(0xFF711527),
          bufferedColor: Color(0xFF460C20),
          backgroundColor: Colors.black.withOpacity(0.7),
          handleColor: Color(0xFFEA2546)),
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      autoInitialize: true,
      placeholder: Container(
        color: Colors.black,
      ),
    );
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: EdgeInsets.only(left: 15, right: 15),
        width: MediaQuery.of(context).size.width,
        color: Colors.black45.withOpacity(0.5),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
          ],
        ));
  }
}
