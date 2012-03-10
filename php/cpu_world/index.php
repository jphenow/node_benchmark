<?php
echo "Fibonacci: " . fibonacci(20);

function fibonacci($y){
  $fibminus2 = 0;
  $fibminus1 = 1;
  $fib = 0;

  if($y == 0 || $y == 1){
    return $y;
  }
  for($i=2;$i <= $y; $i++){
    $fib = $fibminus1 + $fibminus2;
    $fibminus2 = $fibminus1;
    $fibminus1 = $fib;
  }
  return $fib;
}
?>
