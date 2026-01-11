package
{
   import mx.core.IFlexModuleFactory;
   import mx.skins.halo.DefaultDragImage;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _DragManagerStyle
   {
      private static var _embed_css_Assets_swf_mx_skins_cursor_DragCopy_914944550:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragCopy_914944550;
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_DragMove_914644378:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragMove_914644378;
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_DragLink_914682289:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragLink_914682289;
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_DragReject_774721940:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragReject_774721940;
      
      public function _DragManagerStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("DragManager");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("DragManager",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.copyCursor = _embed_css_Assets_swf_mx_skins_cursor_DragCopy_914944550;
               this.moveCursor = _embed_css_Assets_swf_mx_skins_cursor_DragMove_914644378;
               this.rejectCursor = _embed_css_Assets_swf_mx_skins_cursor_DragReject_774721940;
               this.linkCursor = _embed_css_Assets_swf_mx_skins_cursor_DragLink_914682289;
               this.defaultDragImageSkin = DefaultDragImage;
            };
         }
      }
   }
}

