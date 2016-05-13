<?php

function createUser($username, $password, $email) {
	global $conn;
	$salt = hash("sha512", utf8_encode(mcrypt_create_iv(256,MCRYPT_DEV_URANDOM)));
	$stmt = $conn->prepare("INSERT INTO users VALUES (default,?, ?, ?, ?, clock_timestamp(),clock_timestamp()) RETURNING userid");
	$stmt->execute(array($username, hash("sha256",$password.$salt),$salt, $email));
	$result = $stmt->fetch();
	if($result == true){
		$_SESSION['username'] = $username;
		$_SESSION['userid'] = $result['userid'];
		return true;
	}
	return false;
}

function isLoginCorrect($username, $password) {
	global $conn;
	$stmt = $conn->prepare("SELECT salt, password, userid
			FROM users
			WHERE username = ?");
	$stmt->execute(array($username));
	$res = $stmt->fetch();

	if($res){
		$saltedPw = $_POST['password'].$res['salt'];
		if(hash('sha256', $saltedPw) === $res['password']){
			$_SESSION['username'] = $username;
			$_SESSION['userid'] = $res['userid'];
			//$_SESSION['tok'] = bin2hex(openssl_random_pseudo_bytes(50));
			return true;
		}
	}

	return false;
}

function logoutUser($userid) {
	global $conn;
	$stmt = $conn->prepare("UPDATE Users SET lastLogout = clock_timestamp() WHERE userid = ?");
	$stmt->execute(array($userid));
	return $stmt->fetch() == true;
}

function getUsername($userID){
	global $conn;
	$stmt = $conn->prepare("SELECT username FROM Users WHERE userid = ?");
	$stmt->execute(array($userID));
	return $stmt->fetch()['username'];
}

function getUserByEmail($email){
	global $conn;
	$stmt = $conn->prepare("SELECT userid FROM Users WHERE email = :email");
	$stmt->bindParam(':email', $email);
	$stmt->execute(array($email));
	$results = $stmt->fetch();
	if ($results == false)
		return false;
	return $results['userid'];

}
function getUserEmail($userid){
	global $conn;
	$stmt = $conn->prepare("SELECT email FROM Users WHERE userid = ?");
	$stmt->execute(array($userid));
	$result = $stmt->fetch();
	if($result === false)
		return false;
	return $result['email'];
}

function getUserInfo($userid){
	global $conn;
	$stmt = $conn->prepare("SELECT joindate, location, birthday, education FROM Users WHERE userid = ?");
	$stmt->execute(array($userid));
	$result = $stmt->fetch();
	if($result === false){
		return false;
	}
	return $result;
}

function recoverUserPassword($userId, $base_url){
	global $conn;
	$stmt = $conn->prepare("INSERT INTO passwordrecovery VALUES (default, ?, clock_timestamp(), ?)");
	$uuid = getGUID();
	$stmt->execute(array($userId, $uuid));
	$subject = "ProjectHarbor Password Recovery";
	$headers = array();
	$headers[] = "MIME-Version: 1.0";
	$headers[] = "Content-type: text/plain; charset=iso-8859-1";
	$headers[] = "From: projectharbor@lbaw.com";
	$headers[] = "Subject: {$subject}";
	$headers[] = "X-Mailer: PHP/".phpversion();
	$email = getUserEmail($userId);
	if ($email == false)
		return false;
	$messageBody = "You, or someone who knows your email, attempted to recover a password for the website ProjectHarbor.\r\n
If this wasn't you or this recovery was initiated by mistake no action is required on your part.\r\n
If you wish to reset the password please follow the link below \r\n" . "gnomo.fe.up.pt".$base_url . "pages/passwordreset.php".'?uuid='.$uuid.'&userid='.$userId;
	mail($email, $subject, $messageBody, implode("\r\n", $headers));
}

function updateInfo($email, $location, $bday, $education, $userid){
	global $conn;

	$stmt = $conn->prepare("UPDATE Users SET email = ?, location = ?, birthday=?, education=? WHERE userid=?");
	$stmt->execute(array($email, $location, $bday, $education, $userid));
	return $stmt->fetch == true;
}

function updatePassword($pass){
	global $conn;
	$stmt = $conn->prepare("SELECT salt FROM users WHERE userid = ?");
	$stmt->execute(array($_SESSION['userid']));
	$salt = $stmt->fetch();

	$stmt = $conn->prepare("UPDATE Users SET password = ? WHERE userid = ?");
	$stmt->execute(array(hash('sha256', $pass.$salt['salt']), $_SESSION['userid']));

	return $stmt->fetch() == true;

}
function resetPassword($pass, $userid){
	global $conn;
	$stmt = $conn->prepare("SELECT salt FROM users WHERE userid = ?");
	$stmt->execute(array($userid));
	$salt = $stmt->fetch();

	$stmt = $conn->prepare("UPDATE Users SET password = ? WHERE userid = ?");
	$stmt->execute(array(hash('sha256', $pass.$salt['salt']), $userid));
	var_dump($stmt->rowCount());
	return $stmt->rowCount() == 1;

}
function deleteRecovery($uuid){
	global $conn;
	$stmt = $conn->prepare("DELETE FROM passwordrecovery WHERE uniqueidentifier = ?");
	$stmt->execute(array($uuid));
	return $stmt->rowCount() == 1;
}

function validateRecovery($user, $uuid){
	global $conn;
	$stmt = $conn->prepare("SELECT COUNT(passwordrecoveryid) FROM passwordrecovery WHERE
					userid = ? AND uniqueidentifier = ?");
	$stmt->execute(array($user, $uuid));
	$exists = $stmt->fetch();
	if($exists != 0){
		return true;
	}
	return false;
}
//taken from http://stackoverflow.com/a/18206984
function getGUID(){
	if (function_exists('com_create_guid')){
		return com_create_guid();
	}
	else {
		mt_srand((double)microtime()*10000);//optional for php 4.2.0 and up.
		$charid = strtoupper(md5(uniqid(rand(), true)));
		$hyphen = chr(45);// "-"
		$uuid = chr(123)// "{"
			.substr($charid, 0, 8).$hyphen
			.substr($charid, 8, 4).$hyphen
			.substr($charid,12, 4).$hyphen
			.substr($charid,16, 4).$hyphen
			.substr($charid,20,12)
			.chr(125);// "}"
		return $uuid;
	}
}
?>
