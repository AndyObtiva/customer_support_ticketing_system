Feature: Ticketing As Support Agent
  Support Agents need to service support request tickets reported by customers

Scenario: List open support request tickets
  Given Support Agent is signed in
  And the following support request tickets exist in system:
  | Support Request | Customer Email            | Status |
  | Open Ticket 1   | customer1@opentickets.com | open   |
  | Open Ticket 2   | customer2@opentickets.com | open   |
  | Open Ticket 3   | customer3@opentickets.com | closed |
  When Support Agent chooses to list open support request tickets
  Then Support Agent is presented with the following support request tickets:
  | Support Request | Customer Email            | Status |
  | Open Ticket 1   | customer1@opentickets.com | open   |
  | Open Ticket 2   | customer2@opentickets.com | open   |
  And Support Agent is not presented with the following support request tickets:
  | Support Request | Customer Email            | Status |
  | Open Ticket 3   | customer3@opentickets.com | closed |

Scenario: List closed support request tickets
  Given Support Agent is signed in
  And the following support request tickets exist in system:
  | Support Request | Customer Email            | Status |
  | Open Ticket 1   | customer1@opentickets.com | open   |
  | Open Ticket 2   | customer2@opentickets.com | open   |
  | Open Ticket 3   | customer3@opentickets.com | closed |
  When Support Agent chooses to list open support request tickets
  And Support Agent chooses to filter by closed support request tickets
  Then Support Agent is presented with the following support request tickets:
  | Support Request | Customer Email            | Status |
  | Open Ticket 3   | customer3@opentickets.com | closed |
  And Support Agent is not presented with the following support request tickets:
  | Support Request | Customer Email            | Status |
  | Open Ticket 1   | customer1@opentickets.com | open   |
  | Open Ticket 2   | customer2@opentickets.com | open   |
  And Support Agent chooses to filter by open support request tickets
  Then Support Agent is presented with the following support request tickets:
  | Support Request | Customer Email            | Status |
  | Open Ticket 1   | customer1@opentickets.com | open   |
  | Open Ticket 2   | customer2@opentickets.com | open   |
  And Support Agent is not presented with the following support request tickets:
  | Support Request | Customer Email            | Status |
  | Open Ticket 3   | customer3@opentickets.com | closed |

Scenario: List all support request tickets
  Given Support Agent is signed in
  And the following support request tickets exist in system:
  | Support Request | Customer Email            | Status |
  | Open Ticket 1   | customer1@opentickets.com | open   |
  | Open Ticket 2   | customer2@opentickets.com | open   |
  | Open Ticket 3   | customer3@opentickets.com | closed |
  When Support Agent chooses to list open support request tickets
  And Support Agent chooses to filter by all support request tickets
  Then Support Agent is presented with the following support request tickets:
  | Support Request | Customer Email            | Status |
  | Open Ticket 1   | customer1@opentickets.com | open   |
  | Open Ticket 2   | customer2@opentickets.com | open   |
  | Open Ticket 3   | customer3@opentickets.com | closed |

Scenario: View open support request ticket status and details
  Given Support Agent is signed in
  And the following support request tickets exist in system:
  | Support Request | Customer Email            | Status |
  | Status Ticket 1 | customer1@opentickets.com | closed |
  | Status Ticket 2 | customer2@opentickets.com | open   |
  | Status Ticket 3 | customer3@opentickets.com | closed |
  When Support Agent chooses to list open support request tickets
  And Support Agent chooses to view support request ticket "Status Ticket 2"
  Then Support Agent is presented with support request ticket status and details of "Status Ticket 2"

Scenario: Comment on support request ticket as Support Agent
  Given Support Agent is signed in
  And the following support request tickets exist in system:
  | Support Request  | Customer Email            | Status |
  | Comment Ticket 1 | customer1@opentickets.com | open   |
  When Support Agent chooses to list open support request tickets
  And Support Agent chooses to view support request ticket "Comment Ticket 1"
  When Support Agent submits comment "Help is on its way"
  Then Support Agent is presented with comment "Help is on its way"

Scenario: Close support request ticket as Support Agent
  Given Support Agent is signed in
  And the following support request tickets exist in system:
  | Support Request  | Customer Email            | Status |
  | Closing Ticket 1 | customer1@opentickets.com | open   |
  When Support Agent chooses to list open support request tickets
  And Support Agent chooses to view support request ticket "Closing Ticket 1"
  When Support Agent closes support request ticket "Closing Ticket 1"
  Then Support Agent is presented with support request ticket "Closing Ticket 1" having status "closed"
  And Support Agent cannot submit comments

Scenario: Re-open support request ticket as Support Agent
  Given Support Agent is signed in
  And the following support request tickets exist in system:
  | Support Request  | Customer Email            | Status |
  | Opening Ticket 1 | customer1@opentickets.com | closed |
  When Support Agent chooses to list open support request tickets
  And Support Agent chooses to filter by closed support request tickets
  And Support Agent chooses to view support request ticket "Opening Ticket 1"
  When Support Agent re-opens support request ticket "Opening Ticket 1"
  Then Support Agent is presented with support request ticket "Opening Ticket 1" having status "open"
  And Support Agent can submit comments
