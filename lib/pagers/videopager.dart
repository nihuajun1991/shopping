
import 'package:auto_orientation/auto_orientation.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget{
  final String  videouri ;

  const VideoApp({Key key, this.videouri}) : super(key: key);

  @override
  _VideoAppState createState() {

    return _VideoAppState();
  }
}


class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _videoPlayerController1;
  bool _isPlaying = false;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(widget.videouri);

    _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController1,
        aspectRatio: 16 / 9,
        autoPlay: false,
        looping: false,
        placeholder: new Container(
          color: Colors.grey,
        ),
        autoInitialize: !true,
        materialProgressColors: new ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.blue,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightGreen,
        ),
        routePageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondAnimation, provider) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return VideoScaffold(
            child: Scaffold(
              resizeToAvoidBottomPadding: false,
              body: Container(
                alignment: Alignment.center,
                color: Colors.black,
                child: provider,
              ),
            ),
          );
        },
      );
    });
  }


  @override
  void dispose() {
    _videoPlayerController1.dispose();

    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     body: Center(
       child: Chewie(
         controller: _chewieController,
       ),
     ),
    );
  }
}

class VideoScaffold extends StatefulWidget {
  const VideoScaffold({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() => _VideoScaffoldState();
}

class _VideoScaffoldState extends State<VideoScaffold> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    AutoOrientation.landscapeMode();
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    AutoOrientation.portraitMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}