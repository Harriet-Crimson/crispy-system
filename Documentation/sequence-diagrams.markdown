1C - Stewart tracks progress
```mermaid
sequenceDiagram
  actor Stewart
  actor Website
  actor Server
  actor Module Schema
  actor Student Schema
  Stewart->>Website: Open Study Planner
  Stewart->>Website: Enter username and password
  activate Website
  Website->>Server: Request credential validation
  activate Server
  Server->>Student Schema: Validate credentials
  activate Student Schema
  alt happy path
    Student Schema -->> Server: Student data
    deactivate Student Schema
    Server -->> Website: Student data
    deactivate Server
    Website -->> Stewart: Logged in
    deactivate Website
    Stewart ->> Website: Select module
    activate Website
    Website ->> Server: request Stewart's data for specified module
    activate Server
    Server ->> Module Schema: request Stewart's data for specified module
    activate Module Schema
    Module Schema -->> Server: Stewart's task progress data
    deactivate Module Schema
    Server -->> Website: Stewart's task progress data
    deactivate Server
    Website -->> Stewart: Display progress
    deactivate Website
  else login failiure
    Student Schema -->> Server: No student found
    Server -->> Website: Invalid credentials
    Website -->> Stewart: Show login error
  else data failiure
    Module Schema -->> Server: data not found
    Server -->> Website: data not found
    Website -->> Stewart: Show data not found error
  end

  
```


**2C - Cassie creates a task - Sucess Path**
```mermaid
sequenceDiagram
  actor Cassie
  actor Website
  actor Server
  actor Module Schema
  actor Task Schema
  Cassie->>Website: Select module
  activate Website
  Website->>Server: Request to acess module
  activate Server
  Server->>Module Schema: Select relevant module records
  activate Module Schema
  Module Schema-->>Server: Module information
  deactivate Module Schema
  Server-->>Website: Contents of module page
  deactivate Server
  Website-->>Cassie: View of module information
  Cassie->>Website: Chooses to create a new task
  Website->>Server: Informs it of user request
  activate Server
  Server-->>Website: Page information
  deactivate Server
  Website-->>Cassie: Prompts for tasks details
  Cassie->>Website: Information about new task
  Website->>Server: Validate information about task and pass on info
  activate Server
  Server->>Module Schema: Find relevant Module details
  activate Module Schema
  Module Schema-->>Server: Module code
  deactivate Module Schema
  Server->>Task Schema: Create new task using Module code
  activate Task Schema
  Task Schema-->> Server: Confirm task has been created
  deactivate Task Schema
  Server-->>Website: Confirms information is valid and task created
  deactivate Server
  Website-->>Cassie: Confirms tasks is complete
  deactivate Website
```
**2C - Cassie creates a task - Failure Path**
```mermaid
sequenceDiagram
  actor Cassie
  actor Website
  actor Server
  actor Module Schema
  Cassie->>Website: Select module
  activate Website
  Website->>Server: Request to acess module
  activate Server
  Server->>Module Schema: Select relevant module records
  activate Module Schema
  Module Schema-->>Server: Module does not exist
  deactivate Module Schema
  Server-->>Website: Error message
  deactivate Server
  Website-->>Cassie: Unable to find module
  deactivate Website
```
