import 'dart:async';
import 'dart:convert';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:flutter/material.dart';

// For using PlatformException
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

class DeviceSetting extends StatefulWidget {
  static const String routeName = '/material/data-table';

  DeviceSetting();

  @override
  _BluetoothAppState createState() => _BluetoothAppState();
}

class _BluetoothAppState extends State<DeviceSetting> {
  // Initializing a global key, as it would help us in showing a SnackBar later
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences prefs;

  // Get the instance of the bluetooth
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');

  // Define some variables, which will be required later
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice _device;

  bool _pressed = false;
  final dateFormat = DateFormat("yyyy/MM/dd hh:mm:ss");

  @override
  void initState() {
    super.initState();
    bluetoothConnectionState();


  }

  // We are using async callback for using await
  Future<void> bluetoothConnectionState() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    // For knowing when bluetooth is connected and when disconnected
    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case FlutterBluetoothSerial.CONNECTED:
          Toast.show("Connect event call!!", context);
         // _connected = true;
          setState(() {

          /*  _connected = true;
            _pressed = false;*/
          });

          break;

        case FlutterBluetoothSerial.DISCONNECTED:
          Toast.show("disconnect event call!!", context);
          globals.connected  = false;
          setState(() {

          /*  _connected = false;
            _pressed = false;*/
          });
          break;

        default:
         // print("Bluetooth is "+ state.toString());
          if(state==12){
            globals.connected = true;
            Toast.show("Bluetooth is ON ", context);

          }else if (state==10){
            globals.connected = false;
            Toast.show("Bluetooth is OFF ", context);

          }
          break;
      }
    });

    // It is an error to call [setState] unless [mounted] is true.
    if (!mounted) {
      return;
    }

    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class
    setState(() {
      _devicesList = devices;
    });
  }

  // Now, its time to build the UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Flutter Bluetooth"),
          backgroundColor:  Color(0xff07426A),
        ),
        body: Card(
          elevation: 10,
          margin:EdgeInsets.all(15.0),
          borderOnForeground: true,
          color: Colors.yellow[50] ,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Please Select your PAIRED DEVICES",
                    style: TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 17.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Text(
                          'Device:',
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: DropdownButton(
                          items: _getDeviceItems(),
                          onChanged: ( BluetoothDevice value)async {
                            print(value);
                            print("before");
                            prefs = await SharedPreferences.getInstance();
                            print(value.address.toString());
                            prefs.setString(TablesColumnFile.bluetoothAddress, value.address.toString());
                            print(value.address.toString());
                            print("after");

                            return setState(() => _device = value);

                          } ,
                          value: _device,
                        ),
                      )

                    /*  RaisedButton(
                        child: Text('Click Button '),
                        onPressed: () async {
                        if(globals.connected == true){
                          Toast.show("Connected!!", context);
                          bool status  = await bluetooth.isOn;
                          print("?????"+ status.toString());
                          bluetooth.disconnect();

                        }else if (globals.connected == false){
                          Toast.show("Disconnected!!", context);
                          bluetooth.openSettings;
                          bool status  = await bluetooth.isOn;
                          print("?????"+ status.toString());
                          bluetooth.connect(_device);
                        }

                          setState(() {

                          });
                        },
                      ),*/

                    ],
                  ),
                ),
              /*  Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "DEVICE 1",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed:
                                _connected ? _sendOnMessageToBluetooth : null,
                            child: Text("ON"),
                          ),
                          FlatButton(
                            onPressed:
                                _connected ? _sendOffMessageToBluetooth : null,
                            child: Text("OFF"),
                          ),
                          FlatButton(
                            onPressed: () {
                              _callChannel();
                            },
                            child: Text("Save Device"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),*/
                Divider(
                  color: Colors.black,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        "NOTE: If you cannot find the device in the list, please turn on bluetooth and pair the device by going to the bluetooth settings",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 17.0,  color: Colors.red),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Create the List of devices to be shown in Dropdown Menu
  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name +"\n"+ device.address),
          value: device,
        ));


        print("Device id>>>>>>>>>>>>> : " + device.address);
        print("Device name>>>>>>>>>>>>> : " + device.name);

      });
    }

    return items;
  }

  // Method to connect to bluetooth
  void _connect() {
    if (_device == null) {
      show('No device selected');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected) {
          bluetooth
              .connect(_device)
              .timeout(Duration(seconds: 10))
              .catchError((error) {
            setState(() => _pressed = false);
          });
          setState(() => _pressed = true);
        }
      });
    }
  }

  // Method to disconnect bluetooth
/*  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _pressed = true);
  }*/

  // Method to send message,
  // for turning the bletooth device on
  void _sendOnMessageToBluetooth() {
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.write("1");
        show('Device Turned On');
      }
    });
  }

  // Method to send message,
  // for turning the bletooth device off
 /* void _sendOffMessageToBluetooth() {
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.write("0");
        show('Device Turned Off');
      }
    });
  }*/

  // Method to show a Snackbar,
  // taking message as the text
  Future show(
    String message, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        content: new Text(
          message,
        ),
        duration: duration,
      ),
    );
  }

 /* _callChannel() async {


    try {
      final String result = await platform.invokeMethod("deviceSetting", {
        "BluetoothADD":_device.address.toString(),

      });
      String geTest = '$result';
      print("FLutter : " + geTest.toString());
    } on PlatformException catch (e) {
      print("FLutter : " + e.message.toString());
    }
  }*/
}
