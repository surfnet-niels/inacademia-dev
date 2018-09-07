<?php
foreach (getallheaders() as $name => $value) {
   $OIDC_header = strpos($name , "OIDC_CLAIM");
   if($OIDC_header !== false) {
        echo "<b>$name</b>: $value</br>";
   }
}
?>

