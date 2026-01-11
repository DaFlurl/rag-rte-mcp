// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.ISystemManager

package mx.managers
{
    import flash.events.IEventDispatcher;
    import mx.core.IChildList;
    import mx.core.IFlexModuleFactory;
    import flash.display.Sprite;
    import flash.text.TextFormat;
    import flash.events.Event;
    import flash.display.DisplayObject;
    import mx.core.ISWFBridgeGroup;
    import flash.display.LoaderInfo;
    import flash.geom.Rectangle;
    import flash.display.Stage;

    public interface ISystemManager extends IEventDispatcher, IChildList, IFlexModuleFactory 
    {

        function set focusPane(_arg_1:Sprite):void;
        function get toolTipChildren():IChildList;
        function useSWFBridge():Boolean;
        function isFontFaceEmbedded(_arg_1:TextFormat):Boolean;
        function deployMouseShields(_arg_1:Boolean):void;
        function get rawChildren():IChildList;
        function get topLevelSystemManager():ISystemManager;
        function dispatchEventFromSWFBridges(_arg_1:Event, _arg_2:IEventDispatcher=null, _arg_3:Boolean=false, _arg_4:Boolean=false):void;
        function getSandboxRoot():DisplayObject;
        function get swfBridgeGroup():ISWFBridgeGroup;
        function removeFocusManager(_arg_1:IFocusManagerContainer):void;
        function addChildToSandboxRoot(_arg_1:String, _arg_2:DisplayObject):void;
        function get document():Object;
        function get focusPane():Sprite;
        function get loaderInfo():LoaderInfo;
        function addChildBridge(_arg_1:IEventDispatcher, _arg_2:DisplayObject):void;
        function getTopLevelRoot():DisplayObject;
        function removeChildBridge(_arg_1:IEventDispatcher):void;
        function isDisplayObjectInABridgedApplication(_arg_1:DisplayObject):Boolean;
        function get popUpChildren():IChildList;
        function get screen():Rectangle;
        function removeChildFromSandboxRoot(_arg_1:String, _arg_2:DisplayObject):void;
        function getDefinitionByName(_arg_1:String):Object;
        function activate(_arg_1:IFocusManagerContainer):void;
        function deactivate(_arg_1:IFocusManagerContainer):void;
        function get cursorChildren():IChildList;
        function set document(_arg_1:Object):void;
        function get embeddedFontList():Object;
        function set numModalWindows(_arg_1:int):void;
        function isTopLevel():Boolean;
        function isTopLevelRoot():Boolean;
        function get numModalWindows():int;
        function addFocusManager(_arg_1:IFocusManagerContainer):void;
        function get stage():Stage;
        function getVisibleApplicationRect(_arg_1:Rectangle=null):Rectangle;

    }
}//package mx.managers

