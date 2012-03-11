<?php
  include 'db.php';
  for($i = 0; $i <= 1000; $i++){
    mysql_query("INSERT INTO user (name, profile_id)
                                VALUES ('PHP', 3)");
  }
  print "Inserts complete!";
  mysql_close($con);
?>
