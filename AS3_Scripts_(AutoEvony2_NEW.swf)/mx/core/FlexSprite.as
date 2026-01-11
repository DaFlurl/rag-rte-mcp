// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.FlexSprite

package mx.core
{
    import flash.display.Sprite;
    import mx.utils.NameUtil;

    public class FlexSprite extends Sprite 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public function FlexSprite()
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

