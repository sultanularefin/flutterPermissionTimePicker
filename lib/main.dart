


import 'dart:async';

//import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:timePickerTest/FlutterBlueApp.dart';
import 'package:timePickerTest/PermissionPage.dart';
import 'package:system_shortcuts/system_shortcuts.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';


import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:oktoast/oktoast.dart';




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

  // static const platform = const MethodChannel('samples.flutter.dev/battery');

  static const platform = const MethodChannel('com.example.timePickerTest');



// SSSS


  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];


  int _counter = 0;
  int _totalCount = 0;

  bool blueToothState = false;
  bool wiFiState = false;


//  PermissionStatus _permissionStatus;
  PermissionStatus _permissionStatus = PermissionStatus.undetermined;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }



  @override
  void initState(){



    localStorageCheck();

    _getBatteryLevel();


    super.initState();


    printerManager.scanResults.listen((devices) async {
      // print('UI: Devices found ${devices.length}');
      setState(() {
        _devices = devices;
      });
    });

  }


  void _startScanDevices() {

    print('at _startScanDevices()');



    setState(() {
      _devices = [];
    });




    printerManager.startScan(Duration(seconds: 4));
  }



  void _startScanDummyDevices() {
    print('debug print inside _startScanDevices() method ');


    print('debug print blueToothDevicesState set to empty/ []  ');
    print(
        'debug print before calling  printerManager.startScan(Duration(seconds: 4));  ');


    print(
        'debug print after calling  printerManager.startScan(Duration(seconds: 4));'
            ' inside _startScanDevices() method   ');


    BluetoothDevice _x = new BluetoothDevice();
    _x.name = 'Restaurant Printer';
    _x.address = '0F:02:18:51:23:46';
    _x.type = 3;
    _x.connected = null;


    PrinterBluetooth x = new PrinterBluetooth(_x);

    BluetoothDevice _y = new BluetoothDevice();
    _y.name = 'JBL Charge 4';
    _y.address = '98:52:3D:BB:18:26';
    _y.type = 3;
    _y.connected = null;


    PrinterBluetooth y = new PrinterBluetooth(_y);

    List<PrinterBluetooth> tempBlueToothDevices = new List<PrinterBluetooth>();
    tempBlueToothDevices.addAll([x, y]);

    setState(() {
      _devices = tempBlueToothDevices;
    });
  }

  void _stopScanDevices(){
  print('at _stopScanDevices()');
    printerManager.stopScan();
  }

  Future<Ticket> demoReceipt(PaperSize paper) async {
    final Ticket ticket = Ticket(paper);

    // Print image
    final ByteData data = await rootBundle.load('assets/rabbit_black.jpg');
    final Uint8List bytes = data.buffer.asUint8List();
    final Image image = decodeImage(bytes);
    // ticket.image(image);

    ticket.text('GROCERYLY',
        styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);

    ticket.text('889  Watson Lane', styles: PosStyles(align: PosAlign.center));
    ticket.text('New Braunfels, TX', styles: PosStyles(align: PosAlign.center));
    ticket.text('Tel: 830-221-1234', styles: PosStyles(align: PosAlign.center));
    ticket.text('Web: www.example.com',
        styles: PosStyles(align: PosAlign.center), linesAfter: 1);

    ticket.hr();
    ticket.row([
      PosColumn(text: 'Qty', width: 1),
      PosColumn(text: 'Item', width: 7),
      PosColumn(
          text: 'Price', width: 2, styles: PosStyles(align: PosAlign.right)),
      PosColumn(
          text: 'Total', width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);

    ticket.row([
      PosColumn(text: '2', width: 1),
      PosColumn(text: 'ONION RINGS', width: 7),
      PosColumn(
          text: '0.99', width: 2, styles: PosStyles(align: PosAlign.right)),
      PosColumn(
          text: '1.98', width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);
    ticket.row([
      PosColumn(text: '1', width: 1),
      PosColumn(text: 'PIZZA', width: 7),
      PosColumn(
          text: '3.45', width: 2, styles: PosStyles(align: PosAlign.right)),
      PosColumn(
          text: '3.45', width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);
    ticket.row([
      PosColumn(text: '1', width: 1),
      PosColumn(text: 'SPRING ROLLS', width: 7),
      PosColumn(
          text: '2.99', width: 2, styles: PosStyles(align: PosAlign.right)),
      PosColumn(
          text: '2.99', width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);
    ticket.row([
      PosColumn(text: '3', width: 1),
      PosColumn(text: 'CRUNCHY STICKS', width: 7),
      PosColumn(
          text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
      PosColumn(
          text: '2.55', width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);
    ticket.hr();

    ticket.row([
      PosColumn(
          text: 'TOTAL',
          width: 6,
          styles: PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
      PosColumn(
          text: '\$10.97',
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
    ]);

    ticket.hr(ch: '=', linesAfter: 1);

    ticket.row([
      PosColumn(
          text: 'Cash',
          width: 7,
          styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      PosColumn(
          text: '\$15.00',
          width: 5,
          styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
    ]);
    ticket.row([
      PosColumn(
          text: 'Change',
          width: 7,
          styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      PosColumn(
          text: '\$4.03',
          width: 5,
          styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
    ]);

    ticket.feed(2);
    ticket.text('Thank you!',
        styles: PosStyles(align: PosAlign.center, bold: true));

    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy H:m');
    final String timestamp = formatter.format(now);
    ticket.text(timestamp,
        styles: PosStyles(align: PosAlign.center), linesAfter: 2);

    // Print QR Code from image
    // try {
    //   const String qrData = 'example.com';
    //   const double qrSize = 200;
    //   final uiImg = await QrPainter(
    //     data: qrData,
    //     version: QrVersions.auto,
    //     gapless: false,
    //   ).toImageData(qrSize);
    //   final dir = await getTemporaryDirectory();
    //   final pathName = '${dir.path}/qr_tmp.png';
    //   final qrFile = File(pathName);
    //   final imgFile = await qrFile.writeAsBytes(uiImg.buffer.asUint8List());
    //   final img = decodeImage(imgFile.readAsBytesSync());

    //   ticket.image(img);
    // } catch (e) {
    //   print(e);
    // }

    // Print QR Code using native function
    // ticket.qrcode('example.com');

    ticket.feed(2);
    ticket.cut();
    return ticket;
  }

  Future<Ticket> testTicket(PaperSize paper) async {
    final Ticket ticket = Ticket(paper);

    ticket.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    ticket.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
        styles: PosStyles(codeTable: PosCodeTable.westEur));
    ticket.text('Special 2: blåbærgrød',
        styles: PosStyles(codeTable: PosCodeTable.westEur));

    ticket.text('Bold text', styles: PosStyles(bold: true));
    ticket.text('Reverse text', styles: PosStyles(reverse: true));
    ticket.text('Underlined text',
        styles: PosStyles(underline: true), linesAfter: 1);
    ticket.text('Align left', styles: PosStyles(align: PosAlign.left));
    ticket.text('Align center', styles: PosStyles(align: PosAlign.center));
    ticket.text('Align right',
        styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    ticket.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);

    ticket.text('Text size 200%',
        styles: PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    // Print image
    final ByteData data = await rootBundle.load('assets/logo.png');
    final Uint8List bytes = data.buffer.asUint8List();
    final Image image = decodeImage(bytes);
    ticket.image(image);
    // Print image using alternative commands
    // ticket.imageRaster(image);
    // ticket.imageRaster(image, imageFn: PosImageFn.graphics);

    // Print barcode
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    ticket.barcode(Barcode.upcA(barData));



    ticket.feed(2);

    ticket.cut();
    return ticket;
  }

  void _testPrint(PrinterBluetooth printer) async {
    printerManager.selectPrinter(printer);

    // TODO Don't forget to choose printer's paper
    const PaperSize paper = PaperSize.mm80;

    final PosPrintResult res =
    await printerManager.printTicket(await demoReceipt(paper));

    showToast(res.msg);
  }



  // Get battery level.
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }


  // Future<void> return type .  ??
  Future<void> localStorageCheck () async{



   bool blueTooth= await SystemShortcuts.checkBluetooth;// return true/false
   bool wifi =   await SystemShortcuts.checkWifi;// return true/false


   setState(() {
     wiFiState = wifi;
     blueToothState = blueTooth;
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


  Widget permissionButton(BuildContext context){
    var logger = Logger();

    logger.d("Logger is working!");

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

//          final Permission permission= Permission.contacts;
          final Permission permission= Permission.camera;
          print('at Future<void> requestPermission $permission');

          final status = await permission.request();

          print('status: $status');

          switch (status) {
            case PermissionStatus.granted:
              print('PermissionStatus.granted');
            // do something
              break;
            case PermissionStatus.denied:
              print('PermissionStatus.denied');
            // do something
              break;
            case PermissionStatus.restricted:
              print('PermissionStatus.restricted');
            // do something
              break;
            case PermissionStatus.permanentlyDenied:
              print('PermissionStatus.permanentlyDenied');
            // do something
              break;
            case PermissionStatus.undetermined:
              print('PermissionStatus.undetermined');
            // do something
              break;
            default:
          }

          setState(() {
            print(status);


            _permissionStatus = status;

            if (status == PermissionStatus.granted) {
               logger.i('permission was granted: permission was granted');
            }




            print(_permissionStatus);
          });


//          final Permission _permissionHandler = Permission();
//          var result = await _permissionHandler.requestPermissions([PermissionGroup.contacts]);


        },


//        clipBehavior: Clip.hardEdge,
        splashColor: Colors.lime,

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
                  color: Colors.grey,
                ),


              ),

              Container(
                alignment: Alignment.center,
                width: displayWidth(context) / 4.5,
//                                        color:Colors.purpleAccent,
                // do it in both Container
                child: Text('Request Permission..'),

              )


            ],
          ),
        ),
      ),
    );



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
        splashColor: Colors.yellowAccent,

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
                  color: Colors.redAccent,
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


    var logger = Logger();

    logger.d("Logger is working!");


    // wiFiState = wifi;
    // blueToothState = blueTooth;

    print('wiFiState: $wiFiState');
    print('blueToothState: $blueToothState');

    // print('blueToothState: $blueToothState');

    logger.w('wiFiState: $wiFiState');
    logger.w('blueToothState: $blueToothState');
    logger.i('_batteryLevel: $_batteryLevel');
    logger.i('_devices: $_devices');





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

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Container(
                width: displayWidth(context)/2,
                child: shoppingCartWidget(context)
            ),

            Container(
                width: displayWidth(context)/2,
                child: permissionButton(context)
            ),




            SizedBox(height: 30),

            Center(
              child: RaisedButton(
                child: Text('Open route Permissions Page'),
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PermissionPage()),
                  );

                },
              ),
            ),

            RaisedButton(
              child: Text('Get Battery Level'),
              onPressed: _getBatteryLevel,
            ),


            Text(_batteryLevel),



            Container(
              height:displayHeight(context)/2,
              color:Colors.blue,
              child: ListView.builder(
                  itemCount: _devices.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => _testPrint(_devices[index]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 60,
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.print),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(_devices[index].name ?? ''),
                                      Text(_devices[index].address),
                                      Text(
                                        'Click to print a test receipt',
                                        style: TextStyle(color: Colors.grey[700]),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    );
                  }),
            ),






          ],
        ),
      ),

      floatingActionButton: StreamBuilder<bool>(
        stream: printerManager.isScanningStream,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: _stopScanDevices,
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
              child: Icon(Icons.search),
              onPressed: _startScanDevices,

//              onPressed: _startScanDummyDevices,


            );
          }
        },
      ),
    );
  }
}


