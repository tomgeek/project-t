var resolvedDependencies = [], srcFolder = "src", extension = "coffee",
    CLASS_REGEXP = /\[object (.*?)\]/, PLACEHOLDER_REGEXP = /#\{(.*)\}/,
    json, classDefinitions, paths, allDependencies, command;

readDependenciesFile("dependencies.json");

allDependencies = getAllDependencies(json);
console.log("got " + allDependencies.split(" ").length + " dependencies");

command = "coffee -j script/main.js -w -c " + allDependencies;
executeCommand(command);

function readDependenciesFile(file) {
    var fs = require("fs");
    json = JSON.parse(fs.readFileSync(file));
    classDefinitions = json.classDefinition;
    paths = json.paths;
}

function getAllDependencies(json) {
    var globalDependencies = resolveDependencies(json.dependencies.global);
    var otherDependencies = resolveDependencies(json.dependencies.root);
    return globalDependencies + " " + otherDependencies;
}

/**
 * Recursively resolves dependencies, if path is dynamic it replaces the dynamic part.
 * @param dependencies
 * @return {String}
 */
function resolveDependencies(dependencies) {
    var retVal = [], length, i, key, classDefinition;
    if (getType(dependencies) == "array") {
        length = dependencies.length;
        for (i = 0; i < length; i++) {
            retVal.push(resolveDependencies(dependencies[i]));
        }
    } else if (getType(dependencies) == "object") {
        for (key in dependencies) {
            retVal.push(resolveDependencies(dependencies[key]));
        }
    } else if (getType(dependencies) == "string") {
        // either path or class
        if ((classDefinition = classDefinitions[dependencies]) != null) {
            // class => check whether it has another dependencies
            if (classDefinition.dependencies != null) {
                // it has dependencies
                retVal.push(resolveDependencies(classDefinition.dependencies));
            }
            if (resolvedDependencies.indexOf(dependencies) < 0) {
                // it was not added to dependencies
                resolvedDependencies.push(dependencies);
                retVal.push(resolvePath(classDefinition.path));
            }
        } else {
            // path
            retVal.push(resolvePath(dependencies));
        }
    }
    // paths separated with space, but trimmed because already included dependencies returns empty string
    return retVal.join(" ").trim();
}

/**
 * Resolves type of variable
 * @param {Object} object
 * @return {String}
 */
function getType(object) {
    var type = Object.prototype.toString.call(object);
    return type.match(CLASS_REGEXP)[1].toLowerCase();
}

/**
 * Replaces placeholders by actual path
 * @param {String} path
 * @return {string}
 */
function resolvePath(path) {
    return srcFolder + "/" + path.replace(PLACEHOLDER_REGEXP, function(match, group) {
        return paths[group];
    }) + "." + extension;
}

/**
 * Executes the CoffeeScript command for compiling and watching sources.
 * @param {String} command
 */
function executeCommand(command) {
    var exec = require('child_process').exec, child;
    child = exec(command, function (error, stdout, stderr) {
        if (error !== null) {
            console.log('exec error: ' + error);
        }
    });

    child.stdout.on("data", function(chunk) {
        console.log(chunk.trim());
    });
}
