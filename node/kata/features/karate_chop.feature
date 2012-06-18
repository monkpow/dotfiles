Feature: chop finds the index of a passed value of an array

Scenario:  Finds Array

Given I have the array []             
When I call chop with the value 3
Then I should recieve the result -1     

Given I have the array []     
When I call chop with the value 3
Then I should recieve the result -1     

Given I have the array [1]          
When I call chop with the value 3
Then I should recieve the result -1     

Given I have the array [1]          
When I call chop with the value 1
Then I should recieve the result 0      

Given I have the array [1, 3, 5]    
When I call chop with the value 1
Then I should recieve the result 0      
 
Given I have the array [1, 3, 5]    
When I call chop with the value 3
Then I should recieve the result 1      

Given I have the array [1, 3, 5]    
When I call chop with the value 5
Then I should recieve the result 2      

Given I have the array [1, 3, 5]    
When I call chop with the value 0
Then I should recieve the result -1     

Given I have the array [1, 3, 5]    
When I call chop with the value 2
Then I should recieve the result -1     

Given I have the array [1, 3, 5]    
When I call chop with the value 4
Then I should recieve the result -1     

Given I have the array [1, 3, 5]    
When I call chop with the value 6
Then I should recieve the result -1     

Given I have the array [1, 3, 5, 7] 
When I call chop with the value 1
Then I should recieve the result 0      

Given I have the array [1, 3, 5, 7] 
When I call chop with the value 3
Then I should recieve the result 1      

Given I have the array [1, 3, 5, 7] 
When I call chop with the value 5
Then I should recieve the result 2      

Given I have the array [1, 3, 5, 7] 
When I call chop with the value 7
Then I should recieve the result 3      

Given I have the array [1, 3, 5, 7] 
When I call chop with the value 0
Then I should recieve the result -1     

Given I have the array [1, 3, 5, 7] 
When I call chop with the value 2
Then I should recieve the result -1     

Given I have the array [1, 3, 5, 7] 
When I call chop with the value 4
Then I should recieve the result -1     

Given I have the array [1, 3, 5, 7] 
When I call chop with the value 6
Then I should recieve the result -1     

Given I have the array [1, 3, 5, 7] 
When I call chop with the value 8
Then I should recieve the result -1     
