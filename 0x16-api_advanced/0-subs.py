#!/usr/bin/python3
"""
Queries the Reddit API and returns the number of \
    subscribers for a given subreddit.
"""
import requests


def number_of_subscribers(subreddit):
    """Returns the total number of subscribers for a\
        subreddit or 0 if invalid."""
    url = f"https://www.reddit.com/r/{subreddit}/about.json"
    headers = {"User-Agent": "custom-script/1.0"}

    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code == 200:
        return response.json().get("data", {}).get("subscribers", 0)
    return 0
