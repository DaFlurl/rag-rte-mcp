package autoevony.gui
{
   import autoevony.common.Utils;
   import autoevony.gui.newarmy.NewArmyWin;
   import autoevony.player.LoginHelper;
   import flash.net.SharedObject;
   import mx.containers.Canvas;
   import mx.events.PropertyChangeEvent;
   
   public class CityPanelBean extends Canvas
   {
      
      internal static const ICON_TYPE_NONE:int = 0;
      
      internal static const ICON_TYPE_SUZ:int = 1;
      
      internal static const ICON_TYPE_COL:int = 2;
      
      private static const SUZ_ICON:Class = CityPanelBean_SUZ_ICON;
      
      private static const COL_ICON:Class = CityPanelBean_COL_ICON;
      
      internal var lastSavedScriptFileName:String = null;
      
      private var _1691131734scriptIsRunning:Boolean;
      
      internal var lastLoadedGoalsFileName:String = null;
      
      private var isSuz:Boolean;
      
      public var marchWin:NewArmyWin;
      
      private var _249938341scriptTxt:String;
      
      private var _35872819castleId:int;
      
      private var isCol:Boolean;
      
      internal var lastLoadedScriptFileName:String = null;
      
      private var _1729777296goalsTxt:String;
      
      internal var lastSavedGoalsFileName:String = null;
      
      public function CityPanelBean(param1:int, param2:String = "", param3:int = -1)
      {
         super();
         this.castleId = param1;
         this.label = param2;
         if(param3 != -1)
         {
            this.setTabIcon(param3);
         }
         else
         {
            this.icon = null;
         }
         this.goalsTxt = "";
         this.scriptTxt = "";
         this.isSuz = false;
         this.isCol = false;
         this.scriptIsRunning = false;
         this.marchWin = null;
      }
      
      internal function setTabIcon(param1:int) : void
      {
         if(param1 == ICON_TYPE_NONE)
         {
            if(this.isSuz || this.isCol)
            {
               this.icon = null;
               this.isSuz = false;
               this.isCol = false;
            }
         }
         else if(param1 == ICON_TYPE_SUZ)
         {
            if(!this.isSuz)
            {
               this.icon = SUZ_ICON;
               this.isSuz = true;
               this.isCol = false;
            }
         }
         else if(param1 == ICON_TYPE_COL)
         {
            if(!this.isCol)
            {
               this.icon = COL_ICON;
               this.isSuz = false;
               this.isCol = true;
            }
         }
      }
      
      internal function onLoadScript(param1:Object = null, param2:int = 500) : void
      {
         if(Snippets.isInitialized)
         {
            this.scriptTxt = SharedObject.getLocal("citytab" + this.castleId).data.now;
            if(this.scriptTxt == null)
            {
               this.scriptTxt = "";
            }
            if(LoginHelper.getInstance().autoScript && Utils.trim(this.scriptTxt) != "")
            {
               Utils.callLater(param2,MainScreen.getInstance()._cityPanel.onRunScript,[this.castleId]);
            }
         }
         else
         {
            Utils.callLater(50,this.onLoadScript,[param1,param2]);
         }
      }
      
      public function set scriptTxt(param1:String) : void
      {
         var _loc2_:Object = this._249938341scriptTxt;
         if(_loc2_ !== param1)
         {
            this._249938341scriptTxt = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scriptTxt",_loc2_,param1));
         }
      }
      
      public function set scriptIsRunning(param1:Boolean) : void
      {
         var _loc2_:Object = this._1691131734scriptIsRunning;
         if(_loc2_ !== param1)
         {
            this._1691131734scriptIsRunning = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scriptIsRunning",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalsTxt() : String
      {
         return this._1729777296goalsTxt;
      }
      
      public function set goalsTxt(param1:String) : void
      {
         var _loc2_:Object = this._1729777296goalsTxt;
         if(_loc2_ !== param1)
         {
            this._1729777296goalsTxt = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalsTxt",_loc2_,param1));
         }
      }
      
      internal function onLoadGoals(param1:Object = null, param2:int = 20) : void
      {
         if(Snippets.isInitialized)
         {
            this.goalsTxt = SharedObject.getLocal("citygoals" + this.castleId).data.now;
            if(this.goalsTxt == null)
            {
               this.goalsTxt = "";
            }
            if(LoginHelper.getInstance().autoRun)
            {
               Utils.callLater(param2,MainScreen.getInstance()._cityPanel.onSetGoals,[this.castleId]);
            }
         }
         else
         {
            Utils.callLater(50,this.onLoadGoals,[param1,param2]);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get scriptTxt() : String
      {
         return this._249938341scriptTxt;
      }
      
      public function set castleId(param1:int) : void
      {
         var _loc2_:Object = this._35872819castleId;
         if(_loc2_ !== param1)
         {
            this._35872819castleId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"castleId",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get scriptIsRunning() : Boolean
      {
         return this._1691131734scriptIsRunning;
      }
      
      [Bindable(event="propertyChange")]
      public function get castleId() : int
      {
         return this._35872819castleId;
      }
   }
}

