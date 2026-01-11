// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_TextInputStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _TextInputStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("TextInput");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("TextInput", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.backgroundDisabledColor = 0xDDDDDD;
                    this.backgroundColor = 0xFFFFFF;
                };
            };
        }


    }
}//package 

