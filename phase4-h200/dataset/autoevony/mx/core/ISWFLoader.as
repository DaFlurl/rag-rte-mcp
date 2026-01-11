// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.ISWFLoader

package mx.core
{
    import flash.geom.Rectangle;

    public interface ISWFLoader extends ISWFBridgeProvider 
    {

        function getVisibleApplicationRect(_arg_1:Boolean=false):Rectangle;
        function set loadForCompatibility(_arg_1:Boolean):void;
        function get loadForCompatibility():Boolean;

    }
}//package mx.core

