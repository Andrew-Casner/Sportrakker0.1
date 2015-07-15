<?php
/**
 * Code to add a user
 */
include("../Database/config.inc.php");

// assuming that POST data was even added.
try {

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
                $stmt->execute(array(':user_mail_new' => htmlspecialchars($_POST['userEmail']), ':user_pass_new' => htmlspecialchars($_POST['userPassword'])));
                $affected_rows = $stmt->rowCount();
                echo($affected_rows);
            } catch (PDOException $ex) {
                die("Failed to run query: " . $ex->getMessage());
            }

        /***Now add user info to the person table***/
            try {
                $stmt = $db->prepare('INSERT INTO people (user_id,firstname,lastname,email,birth_date,gender,address,city,state_id,zipcode,phone)
                  VALUES (LAST_INSERT_ID(),:firtname, :lastname,:user_mail,:birthdate,:gender,NULL,NULL,NULL,NULL,NULL');
                //use the POSTED email and pass and clean iut
                $stmt->execute(array(':firstname' => htmlspecialchars($_POST['userFirstName']),
                                ':lastname' => htmlspecialchars($_POST['userLastName']),
                                ':user_mail' => htmlspecialchars($_POST['userEmail']),
                                ':birthdate' => htmlspecialchars($_POST['userBirthMonth'].'/'.$_POST['userBirthDay'].'/'.$_POST['userBirthYear']),
                                 'gender' => htmlspecialchars(substr($_POST['userGender'],0,1))));

                $affected_rows = $stmt->rowCount();
                echo($affected_rows);
            } catch (PDOException $ex) {
                die("Failed to run query: " . $ex->getMessage());
            }

        header("Location: User_Login.php");
        }

}
catch(PDOException $ex) {
    echo("oh no");
}
?>