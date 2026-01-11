// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_textAreaVScrollBarStyleStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _textAreaVScrollBarStyleStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration(".textAreaVScrollBarStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".textAreaVScrollBarStyle", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                };
            };
        }


    }
}//package 

