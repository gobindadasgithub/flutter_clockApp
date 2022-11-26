import 'package:flutter/material.dart';

import 'custompaint.dart';

void main() {
  runApp(const MyApp());
}

extension on num {
  double get toRad => this * 0.01745329;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomPaintExample(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> widthAnim;
  late Animation<double> heightAnim;
  late Animation<double> opacityAnim;
  late Animation<Decoration> boxAnim;
  late Animation<Alignment> alignAnim;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    widthAnim = Tween<double>(begin: 50.0, end: 200.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.2, curve: Curves.easeInOutCubic)));

    heightAnim = Tween<double>(begin: 50.0, end: 200.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.2, 0.4, curve: Curves.easeInOutCubic)));

    boxAnim = DecorationTween(
        begin: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(0)
        ),
        end: BoxDecoration(
            color: Colors.blueGrey.shade900,
            borderRadius: BorderRadius.circular(24)))
        .animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.4, 0.6, curve: Curves.easeInOutCubic)));

    opacityAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.6, 0.7, curve: Curves.easeInOutCubic)));

    alignAnim =
        Tween<Alignment>(begin: Alignment.topCenter, end: Alignment.center)
            .animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.7, 1.0, curve: Curves.bounceOut)));

    controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        controller.reverse();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: controller,
              builder: (context, _) => Container(
                alignment: alignAnim.value,
                width: widthAnim.value,
                height: heightAnim.value,
                decoration: boxAnim.value,
                child: Opacity(
                  opacity: opacityAnim.value,
                  child: Text(
                    'Hello Flutter',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: startAnimation,
        tooltip: 'Start Animation',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void startAnimation() {
    controller.forward();
  }
}

const txt =
'''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Velit laoreet id donec ultrices tincidunt arcu non sodales neque. Neque egestas congue quisque egestas diam. Proin libero nunc consequat interdum. Quis risus sed vulputate odio ut enim blandit volutpat maecenas. Nibh tellus molestie nunc non blandit massa enim nec. Amet porttitor eget dolor morbi non arcu risus. Massa sed elementum tempus egestas sed sed risus pretium. Quisque sagittis purus sit amet volutpat. Risus nullam eget felis eget nunc. Parturient montes nascetur ridiculus mus mauris vitae ultricies. Dolor sed viverra ipsum nunc aliquet bibendum enim facilisis gravida. Sodales ut etiam sit amet nisl purus. Id neque aliquam vestibulum morbi blandit cursus. Consequat ac felis donec et. Sit amet tellus cras adipiscing enim eu turpis. Ut ornare lectus sit amet.''';
