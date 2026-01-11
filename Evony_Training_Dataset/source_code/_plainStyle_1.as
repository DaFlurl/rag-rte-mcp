// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_plainStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _plainStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration(".plain");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".plain", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.paddingTop = 0;
                    this.paddingLeft = 0;
                    this.horizontalAlign = "left";
                    this.paddingRight = 0;
                    this.backgroundImage = "";
                    this.paddingBottom = 0;
                    this.backgroundColor = 0xFFFFFF;
                };
            };
        }


    }
}//package 

