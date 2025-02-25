#!/usr/bin/python3
"""
Recursively queries the Reddit API, parses hot article titles,\
      and prints a sorted count of given keywords.
"""
import requests


def count_words(subreddit, word_list, word_count=None, after=None):
    """Counts occurrences of keywords in hot article titles\
          from a subreddit."""
    if word_count is None:
        word_count = {}

    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    headers = {"User-Agent": "custom-script/1.0"}
    params = {"after": after} if after else {}

    response = requests.get(url, headers=headers,
                            params=params, allow_redirects=False)
    if response.status_code != 200:
        return

    data = response.json().get("data", {})
    posts = data.get("children", [])

    for post in posts:
        title_words = post.get("data", {}).get("title", "").lower().split()
        for word in word_list:
            lower_word = word.lower()
            t_wd_count = title_words.count(lower_word)
            word_count[lower_word] = word_count.get(lower_word, 0) + t_wd_count

    after = data.get("after")
    if after is not None:
        return count_words(subreddit, word_list, word_count, after)

    sorted_counts = sorted(
        [(word, count) for word, count in word_count.items() if count > 0],
        key=lambda x: (-x[1], x[0])
    )

    for word, count in sorted_counts:
        print(f"{word}: {count}")
