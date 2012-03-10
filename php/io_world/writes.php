<?php
  $con = mysql_connect("127.0.0.1", "root", "") or die(mysql_error());
  mysql_select_db("benchmark", $con) or die(mysql_error());
  for($i = 0; $i <= 1000; $i++){
    mysql_query("INSERT INTO user (name, profile_id)
                                VALUES ('PHP', 3)");
  }
  print "Inserts complete!";
  mysql_close($con);
?>
