// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.FlexShape

package mx.core
{
    import flash.display.Shape;
    import mx.utils.NameUtil;

    public class FlexShape extends Shape 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public function FlexShape()
        {
            super();
            try
            {
                name = NameUtil.createUniqueName(this);
            }
            catch(e:Error)
            {
            };
        }

        override public function toString():String
        {
            return (NameUtil.displayObjectToString(this));
        }


    }
}//package mx.core

