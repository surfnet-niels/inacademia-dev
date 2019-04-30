<?php
foreach (getallheaders() as $name => $value) {
   $OIDC_header = strpos($name , "OIDC_CLAIM");
   if($OIDC_header !== false) {
        echo "<b>$name</b>: $value</br>";
   }
}
?>
<a href="/protected/redirect_uri?logout=%2Fprotected">Logout</a>
