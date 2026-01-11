// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.states.IDegrafaStateClient

package com.degrafa.states
{
    import flash.events.IEventDispatcher;
    import com.degrafa.IGeometry;
    import com.degrafa.core.collections.GeometryCollection;

    public interface IDegrafaStateClient extends IEventDispatcher, IStateClient, IGeometry 
    {

        function get geometryCollection():GeometryCollection;
        function get states():Array;
        function set geometry(_arg_1:Array):void;
        function get geometry():Array;
        function get isInitialized():Boolean;
        function set states(_arg_1:Array):void;

    }
}//package com.degrafa.states

