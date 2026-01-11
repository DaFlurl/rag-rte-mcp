// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_NumericStepperStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.skins.halo.NumericStepperDownSkin;
    import mx.skins.halo.NumericStepperUpSkin;
    import mx.core.IFlexModuleFactory;

    public class _NumericStepperStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("NumericStepper");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("NumericStepper", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.downArrowSkin = NumericStepperDownSkin;
                    this.cornerRadius = 5;
                    this.focusRoundedCorners = "tr br";
                    this.upArrowSkin = NumericStepperUpSkin;
                };
            };
        }


    }
}//package 

