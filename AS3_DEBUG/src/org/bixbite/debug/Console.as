package org.bixbite.debug
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Component;
	import org.bixbite.core.Compound;
	import org.bixbite.core.View;
	import org.bixbite.debug.ui.*;
	import org.bixbite.debug.vo.*;
	import org.bixbite.framework.factories.GraphicsFactory;
	import org.bixbite.framework.factories.TextFactory;
	
	
	
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Console extends Sprite
	{
		private var isOpen	:Boolean = false;
		private var content	:Sprite;
		
		private var rootCompound	:AbstractCompound;
		private var module			:AbstractCompound;
		
		private var scope			:Class;
		
		private var componentList	:Dictionary;
		
		private var compounds		:Dictionary = new Dictionary();
		private var behaviours		:Dictionary = new Dictionary();
		private var datas			:Dictionary = new Dictionary();
		private var trans			:Dictionary = new Dictionary();
		private var views			:Dictionary = new Dictionary();
		
		private var component		:AbstractComponent;
		
		// Flex 4.x sdk:
		[Embed(source="../../../../assets/pf_ronda_seven.ttf",embedAsCFF="false",fontName="PF Ronda Seven",mimeType="application/x-font")]
		
		//Flex 3.x sdk:
		//[Embed(source="/assets/pf_ronda_seven.ttf", fontName="PF Ronda Seven", mimeType="application/x-font")]
		protected var Ronda:Class;
		
		public function Console(componentList:Dictionary)
		{
			this.componentList = componentList;
			this.visible = false;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			create();
		}
		
		private function create():void
		{
			var gFactory:GraphicsFactory 	= GraphicsFactory.getInstance();
			gFactory.drawBox(graphics, 0, 0, stage.stageWidth, stage.stageHeight, 0x222222, 0.2);
			
			var tFactory:TextFactory 		= TextFactory.getInstance();
			var rondaFont:Font 				= new Ronda();
			tFactory.setTextFormat("hexLabel", "PF Ronda Seven", 8, 0xFFFFFF, "left");
			
			content = new Sprite();
			content.name = "content";
			content.x = int(stage.stageWidth * 0.5);
			content.y = int(stage.stageHeight * 0.5);
			addChild(content);
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case "compound":
					e.target.startDrag();
					break;
				default:
					content.startDrag();
					break;
			}
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			stopDrag();
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.charCode == 9)
				(isOpen) ? close() : open();
		}
		
		private function open():void
		{
			this.visible = isOpen = true;
		}
		
		private function close():void
		{
			this.visible = isOpen = false;
		}
		
		public function log(compound:Compound, object:Class, msg:String):void
		{
			var name	:String = getQualifiedClassName(compound).split("::")[1];
			var oname	:String = getQualifiedClassName(object).split("::")[1];
			
			output("Compound [", name, "] duplicated [", oname, "]" );
		}
		
		public function send(type:String, params:Object):void
		{
			
		}
		
		public function inspect(object:Class):void
		{
			var xmlData:XML = describeType(object);
		}
		
		public function registerCompound(compound:Compound):void 
		{
			var name:String = getQualifiedClassName(compound).split("::")[1];
			
			var rootCompound_mc:HexWindow = new HexWindow(name, 0x000336, 100, 100);
			rootCompound_mc.name = "compound";
			addChild(rootCompound_mc);
			
			rootCompound = new AbstractCompound(name, rootCompound_mc);
			compounds[name] = rootCompound;
			
			output("Compound [", name, "] registered");
		}
		
		public function registerModule(compound:Compound, object:Class):void 
		{
			var name	:String = getQualifiedClassName(compound).split("::")[1];
			var oname	:String = getQualifiedClassName(object).split("::")[1];
			
			var currentCompound:AbstractCompound = AbstractCompound(compounds[name]);
			
			var module_mc:HexWindow = new HexWindow(oname, 0x000336, 100, 100);
			module_mc.name = "compound";
			currentCompound.mc.addChild(module_mc);
			
			component = new AbstractCompound(oname, module_mc);
			compounds[oname] = currentCompound.compounds[oname] = component;
			
			output("Compound [", name, "] add module [", oname, "]" );
		}
		
		public function registerData(compound:Compound, object:Class):void 
		{
			var name	:String = getQualifiedClassName(compound).split("::")[1];
			var oname	:String = getQualifiedClassName(object).split("::")[1];
			
			var currentCompound:AbstractCompound = AbstractCompound(compounds[name]);
			
			var data_mc:HexWindow = new HexWindow(oname, 0x662222, 100, 100);
			data_mc.name = "data";
			currentCompound.mc.addChildItem(data_mc, 0, -103);
			
			component = new AbstractDataComponent(oname, data_mc);
			datas[oname] = currentCompound.datas[oname] = component;
			
			output("Compound [", name, "] add data [", oname, "]" );
		}
		
		public function registerTransponder(compound:Compound, object:Class):void 
		{
			var name	:String = getQualifiedClassName(compound).split("::")[1];
			var oname	:String = getQualifiedClassName(object).split("::")[1];
			
			var currentCompound:AbstractCompound = AbstractCompound(compounds[name]);
			
			var trans_mc:HexWindow = new HexWindow(oname, 0x226666, 100, 100);
			trans_mc.name = "transponder";
			currentCompound.mc.addChildItem(trans_mc, 94, 0 , false);
			
			component = new AbstractTransComponent(oname, trans_mc);
			trans[oname] = currentCompound.trans[oname] = component;
			
			output("Compound [", name, "] add trans [", oname, "]" );
		}
		
		public function registerView(compound:Compound, object:Class):void 
		{
			trace("**registerView:", object.uid);
			
			var name	:String = getQualifiedClassName(compound).split("::")[1];
			var oname	:String = getQualifiedClassName(object).split("::")[1];
			
			var currentCompound:AbstractCompound = AbstractCompound(compounds[name]);
			
			var view_mc:HexWindow = new HexWindow(oname, 0x226622, 100, 100);
			view_mc.name = "view";
			currentCompound.mc.addChildItem(view_mc, -94, 0 , false);
			
			component = new AbstractViewComponent(oname, view_mc);
			views[oname] = currentCompound.views[oname] = component;
			
			output("Compound [", name, "] add view [", oname, "]" );
		}
		
		public function registerBehaviour(signal:String, object:Class):void
		{
			var name	:String = getQualifiedClassName(object).split("::")[1];
			trace("BEHAVIOUR::", name);
		}
		
		public function execute(component:Behaviour):void
		{
			var name:String = getQualifiedClassName(component).split("::")[1];
			trace("EXECUTE::", name);
			/*
			AbstractBehaviour(behaviours[name]).execute();*/
		}
		
		public function initialise(component:*):void 
		{
			var name	:String = getQualifiedClassName(component).split("::")[1];
			trace("INIT::", name);
		}
		
		public function register(component:*):void 
		{
			//var name	:String = getQualifiedClassName(compound).split("::")[1];
			var name	:String = getQualifiedClassName(component).split("::")[1];
			var xml		:XML 	= describeType(component);
			var ctype	:String	= xml.@base;
			
			//trace(xml);
			if(component is View){
				trace("VIEW::", ctype);
			}
			
			trace("REGISTERED::", name);
		}
		
		public function duplication(component:Class):void 
		{
			
			var cname	:String = getQualifiedClassName(component).split("::")[1];
			trace("DUPLICATION    ", cname);
			//this.component.markAsDuplicate();
		}
		
		public function addSlot(type:String):void 
		{
			trace("addSlot", type);
		}
		
		public function setScope(component:*):void
		{
			var name	:String = getQualifiedClassName(component).split("::")[1];
			
			scope = componentList[component];
			
			trace("SET_SCOPE::", name);
		}
		
		private function output(...rest):void
		{
			trace(rest.join(" "));
		}
	
	}

}