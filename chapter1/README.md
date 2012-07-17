Chapter 1. Cappuccino: What Is It?
==================================

A Little History
----------------

Cappuccino is a programming environment for building rich, "desktop-class", client-side web applications. It consists of two major pieces: the "Objective-J" programming language, and the "Cappuccino" application framework. Applications built with Cappuccino will run in most web browsers used today.

Objective-J is a small language extension to the popular JavaScript programming language, adding most of the same features that Objective-C adds to C. Objective-J itself is implemented in JavaScript, so it doesn't require proprietary browser extensions like Flash or Java.

Cappuccino is the application framework built using Objective-J, which implements many of the Cocoa APIs. However, Cappuccino's functionality is constrained to what browsers allow web pages to do, so certain features like direct filesystem access are not usually possible. 

Figure 1.1 Where is Cappuccino?

+------------+----------+
| Cappuccino | Your App |
+------------+----+-----+
|   Objective-J   |     |
+-----------------+     |
|       JavaScript      |
+-----------------------+
|   Web Browser / DOM   |
+-----------------------+
|   Operating System    |
+-----------------------+

Cappuccino applications are loaded and run in web browsers, rather than downloaded as desktop applications. To display their user interfaces and get user input events they use JavaScript APIs provided by the web browser. Currently Cappuccino's display technology uses DOM and Canvas APIs internally, but because Cappuccino programmers don't usually use these APIs directly that could be swapped for another technology like SVG or WebGL.

Tools
-----

The only tools absolutely required to build a Cappuccino application are a web browser and a text editor. While you may use an IDE such as Xcode, most Cappuccino programmers opt for a text editor such as TextMate, Sublime Text, vi, or Emacs. Objective-J syntax highlighting is available for a variety of editors [LINK].

JavaScript is an interpreted language, and the Objective-J compiler is implemented in JavaScript, so Cappuccino applications can seamlessly run in the browser without an explicit compilation step. However, compiling your Objective-J code to JavaScript when deploying your application will reduce the application's load time and is highly recommended. Cappuccino comes with command-line tools to do this.

Cappuccino includes a tool called `nib2cib` which converts the XIB user interface files produced by Xcode's Interface Builder to a format compatible with Cappuccino. 

Most web browsers include a JavaScript debugger, profiler, and other tools you may find useful. Some of them work better than others. We prefer Chrome's developer tools.

Language
--------

Objective-J is to JavaScript, as Objective-C is to C. This paragraph from Cocoa Programming can be adapted word for word:

"Objective-J is a simple and elegant extension to JavaScript, and mastering it will take about two hours if you already know JavaScript and an object-oriented language such as Java or C++."

It was straightforward to add Objective-C's syntax to JavaScript because much of JavaScript's syntax was derived from C-like languages. Likewise, just as you can use any C syntax within an Objective-C source file, you can use plain old JavaScript within any Objective-J source code file.

The major differences between Objective-J and Objective-C arise from the differences between C and JavaScript:

* JavaScript is interpreted. C is usually compiled to machine code.
* JavaScript is dynamically typed. C is statically typed (though Objective-C allows for dynamic typing).
* JavaScript is garbage collected. Memory is manually managed in C (though Objective-C has other options).
* JavaScript is "memory safe", while C allows for raw memory access, and the problems that come with it.
* Both languages have many idiosyncrasies which manifest themselves in Objective-C and Objective-J.

Objects, Classes, Methods, and Messages
---------------------------------------

When comparing Objective-J to Objective-C, a JavaScript object is analogous to a C struct. In reality JavaScript objects are more expressive than structs: properties can be added or removed at runtime, you can associate JavaScript methods with an object, and objects can inherit from other objects. However, JavaScript objects use prototypal inheritance, while Objective-J objects use the same Smalltalk inspired classical inheritance model used by Objective-C.

Just as in Objective-C, we have "classes", "instances" of a class, "methods", and we send "messages" to an object to call methods.

Frameworks
----------

Cappuccino implements much of Cocoa's Foundation and AppKit APIs, but not CoreData.

Most Cappuccino classes are identically named to their Cocoa counterparts, except they are prefixed with "CP" for "Cappuccino" instead of "NS" for "NextStep". Certain APIs such as CoreGraphics ("CG") retain the same prefix.

Most messages are also identically named, except where platform differences required API changes. In particular, synchronous IO APIs are not generally used in the browser. JavaScript in the browser is a single-threaded environment, and blocking IO calls will cause the UI to hang.

How to Read This Document
-------------------------

Programmers already familiar with Cocoa can treat this document as a stand-alone "Cappuccino for Cocoa Programmers" primer.

Cocoa novices should read this document concurrently with "Cocoa Programming for Mac OS X". You can read a book chapter at a time, followed by the corresponding chapter in this document, or follow along more closely by reading each subsection as you reach them.

Objective-J versions of the code are provided.

Cappuccino documentation [LINK]

Typographical Conventions
-------------------------

Common Mistakes
---------------

How to Learn
------------