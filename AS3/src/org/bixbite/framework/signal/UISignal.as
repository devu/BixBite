/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.signal 
{
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class UISignal 
	{
		static public const INIT:String = "UISignal.INIT";
		static public const DATA_REQUEST:String = "UISignal.DATA_REQUEST";
		static public const ON_DATA:String = "UISignal.ON_DATA";
		
		static public const SHOW:String = "UISignal.SHOW";
		static public const HIDE:String = "UISignal.HIDE";
		
		static public const CREATE_WINDOW:String = "UISignal.CREATE_WINDOW";
		static public const OPEN_WINDOW:String = "UISignal.OPEN_WINDOW";
		static public const CLOSE_WINDOW:String = "UISignalCLOSE_WINDOW";
		static public const DESTROY_WINDOW:String = "UISignal.DESTROY_WINDOW";
		
		static public const CREATE_PANEL	:String = "UISignal.CREATE_PANEL";
		static public const DESTROY_PANEL	:String = "UISignal.DESTROY_PANEL";
		
		static public const CLOSE:String = "UISignal.CLOSE";
		static public const OPEN:String = "UISignal.OPEN";
		static public const CREATE:String = "UISignal.CREATE";
		
	}

}