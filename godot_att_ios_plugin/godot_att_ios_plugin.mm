//
//  godot_att_ios_plugin.mm
//

#import <Foundation/Foundation.h>

#import "godot_att_ios_plugin.h"
#import "godot_att_ios_plugin_implementation.h"

#import "core/config/engine.h"


GodotAttIosPlugin *plugin;

void godot_att_ios_plugin_init() {
	NSLog(@"init plugin");

	plugin = memnew(GodotAttIosPlugin);
	Engine::get_singleton()->add_singleton(Engine::Singleton("GodotAttIosPlugin", plugin));
}

void godot_att_ios_plugin_deinit() {
	NSLog(@"deinit plugin");
	
	if (plugin) {
	   memdelete(plugin);
   }
}
