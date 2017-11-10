<?php require_once 'functions.php' ?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Bookstore</title>
</head>
<body>
  <p><?php echo loginMessage(); ?></p>
  <?php
    $booksJSON = file_get_contents('books.json');
    $books = json_decode($booksJSON, true);
    if (isset($_GET['title'])) {
      echo '<p>looking for: ' . $_GET['title'] . '</p>';
      if (bookingBook($books, $_GET['title'])) {
        echo 'booked!';
        updateBooks($books);
      } else {
        echo 'the book is not available';
      }
    } else {
      echo '<p>you are not looking for a book?</p>';
    }
  ?>
  <ul>
    <?php foreach ($books as $book): ?>
      <li>
        <a href="?title=<?php echo $book['title']; ?>">
          <?php echo printableTitle($book); ?>
        </a>
      </li>
    <?php endforeach; ?>
  </ul>
</body>
</html>


