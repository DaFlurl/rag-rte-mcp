// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_ButtonStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.skins.halo.ButtonSkin;
    import mx.core.IFlexModuleFactory;

    public class _ButtonStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("Button");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Button", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.paddingTop = 2;
                    this.textAlign = "center";
                    this.skin = ButtonSkin;
                    this.paddingLeft = 10;
                    this.fontWeight = "bold";
                    this.cornerRadius = 4;
                    this.paddingRight = 10;
                    this.verticalGap = 2;
                    this.horizontalGap = 2;
                    this.paddingBottom = 2;
                };
            };
        }


    }
}//package 

