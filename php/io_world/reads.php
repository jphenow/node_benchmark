<?php
  include 'db.php';
  $result = mysql_query("SELECT name, email_address FROM user, profile WHERE user.profile_id = profile.id");
  $rows = array();
  while($row = mysql_fetch_assoc($result)) {
    $rows[] = $row;
  }
  print json_encode($rows);
  mysql_close($con);
?>
