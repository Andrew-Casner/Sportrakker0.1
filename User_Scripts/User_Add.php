<?php
/**
 * Code to add a user
 */
//Will make our database connection.
include("../Database/config.inc.php");

// assuming that POST data was even added.
try {
    if (array_key_exists('content', $_POST)) {
        Console.log("Post recieved...");
        //First check if user is not already created
        // Check if the username is already taken
        $query = "SELECT 1 FROM users WHERE user_name = :username";
        $query_params = array(':username' => $_POST['userName']);//Grab post data
        try { //executes statement to database
            $stmt = $db->prepare($query);
            $result = $stmt->execute($query_params);
        } catch (PDOException $ex) {
            die("Failed to run query: " . $ex->getMessage());
        }
        $row = $stmt->fetch();
        if ($row) {
            die("This username is already in use");
        }//exit if any user has this existing username

        //Now to enter our new user into the database
        //Create query that will add user into a database
        $query = "INSERT INTO users VALUES (NULL,:username,:password)";
        $query_params = array(':username' => $_POST['userName'], ':password' => $_POST["userPassword"]);
        try { //executes statement to database
            $stmt = $db->prepare($query);
            $result = $stmt->execute($query_params);
        } catch (PDOException $ex) {
            die("Failed to run query: " . $ex->getMessage());
        }

        // Obtain user id of user we just created
        $query = "SELECT user_id FROM users where user_name = :username";
        $query_params = array(':username' => $_POST['userName']);
        try { //executes statement to database
            $stmt = $db->prepare($query);
            $result = $stmt->execute($query_params);
        } catch (PDOException $ex) {
            die("Failed to run query: " . $ex->getMessage());
        }

        // Now that we added a user we can link it to the personal data table


    }
}
catch(PDOException $ex) {

}
?>