Feature: creating a new blog post
  In order to share my thoughts with the world
  As an author
  I want to publish personal content

  Background: creating the post
    Given I am on the new post page

  Scenario: creating a new post
    When I fill out all the required new post form fields
    And I submit the form
    Then I should see "Post successfully created"
    And I should be on the posts page
