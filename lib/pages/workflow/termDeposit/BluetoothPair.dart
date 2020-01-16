import 'dart:async';
import 'package:flutter/material.dart';
// For using PlatformException
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/MiniStatementBean.dart';




class BluetoothPair extends StatefulWidget {
  static const String routeName = '/material/data-table';
  final List<MiniStatementBean> ministatemntbean;
  BluetoothPair(this.ministatemntbean);





  @override
  _BluetoothAppState createState() => _BluetoothAppState();
}

class _BluetoothAppState extends State<BluetoothPair> {
  // Initializing a global key, as it would help us in showing a SnackBar later
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // Get the instance of the bluetooth
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  static const platform = const MethodChannel('com.infrasoft.microfinance');

  // Define some variables, which will be required later
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice _device;
  bool _connected = false;
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
          setState(() {
            _connected = true;
            _pressed = false;
          });

          break;

        case FlutterBluetoothSerial.DISCONNECTED:
          setState(() {
            _connected = false;
            _pressed = false;
          });
          break;

        default:
          print(state);
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
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "PAIRED DEVICES",
                  style: TextStyle(fontSize: 24, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Device:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton(
                      items: _getDeviceItems(),
                      onChanged: (value) => setState(() => _device = value),
                      value: _device,
                    ),
                    RaisedButton(
                      onPressed:
                      _pressed ? null : _connected ? _disconnect : _connect,
                      child: Text(_connected ? 'Disconnect' : 'Connect'),
                    ),
                  ],
                ),
              ),
              Padding(
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
                            _callChannel(widget.ministatemntbean);
                          },
                          child: Text("Call Method channel"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      "NOTE: If you cannot find the device in the list, please turn on bluetooth and pair the device by going to the bluetooth settings",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ),
              )
            ],
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
          child: Text(device.address),
          value: device,
        ));
        print("Device name>>>>>>>>>>>>> : "+ device.address);
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
  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _pressed = true);
  }

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
  void _sendOffMessageToBluetooth() {
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.write("0");
        show('Device Turned Off');
      }
    });
  }

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

  _callChannel(List<MiniStatementBean> miniStatementBeanList) async{
    String repeatedStringEntryDate = "";
    for(var items in miniStatementBeanList){
      repeatedStringEntryDate = items.mentrydate.toString()+repeatedStringEntryDate;
    }
    print("repeatedStringEntryDate"+repeatedStringEntryDate);
    String repeatedStringAmount = "";
    for(var items in miniStatementBeanList){
      repeatedStringAmount = items.mlcytrnamt.toString()+repeatedStringAmount;
    }
    print("repeatedStringAmount"+repeatedStringAmount);
    String repeatedStringDrCr = "";
    for(var items in miniStatementBeanList){
      repeatedStringDrCr = items.mdrcr.toString()+repeatedStringDrCr;
    }
    print("repeatedStringDrCr"+repeatedStringDrCr);
    String repeatedStringRemarks = "";
    for(var items in miniStatementBeanList){
      repeatedStringRemarks = items.mparticulars.toString()+repeatedStringRemarks;
    }
    print("repeatedStringRemarks"+repeatedStringRemarks);
    String mlbrcode=widget.ministatemntbean[0].mlbrcode.toString();
    String mbramchname=widget.ministatemntbean[0].mbramchname.toString();
    String date=dateFormat.format(DateTime.now());
    String prdAccId=widget.ministatemntbean[0].mprdacctid.substring(0, 8).trim()+"/"+
        widget.ministatemntbean[0].mprdacctid.substring(8, 16).trim()+"/"+
        widget.ministatemntbean[0].mprdacctid.substring(16, 24).trim();
    String mlongname=widget.ministatemntbean[0].mlongname.toString();
    String macttotballcy=widget.ministatemntbean[0].macttotballcy.toString();

    try {
      final String  result = await platform.invokeMethod("showNativeView",
         {"mlbrcode":mlbrcode,
        "mbramchname":mbramchname,
        "date":date,
        "prdAccId":prdAccId,
        "mlongname":mlongname,
        "macttotballcy":macttotballcy,
        "repeatedStringEntryDate":repeatedStringEntryDate,
        "repeatedStringAmount":repeatedStringAmount,
        "repeatedStringDrCr":repeatedStringDrCr,
        "repeatedStringRemarks":repeatedStringRemarks});
      String geTest = 'geTest at $result';
      print("FLutter : "+geTest.toString());
    } on PlatformException catch (e) {
      print("FLutter : "+e.message.toString());
    }

  }
}
