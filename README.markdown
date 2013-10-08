Looking for robust, flexible but small and scalable micro architecture and don't want to sacrifice any processor cycle? Look no further!

<b>BixBite</b> - The fastest and simplest Signal/Slot based application framework!

Inspired by :
Actor Model (https://en.wikipedia.org/wiki/Actor_model)
MVC paradigm via [SMALLTALK 80] (http://st-www.cs.illinois.edu/users/smarch/st-docs/mvc.html)
Signal/Slot system aka [QT framework] (http://qt-project.org/doc/qt-4.8/signalsandslots.html)
 
<b>Manifesto:</b>
1. We believe, that clean and simple code is very important for maintainability of the application and necessary for developers to progress.
2. We believe, that some logical patterns and good practices are necessary to achieve that goal and greater efficiency in general.
3. We believe, that patterns and structures don't have to slow you and your application down.
4. We believe, that those developing over-bloated spaghetti code simply failed at point 1.
5. We believe, that reason they failed is because of commonly used frameworks failed at point 2 and simply gave up on 3. :)
 
<b>Footprint:</b>
Core framework ready to go has only:
AS3 - 4.5kb () + Context GL 0.5kb
JS  - 2.3KB gzipped + Context GL - 849b gzipped (but this part is more likely to grow)

<b>Characteristic:</b>
Signal/Slot and Request/Response communication mechanism has been designed to keep all Actors completely decoupled.
That gave us possibility to create independent components or triads that can be added to any BixBite based project without clashes, cross references and dependencies.
That makes it perfect modular system. BixBite evolves from MVC and Actor Model paradigm but it stays very simple. It is hard to call it framework but more like a set of few classes/objects ready to work with.
Our focus is on communication layer that makes this solution standing out from many other frameworks.
Having only 1 layer of abstraction.
View Structure is encapsulated into something we call Context GL, an abstract library to work with native graphic API's regardless of the target platform and solution being used.

<b>Performance:</b>
At current stage this framework is tiny, AS3/JS friendly, not intrusive, type safe and the fastest for performance critical code.
Signal/Slot system is even faster than Robert Penner Signals. Why? Because it's built into the core as a main and only communication mechanism.
Currently it's 4 times faster than native events of Flash. Similar gain of speed on JavaScript port vs DOM events.
Compared to commonly known JS framework, well, nothing to compare! 100x faster than jQuery.
But this is not enough yet. Signal Referencing System(SRS) will let you perform notification with a speed of local callback.
It is not a magic, but the fact no matter how complicated your structure get, SRS will always unravel it into flat and shallow structure on the fly.

<b>Cross-platform:</b>
Our another goal is to implement BixBite with a multiple targets to get as close to native platform as possible.
Encapsulate all platform differences in a common API that is abstract to the platform language.
This way the code you writing is scalable and easily portable. No compilers, interpreters, ants, shells, and other animals, no overhead.
For time being we have fully implemented AS3 and mostly implemented JS version of it.
There is even a Java port but... is not a focus nor priority of this development yet.
There is a plan on web based IDE that will wrap the whole API into a tool that will help you develop with even greater ease.

For more info, please visit the [Bixbite](http://www.bixbite.org)

<b>This is still Beta release of AS3 and JS port of BixBite framework. Use on your own risk.</b>

<b>Features:</b>
- Only 1 level of abstraction.
- Core as a micro architecture is ready and fully functioning.
- Common API, code written in AS3 and JS is almost identical, there is no need for recompilation or interpretation on architecture level.
- Signal/Slot notification system inspired by QT4 is currently 4 times faster to compare to native Events.
- Request/Response mechanism for Data<->Behaviour components
- AMS - Application Modular System - you can create number of small standalone apps and pull them into another Compound and run as modules.
- Multi-cast and Signle-cast methods to leverage one-to-many and many-to-one communication routes.
- Virtual Display List (from 0.9.5) it's a common ground for all platforms. Regardless of what is native system using Flash/DOM/SVG/CANVAS you always work with Context the same way.
- Open architecture. It is easy to adopt existing frameworks or tools to work with BixBite. For instance to develop with tools such as EaseJS(JS) or Starling(AS3) it is just another interface of the Virtual Display List to be done.
- Small footprint, fully functional core AS3 has only 5kb (JS minified version of framework 3.3KB (gzipped)
- The best framework for game developers and mobile platform in terms of performance and memory consumption.
- The best framework for web development in general. Using BixBite JS plugin-free version, you can easily develop application that performs well on mobile devices.
- Using BixBite AS3 you creating lighter and faster structure to compare to any well known frameworks or even pure AS3 using native Events as communication layer.
Speed of code execution has been pushed to its limits, we were trying hard to make it happen. However, BixBite JS and pure code execution is even faster than on FlashPlayer!
- Type safe API on AS3 target makes it robust for development and debugging, even if you lack of good tools on JS target, result of AS3 can by trusted and just copy and pasted to JS.
- Completely loosely decoupled classes, no dependencies and cross references, No needs for public methods at all.
- Less classes to get the job done.
- Faster execution of any part of the system. By using a very shallow structure implemented with the best practices on target platform native language.
- Smallest startup lag. To get whole framework up and running + register testing application that will display 10,000 squares on the screen, it takes 14ms on AS3 and 19ms on Chrome/Canvas
- Consistent and clean code.
- CDTV design pattern (Compound, Data, Transponder, View) supported with Behaviours that acts like executable components and leverage business logic of application.
- CDTV signal bus to make sure communication between actors is happening in correct order and according to the rules.
- Using just a core you can create your own branch or have own idea how you can implement 2nd abstraction level or way to deal with graphical context.
- Framework layer is completely independent from the core. Creates opportunity to have different framework implementations based on native display list, custom as well as Stage3D.
We've got modified version of Starling to run with BixBite as well. For JS target you can leverage DOM, SVG or Canvas API without changing your architecture at all.
- Documentation.
- SWC libraries for AS3.
- Performance tests.
- Examples of use.
- Templates for Flash Develop.
   