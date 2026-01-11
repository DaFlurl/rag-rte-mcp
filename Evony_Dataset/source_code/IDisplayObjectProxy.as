// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.geometry.display.IDisplayObjectProxy

package com.degrafa.geometry.display
{
    import flash.display.DisplayObject;

    public interface IDisplayObjectProxy 
    {

        function get transformBeforeRender():Boolean;
        function get displayObject():DisplayObject;
        function get layoutMode():String;

    }
}//package com.degrafa.geometry.display

