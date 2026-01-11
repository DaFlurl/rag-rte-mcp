// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.IDeferredInstantiationUIComponent

package mx.core
{
    public interface IDeferredInstantiationUIComponent extends IUIComponent 
    {

        function set cacheHeuristic(_arg_1:Boolean):void;
        function createReferenceOnParentDocument(_arg_1:IFlexDisplayObject):void;
        function get cachePolicy():String;
        function set id(_arg_1:String):void;
        function registerEffects(_arg_1:Array):void;
        function executeBindings(_arg_1:Boolean=false):void;
        function get id():String;
        function deleteReferenceOnParentDocument(_arg_1:IFlexDisplayObject):void;
        function set descriptor(_arg_1:UIComponentDescriptor):void;
        function get descriptor():UIComponentDescriptor;

    }
}//package mx.core

