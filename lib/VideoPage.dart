import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Videopage extends StatefulWidget {
  const Videopage({super.key});

  @override
  State<Videopage> createState() => _VideopageState();
}

class _VideopageState extends State<Videopage> {
  // late CachedVideoPlayerController vCtl;
  // late CustomVideoPlayerController cCtl;
  TabController? _controller;
  final List<Widget> tabs = [
    Tab(
      text: '  Result  ',
    ),
    Tab(
      text: '  Feed  ',
    ),
    Tab(
      text: '  Key Battle  ',
    ),
    Tab(
      text: '  Exit  ',
    ),
    Tab(
      text: '  Another  ',
    ),
  ];
  late FlickManager flickManager;

  bool isLoading = true;
  String videoUrl =
      "https://videos.pexels.com/video-files/4010131/4010131-hd_1366_720_50fps.mp4";
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
            videoPlayerOptions:
                VideoPlayerOptions(allowBackgroundPlayback: false),
            Uri.parse(videoUrl))
          ..initialize().then((value) => setState(() {
                isLoading = false;
              })));
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 300,
                  child: FlickVideoPlayer(flickManager: flickManager)),
            ),
    );
    // TabBar(
    //     tabAlignment: TabAlignment.start,
    //     dragStartBehavior: DragStartBehavior.start,
    //     dividerColor: Colors.transparent,
    //     isScrollable: true,
    //     indicatorColor: Colors.pink,
    //     controller: _controller,
    //     tabs: tabs),
  }
}
