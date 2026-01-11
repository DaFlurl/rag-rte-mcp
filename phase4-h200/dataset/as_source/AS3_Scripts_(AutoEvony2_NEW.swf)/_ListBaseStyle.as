// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_ListBaseStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.skins.halo.ListDropIndicator;
    import mx.core.IFlexModuleFactory;

    public class _ListBaseStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ListBase");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ListBase", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.borderStyle = "solid";
                    this.paddingTop = 2;
                    this.backgroundColor = 0xFFFFFF;
                    this.backgroundDisabledColor = 0xDDDDDD;
                    this.dropIndicatorSkin = ListDropIndicator;
                    this.paddingLeft = 2;
                    this.paddingBottom = 2;
                    this.paddingRight = 0;
                };
            };
        }


    }
}//package 

