<?php

  function createUser($username, $password, $email) {
    global $conn;
    $salt = mcrypt_create_iv(256,MCRYPT_DEV_URANDOM);
    $stmt = $conn->prepare("INSERT INTO users VALUES (default,?, ?, ?, ?, clock_timestamp(),clock_timestamp())");
    $stmt->execute(array($username, $realname, hash("sha256",$password.$salt),$salt));
    return $stmt->fetch() == true;
  }

  function isLoginCorrect($username, $password) {
    global $conn;
    $stmt = $conn->prepare("SELECT salt, password
                            FROM users
                            WHERE username = ?");
    $stmt->execute(array($username));
    $salt = $stmt->fetch();

    if($res){
      $saltedPw = $_POST['password'].$res['salt'];
      if(hash('sha256', $saltedPw) === $res['password']){
        $_SESSION['username'] = $username;
        $_SESSION['id'] = $res['uid'];
        //$_SESSION['tok'] = bin2hex(openssl_random_pseudo_bytes(50));
        return true;
      }
    }

    return false;
  }
?>
