<?php

$v8 = new V8Js();
$result = $v8->executeString('3 + 4;');
echo $result;