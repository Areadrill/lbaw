<?php

function createUser($username, $password, $email) {
	global $conn;
	$salt = utf8_encode(mcrypt_create_iv(256,MCRYPT_DEV_URANDOM));
	$stmt = $conn->prepare("INSERT INTO users VALUES (default,?, ?, ?, ?, clock_timestamp(),clock_timestamp())");
	$stmt->execute(array($username, hash("sha256",$password.$salt),$salt, $email));
	return $stmt->fetch() == true;
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

function getUserByEmail($email){
	global $conn;
	$stmt = $conn->prepare("SELECT userid FROM Users WHERE email = :email");
	$stmt->bindParam(':email', $email);
	$results = $stmt->execute(array($email));
	if ($results == false)
		return false;
	return $results['userid'];

}
function getUserEmail($userId){
	global $conn;
	$stmt = $conn->prepare("SELECT email FROM Users WHERE userid = ?");
	$result = $stmt->execute(array($userid));
	if($result == false)
		return false;
	return $result['email'];
}
function recoverUserPassword($userId){
	global $conn;
	$stmt = $conn->prepare("INSERT INTO passwordrecovery VALUES (default, ?, clock_timestamp(), ?)");
	$uuid = com_create_guid();
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
			If this wasn't you or it was performed by mistake no action is required on your part.\r\n
			If you wish to reset the password please follow the link below \r\n" . $BASE_UR . "pages/users/passwordreset.php";
	mail($email, $subject, $messageBody, implode("\r\n", $headers)); 	
}
?>
