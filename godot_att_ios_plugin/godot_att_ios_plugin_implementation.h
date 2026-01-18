#ifndef godot_att_ios_plugin_implementation_h
#define godot_att_ios_plugin_implementation_h

#include "core/object/object.h"
#include "core/object/class_db.h"

class GodotAttIosPlugin : public Object {
    GDCLASS(GodotAttIosPlugin, Object);
    
    static void _bind_methods();
    
public:
    void hello_world();
    
    void request_tracking();
    bool can_show_request_dialog();
    String get_idfa();
    
    GodotAttIosPlugin();
    ~GodotAttIosPlugin();
};

#endif /* godot_att_ios_plugin_implementation_h */
