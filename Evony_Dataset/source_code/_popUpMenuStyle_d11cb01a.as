// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_popUpMenuStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _popUpMenuStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration(".popUpMenu");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".popUpMenu", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.textAlign = "left";
                    this.fontWeight = "normal";
                };
            };
        }


    }
}//package 

