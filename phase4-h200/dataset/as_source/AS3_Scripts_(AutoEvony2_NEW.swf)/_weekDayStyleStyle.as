// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_weekDayStyleStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _weekDayStyleStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration(".weekDayStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".weekDayStyle", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.fontWeight = "bold";
                    this.textAlign = "center";
                };
            };
        }


    }
}//package 

