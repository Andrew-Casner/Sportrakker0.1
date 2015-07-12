<?php
// Make our db connection via the config script

try{
    $db = new pdo('mysql:host=127.0.0.1:3306;dbname=sportrakker_db', 'root', '');
}catch(PDOException $ex){
    die(json_encode(
        array('outcome' => false, 'message' => 'Unable to connect')
    )
    );
}
?>