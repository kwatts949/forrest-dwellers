<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="preconnect" href="https://fonts.googleapis.com"> 
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
    <link href="https://fonts.googleapis.com/css2?family=Old+Standard+TT&display=swap" rel="stylesheet">
    <link href="style.css" rel="stylesheet">
    <meta charset=utf-8>
    <title>Sign up!</title>
  </head>
  <body>
    <form align="center" method="POST" action="/home">
      <div>
        <h1>username</h1>
        <label>username:</label>
        <input type="text" name="username"/>
      </div>
      <div>
        <label>email:</label>
        <input type="text" name="email"/>
      </div>
      <div>
        <label>password:</label>
        <input type="password" name="password"/>
      </div>
      <input type="submit"/>
      <button onclick="history.back()">Go Back</button>
    </form>
  </body
</html>