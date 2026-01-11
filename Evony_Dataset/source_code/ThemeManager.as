package autoevony.gui.controls.themes
{
   import mx.core.Application;
   import mx.core.mx_internal;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class ThemeManager
   {
      public static const DEFAULT_THEME:String = "Default";
      
      public static var themes:Themes = new Themes();
      
      public static var unloadGlobal:Boolean = false;
      
      private static var currentTheme:String = "";
      
      private static var effectMap:Object = new Object();
      
      private static var overrideMap:Object = new Object();
      
      private static var selectors:Array = new Array();
      
      public function ThemeManager()
      {
         super();
      }
      
      public static function loadTheme(param1:Object = null, param2:String = "Default") : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:CSSStyleDeclaration = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         if(param2 == currentTheme)
         {
            return;
         }
         currentTheme = param2;
         if(param1 == null)
         {
            param1 = themes[param2.split(" ").join("_") + "_Theme"];
         }
         if(param1 == null)
         {
            param1 = themes.Default_Grey_RE_Theme;
            currentTheme = DEFAULT_THEME;
         }
         for(_loc7_ in param1)
         {
            if(_loc7_ == "mainApp")
            {
               for(_loc4_ in param1[_loc7_])
               {
                  Application.application.setStyle(_loc4_,param1[_loc7_][_loc4_]);
               }
            }
            else
            {
               _loc3_ = _loc7_.charAt(0) == "_" ? "." + _loc7_.substr(1) : _loc7_;
               _loc5_ = StyleManager.getStyleDeclaration(_loc3_);
               if(!_loc5_)
               {
                  _loc5_ = new CSSStyleDeclaration();
                  StyleManager.setStyleDeclaration(_loc3_,_loc5_,false);
                  selectors.push(_loc3_);
               }
               _loc6_ = overrideMap[_loc3_];
               if(_loc6_ == null)
               {
                  _loc6_ = new Array();
                  overrideMap[_loc3_] = _loc6_;
               }
               for(_loc4_ in param1[_loc7_])
               {
                  _loc5_.mx_internal::setStyle(_loc4_,param1[_loc7_][_loc4_]);
                  _loc6_.push(_loc4_);
               }
            }
         }
         resetStage();
      }
      
      private static function unloadOverrides() : void
      {
         var _loc7_:String = null;
         var _loc1_:CSSStyleDeclaration = null;
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         for(_loc7_ in overrideMap)
         {
            _loc1_ = StyleManager.getStyleDeclaration(_loc7_);
            if(_loc1_ != null)
            {
               _loc2_ = overrideMap[_loc7_];
               if(_loc2_ != null)
               {
                  _loc3_ = _loc2_.length;
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_)
                  {
                     _loc1_.mx_internal::clearOverride(_loc2_[_loc4_]);
                     _loc4_++;
                  }
               }
               _loc2_ = effectMap[_loc7_];
               if(_loc2_ != null)
               {
                  _loc3_ = _loc2_.length;
                  _loc6_ = _loc1_.mx_internal::effects;
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_)
                  {
                     _loc5_ = int(_loc6_.indexOf(_loc2_[_loc4_]));
                     if(_loc5_ != -1)
                     {
                        _loc6_.splice(_loc5_,1);
                     }
                     _loc4_++;
                  }
               }
            }
         }
         overrideMap = null;
         effectMap = null;
      }
      
      public static function getStyle(param1:String, param2:String) : *
      {
         return StyleManager.getStyleDeclaration(param1).getStyle(param2);
      }
      
      private static function unloadStyleDeclarations() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < selectors.length)
         {
            StyleManager.clearStyleDeclaration(selectors[_loc1_] as String,false);
            _loc1_++;
         }
         selectors = null;
      }
      
      private static function resetStage() : void
      {
         Application.application.resetStage();
      }
      
      public static function unload() : void
      {
         unloadOverrides();
         unloadStyleDeclarations();
         if(unloadGlobal)
         {
            StyleManager.mx_internal::stylesRoot = null;
            StyleManager.mx_internal::initProtoChainRoots();
         }
         resetStage();
      }
   }
}

