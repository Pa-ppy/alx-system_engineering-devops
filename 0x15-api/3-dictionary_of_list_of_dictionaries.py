#!/usr/bin/python3
"""
Fetches and exports TODO list data of all employees to a JSON file.
"""
import json
import requests


if __name__ == "__main__":
    base_url = "https://jsonplaceholder.typicode.com"

    users = requests.get(f"{base_url}/users").json()

    all_tasks = {}

    for user in users:
        user_id = str(user.get("id"))
        username = user.get("username")

        todos = requests.get(f"{base_url}/todos",
                             params={"userId": user_id}).json()

        all_tasks[user_id] = [
            {
                "username": username,
                "task": todo.get("title"),
                "completed": todo.get("completed"),
            }
            for todo in todos
        ]

    with open("todo_all_employees.json", "w") as json_file:
        json.dump(all_tasks, json_file)
