<?php
  
  echo "tou aqui em cima";

  include_once('../../config/init.php');
  include_once($BASE_DIR .'database/users.php');

  echo "tou aqui";

  if (!$_POST['username'] || !$_POST['password']) {
    $_SESSION['error_messages'][] = 'Invalid login';
    $_SESSION['form_values'] = $_POST;
    header('Location: ' . $_SERVER['HTTP_REFERER']);
    exit;
  }

  echo "tou aqui 2";

  $username = $_POST['username'];
  $password = $_POST['password'];

  echo "tou aqui 3";

  if (isLoginCorrect($username, $password)) {
    $_SESSION['username'] = $username;
    $_SESSION['success_messages'][] = 'Login successful';
    var_dump('good login');
    header('Location: ' . $BASE_URL .'pages/userpage.php');
  } else {
    $_SESSION['error_messages'][] = 'Login failed';
    var_dump('bad login');
    header('Location: ' . $_SERVER['HTTP_REFERER']);
  }

  echo "tou aqui 4";
?>
