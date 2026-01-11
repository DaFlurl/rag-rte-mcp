// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_comboDropdownStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _comboDropdownStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration(".comboDropdown");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".comboDropdown", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.shadowDirection = "center";
                    this.fontWeight = "normal";
                    this.dropShadowEnabled = true;
                    this.leading = 0;
                    this.backgroundColor = 0xFFFFFF;
                    this.shadowDistance = 1;
                    this.cornerRadius = 0;
                    this.borderThickness = 0;
                    this.paddingLeft = 5;
                    this.paddingRight = 5;
                };
            };
        }


    }
}//package 

