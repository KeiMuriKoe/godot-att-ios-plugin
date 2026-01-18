# ATT iOS Godot Plugin
A Godot Android plugin for integrating ATT request into Godot 4.5.1+.

## Usage
* Copy the **GodotAttIosPlugin** folder into your Godot project's **ios/plugins** directory
* Add the script [att_manager.gd](att_manager.gd) to **AutoLoad**
* Use the **AttManager** singleton to interact with the plugin

`request_tracking() -> void`

`can_show_request_dialog() -> bool`

`get_idfa() -> String`

[`Godot iOS Plugin Template fork by KeiMuriKoe`](https://github.com/KeiMuriKoe/godot-ios-plugin-template)