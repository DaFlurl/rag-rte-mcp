// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_opaquePanelStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _opaquePanelStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration(".opaquePanel");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".opaquePanel", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.footerColors = [0xE7E7E7, 0xC7C7C7];
                    this.borderColor = 0xFFFFFF;
                    this.headerColors = [0xE7E7E7, 0xD9D9D9];
                    this.borderAlpha = 1;
                    this.backgroundColor = 0xFFFFFF;
                };
            };
        }


    }
}//package 

