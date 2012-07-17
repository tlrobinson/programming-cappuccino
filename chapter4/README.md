Chapter 4. Memory Management
============================

JavaScript is a garbage collected language, so Objective-J is as well.

`retain`, `release`, and `autorelease` methods are provided for compatibility, but they don't do anything and shouldn't be used in Cappuccino applications.

Garbage collection will take care of cleaning up after you, as long as you don't hold references to objects you no longer need.
