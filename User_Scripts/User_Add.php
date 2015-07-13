<?php
/**
 * Code to add a user
 */
//Will make our database connection.
include("../Database/config.inc.php");

// assuming that POST data was even added.
try {
    if (array_key_exists('content', $_POST)) {
        echo("Post recieved...");//should add to html

        // Check if the username is already taken
        try { //executes statement to database
            $stmt = $db->prepare('SELECT 1 FROM users WHERE user_mail = :user_mail_new');
            //use the POSTED email, and clean it
            $stmt->execute(array(':user_mail_new' => htmlspecialchars($_POST['userEmail'])));
        } catch (PDOException $ex) {
            die("Failed to run query: " . $ex->getMessage());
        }
        $row = $stmt->fetch();
        if ($row) {
            die("This username is already in use");
        }
        else{//exit if any user has this existing username

            //Now to enter our new user into the database
            //Create query that will add user into a database
            try {
                $stmt = $db->prepare('INSERT INTO users (user_id,user_mail,user_pass) VALUES (NULL, :user_mail_new, :user_pass_new)');
                //use the POSTED email and pass and clean it
                $stmt->execute(array(':user_mail_new' => htmlspecialchars($_POST['userEmail']), ':user_pass_new' => htmlspecialchars($_POST['userPass'])));
                $affected_rows = $stmt->rowCount();
                echo($affected_rows);
            } catch (PDOException $ex) {
                die("Failed to run query: " . $ex->getMessage());
            }



        }
    }
}
catch(PDOException $ex) {

}
?>