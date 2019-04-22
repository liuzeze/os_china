package lz.com.androiddemo;

import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.FrameLayout;

import io.flutter.facade.Flutter;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;

public class MainActivity extends AppCompatActivity {
    private static final String CHANNEL = "com.lz/demo";
    private MethodChannel mMethodChanel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_main);
        FlutterView flutterView = Flutter.createView(MainActivity.this, getLifecycle(), "createview");
        FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(FrameLayout.LayoutParams
                .MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT);
        addContentView(flutterView, params);

        mMethodChanel = new MethodChannel(flutterView, CHANNEL);

        mMethodChanel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

//                flutter  传递数据给这里  mresult  介意携带数据回调给flutter
              /*  methodCall.method;
                methodCall.argument();
                result.success();*/

                sendFlutterMsg(methodCall.argument("success"));
            }
        });
    }

    //传递参数给flutter，参数分别为名字，参数，以及回调方法
    private void sendFlutterMsg(String s) {
        mMethodChanel.invokeMethod("sendFluter", s, new MethodChannel.Result() {
            @Override
            public void success(@Nullable Object o) {
                Log.e("debug", "success" + o.toString());
            }

            @Override
            public void error(String s, @Nullable String s1, @Nullable Object o) {
                Log.e("debug", "error" + o.toString());
            }

            @Override
            public void notImplemented() {
                Log.e("debug", "没有实现");
            }
        });
    }
}
