<?php
/**
 * Will login user if credentials are correct
 * Will initiate PHP session management
 */
include("../Database/config.inc.php");

$message = 'nothing';
echo($message);
/*** check that both the username, password have been submitted ***/
if(!isset( $_POST['userEmailLogin'], $_POST['userPasswordLogin']))
{
    $message = 'Please enter a valid username and password';
    echo($message);
}

else
{


    try
    {
        /*** prepare the select statement ***/
        $stmt = $db->prepare("SELECT user_id, user_mail, user_pass FROM users
                    WHERE user_mail = :user_mail_query AND user_pass = :user_pass_query");

        /*** execute the prepared statement ***/
        $stmt->execute(array(':user_mail_query' => htmlspecialchars($_POST['userEmailLogin']),':user_pass_query' => htmlspecialchars($_POST['userPasswordLogin'])));

        /*** check for a result ***/
        $user_id = $stmt->fetchColumn(0);
        $user_email = $stmt->fetchColumn(1);
        /*** if we have no result then fail boat ***/
        if($user_id == false)
        {
            $message = 'Login Failed';
        }
        /*** if we do have a result, all is well ***/
        else
        {
            /*** set the session user_id variable ***/
            $_SESSION['user_id'] = $user_id;

            /*** set the session user_id variable ***/
            $_SESSION['user_email'] = $user_email;
            /*** tell the user we are logged in ***/
            $message = 'You are now logged in, ';
        }

        echo($message);
        echo('Hello '.$user_email);
    }
    catch(Exception $e)
    {
        /*** if we are here, something has gone wrong with the database ***/
        $message = 'We are unable to process your request. Please try again later"';
    }

}
?>