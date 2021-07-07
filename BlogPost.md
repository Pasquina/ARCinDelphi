# Delphi Red Herrings: Hidden Virtual Methods
**Trying to Grasp the Depths of a Universe Far, Far Away**
## Genesis

Working on some development I discovered a memory leak. This is not uncommon, and since I had just made some code changes it should have been easy to track down and fix. "Problem solved!" Unfortunately, it took a lot longer than that and after reading dozens of blog posts, Embarcadero DocWiki pages and many Stackoverflow answers, I was still uncertain of what was happening. Even my favorite Delphi gurus on Stackoverflow had apparently never answered a question quite like mine.

## Summary
There's a small demo program at [https://github.com/Pasquina/ARCinDelphi.git](https://github.com/Pasquina/ARCinDelphi.git "ARCinDelphi") that you really need to download in order to try some of the simple things I mention here.

There are two classes defined in the program:

- A Parent Class
- A Child Class

The parent is descended from `TInterfacedObject` and hence the child (as a descendant of Parent) also has `TInterfacedObject` as an ancestor. A couple of empty interfaces are defined to permit referencing.
 
The child class uses the `inherited` directive to invoke the `Create` and `Destroy` methods of the parent. When you run the program and push the button (the only object that responds to a click on the small form) instantiation proceeds using interfaces, first a parent concrete instance and then a child concrete instance. As instantiation proceeds, `ShowMessage` is used so you can follow the events as they take place.

Finally, after both concrete instantiations take place, the routine exits the event handler, causing the instantiated objects to go out of scope. From here, the compiler and ARC take over and dispose of the concrete instances.

As the concrete instantiations are `destroy`ed a `ShowMessage` tracks the events so you can follow the progress of object lifetimes. The messages should look like this:

~~~
Creating Base Class Instance (From Event Handler Code)
Base Object Create (From Base Class Create Method)

Creating Child Class Instance (From Event Handler Code)
Base Object Create (From Base Class Create Method via Inherited Directive)
Child Object Create (From Child Class Create Method)

Exiting Scope (From Event Handler Code at the Very End)
Child Object Destroy (From Child Class Destroy Method)
Base Object Destroy (From Base Class Destroy Method via Inherited Directive)
Base Object Destroy (From Base Class Destroy Method)
~~~

## Not So Fast

While all of this behavior so far is expected, let's try a small experiment.
~~~
Remove the override directive from the Child Class Destroy method and run the program as before.
~~~
The first thing you notice is you get that annoying message from the compiler about 
~~~
method... hides virtual method of base type ...
~~~
As far as I can tell, that simply isn't true. You can still "see" the base method with code, reference it, invoke it using `inherited` and so forth. Hidden from who or what?

Then if you run the code, the `ShowMessage` trace looks like this:

~~~
Creating Base Class Instance (From Event Handler Code)
Base Object Create (From Base Class Create Method)

Creating Child Class Instance (From Event Handler Code)
Base Object Create (From Base Class Create Method via Inherited Directive)
Child Object Create (From Child Class Create Method)

Exiting Scope (From Event Handler Code at the Very End)
Child Object Destroy (Missing! Gone fishing! Disappeared!)
Base Object Destroy (From Base Class Destroy Method via Inherited Directive)
Base Object Destroy (From Base Class Destroy Method)
~~~

But wait! There's more. Close the program and you get the following from the `ReportMemoryLeaksonShutdown` that has been enabled for the program.
~~~
An unexpected memory leak has occurred. The unexpected small block leaks are:
Etc., etc.
~~~

Put the `override` directive back on the Child Class `destructor` and things are fine.

## Conclusion
I don't know what the intended behavior is supposed to be for this, but I do know that inadequate documentation of all kinds cost me a lot of time figuring out what was going on. Avoiding the problem is easy enough. Triage is another matter.

If anyone has better answers than the ones I've given, I'd like to hear them. Please leave comments if you have more information on this odd behavior.