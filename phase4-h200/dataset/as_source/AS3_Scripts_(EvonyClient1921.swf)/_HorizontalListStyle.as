// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_HorizontalListStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _HorizontalListStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("HorizontalList");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("HorizontalList", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.textAlign = "center";
                };
            };
        }


    }
}//package 

