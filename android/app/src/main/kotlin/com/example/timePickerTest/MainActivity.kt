package com.example.timePickerTest
//import android.bluetooth.BluetoothDevice
//import android.content.BroadcastReceiver
//import android.content.Context
//import android.content.Intent
//import android.content.IntentFilter
//import android.os.Bundle
//import android.widget.Toast
//import androidx.appcompat.app.AppCompatActivity

import io.flutter.embedding.android.FlutterActivity


class MainActivity: FlutterActivity() {
    
}




/*

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        title = "KotlinApp"
        val filter = IntentFilter()
        filter.addAction(BluetoothDevice.ACTION_ACL_CONNECTED)
        filter.addAction(BluetoothDevice.ACTION_ACL_DISCONNECT_REQUESTED)
        filter.addAction(BluetoothDevice.ACTION_ACL_DISCONNECTED)
        this.registerReceiver(broadcastReceiver, filter)
    }
    private val broadcastReceiver: BroadcastReceiver = object : BroadcastReceiver() {
        var device: BluetoothDevice? = null
        override fun onReceive(
                context: Context,
                intent: Intent
        ) {
            val action = intent.action
            device = intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE)
            if (BluetoothDevice.ACTION_ACL_CONNECTED == action) {
                Toast.makeText(
                        baseContext,
                        "Device is now Connected",
                        Toast.LENGTH_SHORT
                ).show()
            } else if (BluetoothDevice.ACTION_ACL_DISCONNECTED == action) {
                Toast.makeText(
                        baseContext,
                        "Device is disconnected",
                        Toast.LENGTH_SHORT
                ).show()
            }
        }
    }
}
*/
