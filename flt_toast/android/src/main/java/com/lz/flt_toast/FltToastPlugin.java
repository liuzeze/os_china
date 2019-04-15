package com.lz.flt_toast;

import android.content.Context;
import android.widget.Toast;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FltToastPlugin
 */
public class FltToastPlugin implements MethodCallHandler {

    private final Context mContext;

    public FltToastPlugin(Context context) {
        mContext = context;
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flt_toast");
        channel.setMethodCallHandler(new FltToastPlugin(registrar.context()));
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("showToast")) {
            Toast.makeText(mContext,call.argument("text").toString(),Toast.LENGTH_SHORT).show();
            result.success(true);
        } else {
            result.notImplemented();
        }
    }
}
