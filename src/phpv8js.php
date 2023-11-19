<div style="font-size:60px; padding: 20px;">

    <?php

    $v8 = new V8Js();

    /* basic.js */
    $JS = <<< EOT
        len = print('Hello' + ' ' + 'World! from JS' + "\\n");
        len;
        EOT;

    try {
        var_dump($v8->executeString($JS, 'basic.js'));
    } catch (V8JsException $e) {
        var_dump($e);
    }

    ?>

</div>
<pre style="padding: 10px; border: 1px solid #ccc; margin: 10px; margin-top: 30px;">

$v8 = new V8Js();

/* basic.js */
$JS = <<< EOT
    len = print('Hello' + ' ' + 'World! from JS' + "\\n");
    len;
    EOT;

try {
    var_dump($v8->executeString($JS, 'basic.js'));
} catch (V8JsException $e) {
    var_dump($e);
}

<pre>