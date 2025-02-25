#!/usr/bin/python3
"""
Recursively queries the Reddit API and returns a\
      list of all hot article titles.
"""
import requests


def recurse(subreddit, hot_list=[], after=None):
    """Returns a list of all hot post titles for \
        a subreddit, or None if invalid."""
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    headers = {"User-Agent": "custom-script/1.0"}
    params = {"after": after} if after else {}

    response = requests.get(url, headers=headers,
                            params=params, allow_redirects=False)
    if response.status_code == 200:
        data = response.json().get("data", {})
        posts = data.get("children", [])
        for post in posts:
            hot_list.append(post.get("data", {}).get("title"))

        after = data.get("after")
        if after is not None:
            return recurse(subreddit, hot_list, after)
        return hot_list
    return None
