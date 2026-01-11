// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_DragManagerStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.skins.halo.DefaultDragImage;
    import mx.core.IFlexModuleFactory;

    public class _DragManagerStyle 
    {

        private static var _embed_css_Assets_swf_mx_skins_cursor_DragLink_1613232082:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragLink_1613232082;
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragCopy_1612969821:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragCopy_1612969821;
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragMove_1613173305:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragMove_1613173305;
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragReject_813882489:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragReject_813882489;


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("DragManager");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("DragManager", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.rejectCursor = _embed_css_Assets_swf_mx_skins_cursor_DragReject_813882489;
                    this.defaultDragImageSkin = DefaultDragImage;
                    this.moveCursor = _embed_css_Assets_swf_mx_skins_cursor_DragMove_1613173305;
                    this.copyCursor = _embed_css_Assets_swf_mx_skins_cursor_DragCopy_1612969821;
                    this.linkCursor = _embed_css_Assets_swf_mx_skins_cursor_DragLink_1613232082;
                };
            };
        }


    }
}//package 

