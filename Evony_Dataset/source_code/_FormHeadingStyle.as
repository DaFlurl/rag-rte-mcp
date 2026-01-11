// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_FormHeadingStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _FormHeadingStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("FormHeading");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("FormHeading", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.fontWeight = "bold";
                    this.verticalGap = 16;
                    this.fontSize = 12;
                    this.borderStyle = "none";
                };
            };
        }


    }
}//package 

