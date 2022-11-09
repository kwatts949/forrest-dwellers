 <!DOCTYPE html>

<html lang="en">
    <head>
        <link rel="preconnect" href="https://fonts.googleapis.com"> 
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
        <link href="https://fonts.googleapis.com/css2?family=Old+Standard+TT&display=swap" rel="stylesheet">
        <link href="style.css" rel="stylesheet">
        <meta charset=utf-8>
        <title>Forrest Dwellers</title>
    </head>
    <body>
        <h1>Welcome to Forrest Dwellers!</h1>
        <p> Sign up below to stay at your perfect habitat!<p>
    <form>
        <div class="container">

        <h1>Forrest Dwellers</h1>
        <p>Welcome to Forrest Dwellers!  Sign up below to stay at your perfect habitat!<p>
        <form action='/home' method='POST'>
        <div>
            <label for="username"><b>Username</b></label>
            <input 
                type="text"
                placeholder="Enter username"
                name="username"
                id="username"
                required>
            <label for="email"><b>Email</b></label>
            <input
                type="text"
                placeholder="Enter Email"
                name="email"
                id="email"
                required>
            <label for="pwd"><b>Password</b></label>
            <input
                type="password"
                placeholder="Enter Password"
                name="password"
                id="pwd"
                required>
            </div>
                <input type="submit"/>
            <div>
                <p>Already have an account? <a href="/login">Log in</a>.</p>
            </div>
            <div></div>
        </form>
    </body>
<html>             