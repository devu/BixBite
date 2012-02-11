package com.mindScriptAct.robotTest.view.application {
import flash.events.Event;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
public class OutputEvent extends Event {
	
	static public const APPEND_LINE:String = "appendOutput";
	
	public var outputText:String;
	
	public function OutputEvent(type:String, outputText:String){
		super(type);
		this.outputText = outputText;
	
	}
	
	public override function clone():Event {
		return new OutputEvent(type, outputText);
	}

}
}