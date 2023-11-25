import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit_main.dart';
import 'drtStreamClass.dart';
import 'eputable_main.dart';
import 'helpWidget.dart';

void main() {

  runApp( MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

 return   MultiBlocProvider(
      providers: [

        BlocProvider<mainCubit>(
          create: (context) => mainCubit(),
        ),

      ],
      child:MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  MyHomePage(),
      ),
    );

  }
}

class MyHomePage extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  void _incrementCounter() {
    _counter=_counter+1;
    _counterBloc.incrementCounter(_counter);
    setState(() {

    });


  }
  final CounterBloc _counterBloc = CounterBloc();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _counterBloc.counterStream.listen((int counter) {
      setState(() {
        controller.text = "$counter"; // Update text when counter changes
      });
    });

    controller.addListener(() {

      print("check values hear");
    });

  }


  @override
  Widget build(BuildContext context) {
  //  geiControllerV();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("widget"),
      ),
      body: /*BlocBuilder<mainCubit, AssignRackState>(
        builder: (context,state) {*/
           Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              //
              // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
              // action in the IDE, or press "p" in the console), to see the
              // wireframe for each widget.
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                helpaWem().getTestFieldVa(controller,(String ds )
                {
                  print("testField Call hera $ds ");
                }),
            /*  TextField(
                controller: controller,
                onChanged: (values)
                {
print("call onChanged");
                },

              ) */


                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
       /* }
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



class MyAp11p extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isolate Counter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePageIsolate(),
    );
  }
}
class MyHomePageIsolate extends StatefulWidget {
  @override
  _MyHomePageStateIsolate createState() => _MyHomePageStateIsolate();
}

class _MyHomePageStateIsolate extends State<MyHomePageIsolate> {
  int _counter = 0;
  late Isolate isolate;
  late SendPort sendPort;

  @override
  void initState() {
    super.initState();
    initIsolate();
  }

  void initIsolate() async {
    ReceivePort receivePort = ReceivePort();
    isolate = await Isolate.spawn(isolateEntry, receivePort.sendPort);
    receivePort.listen((message) {
      _counter=message;
      setState(() {

      });
    });

  }

   void isolateEntry(SendPort sendPort) {
    int counter = 0;
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      counter++;
      sendPort.send(counter); // Send only the counter value
    });
  }

  @override
  void dispose() {
    super.dispose();
    isolate.kill();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolate Counter Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Counter value from isolate:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          initIsolate();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
/*
class _MyHomePageStateIsolate extends State<MyHomePageIsolate> {
  int _counter = 0;
  late Isolate isolate;

  @override
  void initState() {
    super.initState();
    initIsolate();
  }

  void initIsolate() async {
    ReceivePort receivePort = ReceivePort();
    isolate = await Isolate.spawn(isolateEntry, receivePort.sendPort);
    receivePort.listen((dynamic message) {
      setState(() {
        _counter = message;
      });
    });
  }

  static void isolateEntry(SendPort sendPort) {
    int counter = 0;
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      counter++;
      sendPort.send(counter); // Send only the counter value
    });
  }

  @override
  void dispose() {
    super.dispose();
    isolate.kill();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolate Counter Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Counter value from isolate:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          initIsolate();
        },
        tooltip: 'Restart Isolate',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}*/
