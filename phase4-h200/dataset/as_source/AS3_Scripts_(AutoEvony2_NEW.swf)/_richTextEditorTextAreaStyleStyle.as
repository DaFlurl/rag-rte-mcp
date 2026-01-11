// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_richTextEditorTextAreaStyleStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _richTextEditorTextAreaStyleStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration(".richTextEditorTextAreaStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".richTextEditorTextAreaStyle", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                };
            };
        }


    }
}//package 

