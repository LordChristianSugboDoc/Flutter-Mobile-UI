package com.example.network_info;

import android.content.Context;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Build;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class NetworkInfoPlugin implements FlutterPlugin, MethodCallHandler {
    private Context applicationContext;

    public static void registerWith(@NonNull FlutterPlugin.FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "network_info");
        channel.setMethodCallHandler(new NetworkInfoPlugin(flutterPluginBinding.getApplicationContext()));
    }

    private NetworkInfoPlugin(Context context) {
        this.applicationContext = context;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPlugin.FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "network_info");
        channel.setMethodCallHandler(this);
        this.applicationContext = flutterPluginBinding.getApplicationContext();
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPlugin.FlutterPluginBinding binding) {
        // Cleanup
    }

    @Override
    public void onMethodCall(MethodCall call, @NonNull Result result) {
        if (call.method.equals("getLocalIpAddress")) {
            result.success(getLocalIpAddress());
        } else {
            result.notImplemented();
        }
    }

    private String getLocalIpAddress() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            return "Not available on Android M and above";
        } else {
            WifiManager wifiManager = (WifiManager) applicationContext.getSystemService(Context.WIFI_SERVICE);
            WifiInfo wifiInfo = wifiManager.getConnectionInfo();
            int ipAddress = wifiInfo.getIpAddress();
            return String.format("%d.%d.%d.%d",
                    (ipAddress & 0xff),
                    (ipAddress >> 8 & 0xff),
                    (ipAddress >> 16 & 0xff),
                    (ipAddress >> 24 & 0xff));
        }
    }
}