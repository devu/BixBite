Bixbite - Cross platform application framework and interpreter

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

Framework Classic Branch
There is few initial classes that let you built classic flash AS3 projects using Composite and Decorator pattern.
Composite pattern is being used to create nested views with a structure similar to what we know from Display List.
Decorator pattern lets you work with native Display Objects inside any View.

Planed for future releases
- More detailed DOCS.
- components - set of functioning triads MVC and accompanying signals, that perform some specific tasks, so you can easily add to your project.
- examples, examples, examples.

- more branches of framework:
    
Framework Blit
- where views relies on bitmap output data only

Framework CustomDSP
- custom display list implementation, stripped out version of native one to make your application tiny especialy for mobile development.

Framework Stage3D
- custom display list and graphics implementation that relies on Stage3D GPU accelerated API