# MULE

MULE (Minimal USD Layout Editor) aims to be a simple USD editor that allows modification and compilation of USD scenes on MacOS through SceneKit.

Currently there is only very limited functionality:
* you can open usd files for preview in SceneKitView
* you can show/hide nodes
* you can save out a flattened USD file

# Editing

Since scenekit takes ownership of the data and cannot work with other than flattened files, the plan for editing is that while scenekit can provide the preview and editing (transformations / flags / materials), the same edits are performed simultaneously through the USD C++ API into the scene files themselves, in sync. 

And hopefully that’ll be a close enough match.

# Samples

Here's MULE running with one of the sample .usdz files from Apple's USDPython bundle:

![mule_window](https://github.com/simpassi/mule/blob/master/images/mule_window.png)

SceneKit debug gives a lot of access to the internals (after conversion):

![scenekit_debug](https://github.com/simpassi/mule/blob/master/images/scenekit_debug.png)

# Next steps

* Saving overrides as a separate layer
* Bringing in multiple USD files at different prim paths and saving out a layout file
* Basic transformation handling
