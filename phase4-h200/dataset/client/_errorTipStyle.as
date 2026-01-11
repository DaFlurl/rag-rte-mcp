// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_errorTipStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _errorTipStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration(".errorTip");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".errorTip", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.paddingTop = 4;
                    this.borderColor = 13510953;
                    this.paddingLeft = 4;
                    this.color = 0xFFFFFF;
                    this.fontWeight = "bold";
                    this.paddingRight = 4;
                    this.shadowColor = 0;
                    this.fontSize = 9;
                    this.paddingBottom = 4;
                    this.borderStyle = "errorTipRight";
                };
            };
        }


    }
}//package 

