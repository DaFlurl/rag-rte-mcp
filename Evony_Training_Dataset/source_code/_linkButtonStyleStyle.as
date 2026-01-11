// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_linkButtonStyleStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _linkButtonStyleStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration(".linkButtonStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".linkButtonStyle", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.paddingTop = 2;
                    this.paddingLeft = 2;
                    this.paddingBottom = 2;
                    this.paddingRight = 2;
                };
            };
        }


    }
}//package 

