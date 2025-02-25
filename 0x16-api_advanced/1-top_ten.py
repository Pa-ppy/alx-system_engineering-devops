#!/usr/bin/python3
"""
Queries the Reddit API and prints the titles of the first 10 hot posts.
"""
import requests


def top_ten(subreddit):
    """Prints the top 10 hot post titles for \
        a subreddit or 'None' if invalid."""
    url = f"https://www.reddit.com/r/{subreddit}/hot.json?limit=10"
    headers = {"User-Agent": "custom-script/1.0"}

    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code == 200:
        posts = response.json().get("data", {}).get("children", [])
        for post in posts:
            print(post.get("data", {}).get("title"))
    else:
        print("None")
