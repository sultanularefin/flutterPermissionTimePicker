

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';


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
      width: displayWidth(
          context) / 13,
      height: displayHeight(context) / 25,
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


        clipBehavior: Clip.hardEdge,
        splashColor: Color(0xffFEE295),

        highlightElevation: 12,

          /*
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(35.0),
        ),

        borderSide: BorderSide(
          color: Color(0xffFEE295),
          style: BorderStyle.solid,
          width: 3.6,
        ),
        */

        child:
        Container(
//                      color:Colors.blue,
//                    width:displayWidth(context)/4,

          margin: EdgeInsets.fromLTRB(
              0, 0, 0, 0 /*15*/),
          width: displayWidth(context) / 4.5,
          height: displayHeight(context) / 24,

          /*
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(4),
            border: Border.all(

              color: Color(0xffBCBCBD),

              style: BorderStyle.solid,
              width: 2.0,


            ),

            boxShadow: [
              BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                  color: Color(0xffFFFFFF),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 2.0))
            ],

//                      color:Colors.blue,
            color: Color(0xffFFFFFF),
//                                      Colors.black54
          ),

*/

//
//                                  color: Color(0xffFFFFFF),


          child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(

//                                          height: 25,
                height: displayHeight(context) / 40,
                width: 5,
                margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                child: Icon(
//                                          Icons.add_shopping_cart,
                  Icons.watch_later,
                  size: 28,
                  color: Color(0xffBCBCBD),
                ),


              ),

              Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
//                          color:Colors.green,
                alignment: Alignment.center,
                width: displayWidth(context) / 7.5,
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
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
                width: displayWidth(context)/3,
                child: shoppingCartWidget(context)
            )
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
