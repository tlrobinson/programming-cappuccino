Chapter 2. Let's Get Started
============================

Xcode
-----

Installing Cappuccino [TODO]

Create a New Project
--------------------

Many of the tasks you'd do using Xcode will be done with Cappuccino's command line tools. `capp` is one of those tools.

To get a list of project templates, enter `capp gen --list-templates` in a terminal. "NibApplication" generates an application which uses a NIB, but NIBs aren't necessary to build Cappuccino user interfaces, so you can the "Application" template to generate an application without a NIB.

Figure 2.3. Name Project

    capp gen -t NibApplication Random

Figure 2.4. Skeleton of a Project

	AppController.j
	index-debug.html
	index.html
	Info.plist
	Jakefile
	main.j
	Resources/MainMenu.cib
	Resources/MainMenu.xib
	Resources/spinner.gif
	Frameworks/AppKit
	Frameworks/Foundation
	Frameworks/Objective-J
	Frameworks/Debug/AppKit
	Frameworks/Debug/Foundation
	Frameworks/Debug/Objective-J

To get a NIB-based application to load we need to convert the NIB (or XIB) to the Cappuccino equivalent, a XIB. To do this we can use the `nib2cib` command line tool, or the `XcodeCapp` tool can do it for us automatically.

Here's a description of XcodeCapp from the documentation:

> What is XcodeCapp?
> 
> One of Cappuccino’s greatest features is the ability to use Xcode 4 to create the user interface for your web applications. Xcode creates .xib files which then must be converted by the command line utility nib2cib to .cib files for use with Cappuccino. But beginning with Xcode 4, there is no way to directly create outlets and actions without editing Objective-C header files.
> 
> XcodeCapp acts as a bridge between Xcode and Cappuccino. It performs two main functions:
> 
> * Reads your source files when they are modified and automatically creates outlets and actions in the .xib file.
> * Automatically converts .xib files to .cib files when the .xib file is modified.

Launch XcodeCapp, located in your Applications directory, and select "Listen to Project" from the menu bar icon. Pick your "Random" project, and XcodeCapp will begin processing NIBs and XIBs in your project. XcodeCapp will automatically reprocess modified files.

We can then open "index-debug.html" or "index.html" in our web browser. The difference between these two files is that "index-debug.html" loads Frameworks which have not been "minified", making the application easier to debug. Deployed applications should always use the "index.html", as it will be significantly smaller.

