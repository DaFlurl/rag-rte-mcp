package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _VDividedBoxStyle
   {
      private static var _embed_css_Assets_swf_mx_skins_cursor_VBoxDivider_649363429:Class = _VDividedBoxStyle__embed_css_Assets_swf_mx_skins_cursor_VBoxDivider_649363429;
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_HBoxDivider_1798985123:Class = _VDividedBoxStyle__embed_css_Assets_swf_mx_skins_cursor_HBoxDivider_1798985123;
      
      private static var _embed_css_Assets_swf_mx_skins_BoxDividerSkin_1575870918:Class = _VDividedBoxStyle__embed_css_Assets_swf_mx_skins_BoxDividerSkin_1575870918;
      
      public function _VDividedBoxStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("VDividedBox");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("VDividedBox",style,false);
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

