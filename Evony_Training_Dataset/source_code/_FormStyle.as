// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_FormStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _FormStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("Form");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Form", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.paddingTop = 16;
                    this.verticalGap = 6;
                    this.paddingLeft = 16;
                    this.paddingBottom = 16;
                    this.paddingRight = 16;
                };
            };
        }


    }
}//package 

