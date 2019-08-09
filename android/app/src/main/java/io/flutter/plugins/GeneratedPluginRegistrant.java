package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.yangyxd.flutterpicker.FlutterPickerPlugin;
import com.github.sroddy.flutterstringencryption.FlutterStringEncryptionPlugin;
import io.github.ponnamkarthik.toast.fluttertoast.FluttertoastPlugin;
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    FlutterPickerPlugin.registerWith(registry.registrarFor("com.yangyxd.flutterpicker.FlutterPickerPlugin"));
    FlutterStringEncryptionPlugin.registerWith(registry.registrarFor("com.github.sroddy.flutterstringencryption.FlutterStringEncryptionPlugin"));
    FluttertoastPlugin.registerWith(registry.registrarFor("io.github.ponnamkarthik.toast.fluttertoast.FluttertoastPlugin"));
    SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
