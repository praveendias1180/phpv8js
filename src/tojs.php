<?php
/**
 * Demo: Sending PHP variables to JS
 */

$v8 = new V8Js();

$phpVar = "Hello, JavaScript!";

/**
 * This is how we pass PHP variables to JS
 */
$v8->var = $phpVar;

/**
 * This is how we reference passed variables in JS
 * PHP.varName
 */
$v8->executeString('var jsVar = PHP.var;');

echo $v8->executeString('jsVar;'); // Output: Hello, JavaScript!