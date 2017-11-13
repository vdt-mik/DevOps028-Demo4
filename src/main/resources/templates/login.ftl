<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="css/login.css">
</head>
<body>

<div class="login">
<h1>Login</h1>
<form method="POST" action="/login?redirect=${RequestParameters.redirect!}">
    <input type="text" name="login" placeholder="Login..." required="required"/>
    <input type="password" name="password" placeholder="Password..." required="required"/>
    <button type="submit" class="btn btn-primary btn-block btn-large">Let me in.</button>
</form>
<br>
</div>

</body>
</html>