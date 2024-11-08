# Lightwave
Lightwave 3D Lscripts
Last checked on Lightwave version 10.1

Modeler:
2PtPolyMaker - Select points and run script. It will generate 2 point polygons between the points.
AllLayersFG - Brings all layers in an object to the foreground. Useful if you don’t work with the Statistics Window open.
CenterPoint - Creates a centerpoint in the middle of a selection, then selects the point after it is created.
ClearLyrNames - Clears the layer names off of layers.
CloneToLayers - Copies the selected geometry to the defined layers.
CloseAllButCurrent - Closes all of the open objects except for the current object.
CycleApplySurfaces - It will take the selected geometry and keep applying textures to it until stopped. Useful for finding out what surface belongs on an object.
DongleCheck - Checks if a dongle is plugged in when Modeler is started. Please note it requires a special install to work.
DongleID - Alerts you to your Dongle ID number.
Fast Set Value - Allows for the quick snapping of points in any axis including U and V.
FixedCopyPaste - Copies the geometry and then selects it so you can then move the newly created geometry.
IsolateLayer - Uses the selected polygons to detect which layer they are on, then brings those layers to the foreground.
Janitor - Cleans up geometry by eliminating common problem geometry, merging points, and unifying polygons.
LyrSurfRenamer - This script will add a prefix to layer names and/or surface names.
MeshCombine - Combines two objects together with options.
MeshMover - Copies the current object into a new object.
MirrorPoints - Mirrors the points’ position based on chosen axis.
MirrorToEmptyLayer - Mirrors the selected geometry to an empty layer instead of current layer.
MoveIt - Saves user defined offsets for moving selected points or polygons and then move them accordingly.
Partify - Creates a new part for each polygon on an object.
PointsToNulls - Saves out the points’ positions to a scene file where they are converted into Nulls.
PolyToSurfaces - Makes every polygon have its own surface.
RadArray 8/9 - Radial array alternative that allows a background point as the center for the array operation. Different versions for LW8 and LW9+
RealtimeSmooth - An interactive previewer for the Smooth tool.
RemoveEmptyLayers - Removes the empty layers in an object.
SaveAllObjects - Saves all objects.
SelectAll - Selects all polygons in the current object.
Selector - Allows for selecting/deselecting of points on chosen sides of axis.
SelectPoint - Allows for interactive selection of a single point based on the point’s ID number.
SelectSurfName - Selects/deselects polygons based on a search phrase (for their surface name).
SelLyrRng - Selects layers based on a range.
SelNegX - Selects all points on the negative X axis.
SelOnePt - Selects one point on each group of connected polygons of the current object.
SelPosX - Selects all points on the positive X axis.
SendToBG - Takes the selected geometry and puts it in the background layer.
SwapPoints - Swaps the point positions of the selected points.
UFlip - Takes a user-defined part (which is usually one half of the model shown in the UV space) and flip its orientation over the 50% mark in the U axis in a given UV map.
Weld Group - Weld pairs of points.
Weld Group Average - Weld Average to pairs of points.

Layout:
AddRandomRotation - Adds random rotation to the selected objects in Layout.
CloneHierarchyRepeat - Creates multiple clones of a selected hierarchy.
CloneRename - Creates clones of a selected object and allows for the immediate renaming/numbering of the clones.
CustomNewLight - Creates lights and saves the settings to create new lights (not clones) and create them across different instances of Lightwave.
DisplaySubpatchLevel - Allows you to do a mass subpatch level change across in the scene.
ExcludeAllLights - Excludes all lights from the selected objects.
HiddenToUnseen - Makes hidden objects UnseenByCamera, and visible objects seen by the camera.
ItemState - Allows for the saving and loading of item render states on a scene by scene basis. Useful on large scenes which may be difficult to remember the item render states for each object when doing test renders.
LightExclusion - Allows for batch excluding/including lights from objects or excluding/including objects from lights based on what is selected.
LightsExcludeAllObjects - Excludes all objects from the selected lights.
LoadItemsRepeat - Launches the load items repeat using a defined scene a chosen number of times.
MakeSceneReadOnly - Makes the currently loaded scene file readonly so that changes cannot be saved to it.
MergeDeselect - Merges the selected polygons and then deselects them.
ModoCameraConversion - Gives the calculations for converting the Lightwave camera into a Modo Camera
MorphSaver - Saves an object’s layers motion into a (linear) morph that can later be animated.
MotLoader - Allows for quick loading of motion files using C:\Temp as a motion folder.
MotSaver - Allows for quick saving of motion files using scene name, time stamp, and C:\Temp as a motion folder.
MultipleKeys - Will select the chosen type of item that has multiple keyframes on it.
MultipleLFS - Allows LoadFromScene from the selected lightwave scene files.
NewCamera - Allows you to create a new camera with an optional target where you can define either a new null to target or an existing object.
NullsToObj - Creates an OBJ from the nulls in a scene. Useful for converting tracking markers to geometry. (1000 Null Limit)
ObjectMask - Creates a black and white matte pass of the selected objects in a scene.
RandomColor - Makes every selected object a random wireframe color.
Rename - A mass renaming utility.
ReplaceSelected - Allows for replacing objects with nulls, a single object, or an object from a list of objects. Also has random and sequential options as well as wireframe color options.
ReplaceTextures - Replaces the images with images from another directory.
ReplaceWithLights - Allows replacing of objects and cameras with Lights.
SaveSelected - Allows for saving just the selected objects as either a normal save or a copy as well as adding an optional prefix.
SaveTransformed - Batch save transformed objects with options.
SelectActive - Takes the item selection and set’s their render checkbox to render. All other items will be turned off so they will not render.
SelectMatteObjects - Selects all objects in the current (saved) scene that have the Matte attribute checked.
VisibilityFrontface - Sets the viewport visibility to frontface wireframe.
VisibilityNone - Sets the viewport visibility to hidden.
