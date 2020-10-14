import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_theme.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

const List<String> defaultImages = [
  "assets/images/weather/001-sunny.svg",
  "assets/images/Carrot.svg",
  "assets/images/Cherry.svg",
  "assets/images/whale.svg",
  "assets/images/Cookies.svg"
];
const List<int> colors = [
  0xFF7ddfc3,
  0xFFDBA5F5,
  0xFFFFE29D,
  0xFFFDAFBB,
  0xFFCDDDF4,
  0xFFEEDFF2,
  0xFFD0C9D6,
];

class AlbumDetailPage extends StatefulWidget {
  AlbumDetailPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AlbumDetailPageState createState() => new _AlbumDetailPageState();
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  List<String> someImages;
  CategoryType categoryType = CategoryType.ui;
  int currentIndex;

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .where((String key) => key.contains('.svg'))
        .toList();

    setState(() {
      someImages = imagePaths;
      for (int i = 0; i < someImages.length; i++) {
        print(someImages[i]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
      advancedPlayer.startHeadlessService();
    }
    _initImages();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            height: 400.0,
            child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Text("Starter",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: Colors.white)),
                        SizedBox(height: 20),
                        AspectRatio(
                          aspectRatio: 1,
                          child: SvgPicture.asset(someImages == null
                              ? defaultImages[index]
                              : someImages[index]),
                        ),
                        SizedBox(height: 10),
                        Text("Starter",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: Colors.white)),
                      ],
                    ),
                    decoration: new BoxDecoration(
//                border: new Border.all(color: Color(0xFFFF0000), width: 0.5), // 边色与边宽度
                      color: Color(colors[index % colors.length]), // 底色
                      borderRadius: new BorderRadius.circular((20.0)), // 圆角度
//                borderRadius: new BorderRadius.vertical(top: Radius.elliptical(20, 50)), // 也可控件一边圆角大小
                    ),
                  );
                },
                viewportFraction: 0.8,
                scale: 0.9,
                itemCount: someImages == null
                    ? defaultImages.length
                    : someImages.length,
//              control: new SwiperControl(),//左右切换箭头
                onTap: (index) => print('点击了第$index个'),
                onIndexChanged: (index) {
                  print('切换了第$index个');
                  currentIndex = index;
                }),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: <Widget>[
                getButtonUI(CategoryType.ui, categoryType == CategoryType.ui),
                const SizedBox(
                  width: 16,
                ),
                getButtonUI(
                    CategoryType.coding, categoryType == CategoryType.coding),
                const SizedBox(
                  width: 16,
                ),
                getButtonUI(
                    CategoryType.basic, categoryType == CategoryType.basic),
              ],
            ),
          ),
          SizedBox(height: 30),
          Flexible(
            child: SingleChildScrollView(
              child: _Tab(children: [
                Text('Play Local Asset \'audio.mp3\':'),
                _Btn(
                    txt: 'Play',
                    onPressed: () =>
                        audioCache.play('/mp3/weather/001-sunny.mp3')),
//                Text('Loop Local Asset \'audio.mp3\':'),
//                _Btn(
//                    txt: 'Loop',
//                    onPressed: () => audioCache.loop('002-cloudy.mp3')),
//                Text('Play Local Asset \'audio2.mp3\':'),
//                _Btn(
//                    txt: 'Play',
//                    onPressed: () => audioCache.play('005-heavy rain.mp3')),
                Text('Play Local Asset In Low Latency \'audio.mp3\':'),
                _Btn(
                    txt: 'Play',
                    onPressed: () => audioCache.play(
                        '/mp3/weather/001-sunny.mp3',
                        mode: PlayerMode.LOW_LATENCY)),
//                Text(
//                    'Play Local Asset Concurrently In Low Latency \'audio.mp3\':'),
//                _Btn(
//                    txt: 'Play',
//                    onPressed: () async {
//                      await audioCache.play('audio.mp3',
//                          mode: PlayerMode.LOW_LATENCY);
//                      await audioCache.play('audio2.mp3',
//                          mode: PlayerMode.LOW_LATENCY);
//                    }),
//                Text('Play Local Asset In Low Latency \'audio2.mp3\':'),
//                _Btn(
//                    txt: 'Play',
//                    onPressed: () => audioCache.play('audio2.mp3',
//                        mode: PlayerMode.LOW_LATENCY)),
//                getLocalFileDuration(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  getLocalFileDuration() {
    return FutureBuilder<int>(
      future: _getDuration(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('No Connection...');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Text('Awaiting result...');
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return Text(
                'audio2.mp3 duration is: ${Duration(milliseconds: snapshot.data)}');
        }
        return null; // unreachable
      },
    );
  }

  Future<int> _getDuration() async {
    File audiofile = await audioCache.load('audio2.mp3');
    await advancedPlayer.setUrl(
      audiofile.path,
    );
    int duration = await Future.delayed(
        Duration(seconds: 2), () => advancedPlayer.getDuration());
    return duration;
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.ui == categoryTypeData) {
      txt = '中文发音';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = '英文发音';
    } else if (CategoryType.basic == categoryTypeData) {
      txt = '收藏';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? AppTheme.nearlyBlue : AppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: AppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });
              print('播放第$currentIndex个');
              audioCache.play('/mp3/weather/001-sunny.mp3');
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color:
                        isSelected ? AppTheme.nearlyWhite : AppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final List<Widget> children;

  const _Tab({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: children
                .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _Btn extends StatelessWidget {
  final String txt;
  final VoidCallback onPressed;

  const _Btn({Key key, this.txt, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 48.0,
        child: RaisedButton(child: Text(txt), onPressed: onPressed));
  }
}

enum CategoryType {
  ui,
  coding,
  basic,
}
