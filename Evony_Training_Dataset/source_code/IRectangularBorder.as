// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.IRectangularBorder

package mx.core
{
    import flash.geom.Rectangle;

    public interface IRectangularBorder extends IBorder 
    {

        function get backgroundImageBounds():Rectangle;
        function get hasBackgroundImage():Boolean;
        function set backgroundImageBounds(_arg_1:Rectangle):void;
        function layoutBackgroundImage():void;

    }
}//package mx.core

