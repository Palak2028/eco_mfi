package com.infrasofttech.eco_mfi;

import android.annotation.SuppressLint;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.os.Build;
import android.util.Log;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.UUID;

/**
 * Use of this class, you need to have the following two permissions <br />
 *   * & Lt; uses-permission android: name = "android.permission.BLUETOOTH" / & gt; <br />
 *   * & Lt; uses-permission android: name = "android.permission.BLUETOOTH_ADMIN" / & gt; <br />
 *   * Android supported versions LEVEL 4 or more, and LEVEL 17 support bluetooth 4 of ble equipment
 */
@SuppressLint("NewApi")
public class BluetoothComm {

    /**
     * Service UUID
     */
    public final static String UUID_STR = "00001101-0000-1000-8000-00805F9B34FB";
    /**
     * Constant: The current Adnroid SDK version number
     */
    private static final int SDK_VER;
    private static final String TAG = "Prowess BT Comm";
    /**
     * Input stream object
     */
    public static InputStream misIn = null;
    /**
     * Output stream object
     */
    public static OutputStream mosOut = null;

    static {
        SDK_VER = Build.VERSION.SDK_INT;
    }

    /**
     * Bluetooth address code
     */
    private String msMAC;
    /**
     * Bluetooth connection status
     */
    public static boolean mbConectOk = false;
    /* Get Default Adapter */
    private BluetoothAdapter mBT = BluetoothAdapter.getDefaultAdapter();
    /**
     * Bluetooth serial port connection object
     */
    private BluetoothSocket mbsSocket = null;
    Void data;
    /**
     * Constructor
     *
     * @param sMAC Bluetooth device MAC address required to connect
     */
    public BluetoothComm(String sMAC) {
        Log.e("Connect 6", "Create Connection" + sMAC);

        if(sMAC.equals("") || sMAC.equals(null))
        {
            this.msMAC = "No Bluetooth";
        }else {
            this.msMAC = sMAC;
        }

        Log.e("Connect this.msMAC", "Create Connection" + this.msMAC);
    }

    /**
     * Bluetooth devices establish serial communication connection <br />
     * This function is best to put the thread to call, because it will block the system when calling
     *
     * @return Boolean false: connection creation failed / true: the connection is created successfully
     */
    final public boolean createConn() {

        Log.e(TAG, ".....crete connection  00S");

        if(!mBT.isEnabled()) return false;
        Log.e(TAG, ".....crete connection  1");
        //If a connection already exists, disconnect
        if(mbConectOk) this.closeConn();

        if(this.msMAC.equals("No Bluetooth")) {
            Log.e(TAG, "Exception not configure bluetooth");
            //Toast.makeText(this,"Please configure Bluetooth connection",Toast.LENGTH_LONG).show();
            return false;
        }else{
            Log.e(TAG, ".....crete connection  1 " + this.msMAC);
        /*Start Connecting a Bluetooth device*/
            final BluetoothDevice device = BluetoothAdapter.getDefaultAdapter().getRemoteDevice(this.msMAC);

            System.out.println("BluetoothDevice device" + device);

            final UUID uuidComm = UUID.fromString(UUID_STR);
            try {
                this.mbsSocket = device.createInsecureRfcommSocketToServiceRecord(uuidComm);
                System.out.println("this.mbsSocket" + this.mbsSocket);
			/*this.mbsSocket = device.createRfcommSocketToServiceRecord(uuidComm);*/
                Log.e(TAG, " Socket obtained First time");
                //Thread.sleep(10000);
                Log.e(TAG, ">>> Connecting First time ");
                this.mbsSocket.connect();
                //System.out.println("this.mBTcomm.createConn()" + this.mbsSocket.connect());
                Log.e(TAG, ">>> CONNECTED SUCCESSFULLY First time");
               // Thread.sleep(1000);
                this.mosOut = this.mbsSocket.getOutputStream();//Get global output stream object
                this.misIn = this.mbsSocket.getInputStream(); //Get global streaming input object
                System.out.println("BluetoothComm outStrm " + this.mosOut.toString() + " BluetoothComm inptStrm " + this.misIn.toString());
                this.mbConectOk = true; //Device is connected successfully

                Log.e(TAG, ">>> CONNECTED SUCCESSFULLY First time mbConectOk" + this.mbConectOk);
            } catch (Exception e) {
                e.printStackTrace();
                try {
                    //Thread.sleep(1000);
                    Log.e(TAG, ">>>>>>           Try 2  ................!");
                    this.mbsSocket = device.createRfcommSocketToServiceRecord(uuidComm);
                    System.out.println("Socket Data " + this.mbsSocket.toString());
                    //*this.mbsSocket = device.createInsecureRfcommSocketToServiceRecord(uuidComm);*//*
                    Log.e(TAG, " Socket obtained second time");
                    //Thread.sleep(1000);
                    Log.e(TAG, " Connecting againg second time ");
                    this.mbsSocket.connect();

                    Log.e(TAG, " Successful connection 2nd time....... ");
                    //Thread.sleep(1000);
                    this.mosOut = this.mbsSocket.getOutputStream();//Get global output stream object
                    this.misIn = this.mbsSocket.getInputStream(); //Get global streaming input object
                    System.out.println(TAG + "outStrm " + this.mosOut.toString() + TAG + "inptStrm " + this.misIn.toString());
                    this.mbConectOk = true;
                } catch (IOException e1) {
                    Log.e(TAG, " Connection Failed by trying both ways....... ");
                    e1.printStackTrace();
                    this.closeConn();//Disconnect
                    Log.e(TAG, " Returning False");
                    return false;
                } catch (Exception ee) {
                    Log.e(TAG, " Connection Failed due to other reasons....... ");
                    ee.printStackTrace();
                    this.closeConn();//Disconnect
                    Log.e(TAG, " Returning False");
                    return false;
                }
                Log.e(TAG, "Exception");
                return false;
            }
            return true;
        }

    }

    /**
     * Disconnect the Bluetooth device connection
     *
     * @return void
     */
    public void closeConn() {
        if(this.mbConectOk) {
            try {
                if(null != this.misIn) this.misIn.close();
                if(null != this.mosOut) this.mosOut.close();
                if(null != this.mbsSocket) this.mbsSocket.close();
                this.mbConectOk = false;//Mark the connection has been closed
            } catch(IOException e) {
                //Any part of the error, will be forced to close socket connection
                this.misIn = null;
                this.mosOut = null;
                this.mbsSocket = null;
                this.mbConectOk = false;//Mark the connection has been closed
            }
        }
        Log.e(TAG, " Closed connection");
    }

    /**
     * If the communication device has been established
     *
     * @return Boolean true: communication has been established / false: communication lost
     */
    public boolean isConnect() {
        return this.mbConectOk;
    }
}
