package com.privacy.detection;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import java.io.IOException;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Collections;
import java.util.List;

public class MainActivity extends AppCompatActivity {
    private static final String TAG = "PrivacyDetectionApp";
    private static final int PERMISSION_REQUEST_CODE = 1001;
    
    private TextView statusText;
    private TextView ipAddressText;
    private Button startButton;
    private Button stopButton;
    private WebServer webServer;
    private Handler handler;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        initViews();
        checkPermissions();
        handler = new Handler(Looper.getMainLooper());
    }
    
    private void initViews() {
        statusText = findViewById(R.id.status_text);
        ipAddressText = findViewById(R.id.ip_address_text);
        startButton = findViewById(R.id.start_button);
        stopButton = findViewById(R.id.stop_button);
        
        startButton.setOnClickListener(v -> startDetection());
        stopButton.setOnClickListener(v -> stopDetection());
        
        updateStatus("等待启动...");
        updateIpAddress();
    }
    
    private void checkPermissions() {
        String[] permissions = {
            Manifest.permission.INTERNET,
            Manifest.permission.ACCESS_NETWORK_STATE,
            Manifest.permission.ACCESS_WIFI_STATE
        };
        
        boolean allGranted = true;
        for (String permission : permissions) {
            if (ContextCompat.checkSelfPermission(this, permission) != PackageManager.PERMISSION_GRANTED) {
                allGranted = false;
                break;
            }
        }
        
        if (!allGranted) {
            ActivityCompat.requestPermissions(this, permissions, PERMISSION_REQUEST_CODE);
        }
    }
    
    private void startDetection() {
        try {
            webServer = new WebServer(8080);
            webServer.start();
            
            updateStatus("检测服务已启动");
            startButton.setEnabled(false);
            stopButton.setEnabled(true);
            
            Toast.makeText(this, "隐私检测服务已启动", Toast.LENGTH_SHORT).show();
            
        } catch (IOException e) {
            Log.e(TAG, "启动检测服务失败", e);
            updateStatus("启动失败: " + e.getMessage());
        }
    }
    
    private void stopDetection() {
        if (webServer != null) {
            webServer.stop();
            webServer = null;
        }
        
        updateStatus("检测服务已停止");
        startButton.setEnabled(true);
        stopButton.setEnabled(false);
        
        Toast.makeText(this, "隐私检测服务已停止", Toast.LENGTH_SHORT).show();
    }
    
    private void updateStatus(String status) {
        handler.post(() -> statusText.setText("状态: " + status));
    }
    
    private void updateIpAddress() {
        String ip = getLocalIpAddress();
        if (ip != null) {
            handler.post(() -> ipAddressText.setText("访问地址: http://" + ip + ":8080"));
        }
    }
    
    private String getLocalIpAddress() {
        try {
            List<NetworkInterface> interfaces = Collections.list(NetworkInterface.getNetworkInterfaces());
            for (NetworkInterface intf : interfaces) {
                List<InetAddress> addrs = Collections.list(intf.getInetAddresses());
                for (InetAddress addr : addrs) {
                    if (!addr.isLoopbackAddress() && addr.getHostAddress().indexOf(':') < 0) {
                        String sAddr = addr.getHostAddress();
                        if (sAddr.startsWith("192.168.") || sAddr.startsWith("10.") || sAddr.startsWith("172.")) {
                            return sAddr;
                        }
                    }
                }
            }
        } catch (Exception e) {
            Log.e(TAG, "获取IP地址失败", e);
        }
        return null;
    }
    
    @Override
    protected void onDestroy() {
        super.onDestroy();
        stopDetection();
    }
}
