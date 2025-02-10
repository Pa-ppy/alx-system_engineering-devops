#!/usr/bin/python3
"""Fetches and displays an employee's TODO list progress."""
import requests
import sys


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit(1)

    employee_id = sys.argv[1]

    user_url = f"https://jsonplaceholder.typicode.com/users/{employee_id}"
    user_data = requests.get(user_url).json()
    employee_name = user_data.get("name")

    todos_url = (
            f"https://jsonplaceholder.typicode.com/todos?userId={employee_id}"
            )
    todos_data = requests.get(todos_url).json()

    completed_tasks = [task.get("title") for task in todos_data
                       if task.get("completed")]

    print(f"Employee {employee_name} is done with tasks"
          f"({len(completed_tasks)}/{len(todos_data)}):")
    for task in completed_tasks:
        print(f"\t {task}")
