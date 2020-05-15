/*:
 ## Exercise - Type Casting and Inspection
 
 Create a collection of type [Any], including a few doubles, integers, strings, and booleans within the collection. Print the contents of the collection.
 */
var collection: [Any] = ["Hi", 32, 4.444, true]
print(collection)

/*:
 Loop through the collection. For each integer, print "The integer has a value of ", followed by the integer value. Repeat the steps for doubles, strings and booleans.
 */
for item in collection {
    if let integer = item as? Int {
        print("The integer has a value of \(integer)")
    }
}

for item in collection {
    if let boolean = item as? Bool {
        print("The boolean has a value of \(boolean)")
    }
}

for item in collection {
    if let double = item as? Double {
        print("The double has a value of \(double)")
    }
}
/*:
 Create a [String : Any] dictionary, where the values are a mixture of doubles, integers, strings, and booleans. Print the key/value pairs within the collection
 */
var mixture: [String: Any] = ["Salam": 5, "Krasniy": "Red", "Pravda": true, "Double": 32.32, "Cifra": "5.25"]
print(mixture)

/*:
 Create a variable `total` of type `Double` set to 0. Then loop through the dictionary, and add the value of each integer and double to your variable's value. For each string value, add 1 to the total. For each boolean, add 2 to the total if the boolean is `true`, or subtract 3 if it's `false`. Print the value of `total`.
 */
var total: Double = 0

for item in mixture {
    if let integer = item.value as? Int {
        total += Double(integer)
    }
    if let double = item.value as? Double {
        total += double
    }
    if let string = item.value as? String {
        total += 1
    }
    if let boolean = item.value as? Bool {
        if boolean == true {
            total += 2
        } else {
            total -= 3
        }
    }
}

print(total)
/*:
 Create a variable `total2` of type `Double` set to 0. Loop through the collection again, adding up all the integers and doubles. For each string that you come across during the loop, attempt to convert the string into a number, and add that value to the total. Ignore booleans. Print the total.
 */
var total2: Double = 0

for item in mixture {
    if let string = item.value as? String {
    if let integerString = string as? Double {
        total2 += integerString
    }
        
    if let integer = item.value as? Int {
        total2 += Double(integer)
    }
    if let double = item.value as? Double {
        total2 += double
    }
    
    }
}

print(total2)
//: page 1 of 2  |  [Next: App Exercise - Workout Types](@next)
