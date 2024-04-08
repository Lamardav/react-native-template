import "react-native-gesture-handler";
import {initializeApp} from "./src/app";
import { NativeModules, DevSettings } from "react-native";
import {isDev} from "./src/core/theme/commonConsts";
import {isIos} from "react-native-modalize/lib/utils/devices";

if (isDev) {
    if (isIos) {
        DevSettings.addItem("iOS debugging: Enable", () => NativeModules.DevSettings.setIsDebuggingRemotely(true));
        DevSettings.addItem("iOS debugging: Disable", () => NativeModules.DevSettings.setIsDebuggingRemotely(false));
    }
}

initializeApp();
