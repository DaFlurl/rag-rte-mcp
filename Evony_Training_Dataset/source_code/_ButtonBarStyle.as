// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_ButtonBarStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _ButtonBarStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ButtonBar");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ButtonBar", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.textAlign = "center";
                    this.horizontalAlign = "center";
                    this.verticalAlign = "middle";
                    this.verticalGap = 0;
                    this.horizontalGap = 0;
                };
            };
        }


    }
}//package 

