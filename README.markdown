Looking for robust, flexible but small and scalable micro architecture and don't want to sacrifice any processor cycle? Look no further!

For time being the core part of bigger project has been open to public.
<b>Bixbite MVC</b> - The fastest and simplest MVC and Signal/Slot based ActionScript 3 framework!

MVC paradigm inspired by [SMALLTALK 80] (http://st-www.cs.illinois.edu/users/smarch/st-docs/mvc.html)
Signal/Slot system inspired by [QT framework] (http://qt-project.org/doc/qt-4.8/signalsandslots.html)
   
Core framework ready to go has only 2.8kb footprint.
Signal/Slot and Request/Response communication mechanism has been designed to keep all Actors completely decoupled.
That gave us possibility to create independent components or triads that can be added to any Bixbite based project without clashes, cross references and dependencies.
That makes it perfect modular system. In the same time sticks to MVC paradigm that is based on very first concept of MVC from 70's. Having only 1 layer of abstraction and nested, Composite Pattern base, view structure. At this stage this framework is tiny, AS3 friendly, not intrusive, type safe and the fastest for performance critical code. Signal/Slot system is even faster than Robert Penner Signals implementation and is not relying on Dictionaries.

But this is not enough yet. Signal referencing mechanism will let you perform notification with a speed of local callback (or arrays for multiple listeners).
There is nothing faster in AS3 world that AS3 world itself!

Bixbite is released under the MIT license.

For more info, please visit the [Bixbite](http://www.bixbite.org)

<b>This is Beta release of AS3 port of Bixbite MVC framework. Use on your own risk.</b>

Release log
0.2.9 What's new

- documentation
- swc libraries
- core as a micro architecture is ready and fully functioning, (not unit tested yet).
- core has very small footprint. Just 3kb with all necessary classes to start.
- using just a core you can create your own branch or have own idea how you can use it. But from this point we have started creating branches you might pick up the one you prefer.
- framework layer is completely independent from the core.

- framework branches
<b>Classic</b>
There is few initial classes that let you built classic flash AS3 projects using Composite and Decorator pattern.
Composite pattern is being used to create nested views with a structure similar to what we know from Display List.
Decorator pattern lets you work with native Display Objects inside any View.

Planed for future releases
- More detailed DOCS.
- components - set of functioning triads MVC and accompanying signals, that perform some specific tasks, so you can easily add to your project.
- examples, examples, examples.

- more branches of framework:
   
<b>Framework Blit</b>
- where views relies on bitmap output data only

<b>Framework CustomDSP</b>
- custom display list implementation, stripped out version of native one to make your application tiny especialy for mobile development.

<b>Framework Stage3D</b>
- custom display list and graphics implementation that relies on Stage3D GPU accelerated API