// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_dateFieldPopupStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _dateFieldPopupStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration(".dateFieldPopup");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".dateFieldPopup", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.dropShadowEnabled = true;
                    this.backgroundColor = 0xFFFFFF;
                    this.borderThickness = 0;
                };
            };
        }


    }
}//package 

