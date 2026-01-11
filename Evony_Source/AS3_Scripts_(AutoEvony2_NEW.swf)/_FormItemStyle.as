// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_FormItemStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _FormItemStyle 
    {

        private static var _embed_css_Assets_swf_mx_containers_FormItem_Required_1871355633:Class = _FormItemStyle__embed_css_Assets_swf_mx_containers_FormItem_Required_1871355633;


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("FormItem");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("FormItem", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.indicatorSkin = _embed_css_Assets_swf_mx_containers_FormItem_Required_1871355633;
                };
            };
        }


    }
}//package 

