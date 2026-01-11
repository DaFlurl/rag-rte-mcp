// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_TextAreaStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _TextAreaStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("TextArea");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("TextArea", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.horizontalScrollBarStyleName = "textAreaHScrollBarStyle";
                    this.backgroundDisabledColor = 0xDDDDDD;
                    this.borderStyle = "solid";
                    this.backgroundColor = 0xFFFFFF;
                    this.verticalScrollBarStyleName = "textAreaVScrollBarStyle";
                };
            };
        }


    }
}//package 

