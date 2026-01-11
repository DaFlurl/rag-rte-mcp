package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _HDividedBoxStyle
   {
      private static var _embed_css_Assets_swf_mx_skins_cursor_VBoxDivider_649363429:Class = _HDividedBoxStyle__embed_css_Assets_swf_mx_skins_cursor_VBoxDivider_649363429;
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_HBoxDivider_1798985123:Class = _HDividedBoxStyle__embed_css_Assets_swf_mx_skins_cursor_HBoxDivider_1798985123;
      
      private static var _embed_css_Assets_swf_mx_skins_BoxDividerSkin_1575870918:Class = _HDividedBoxStyle__embed_css_Assets_swf_mx_skins_BoxDividerSkin_1575870918;
      
      public function _HDividedBoxStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("HDividedBox");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("HDividedBox",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
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
         }
      }
   }
}

