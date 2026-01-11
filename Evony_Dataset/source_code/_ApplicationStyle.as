// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_ApplicationStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.skins.halo.ApplicationBackground;
    import mx.core.IFlexModuleFactory;

    public class _ApplicationStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("Application");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Application", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.backgroundSize = "100%";
                    this.paddingTop = 24;
                    this.backgroundColor = 8821927;
                    this.backgroundImage = ApplicationBackground;
                    this.horizontalAlign = "center";
                    this.backgroundGradientAlphas = [1, 1];
                    this.paddingLeft = 24;
                    this.paddingBottom = 24;
                    this.paddingRight = 24;
                };
            };
        }


    }
}//package 

