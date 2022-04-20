#!/usr/local/bin/node
const behaviors = require('./behaviors/all')
const util = require('util');
const exec = util.promisify(require('child_process').exec);
const semverMajor = require('semver/functions/major');
const preferences = require('./preferences.json');

const getOperatingSystemMajorVersion = async () => {
    const swVersOutput = await exec(`sw_vers -productVersion`);
    if (swVersOutput.stderr) {
        console.error(`Non-empty stderr from sw_vers: ${swVersOutput.stderr}`);
        process.exit();
    }
    const versionNumber = swVersOutput.stdout;
    const majorVersion = semverMajor(versionNumber);
    return majorVersion;
}
(async () => {
    // Close any open System Preferences panes, to prevent them from overriding
    // settings we’re about to change
    
    let result = await exec(`osascript -e 'tell application "System Preferences" to quit'`);
    if (result.stdout) {
        console.log(`Non-empty stdout: ${result.stdout}`);
    }
    if (result.stderr) {
        console.error(`Non-empty stderr: ${result.stderr}`);
    }
    const majorVersion = await getOperatingSystemMajorVersion();
    const behaviorKeys = Object.keys(preferences);
    for (let key of behaviorKeys) {
        let prefValue = preferences[key];
        const shellScript = behaviors[majorVersion][key][prefValue];
        console.log(`Processing preference for \`${key}\``);
        console.log(`Running \`${shellScript}\``);
        const result = await exec(shellScript);
        if (result.stdout) {
            console.log(`Non-empty stdout: ${result.stdout}`);
        }
        if (result.stderr) {
            console.error(`Non-empty stderr: ${result.stderr}`);
        }
    }
    result = await exec(`killall Finder && killall Dock`);
    if (result.stdout) {
        console.log(`Non-empty stdout: ${result.stdout}`);
    }
    if (result.stderr) {
        console.error(`Non-empty stderr: ${result.stderr}`);
    }
})();