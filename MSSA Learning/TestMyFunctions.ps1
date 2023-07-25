function AreaOfRectangle {
  param (
    $Length,
    $Width
  )

  $Area = $Length * $Width
  return $Area
}

AreaOfRectangle -Length 5 -Width 10
$AreaOfObject