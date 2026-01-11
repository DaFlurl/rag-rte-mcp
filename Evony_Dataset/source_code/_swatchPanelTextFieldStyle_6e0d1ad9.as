// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_swatchPanelTextFieldStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _swatchPanelTextFieldStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration(".swatchPanelTextField");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".swatchPanelTextField", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.highlightColor = 12897484;
                    this.borderColor = 14015965;
                    this.paddingLeft = 5;
                    this.shadowCapColor = 14015965;
                    this.paddingRight = 5;
                    this.shadowColor = 14015965;
                    this.borderStyle = "inset";
                    this.buttonColor = 7305079;
                    this.backgroundColor = 0xFFFFFF;
                    this.borderCapColor = 9542041;
                };
            };
        }


    }
}//package 

