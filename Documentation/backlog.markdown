**Database:**
* Student Table
  * Has a unique code
  * Stores the first name
  * Stores the last name
  * Stores the email
  * Stores the password(?)
* Tutor Table
  * Has a unique code
  * Stores the name 
  * Stores the last name 
  * Stores the email
  * Stores the password(?)
* Module Table
  * Has a unique code
  * Has the code of the tutor taking it
* Assignment Table
  * Has a unique code
  * Has the code of the module it belongs to
  * Has the date of the deadline
  * Has a value for the assignments weight
  * Should be deleted when module is deleted
* Tasks Table
  * Has a unique code
  * Has the code of assignment it belongs to
  * Has the task type (studying, programming, writing - is a defined set of types)
  * Has the code of the task that it depends on
  * Should be deleted when assignment is deleted
* Progress Table
  * Has a unique code
  * Stores the student code
  * Stores the task code
  * Update’s progress value when students add to the task
  * Should be deleted when task or student is deleted
* Semester Table
  * Has a unique code
  * Stores the code of a student
  * Stores the code of their module
  * Be deleted when student or module are deleted


**Website:** 
(check with wireframes, if change is made write about it in report design rationale)
* Home page
  * HTML
  * CSS tweaks
  * Connected to JS 
* Login page
  * HTML
  * CSS tweaks
  * Connected to JS 
* Account page
  * HTML
  * CSS tweaks
  * Connected to JS 
* Individual Semester Pages
  * HTML
  * CSS tweaks
  * Connected to JS 
* Overall CSS


**JavaScript:**
* Login
  * Verify login information securely
  * Allow the user to login with their UEA account
  * Allow the user to create new login information
	  * Only allow secure passwords to be used
    * Validate that the email used is unique
  * Display user information unrelated to their studies (name, profile)
* Log out
  * Interpret Semester file
  * Request data associated with an account
  * Verify that the account has access to the data requested
  * Display the data requested
* Create Gantt chart
  * Look up task dependencies
  * Find assignment deadline
* Display?
* Take data for new task
  * Validate it against database
 



