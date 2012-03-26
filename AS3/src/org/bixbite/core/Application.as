/**The MIT License

@copy (c) 2012 Devu Design Limited, Daniel Wasilewski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

package org.bixbite.core 
{
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import org.bixbite.core.interfaces.IApplication;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * <p>The Application represents default class you should subclass your Document Class with.</br>
	 * This is required to initialise Observer and signal slot system.</p>
	 * 
	 * <p>Due to AS3 Document Class restrictions it must subclass DisplayObjectContainer this is why extends Sprite.<br>
	 * The only thing we need from it, is to access the system features. And implemementation of this class may vary depends of target platforms.
	 * This is platform specific implementation when the Stage is the main system IO provider.<br>
	 * For instance, Views will get access to Display List, Models can access infoLoader, Controllers can listen to native listeners to controll specific behaviours directly on the stage.
	 * This is why stage is accesible from any actor and it's the Application class purpose to register itself within Observer as the very first class and bridge system with system IO provider.</p>
	 * 
	 * <p>In case you have more than one Applications running at the same time any following application will run as module, usign the same reference of Observer to make shared signal/slot communication possible.
	 * This is very usefull in modular projects. Concider application, for instance Preloader, that will load external swf build within Bixbite framework as well. 
	 * Preloader may already have some actors initialised you wish to reuse such StageController, SharedObjectModel, so you don't have to repeat yourself.</p>
	 * 
	 * @langversion	3.0
	 * @version 0.4.5
	 * 
	 * @example
	 * <codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * //Bixbite document class template
	 * package  
	 * {
	 * 	import org.bixbite.mvc.Application;
	 * 	
	 * 	public class Main extends Application 
	 * 	{
	 * 		public function Main() 
	 * 		{
	 * 			entry point
	 * 		}
	 * 	}
	 * }
	 * </codeblock>
	 */
	public class Application extends Sprite implements IApplication
	{
		private var emiter		:Emiter 	= Emiter.register(IApplication(this));
		private var _module		:Boolean 	= false;
		
		/**
		 * Constructor, Application is an abstract class, cannot be directly instatiated. 
		 * It must be subclassed by Document Class.
		 */
		public function Application()
		{
			if(Object(this).constructor == Application) throw new IllegalOperationError("Abstract Class");
		}
		
		/**
		 * Read-only getter to check application mode
		 */
		public function get module():Boolean 
		{
			return _module;
		}
		
		/**
		 * System controlled setter to switch application into module mode
		 */
		BIXBITE function set module(value:Boolean):void 
		{
			_module = value;
		}
	}

}