<?php

namespace Bookstore\Domain;

class Book {
  public $isbn;
  public $title;
  public $author;
  public $available;

  public function __construct(
    int $isbn,
    string $title,
    string $author,
    int $available = 0
  ) {
    $this->isbn = $isbn;
    $this->title = $title;
    $this->author = $author;
    $this->available = $available;
  }
  public function getIsbn(): int {
    return $this->isbn;
  }
  public function getTitle(): string {
    return $this->title;
  }
  public function getAuthor(): string {
    return $this->author;
  }
  public function isAvailable(): bool {
    return $this->available;
  }

  public function getPrintableTitle(): string {
    $result = '<i>' . $this->title . '</i> - ' . $this->author;

    if (!$this->available) {
      $result .= ' <b>Not Available</b>';
    }
    return $result;
  }

  public function getCopy(): bool {
    if ($this->available < 1) {
      return false;
    } else {
      $this->available--;
      return true;
    }
  }

  public function addCopy() {
    $this->available++;
  }
}
