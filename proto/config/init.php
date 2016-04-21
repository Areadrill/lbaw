<?php
  session_set_cookie_params(3600, '/~joao');
  session_start();

  error_reporting(E_ALL); // E_NOTICE by default
  ini_set("display_errors", "1");
  $BASE_DIR = '/home/joao/public_html/lbaw/proto/';
  $BASE_URL = '/~joao/lbaw/proto/';

  $conn = new PDO('pgsql:host=localhost;dbname=lbaw', 'postgres', 'bolachas');
  $conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
  $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

  $conn->exec('SET SCHEMA \'proto\'');

  include_once($BASE_DIR . 'lib/smarty/Smarty.class.php');
  $smarty = new Smarty;
  $smarty->template_dir = $BASE_DIR . 'templates/';
  $smarty->compile_dir = $BASE_DIR . 'templates_c/';
  $smarty->assign('BASE_URL', $BASE_URL);

  $smarty->assign('ERROR_MESSAGES', $_SESSION['error_messages']);
  $smarty->assign('FIELD_ERRORS', $_SESSION['field_errors']);
  $smarty->assign('SUCCESS_MESSAGES', $_SESSION['success_messages']);
  $smarty->assign('FORM_VALUES', $_SESSION['form_values']);
  $smarty->assign('USERNAME', $_SESSION['username']);

  unset($_SESSION['success_messages']);
  unset($_SESSION['error_messages']);
  unset($_SESSION['field_errors']);
  unset($_SESSION['form_values']);
?>
