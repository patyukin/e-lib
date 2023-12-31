<?php

declare(strict_types=1);

/*
 * Made for YouTube channel https://www.youtube.com/@eazy-dev
 */

namespace App\Model;

class BookChapterTreeResponse
{
    /**
     * @param BookChapter[] $items
     */
    public function __construct(private array $items = [])
    {
    }

    /**
     * @return BookChapter[]
     */
    public function getItems(): array
    {
        return $this->items;
    }

    public function addItem(BookChapter $chapter): void
    {
        $this->items[] = $chapter;
    }
}
