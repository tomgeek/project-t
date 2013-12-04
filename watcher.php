<?php
//TODO:
//	into classes
//	exception handling
//	checking:
//		json pattern structure
//		file exists

$srcFolder = "src/";
$srcExtension = ".coffee";

$file = (isset($argv[1]) != null) ? $argv[1] : "dependencies.json";
$outputFile = (isset($argv[2]) != null) ? $argv[2] : "script/main.js";
$content = file_get_contents($file);
$content = json_decode($content);

//to array
$content->classDefinition = (array) $content->classDefinition;

//root na prvni misto
if (isset($content->dependencies->root)) {
	if (array_key_exists($content->dependencies->root, $content->classDefinition)) {
		$value = $content->classDefinition[$content->dependencies->root];
		unset($content->classDefinition[$content->dependencies->root]);
		$content->classDefinition = array($content->dependencies->root => $value) + $content->classDefinition;
	}
}

$result = array();
array_walk($content->classDefinition, function($val, $key) use(&$result) {
	$result[] = $key;
	if (isset($val->dependencies)) {
		$l = array_search($key, $result);
		$r = $l ? $l : 0;
		if (is_array($val->dependencies)) {
			foreach ($val->dependencies as $dependecy) {
				array_splice($result, $r, 0, array($dependecy));
			}
		} else {
			array_splice($result, $r, 0, array($val->dependencies));
		}
	}
});

$result = array_unique($result);

//nahradit jmeno tridy cestou
foreach ($result as $key => $val) {
	$result[$key] = $content->classDefinition[$val]->path;
}
//pripojit globalni cesty na zacatek pole
$result = array_merge($content->dependencies->global, $result);

//nahradit promenne v cestach za plnohodnotne cesty a pripojit jmeno souboru
foreach ($result as $key => $value) {
	preg_match('/#{(?P<constant>\w+)}/', $value, $matches);
	$result[$key] = $srcFolder . (isset($matches["constant"]) ? str_replace($matches[0], $content->paths->$matches["constant"], $value) : $value) . $srcExtension;
}

$command = "coffee -j " . $outputFile . " -w -c  " . implode(" ", $result);
echo "watching: " . count($result) . " files\n";
echo system($command);
