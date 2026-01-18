#import <Foundation/Foundation.h>
#include "core/config/project_settings.h"
#import "godot_att_ios_plugin_implementation.h"
#import "godot_att_ios_plugin-Swift.h"

String const SIGNAL_TRACKING_COMPLETED = "tracking_request_completed";

void GodotAttIosPlugin::_bind_methods() {
    
    ClassDB::bind_method(D_METHOD("hello_world"), &GodotAttIosPlugin::hello_world);
    ClassDB::bind_method(D_METHOD("get_idfa"), &GodotAttIosPlugin::get_idfa);
    
    ClassDB::bind_method(D_METHOD("can_show_request_dialog"), &GodotAttIosPlugin::can_show_request_dialog);
    
    ClassDB::bind_method(D_METHOD("request_tracking"), &GodotAttIosPlugin::request_tracking);
    
    ADD_SIGNAL(MethodInfo(SIGNAL_TRACKING_COMPLETED, PropertyInfo(Variant::STRING, "status")));
}

GodotAttIosPlugin::GodotAttIosPlugin() {
    NSLog(@"GodotAttIosPlugin: Initialized");
}

GodotAttIosPlugin::~GodotAttIosPlugin() {
    NSLog(@"GodotAttIosPlugin: Deinitialized");
}

void GodotAttIosPlugin::hello_world() {
    NSLog(@"GodotAttIosPlugin: Hello from Obj-C++");
    [GodotAttIosPluginSwift helloWorldFromSwift];
}

bool GodotAttIosPlugin::can_show_request_dialog() {
    GodotAttIosPluginSwift *swift = [[GodotAttIosPluginSwift alloc] init];
    return (bool)[swift canShowRequestDialog];
}

String GodotAttIosPlugin::get_idfa() {
    GodotAttIosPluginSwift *swift = [[GodotAttIosPluginSwift alloc] init];
    NSString *idfa_ns = [swift getIDFA];
    
    String idfa_godot = String([idfa_ns UTF8String]);
    
    NSLog(@"GodotAttIosPlugin: get_idfa called. Value: %@", idfa_ns);
    return idfa_godot;
}

void GodotAttIosPlugin::request_tracking() {
    NSLog(@"GodotAttIosPlugin: Requesting tracking logic from Swift...");
    
    GodotAttIosPlugin *plugin_instance = this;
    GodotAttIosPluginSwift *swift = [[GodotAttIosPluginSwift alloc] init];
    
    [swift requestTrackingWithCompletion:^(NSString * _Nonnull result) {
        NSLog(@"GodotAttIosPlugin: Result received: %@", result);
        
        String godot_status_string = String(result.UTF8String);
        
        plugin_instance->call_deferred("emit_signal", SIGNAL_TRACKING_COMPLETED, godot_status_string);
    }];
}
