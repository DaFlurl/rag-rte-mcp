// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_DataGridItemRendererStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _DataGridItemRendererStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("DataGridItemRenderer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("DataGridItemRenderer", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.paddingLeft = 5;
                };
            };
        }


    }
}//package 

