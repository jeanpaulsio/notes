<?php
  $submitted = isset($_POST['username']) && isset($_POST['password']);
  if ($submitted) {
    setcookie('username', $_POST['username']);
  }
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Bookstore</title>
</head>
<body>
  <?php if ($submitted): ?>
    <p>Your login info is</p>
    <ul>
      <li>username: <?php echo $_POST['username']; ?></li>
      <li>password: <?php echo $_POST['password']; ?></li>
    </ul>
  <?php else: ?>
    <p>you did not submit anything</p>
  <?php endif; ?>
</body>
</html>
