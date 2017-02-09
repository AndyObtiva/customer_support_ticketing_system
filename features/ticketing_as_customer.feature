Feature: Ticketing As Customer
  Customers need to report support requests via tickets,
  which are recorded and organized in the system to be
  serviced by Support Agents

Scenario: Create support request ticket
  Given Customer is signed in
  When Customer chooses to create a support request ticket
  And Customer submits valid support request ticket form details
  Then Ticket is stored
  And Customer is presented with a confirmation for storing support request ticket

Scenario: List own support request tickets
  Given Customer is signed in
  And Customer has following support request tickets:
  | Support Request |
  | Please help 1   |
  | Please help 2   |
  And the following support request tickets exist in system:
  | Support Request |
  | Please help 3   |
  | Please help 4   |
  When Customer chooses to list own support request tickets
  Then Customer is presented with the following support request tickets:
  | Support Request |
  | Please help 1   |
  | Please help 2   |
  And Customer is not presented with the following support request tickets:
  | Support Request |
  | Please help 3   |
  | Please help 4   |

Scenario: View own support request ticket status and details
  Given Customer is signed in
  And Customer has following support request tickets:
  | Support Request | Status |
  | Help status 1   | closed |
  | Help status 2   | open   |
  When Customer chooses to list own support request tickets
  And Customer chooses to view support request ticket "Help status 1"
  Then Customer is presented with support request ticket status and details of "Help status 1"

Scenario: Comment on support request ticket as Customer
  Given Customer is signed in
  And Customer has following support request tickets:
  | Support Request  |
  | Comment Ticket 1 |
  When Customer chooses to list own support request tickets
  And Customer chooses to view support request ticket "Comment Ticket 1"
  When Customer submits comment "Thanks for the help"
  Then Customer is presented with comment "Thanks for the help"

Scenario: Close support request ticket as Customer
  Given Customer is signed in
  And Customer has following support request tickets:
  | Support Request  | Status |
  | Closing Ticket 1 | open   |
  When Customer chooses to list own support request tickets
  And Customer chooses to view support request ticket "Closing Ticket 1"
  When Customer closes support request ticket "Closing Ticket 1"
  Then Customer is presented with support request ticket "Closing Ticket 1" having status "closed"
  And Customer cannot submit comments

Scenario: Re-open support request ticket as Customer
  Given Customer is signed in
  And Customer has following support request tickets:
  | Support Request    | Status |
  | Reopening Ticket 1 | closed |
  When Customer chooses to list own support request tickets
  And Customer chooses to view support request ticket "Reopening Ticket 1"
  When Customer re-opens support request ticket "Reopening Ticket 1"
  Then Customer is presented with support request ticket "Reopening Ticket 1" having status "open"
  And Customer can submit comments
