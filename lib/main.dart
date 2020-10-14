import 'package:BabyLiteracy/views/album_detail_page.dart';
import 'package:BabyLiteracy/views/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_theme.dart';
import 'widgets/animation_mixins.dart'; // See my code reference for this gist
import 'widgets/animation_widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
//        home: AnimatedLogo(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CategoryType categoryType = CategoryType.ui;
  int _counter = 0;
  int count;
  Widget example;
  String code;
  String explanation;
  List<String> images = [
    "assets/images/weather/001-sunny.svg",
    "assets/images/Carrot.svg",
    "assets/images/Cherry.svg",
    "assets/images/whale.svg",
    "assets/images/Cookies.svg"
  ];
  List<String> categorys = ["天气", "食物", "水果", "动物", "职业"];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffbd7ae3),
//            color: Colors.purple
//          image: DecorationImage(
//            image: AssetImage("assets/images/lebronjames.jpg"),
//            fit: BoxFit.cover,
//          ),
        ),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                height: 200,
                child: AnimatedLogo(),
              ),
//              Text(
//                'You have pushed the button this many times:',
//              ),
              Text(
                '糯米识词',
                style: TextStyle(
                  fontSize: 30,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Colors.white,
                ),
//                style: Theme.of(context).textTheme.headline4,
              ),
//              Container(
//                height: 100,
//                width: double.infinity,
//                color: Colors.black,
//                child: SingleChildScrollView(
//                  scrollDirection: Axis.horizontal,
//                  child: Row(
//                    mainAxisSize: MainAxisSize.min,
//                    children: [
//                      for (int i = 0; i < 10; i++)
//                        Container(
//                            width: 100,
//                            height: 80,
//                            padding:
//                                const EdgeInsets.only(left: 4.0, right: 4.0),
//                            child: button(i + 1)),
//                    ],
//                  ),
//                ),
//              ),
              SizedBox(height: 130),
              Container(
                height: 160,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ListView.builder(
                  itemCount: images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.only(left: 20),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
//                      child: Column(
//                          children: [
//                            AspectRatio(
//                              aspectRatio: 1,
//                              child: SvgPicture.asset(images[index]),
//                            ),
//                            Text('PREP:'),
//                            Text('25 min'),
//                          ],
//                      ),
                      child: GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 100.0,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: SvgPicture.asset(images[index]),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(categorys[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      letterSpacing: 0.27,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                        //tap事件触发
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AlbumDetailPage(title: '识字')),
                          );
                        },
                      ),
//                      onPressed: () {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => AlbumDetailPage(title: '识字')),
//                        );
//
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    getButtonUI(
                        CategoryType.ui, categoryType == CategoryType.ui),
                    const SizedBox(
                      width: 16,
                    ),
                    getButtonUI(CategoryType.coding,
                        categoryType == CategoryType.coding),
                  ],
                ),
              ),
//              Row(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: [
//                  Expanded(
//                    child: Image.asset('assets/images/lebronjames.jpg'),
//                  ),
//                  Expanded(
//                    flex: 2,
//                    child: Image.asset('assets/images/lebronjames.jpg'),
//                  ),
//                  Expanded(
//                    child: Image.asset('assets/images/lebronjames.jpg'),
//                  ),
//                ],
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: [
//                  Column(
//                    children: [
//                      Icon(Icons.kitchen, color: Colors.green[500]),
//                      Text('PREP:'),
//                      Text('25 min'),
//                    ],
//                  ),
//                  Column(
//                    children: [
//                      Icon(Icons.timer, color: Colors.green[500]),
//                      Text('COOK:'),
//                      Text('1 hr'),
//                    ],
//                  ),
//                  Column(
//                    children: [
//                      Icon(Icons.restaurant, color: Colors.green[500]),
//                      Text('FEEDS:'),
//                      Text('4-6'),
//                    ],
//                  ),
//                ],
//              ),
            ],
          ),
        ),
      ),

//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.ui == categoryTypeData) {
      txt = '关于';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = '收藏';
    } else if (CategoryType.basic == categoryTypeData) {
      txt = 'Basic UI';
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

  Widget button(int exampleNumber) => Button(
        key: ValueKey('button$exampleNumber'),
        isSelected: this.count == exampleNumber,
        exampleNumber: exampleNumber,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AlbumDetailPage(title: '识字')),
          );
          showExample(
            exampleNumber,
//        widget.examples[exampleNumber - 1].code,
//        widget.examples[exampleNumber - 1].explanation,
            "",
            "",
          );
        },
      );

  void showExample(int exampleNumber, String code, String explanation) =>
      setState(() {
        this.count = exampleNumber;
        this.code = code;
        this.explanation = explanation;
      });
}

class Button extends StatelessWidget {
  final Key key;
  final bool isSelected;
  final int exampleNumber;
  final VoidCallback onPressed;

  Button({
    this.key,
    this.isSelected,
    this.exampleNumber,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: isSelected ? Colors.grey : Colors.grey[800],
        child: Text(exampleNumber.toString(),
            style: TextStyle(color: Colors.white)),
        onPressed: () {
          Scrollable.ensureVisible(
            context,
            duration: Duration(milliseconds: 350),
            curve: Curves.easeOut,
            alignment: 0.5,
          );
          onPressed();
        });
  }
}

class AnimatedLogo extends StatefulWidget {
  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo> with FirstLoad {
  bool _isVisible = false;
  String LOGO_RIGHT = "assets/images/Carrot.svg";
  String LOGO_LEFT = "assets/images/Cherry.svg";
  String LOGO_MID = "assets/images/Cookies.svg";
  String LOGO_TEXT = "assets/images/whale.svg";

  /// Preload svgs before animating
  loadSvgs() => Future.wait([
        loadSvg(context, LOGO_RIGHT),
        loadSvg(context, LOGO_LEFT),
        loadSvg(context, LOGO_MID),
        loadSvg(context, LOGO_TEXT),
      ]).then((_) => setState(() => _isVisible = true));

  @override
  Widget build(BuildContext context) {
    onFirstLoad(
        loadSvgs); // I need context to be initialised so can't use initState

    return Visibility(
        visible: _isVisible,
        child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400, maxHeight: 200),
//            constraints: BoxConstraints.tightFor(width: 400,height: 200),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 100,
                    height: 100,
                    child: _AnimatedStar(LOGO_RIGHT, 300),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 100,
                    height: 100,
                    child: _AnimatedStar(LOGO_LEFT, 1000),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 100,
                    height: 100,
                    child: _AnimatedStar(LOGO_MID, 2000),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 120,
                    height: 100,
                    child: _AnimatedStar(LOGO_TEXT, 0),
                  ),
                ),
              ],
            )));
  }
}

class _AnimatedStar extends AnimatedScale {
  _AnimatedStar(String svgPath, int delay)
      : super(
          child: SvgPicture.asset(svgPath),
          curve: Curves.elasticOut,
          delay: Duration(milliseconds: delay),
          duration: Duration(milliseconds: 1000),
        );
}

Future<SvgPicture> loadSvg(BuildContext context, String path) async {
  var picture = SvgPicture.asset(path);
  await precachePicture(picture.pictureProvider, context);
  return picture;
}
