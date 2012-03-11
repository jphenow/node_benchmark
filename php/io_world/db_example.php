<?php
  $host = "";
  $user = "";
  $pass = "";
  $database = "";
  $con = mysql_connect($host, $user, $pass) or die(mysql_error());
  mysql_select_db($database, $con) or die(mysql_error());
?>
