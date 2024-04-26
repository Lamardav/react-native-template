# Patch list and description 

* React-native 0.72.12. [Reason](https://stackoverflow.com/questions/71702392/viewproptypes-will-be-removed-from-react-native-migrate-to-viewproptypes-export).
If react-native fix this problem, *deprecated-react-native-prop-types* may be removed from node_modules
* react-native-device-detection 0.2.1.
  Outdated, but used in the project to specify new dimensions of iPhones (the change is written right inside the patch)
* React-native-fast-image 8.6.3. [Reason](https://github.com/DylanVann/react-native-fast-image/issues/1002).
  Crash on ios 17+. Lib is outdated and need to removed from proj but still nice works especially with flatLists
