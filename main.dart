// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const customSwatch = MaterialColor(
    0xFFFF5252,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFFF5252),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),
    },
  );

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  bool customDialRoot = true;
  bool extend = false;
  bool rmIcons = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Speed Dial"),
      ),
      body: const Center(
        child: Text('Demo',),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: SpeedDial(
        // animatedIcon: AnimatedIcons.menu_close,
        // animatedIconTheme: IconThemeData(size: 22.0),
        // / This is ignored if animatedIcon is non null
        // child: Text("open"),
        // activeChild: Text("close"),
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 3,
        openCloseDial: isDialOpen,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 4,
        // dialRoot: customDialRoot? (ctx, open, toggleChildren) {
        //   return ElevatedButton(
        //     onPressed: toggleChildren,
        //     style: ElevatedButton.styleFrom(
        //       primary: Colors.blue[900],
        //       padding: const EdgeInsets.symmetric(
        //           horizontal: 22, vertical: 18),
        //     ),
        //     child: const Text(
        //       "Custom Dial Root",
        //       style: TextStyle(fontSize: 17),
        //     ),
        //   );
        // } : null,
        buttonSize: Size.fromRadius(35), // SpeedDial size which defaults to 56 itself
        // iconTheme: IconThemeData(size: 22),
        label: extend? const Text("Open") : null, // The label of the main button.
        /// The active label of the main button, Defaults to label if not specified.
        activeLabel: extend ? const Text("Close") : null,

        /// Transition Builder between label and activeLabel, defaults to FadeTransition.
        // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
        /// The below button size defaults to 56 itself, its the SpeedDial childrens size
        childrenButtonSize: Size.fromRadius(35),
        visible: true,
        direction: SpeedDialDirection.up,
        switchLabelPosition: false,

        /// If true user is forced to close dial manually
        closeManually: false,

        /// If false, backgroundOverlay will not be rendered.
        renderOverlay: true,
        // overlayColor: Colors.black,
        // overlayOpacity: 0.5,
        onOpen: () => debugPrint('OPENING DIAL'),
        onClose: () => debugPrint('DIAL CLOSED'),
        useRotationAnimation: true,
        // foregroundColor: Colors.black,
        // backgroundColor: Colors.white,
        // activeForegroundColor: Colors.red,
        // activeBackgroundColor: Colors.blue,
        elevation: 8.0,
        animationCurve: Curves.elasticInOut,
        isOpenOnStart: false,
        animationDuration: const Duration(milliseconds: 500),
        // shape: customDialRoot
        //     ? const RoundedRectangleBorder()
        //     : const StadiumBorder(),
        // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        children: [
          SpeedDialChild(
            child: !rmIcons ? const Icon(Icons.accessibility) : null,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            //label: 'First',
            onTap: () => setState(() => rmIcons = !rmIcons),
            onLongPress: () => debugPrint('FIRST CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: !rmIcons ? const Icon(Icons.brush) : null,
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            label: 'Second',
            onTap: () => debugPrint('SECOND CHILD'),
          ),
          SpeedDialChild(
            child: !rmIcons ? const Icon(Icons.margin) : null,
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            label: 'Show Snackbar',
            visible: true,
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(("Third Child Pressed")))),
            onLongPress: () => debugPrint('THIRD CHILD LONG PRESS'),
          ),
        ],
      ),
    );
  }
}

