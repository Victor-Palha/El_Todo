# ElTodo 📝

ElTodo is a simple in-memory **To-Do list manager** built with Elixir.  
It leverages **GenServer** to handle task persistence and management efficiently.  

## 🚀 Features
- Add tasks with a unique ID
- List all tasks
- Update tasks by ID
- Remove tasks by ID
- Uses **GenServer** for concurrency and state management
- **Automatically starts the GenServer** using an **Application Supervisor**

## 📦 Installation

Clone the repository and install dependencies:

```sh
git clone https://github.com/Victor-Palha/El_Todo.git
cd El_Todo
```

## 🏗️ Usage

### Starting the Task Manager
Since **ElTodo** is managed by an **Application Supervisor**, simply run:

```sh
iex -S mix
```

The **GenServer** will start automatically.

### Adding a Task
```elixir
ElTodo.Manager.add_task("Buy groceries")
```

### Listing Tasks
```elixir
ElTodo.Manager.list_tasks()
```

### Update a Task
```elixir
ElTodo.Manager.update_tasks(task_id, :state)
```

### Removing a Task
```elixir
ElTodo.Manager.remove_task(task_id)
```

## 🛠️ How it Works
- Uses **GenServer** to maintain state across function calls.
- Tasks are stored in memory as a list of structs (`ElTodo.Task`).
- `Task.new/1` automatically assigns a UUID.
- **Application Supervisor** ensures the **GenServer** starts automatically when the application runs.

## 🔥 Running in IEx
Test it interactively:

```elixir
ElTodo.Manager.add_task("Study Elixir")
ElTodo.Manager.list_tasks()
ElTodo.Manager.update_task("fc647333-f4cc-529b-d57e-c05835d0ae19", :progress) # Replace with actual UUID
ElTodo.Manager.remove_task("fc647333-f4cc-529b-d57e-c05835d0ae19") # Replace with actual UUID
```

---

Made with 💜 in Elixir.