<?php
// Make our db connection via the config script

try{
    $db = new pdo('mysql:host=127.0.0.1:3306;dbname=sportrakker', 'root', '');
}catch(PDOException $ex){// error handling code
    die(json_encode(
        array('outcome' => false, 'message' => 'Unable to connect')
    )
    );
}

?>