#Now let's make a little program that uses it. Let's read our people.txt file and get an array of objects representing its contents. Then let's print out the first item in the file.

    require 'my-csv'
    data = DataRecord.make("people.txt") # Capture return value and
    list = data.read                     # call a class method on it.
    puts list
    # Output:
    # <People: name=Smith, John age=35 weight=175 height=5'10>

#Here we made use of the fact that the new class was returned from the make method. But the new class is also given the appropriate name, so that it can be accessed directly. The following code is exactly the same in effect.

 #   require 'my-csv'
 #   DataRecord.make("people.txt")  # Ignore the return value and
 #   list = People.read             # refer to the class by name.
 #   puts list[0]
    # Output:
    # <People: name=Smith, John age=35 weight=175 height=5'10>


