package com.example.flutterproject

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import com.android.volley.Request
import com.android.volley.RequestQueue
import com.android.volley.Response
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley
import org.json.JSONObject
import androidx.annotation.NonNull

class MainActivity: FlutterActivity() {
    private val CHANNEL = "apidata"

    override fun configureFlutterEngine(@NonNull flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "fetchDataFromApi") {
                val email = call.argument<String>("email") ?: ""
                val password = call.argument<String>("password") ?: ""
                val deviceToken = call.argument<String>("device_token") ?: ""
                fetchDataFromApi(email, password, deviceToken,result)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun fetchDataFromApi(email: String, password: String, devicetoken: String, result: MethodChannel.Result) {
        val url = "https://scratchy.esferasoft.in/api/login"

        val queue: RequestQueue = Volley.newRequestQueue(this)

        // Prepare the POST request body
        val requestBody = JSONObject().apply {
            put("email", email)
            put("password", password)
            put("device_token", devicetoken)
            put("device_type", "android")
        }

        // Create a StringRequest for the POST API call
        val stringRequest = object : StringRequest(
            Request.Method.POST, url,
            Response.Listener<String> { response ->
                result.success(response) // Send the API response back to Flutter
            },
            Response.ErrorListener { error ->
                result.error("API_ERROR", "Failed to fetch data", error.toString()) // Handle API errors
            }
        ) {
            override fun getBody(): ByteArray {
                return requestBody.toString().toByteArray()
            }

            override fun getHeaders(): MutableMap<String, String> {
                return hashMapOf("Content-Type" to "application/json")
            }
        }

        // Add the request to the Volley queue
        queue.add(stringRequest)
    }
}
