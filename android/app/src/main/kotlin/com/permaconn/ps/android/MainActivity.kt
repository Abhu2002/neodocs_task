package com.example.sampleprj
import android.webkit.WebView
import io.flutter.embedding.android.FlutterFragmentActivity
import android.os.Bundle

class MainActivity: FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // ✅ Force WebView to initialize properly
        WebView(this).apply {
            settings.javaScriptEnabled = true
        }
    }
}
