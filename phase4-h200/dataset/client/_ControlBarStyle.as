// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_ControlBarStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _ControlBarStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ControlBar");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ControlBar", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.paddingTop = 10;
                    this.disabledOverlayAlpha = 0;
                    this.paddingLeft = 10;
                    this.paddingRight = 10;
                    this.verticalAlign = "middle";
                    this.paddingBottom = 10;
                    this.borderStyle = "controlBar";
                };
            };
        }


    }
}//package 

