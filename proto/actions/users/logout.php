<?php
  include_once('../../config/init.php');
  include_once($BASE_DIR .'database/users.php');
  logoutUser($_SESSION['userid']);
  session_destroy();

  header('Location: ' . $BASE_URL);
?>
