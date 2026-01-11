// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_DividedBoxStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _DividedBoxStyle 
    {

        private static var _embed_css_Assets_swf_mx_skins_cursor_VBoxDivider_649363429:Class = _DividedBoxStyle__embed_css_Assets_swf_mx_skins_cursor_VBoxDivider_649363429;
        private static var _embed_css_Assets_swf_mx_skins_cursor_HBoxDivider_1798985123:Class = _DividedBoxStyle__embed_css_Assets_swf_mx_skins_cursor_HBoxDivider_1798985123;
        private static var _embed_css_Assets_swf_mx_skins_BoxDividerSkin_1575870918:Class = _DividedBoxStyle__embed_css_Assets_swf_mx_skins_BoxDividerSkin_1575870918;


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("DividedBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("DividedBox", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.dividerThickness = 3;
                    this.dividerColor = 7305079;
                    this.dividerAffordance = 6;
                    this.verticalDividerCursor = _embed_css_Assets_swf_mx_skins_cursor_VBoxDivider_649363429;
                    this.dividerSkin = _embed_css_Assets_swf_mx_skins_BoxDividerSkin_1575870918;
                    this.horizontalDividerCursor = _embed_css_Assets_swf_mx_skins_cursor_HBoxDivider_1798985123;
                    this.dividerAlpha = 0.75;
                    this.verticalGap = 10;
                    this.horizontalGap = 10;
                };
            };
        }


    }
}//package 

