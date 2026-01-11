// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_AlertStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _AlertStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("Alert");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Alert", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.paddingTop = 2;
                    this.borderColor = 8821927;
                    this.paddingLeft = 10;
                    this.color = 0xFFFFFF;
                    this.roundedBottomCorners = true;
                    this.paddingRight = 10;
                    this.backgroundAlpha = 0.9;
                    this.paddingBottom = 2;
                    this.borderAlpha = 0.9;
                    this.buttonStyleName = "alertButtonStyle";
                    this.backgroundColor = 8821927;
                };
            };
        }


    }
}//package 

