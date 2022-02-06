# TapTracksManager

This is a package which capture each tap occured on the main view (including their subviews) or on one that is selected for this purpose. Every time that the app is moving to background the last ten tap will be printed on the debug console.

The classes used are:
- **TapTracks**: the model that contains a timestamp and the tap coordinates
- **TracksLogger**: is the responsible for log the tracks. At the moment, the tracks are printing on the debug console
- **TracksStorer**: the storage layer for this package. This will save and load the tracks. For simplicity, this is just saving them on memory.
- **TapTracksManager**: the manager who integrate the classes as a whole achieving the desired behaviour.
