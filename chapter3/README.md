Chapter 3. Objective-C
======================

* Cappuccino classes are prefixed with "CP" ("Cappuccino") instead of "NS" ("NextStep").
* Declare local variables with "var" instead of their type.
* Don't use "*" to declare a pointer. All JavaScript variables are effectively "pointers".
* JavaScript Array, String, Number, and Boolean instances are "toll-free bridged" to CPArray, CPString, and CPNumber.
* There are no low level "int", "float", "char*" types.

Creating and Using Instances
----------------------------

The `CPArray` class is "toll-free bridged" to JavaScript Arrays (much like how CoreFoundation classes are toll-free bridged to their Cocoa equivalents). This means JavaScript `Array` and Cappuccino `CPArray` instances are interchangeable.

For example, the following three lines are equivalent:

    var foo = [[CPMutableArray alloc] init];
    var foo = new Array(); // using Javascript "Array" constructor
    var foo = []; // using JavaScript Array literal

Note that we omit the "*" in the variable declaration because there is no distinct "pointer" type in Objective-J. All variables are "pointers" to objects.

We also substitute "var" for the type annotation because Objective-J is not statically typed. Remember to include the "var" to avoid leaking variables into the global scope (the source of many bugs in JavaScript programs).

Using Existing Classes
----------------------

Since Objective-J is built on a scripting language, JavaScript, it is easy to write simple command line tools. Simply create a ".j" containing your code:

    @import <Foundation/Foundation.j>

    CPLogRegister(CPLogPrint); // enabled CPLog for the command line

    var array = [[CPMutableArray alloc] init]; // alternatively, Array literal "[]"
    var i;

    for (i = 0; i < 10; i++) {
        var newNumber = i * 3;
        [array addObject:newNumber]; // alternatively, Array method "array.push(newNumber)"
    }

    for (i = 0; i < 10; i++) {
        var numberToPrint = [array objectAtIndex:i]; // alternatively, Array notation "array[i]"
        CPLog("The number at index %d is %s", i, numberToPrint);
    }

No "main()" function is necessary for command line scripts.

Execute this on the command line using the `objj` command line tool:

    objj main.j


NSObject, NSArray, NSMutableArray, and NSString
-----------------------------------------------

### NSObject

Similar to Objective-C, the JavaScript "==" operator will check that two JavaScript objects are the *same* object. However, for the primitive JavaScript types (Number, String, and Boolean) "==" will check that the value is equal. 

Also note that it's considered good practice to use "===" instead of "==" in nearly all cases. The former is more strict about types matching, and is usually what you want.

### NSArray

The above code notes where we could use pure JavaScript Array methods instead of Cappuccino messages:

* `[]` instead of `[[CPMutableArray alloc] init]`
* `array.push(newNumber)` instead of `[array addObject:newNumber]`
* `array[i]` instead of `[array objectAtIndex:i]`

Which you use it up to you. It's common practice to use the less verbose Array literals to get a new array, but still use Objective-J messages for consistency with other Objective-J code.

### NSMutableArray

Since CPArray is toll-free bridged to JavaScript Arrays, which are always mutable, Cappuccino can't enforce immutability. You should still use the correct types to show your intent, and eventually static type checking may be able to enforce mutability.

### NSString

We don't need to prefix strings with "@", since JavaScript Strings are also toll-free bridged to CPString. There are no "C strings". The "@" syntax is supported for Objective-C programmers' convenience.

"Inherits from" versus "Uses" or "Knows About"
----------------------------------------------

Creating Your Own Classes
-------------------------

Creating the LotteryEntry Class
-------------------------------

    @import <Foundation/CPObject.j>

    @implementation LotteryEntry : CPObject
    {
        CPDate entryDate;
        int firstNumber;
        int secondNumber;
    }

    - (void)prepareRandomNumbers
    {
        firstNumber = ((Math.random() * Number.MAX_VALUE) % 100) + 1;
        secondNumber = ((Math.random() * Number.MAX_VALUE) % 100) + 1;
    }
    - (void)setEntryDate:(CPDate)date
    {
        entryDate = date;
    }
    - (CPDate)entryDate
    {
        return entryDate;
    }
    - (int)firstNumber
    {
        return firstNumber;
    }
    - (int)secondNumber
    {
        return secondNumber;
    }

    @end


Changing main.m
---------------

    @import <Foundation/Foundation.j>
    @import "LotteryEntry.j"

    CPLogRegister(CPLogPrint);

    var now = [[CPDate alloc] init];
    // NYI: CPCalender

    var array = [];
    var i;

    for (i = 0; i < 10; i++) {

        // Create a date/time object that is 'i' weeks from now
        var iWeeksFromNow = [CPDate dateWithTimeIntervalSinceNow:(60 * 60 * 24 * 7)]; // close enough

        // Create a new instance of LotteryEntry
        var newEntry = [[LotteryEntry alloc] init];
        [newEntry prepareRandomNumbers];
        [newEntry setEntryDate:iWeeksFromNow];

        // Add the LotteryEntry object to the array
        [array addObject:newEntry];
    }

    for (i = 0; i < 10; i++) {
        // NYI: fast enumeration
        var entryToPrint = array[i];
        // Display its contents
        CPLog("%@", entryToPrint);
    }

Implementing a description Method
---------------------------------

We've simplified the `description` method by using JavaScript String concatenation:

    - (CPString)description
    {
        // NYI: CPDateFormatter
        return entryDate + " = " + firstNumber + " and " + secondNumber;
    }

NSDate
------

Some CPDate methods are missing in Cappuccino, but many are implemented.

Writing Initializers
--------------------

Cappuccino initializers work the same as Cocoa initializers:

    - (id)init
    {
        self = [super init];
        if (self)
        {
            firstNumber = ((Math.random() * Number.MAX_VALUE) % 100) + 1;
            secondNumber = ((Math.random() * Number.MAX_VALUE) % 100) + 1;
        }
        return self;
    }

Initializers with Arguments
---------------------------

Change the `[[LotteryEntry alloc] init]` line in "main.j" to

    var newEntry = [[LotteryEntry alloc] initWithEntryDate:iWeeksFromNow];

and add the following methods to `LotteryEntry` class:

    - (id)initWithEntryDate:(CPDate)theDate
    {
        self = [super init];
        if (self) {
            entryDate = theDate;
            firstNumber = ((Math.random() * Number.MAX_VALUE) % 100) + 1;
            secondNumber = ((Math.random() * Number.MAX_VALUE) % 100) + 1;
        }
        return self;
    }

    - (id)init
    {
        return [self initWithEntryDate:[CPDate date]];
    }

We can throw exceptions using the JavaScript `throw` keyword:

    - (id)init
    {
        throw [CPException exceptionWithName:"BNRBadInitCall"
                    reason:"Initialize Lawsuit with initWithDefendant:"
                  userInfo:nil];
        return nil;
    }


[TODO]

The Debugger
------------
What Have You Done?
-------------------
Meet the Static Analyzer
------------------------
For the More Curious: How Does Messaging Work?
----------------------------------------------
Challenge
---------