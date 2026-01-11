// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_CursorManagerStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.skins.halo.BusyCursor;
    import mx.core.IFlexModuleFactory;

    public class _CursorManagerStyle 
    {

        private static var _embed_css_Assets_swf_mx_skins_cursor_BusyCursor_461621840:Class = _CursorManagerStyle__embed_css_Assets_swf_mx_skins_cursor_BusyCursor_461621840;


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("CursorManager");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("CursorManager", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.busyCursor = BusyCursor;
                    this.busyCursorBackground = _embed_css_Assets_swf_mx_skins_cursor_BusyCursor_461621840;
                };
            };
        }


    }
}//package 

