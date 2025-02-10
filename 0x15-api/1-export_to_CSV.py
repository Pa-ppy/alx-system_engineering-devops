#!/usr/bin/python3
"""Fetches and exports the TODO list of an employee to a CSV file."""
import csv
import requests
import sys


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit(1)

    employee_id = sys.argv[1]

    user_url = f"https://jsonplaceholder.typicode.com/users/{employee_id}"
    user_data = requests.get(user_url).json()
    username = user_data.get("username")

    todos_url = f"https://jsonplaceholder.typicode.com/todos?\
            userId={employee_id}"
    todos_data = requests.get(todos_url).json()

    filename = f"{employee_id}.csv"
    with open(filename, mode="w", newline="") as file:
        writer = csv.writer(file, quoting=csv.QUOTE_ALL)
        for task in todos_data:
            writer.writerow([employee_id, username,
                             task.get("completed"), task.get("title")])
