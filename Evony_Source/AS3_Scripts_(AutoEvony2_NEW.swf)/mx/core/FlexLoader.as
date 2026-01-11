// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.FlexLoader

package mx.core
{
    import flash.display.Loader;
    import mx.utils.NameUtil;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class FlexLoader extends Loader 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public function FlexLoader()
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

