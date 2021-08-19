package com.kigabyte.laofitness;

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugins.androidalarmmanager.AlarmService;

public class Application extends FlutterApplication implements PluginRegistry.PluginRegistrantCallback {

    @Override
    public void onCreate() {
        super.onCreate();
        AlarmService.setPluginRegistrant(this);
    }

    @Override
    public void registerWith(PluginRegistry registry) {
        
    }
}
