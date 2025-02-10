#!/usr/bin/python3
"""Fetches and exports the TODO list of an employee to a JSON file."""
import json
import requests
import sys


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit(1)

    employee_id = sys.argv[1]

    user_url = f"https://jsonplaceholder.typicode.com/users/{employee_id}"
    user_data = requests.get(user_url).json()
    username = user_data.get("username")

    todos_url = (
            f"https://jsonplaceholder.typicode.com/todos?userId={employee_id}"
            )
    todos_data = requests.get(todos_url).json()

    tasks_list = [
        {
            "task": task.get("title"),
            "completed": task.get("completed"),
            "username": username,
        }
        for task in todos_data
    ]
    json_data = {str(employee_id): tasks_list}

    filename = f"{employee_id}.json"
    with open(filename, mode="w") as file:
        json.dump(json_data, file)
