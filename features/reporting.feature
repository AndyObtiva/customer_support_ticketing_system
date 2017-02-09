Feature: Reporting
  Support Agents need to view reports on tickets

Scenario: Generate report for last one month's closed support request tickets
  Given Support Agent is signed in
  And current date is 2027/10/19
  And the following support request tickets exist in system:
  | Support Request | Customer Email            | Status | Closed At  |
  | Report Ticket 1 | customer1@opentickets.com | closed | 2027/10/19 |
  | Report Ticket 2 | customer2@opentickets.com | open   |            |
  | Report Ticket 3 | customer3@opentickets.com | closed | 2027/10/01 |
  | Report Ticket 4 | customer4@opentickets.com | open   |            |
  | Report Ticket 5 | customer5@opentickets.com | closed | 2027/09/19 |
  | Report Ticket 6 | customer6@opentickets.com | closed | 2027/09/18 |
  When Support Agent chooses to generate report for last one month's closed support request tickets
  Then Support Agent is presented with the following support request tickets:
  | Support Request | Customer Email            | Status | Closed At  |
  | Report Ticket 1 | customer1@opentickets.com | closed | 2027/10/19 |
  | Report Ticket 3 | customer3@opentickets.com | closed | 2027/10/01 |
  | Report Ticket 5 | customer5@opentickets.com | closed | 2027/09/19 |
  And Support Agent is not presented with the following support request tickets:
  | Support Request | Customer Email            | Status | Closed At  |
  | Report Ticket 2 | customer2@opentickets.com | open   |            |
  | Report Ticket 4 | customer4@opentickets.com | open   |            |
  | Report Ticket 6 | customer6@opentickets.com | closed | 2027/09/18 |
