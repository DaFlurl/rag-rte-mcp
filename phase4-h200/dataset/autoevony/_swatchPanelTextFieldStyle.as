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
                    this.borderStyle = "inset";
                    this.borderColor = 14015965;
                    this.highlightColor = 12897484;
                    this.backgroundColor = 0xFFFFFF;
                    this.shadowCapColor = 14015965;
                    this.shadowColor = 14015965;
                    this.paddingLeft = 5;
                    this.buttonColor = 7305079;
                    this.borderCapColor = 9542041;
                    this.paddingRight = 5;
                };
            };
        }


    }
}//package 

