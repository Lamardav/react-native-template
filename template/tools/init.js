const fs = require("fs");
const path = require("path");

const packagerIOSIpPath = path.join(__dirname, "..", "ios", "customPackagerIp.txt");
// const packagerAndroidIpPath = path.join(dir, "..", "android", "app", "src", "main", "assets", "customPackagerIp.txt");

createFileIfNotExist(packagerIOSIpPath, "");
// createFileIfNotExist(packagerAndroidIpPath, "");

function createFileIfNotExist(filePath, content) {
    fs.exists(filePath, function (exists) {
        if (!exists) {
            fs.writeFileSync(filePath, content, {encoding: "utf-8"});
            console.log(`create ${filePath}`);
        }
    });
}