Note: Chrome has certain restrictions when loading a page from the filesystem using a "file://" URL. To workaround this we either need to start Chrome with the `--allow-file-access-from-files` command line flag, or load the page using a local webserver (e.x. Mac OS X's "Web Sharing").

The main Function
-----------------

Objective-J files have a ".j" extension instead of Objective-C's ".m", thus "main.j" is the first file to be loaded and executed in a Cappuccino application.

	/*
	 * AppController.j
	 * Random
	 *
	 * Created by You on July 16, 2012.
	 * Copyright 2012, Your Company All rights reserved.
	 */

	@import <Foundation/Foundation.j>
	@import <AppKit/AppKit.j>

	@import "AppController.j"


	function main(args, namedArgs)
	{
	    CPApplicationMain(args, namedArgs);
	}


You'll notice some similarities and differences between "main.m" and "main.j":

* The `#import` preprocessor directive is replaced with `@import` in Objective-J. Most of Objective-J's syntax additions begin with the "@" token.
* We import Foundation and AppKit separately, as well as explicitly import our `CPApplicationController` class, `AppController`, even though "main.j" doesn't reference `AppController` directly. This is to help Cappuccino's optimization tools function correctly.
* `main` is defined using JavaScript's `function` syntax. No argument or return value types are declared. We pass `args` (an array) and `namedArgs` (a map) instead of the usual `argc` and `argv` parameters.

As in Cocoa, you'll rarely need to modify "main.j".

In Interface Builder
--------------------

Rather than opening XIBs in Interface Builder directly, select "Open Project in Xcode" from XcodeCapp menu. [WHY?]

The Utility Area
----------------

The Blank Window
----------------

Cappuccino's default XIB isn't blank like Cocoa's, so delete the slider and text field controls by selecting them and hitting the "delete" key.

For the More Curious: XIBs and NIBs
-----------------------------------

Lay Out the Interface
---------------------

The Dock
--------

Create a Class
--------------

Unlike Objective-C, Objective-J does not have separate header and implementation files, they are combined into a single ".j" file. Create "RandomController.j" instead of "RandomController.h" and "RandomController.m":

    /*
     * RandomController.j
     * Random
     *
     * Created by You on July 16, 2012.
     * Copyright 2012, Your Company All rights reserved.
     */

    @import <Foundation/CPObject.j>

    @implementation RandomController : CPObject
    {
        IBOutlet CPTextField textField;
    }

    - (IBAction)seed:(id)sender
    {
    }

    - (IBAction)generate:(id)sender
    {
    }

    @end

One more thing: because there's no compiling and linking, we need to make sure our application loads "RandomController.j". Import it at the top of "AppController.j":

    @import "RandomController.j"

Create an Instance
------------------

XcodeCapp will automatically generate Objective-C ".h" files in the background so Interface Builder can recognize outlets and actions in your ".j" files. Be sure XcodeCapp is running and listening to the "Random" project.

Make Connections
----------------

A Look at Objective-C
---------------------

Unlike Objective-C, Objective-J does not have static type checking. Instance variables, message parameter, and return type declarations are ignored by the compiler, but it is good practice to include type declarations for documentation purposes. XcodeCapp and Interface Builder also rely on type declarations.

Other type differences:

* `id` still represents any type of object, but Objective-J doesn't have the concept of "pointers".
* `YES` equals JavaScript's `true`
* `NO` equals JavaScript's `false`
* `IBOutlet` and `IBAction` work the same as in Objective-C.
* `nil` equals JavaScript's `null`

Look at the Header File
-----------------------

In addition the syntax differences noted earlier, we have removed the `*` from `IBOutlet NSTextField *textField;` line. All variables in JavaScript are references to objects, so there is no explicit "pointer" type.

Edit the Implementation File
----------------------------

Objective-J combines Objective-C's header (".h") and implementation (".m") files into a single ".j" file. Here is the complete "RandomController.j" file:

    @import <Foundation/CPObject.j>

    @implementation RandomController : CPObject
    {
        IBOutlet CPTextField textField;
    }

    - (IBAction)generate:(id)sender
    {
        // Generate a number between 1 and 100 inclusive
        var generated = ((Math.random() * Number.MAX_VALUE) % 100) + 1;

        console.log("generated = %d", generated);
        
        // Ask the text field to change what it is displaying
        [textField setIntValue:generated];
    }

    - (IBAction)seed:(id)sender
    {
        // Seed the random number generator with the time
        console.log("Would have seeded with time " + new Date().getTime());
    }

    @end

TODO: explain the differences

Build and Run
-------------

Save your code and XIBs, them reload "index-debug.html" to see the changes. Click the buttons to make sure it works properly. To see the logs you need to open your browser's JavaScript console.

If nothing has changed make sure XcodeCapp is running and processing your project correctly.

awakeFromNib
------------

`awakeFromNib` is called `awakeFromCib` in Cappuccino:

    - (void)awakeFromNib
    {
        var now = [CPDate date];
        [textField setObjectValue:now];
    }

Also note that we're using the `var` keyword instead of a type for the "now" local variable. Unlike C and Objective-C, if a local variable is not declared the Objective-J compiler won't complain, and will happily set the variable in the global scope (or the innermost scope where it has been declared). This is the source of many bugs in JavaScript programs, so be sure to include your `var`s!

Documentation
-------------

[TODO]

What Have You Done?
-------------------

Chronology of an Application
----------------------------

