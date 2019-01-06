# MULE

MULE (Minimal USD Layout Editor) aims to be a simple USD editor that allows modification and compilation of USD scenes on MacOS through SceneKit.

Currently there is only very limited functionality: you can open usd files for preview in SceneKitView and show/hide nodes.

# Editing

Since scenekit takes ownership of the data and cannot work with other than flattened files, the plan for editing is that while scenekit can provide the preview and editing (transformations / flags / materials), the same edits are performed simultaneously through the USD Python API into the scene files themselves, in sync. 

And hopefully that’ll be a close enough match. 