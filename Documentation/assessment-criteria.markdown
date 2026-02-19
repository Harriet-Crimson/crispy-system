**Stewart Dent** 

AC-1B1: Given I have an existing semester study profile, when I open the study planner, then an overview area is displayed, and I can select modules in the current profile. [Core] 

AC-1B2: Given I do not have an existing semester study profile, when I open the study planner, then I am prompted that I must make a study planner. [Edge Case] 

AC-1B3: Given there is information to be shown, when Stewart checks the relevant information, then it should be well-formatted and easy to understand. [Edge Case] 

 

AC-1C1: Given I have an existing semester study profile and have existing planned events, when I input progress for a planned event into the study planner, then the details of the event are updated. [Core] 

AC-1C2: Given there is information to be shown, when Stewart checks his progress, then the page should update in very little time. [Core] 

 

AC-1D1: Given provided data file is valid, when I initialise a new semester study profile, then the system prompts me for the semester file from the hub. [Core] 

AC-1D2: Given provided data file is invalid, when I initialise a new semester study profile, then I am prompted to provide a valid data file before creation is completed. [Edge Case] 



AC-1E1: Given Stewart has a stable internet connection, when Stewart sets his priorities for a specific task, then the information should be updated throughout the system in a timely manner. [Core] 


**Cassie Sturday**

AC-2A1: Given - that event information already exists When - Cassie view study planner Then - all relevant information is shown. [Core]

AC-2A2: Given - that event information does not already exists When - Cassie view study planner Then - she is informed that no information is available. [Edge Case]

AC-2B1: Given - task exists When - Cassie makes changes a task Then - Task is updated on study planner. [Core]

AC-2B2: Given - task does not exist When - Cassie makes changes a task Then - task is changed and she is informed it doesn't exist. [Edge Case]

AC-2B3: Given - cassie has permission to update a specific task when - Cassie updates the task information Then - the information should be consolidated into an area that makes logical sense for the end-user. [NFR]

AC-2C1: Given - module exists When -  Cassie creates a task Then - all student can view task. [Core]

AC-2C2: Given - module does not exist. When -  Cassie creates a taskThen - study planner not updated and she is informed.[Edge Case]

AC-2C3: Given - Cassie has permission to add a task and has internet access When - Cassie creates a task Then - The booking should be updated and relayed to the students in a timely manner. [NFR]

AC-2D1: Given - module does not already exist When -  Cassie creates a task Then - new module is created. [Core]

AC-2D2: Given - module does already exist. When -  Cassie creates a task Then - study planner not updated and she is informed. [Edge Case]


**Graham Sutherland**
AC-3A1: Given a student exists, when Graham adds student to a module, then the student is added to the module. [Core] 

AC-3A2: Given a student does not exist, when Graham adds student to a module then, the student is not added to the module and Graham is informed. [Edge Case] 

AC-3A3: Given a student does exist, when Graham adds student to a module, then the student's login information should be handled securely. [Core] 
