#!/usr/bin/python3
"""
Fetches and displays the TODO list progress of an employee using a REST API.
"""
import requests
import sys


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit(1)

    employee_id = sys.argv[1]

    user_url = f"https://jsonplaceholder.typicode.com/users/{employee_id}"
    user_data = requests.get(user_url).json()
    employee_name = user_data.get("name")

    todos_url = f"https://jsonplaceholder.typicode.com/todos?\
            userId={employee_id}"
    todos_data = requests.get(todos_url).json()

    completed_tasks = [task["title"] for task in todos_data
                       if task.get("completed")]
    total_tasks = len(todos_data)
    done_tasks = len(completed_tasks)

    print(f"Employee {employee_name} is done with tasks\
            ({done_tasks}/{total_tasks}):")
    for task in completed_tasks:
        print(f"\t {task}")
