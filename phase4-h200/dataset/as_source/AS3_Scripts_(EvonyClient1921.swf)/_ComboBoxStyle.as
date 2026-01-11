// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_ComboBoxStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.skins.halo.ComboBoxArrowSkin;
    import mx.core.IFlexModuleFactory;

    public class _ComboBoxStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ComboBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ComboBox", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.skin = ComboBoxArrowSkin;
                    this.paddingLeft = 5;
                    this.fontWeight = "bold";
                    this.disabledIconColor = 9542041;
                    this.cornerRadius = 5;
                    this.arrowButtonWidth = 22;
                    this.paddingRight = 5;
                    this.leading = 0;
                    this.dropdownStyleName = "comboDropdown";
                };
            };
        }


    }
}//package 

