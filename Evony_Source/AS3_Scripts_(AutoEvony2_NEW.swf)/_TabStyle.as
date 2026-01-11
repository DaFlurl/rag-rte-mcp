// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_TabStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.skins.halo.TabSkin;
    import mx.core.IFlexModuleFactory;

    public class _TabStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("Tab");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Tab", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.upSkin = null;
                    this.selectedDownSkin = null;
                    this.overSkin = null;
                    this.downSkin = null;
                    this.selectedDisabledSkin = null;
                    this.paddingTop = 1;
                    this.selectedUpSkin = null;
                    this.disabledSkin = null;
                    this.skin = TabSkin;
                    this.paddingBottom = 1;
                    this.selectedOverSkin = null;
                };
            };
        }


    }
}//package 

