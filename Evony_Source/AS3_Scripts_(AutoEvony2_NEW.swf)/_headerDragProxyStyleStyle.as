// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_headerDragProxyStyleStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _headerDragProxyStyleStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration(".headerDragProxyStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".headerDragProxyStyle", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.fontWeight = "bold";
                };
            };
        }


    }
}//package 

