Looking for robust, flexible but small and scalable micro architecture and don't want to sacrifice any processor cycle? Look no further!

For time being the core part of much bigger project has been open to public.
<b>BixBite</b> - The fastest and simplest Signal/Slot based application framework!

MVC paradigm inspired by [SMALLTALK 80] (http://st-www.cs.illinois.edu/users/smarch/st-docs/mvc.html)
Signal/Slot system inspired by [QT framework] (http://qt-project.org/doc/qt-4.8/signalsandslots.html)
   
Core framework ready to go has only 4kb footprint.
Signal/Slot and Request/Response communication mechanism has been designed to keep all Actors completely decoupled.
That gave us possibility to create independent components or triads that can be added to any Bixbite based project without clashes, cross references and dependencies.
That makes it perfect modular system. BixBite evolves from MVC paradigm but it stays in similar conventions. Our focus is on communication layer.
Having only 1 layer of abstraction and nested, Composite Pattern based, view structure.

At current stage this framework is tiny, AS3/JS friendly, not intrusive, type safe and the fastest for performance critical code.
Signal/Slot system is even faster than Robert Penner Signals. Currently it is 4 times faster than native events.
But this is not enough yet. Signal Referencing System(SRS) will let you perform notification with a speed of local callback.

Our another goal is to implement BixBite with a multiple targets to get close to native platform.
Encapsulate all platform differences in a common API that is abstract to the platform language.
This way the code you writing is scalable and easily portable.
For time being we have fully implemented AS3 and mostly implemented JS version of it.

BixBite is released under the MIT license.

For more info, please visit the [Bixbite](http://www.bixbite.org)

<b>This is still Beta release of AS3 port of BixBite framework. Use on your own risk.</b>

Release log
v0.9.2

- Documentation.
- Swc libraries for AS3.
- Performance tests.
- Examples of use.
- The best framework for game developers and mobile platform in terms of performance and memory consumption.
- The best framework for web development in general. Using BixBite JS plugin-free version, you can easily develop application that performs well on mobile devices.
- Using BixBite AS3 you creating lighter and faster structure to compare to any well known frameworks or even pure AS3 using native Events as communication layer.
Speed of code execution has been pushed to its limits, we were trying hard to make it happen. However, BixBite JS and pure code execution is even faster than on FlashPlayer!
- Signal/Slot/Request notification system inspired by QT4
- Signals are faster than native events
- Send one signal to notify multiple Actors at the same time. (multi-cast)
- Type safe API on AS3 target.
- Completely loosely decoupled classes.
- Less classes to get job done.
- Smallest footprint, fully functional core AS3 has only 4 kb(JS minified version of framework 5.24KB (1.58KB gzipped))
- Faster execution of any part of the system.
- Smallest startup lag.
- Cleaner code.
- Only 1 level of abstraction
- ANMS - Application Nested Modular System - you can create number of small standalone apps and pull them into another application run as modules.
- CDTV design pattern (Compound, Data, Transponder, View) supported with Behaviours that acts like executable components and leverage business logic of application.
- CDTV signal bus to make sure communication between actors is happening in correct order.
- Core as a micro architecture is ready and fully functioning, (not unit tested yet).
- Using just a core you can create your own branch or have own idea how you can implement 2nd abstraction level.
- Framework layer is completely independent from the core. Creates opportunity to have different framework implementations based on native display list, custom as well as Stage3D.
We've got modified version of Starling to run with BixBite as well.

Planed for future releases
- More detailed DOCS.
- More examples.
- Tutorials.
- Home website.
   