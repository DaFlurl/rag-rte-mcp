// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.resources.IResourceManager

package mx.resources
{
    import flash.events.IEventDispatcher;
    import flash.system.ApplicationDomain;
    import flash.system.SecurityDomain;

    public interface IResourceManager extends IEventDispatcher 
    {

        function loadResourceModule(_arg_1:String, _arg_2:Boolean=true, _arg_3:ApplicationDomain=null, _arg_4:SecurityDomain=null):IEventDispatcher;
        [Bindable("change")]
        function getBoolean(_arg_1:String, _arg_2:String, _arg_3:String=null):Boolean;
        [Bindable("change")]
        function getClass(_arg_1:String, _arg_2:String, _arg_3:String=null):Class;
        function getLocales():Array;
        function removeResourceBundlesForLocale(_arg_1:String):void;
        function getResourceBundle(_arg_1:String, _arg_2:String):IResourceBundle;
        function get localeChain():Array;
        [Bindable("change")]
        function getInt(_arg_1:String, _arg_2:String, _arg_3:String=null):int;
        function update():void;
        function set localeChain(_arg_1:Array):void;
        [Bindable("change")]
        function getUint(_arg_1:String, _arg_2:String, _arg_3:String=null):uint;
        function addResourceBundle(_arg_1:IResourceBundle):void;
        [Bindable("change")]
        function getStringArray(_arg_1:String, _arg_2:String, _arg_3:String=null):Array;
        function getBundleNamesForLocale(_arg_1:String):Array;
        function removeResourceBundle(_arg_1:String, _arg_2:String):void;
        [Bindable("change")]
        function getObject(_arg_1:String, _arg_2:String, _arg_3:String=null):*;
        [Bindable("change")]
        function getString(_arg_1:String, _arg_2:String, _arg_3:Array=null, _arg_4:String=null):String;
        function installCompiledResourceBundles(_arg_1:ApplicationDomain, _arg_2:Array, _arg_3:Array):void;
        function unloadResourceModule(_arg_1:String, _arg_2:Boolean=true):void;
        function getPreferredLocaleChain():Array;
        function findResourceBundleWithResource(_arg_1:String, _arg_2:String):IResourceBundle;
        function initializeLocaleChain(_arg_1:Array):void;
        [Bindable("change")]
        function getNumber(_arg_1:String, _arg_2:String, _arg_3:String=null):Number;

    }
}//package mx.resources

