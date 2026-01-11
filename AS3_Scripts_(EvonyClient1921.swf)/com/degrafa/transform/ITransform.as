// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.transform.ITransform

package com.degrafa.transform
{
    import com.degrafa.core.IDegrafaObject;
    import flash.geom.Matrix;
    import com.degrafa.IGeometryComposition;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public interface ITransform extends IDegrafaObject 
    {

        function hasExplicitSetting():Boolean;
        function get centerX():Number;
        function get centerY():Number;
        function set centerX(_arg_1:Number):void;
        function set centerY(_arg_1:Number):void;
        function get data():String;
        function get transformMatrix():Matrix;
        function set registrationPoint(_arg_1:String):void;
        function get isIdentity():Boolean;
        function getRegPoint(_arg_1:IGeometryComposition):Point;
        function getTransformFor(_arg_1:IGeometryComposition):Matrix;
        function set data(_arg_1:String):void;
        function get scaleX():Number;
        function get scaleY():Number;
        function get registrationPoint():String;
        function getRegPointForRectangle(_arg_1:Rectangle):Point;
        function get y():Number;
        function get angle():Number;
        function get skewX():Number;
        function get skewY():Number;
        function get x():Number;

    }
}//package com.degrafa.transform

