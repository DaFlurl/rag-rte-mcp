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

        private static var _embed_css_Assets_swf_mx_skins_cursor_DragCopy_914944550:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragCopy_914944550;
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragMove_914644378:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragMove_914644378;
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragLink_914682289:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragLink_914682289;
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragReject_774721940:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragReject_774721940;


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
                    this.copyCursor = _embed_css_Assets_swf_mx_skins_cursor_DragCopy_914944550;
                    this.moveCursor = _embed_css_Assets_swf_mx_skins_cursor_DragMove_914644378;
                    this.rejectCursor = _embed_css_Assets_swf_mx_skins_cursor_DragReject_774721940;
                    this.linkCursor = _embed_css_Assets_swf_mx_skins_cursor_DragLink_914682289;
                    this.defaultDragImageSkin = DefaultDragImage;
                };
            };
        }


    }
}//package 

