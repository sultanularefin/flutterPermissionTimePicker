

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _totalCount = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }


  Size displaySize(BuildContext context) {
//  debugPrint('Size = ' + MediaQuery.of(context).size.toString());
    return MediaQuery.of(context).size;
  }

  double displayHeight(BuildContext context) {
//  debugPrint('Height = ' + displaySize(context).height.toString());
    return displaySize(context).height;
  }

  double displayWidth(BuildContext context) {
//  debugPrint('Width = ' + displaySize(context).width.toString());
    return displaySize(context).width;

//  I/flutter ( 5454): Width = 800.0
//  I/flutter ( 5454): Height = 1232.0
  }



  Widget shoppingCartWidget(BuildContext context){



    return Container(
//                                                                        width:60,

      color:Colors.pinkAccent,
      width: displayWidth(
          context) / 2,
      height: displayHeight(context) / 12,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),

      child: OutlineButton(
        onPressed: () async {


          Future<TimeOfDay> selectedTime24Hour = showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: 10, minute: 47),
            builder: (BuildContext context, Widget child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                child: child,
              );
            },
          );

        },


//        clipBehavior: Clip.hardEdge,
        splashColor: Color(0xffFEE295),

        highlightElevation: 12,
        child:
        Container(

          margin: EdgeInsets.fromLTRB(0, 0, 0, 0 /*15*/),
          width: displayWidth(context)/3,
          height: displayHeight(context) / 14,
          color:Colors.lightGreenAccent,


          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(

//                                          height: 25,
                height: displayHeight(context) / 40,
                width: 5,
                margin: EdgeInsets.only(left: 0),

                child: Icon(
//                                          Icons.add_shopping_cart,
                  Icons.watch_later,
                  size: 28,
                  color: Color(0xffBCBCBD),
                ),


              ),

              Container(
                alignment: Alignment.center,
                width: displayWidth(context) / 4.5,
//                                        color:Colors.purpleAccent,
                // do it in both Container
                child: Text('choose Time'),

              )


            ],
          ),
        ),
      ),
    );



  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
//        title: const Text('Plugin example app'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              var hasOpened = openAppSettings();
              debugPrint('App Settings opened: ' + hasOpened.toString());
            },
          )
        ],
      ),


      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),

            Container(
                width: displayWidth(context)/2,
                child: shoppingCartWidget(context)
            ),

            Center(
              child: ListView(
                  children: Permission.values
                      .where((Permission permission) {
                    if (Platform.isIOS) {
                      return permission != Permission.unknown &&
                          permission != Permission.sms &&
                          //permission != Permission.storage &&
                          permission != Permission.ignoreBatteryOptimizations &&
                          permission != Permission.accessMediaLocation;
                    } else {
                      return permission != Permission.unknown &&
                          permission != Permission.mediaLibrary &&
                          permission != Permission.photos &&
                          permission != Permission.reminders;
                    }
                  })
                      .map((permission) => PermissionWidget(permission))
                      .toList()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
