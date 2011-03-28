Feature: Manage travels
  In order to make travelling easier
  The traveller
  wants to find information about travelling to their destination
  
  Scenario: Submit a journey
    Given I am on the home page
      And the following airports:
        |code|
        |MEL|
        |LAX|

      And the following currencies:
        |code|
        |AUD|
        |USD|

    When I fill in "travel_from" with "MEL"
    And I fill in "travel_to" with "LAX"
    And I press "Fly"
    Then I should see "MELBOURNE"
    And I should see "LOS ANGELES"
    Then I should see "AUD"
    Then I should see "USD"

