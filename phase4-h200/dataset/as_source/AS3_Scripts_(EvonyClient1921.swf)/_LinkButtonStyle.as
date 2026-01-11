// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_LinkButtonStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.skins.halo.LinkButtonSkin;
    import mx.core.IFlexModuleFactory;

    public class _LinkButtonStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("LinkButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("LinkButton", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.skin = LinkButtonSkin;
                    this.paddingLeft = 7;
                    this.selectedDownSkin = null;
                    this.selectedUpSkin = null;
                    this.paddingRight = 7;
                    this.selectedOverSkin = null;
                    this.upSkin = null;
                    this.overSkin = null;
                    this.downSkin = null;
                    this.selectedDisabledSkin = null;
                    this.disabledSkin = null;
                };
            };
        }


    }
}//package 

