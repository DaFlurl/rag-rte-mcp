package
{
   import autoevony.gui.MainScreen;
   import flash.display.Sprite;
   import mx.binding.FunctionReturnWatcher;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_MainScreenWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      
      public function _autoevony_gui_MainScreenWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         MainScreen.watcherSetupUtil = new _autoevony_gui_MainScreenWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         var target:Object = param1;
         var propertyGetter:Function = param2;
         var bindings:Array = param3;
         var watchers:Array = param4;
         watchers[27] = new PropertyWatcher("cache",{"propertyChange":true},[bindings[16]],propertyGetter);
         watchers[34] = new PropertyWatcher("emptyStr",{"propertyChange":true},[bindings[16]],null);
         watchers[33] = new PropertyWatcher("warLogs",{"propertyChange":true},[bindings[16]],null);
         watchers[28] = new PropertyWatcher("logs",{"propertyChange":true},[bindings[16]],null);
         watchers[29] = new PropertyWatcher("cityLogs",{"propertyChange":true},[bindings[16]],null);
         watchers[31] = new PropertyWatcher("_citiesTab",{"propertyChange":true},[bindings[16]],propertyGetter);
         watchers[32] = new PropertyWatcher("selectedIndex",{
            "valueCommit":true,
            "click":true
         },[bindings[16]],null);
         watchers[20] = new PropertyWatcher("_cityPanelBeansArray",{"propertyChange":true},[bindings[12],bindings[13]],propertyGetter);
         watchers[24] = new PropertyWatcher("selectedIndex",{
            "valueCommit":true,
            "creationComplete":true,
            "change":true
         },[bindings[13]],null);
         watchers[21] = new PropertyWatcher("selectedChild",{
            "valueCommit":true,
            "creationComplete":true
         },[bindings[12]],null);
         watchers[25] = new PropertyWatcher("_logTab",{"propertyChange":true},[bindings[17],bindings[16],bindings[15]],propertyGetter);
         watchers[26] = new PropertyWatcher("selectedIndex",{
            "valueCommit":true,
            "click":true
         },[bindings[17],bindings[16],bindings[15]],null);
         watchers[0] = new PropertyWatcher("currentPlayer",{"propertyChange":true},[bindings[0],bindings[1],bindings[2],bindings[3],bindings[4],bindings[5],bindings[6],bindings[7],bindings[8],bindings[9],bindings[13]],propertyGetter);
         watchers[22] = new PropertyWatcher("castlesArray",{"propertyChange":true},[bindings[13]],null);
         watchers[23] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [target._cityPanelBeansArray.selectedIndex];
         },{"collectionChange":true},[bindings[13]],null);
         watchers[1] = new PropertyWatcher("playerInfo",{"propertyChange":true},[bindings[0],bindings[1],bindings[2],bindings[3],bindings[4],bindings[5],bindings[6],bindings[7],bindings[8],bindings[9]],null);
         watchers[6] = new PropertyWatcher("office",{"propertyChange":true},[bindings[3]],null);
         watchers[3] = new PropertyWatcher("alliance",{"propertyChange":true},[bindings[1],bindings[7]],null);
         watchers[12] = new PropertyWatcher("allianceLevel",{"propertyChange":true},[bindings[7]],null);
         watchers[5] = new PropertyWatcher("prestige",{"propertyChange":true},[bindings[2]],null);
         watchers[14] = new PropertyWatcher("honor",{"propertyChange":true},[bindings[8]],null);
         watchers[11] = new PropertyWatcher("levelId",{"propertyChange":true},[bindings[6]],null);
         watchers[2] = new PropertyWatcher("userName",{"propertyChange":true},[bindings[0]],null);
         watchers[17] = new PropertyWatcher("titleId",{"propertyChange":true},[bindings[9]],null);
         watchers[10] = new PropertyWatcher("ranking",{"propertyChange":true},[bindings[5]],null);
         watchers[8] = new PropertyWatcher("medal",{"propertyChange":true},[bindings[4]],null);
         watchers[27].updateParent(target);
         watchers[27].addChild(watchers[34]);
         watchers[27].addChild(watchers[33]);
         watchers[27].addChild(watchers[28]);
         watchers[27].addChild(watchers[29]);
         watchers[31].updateParent(target);
         watchers[31].addChild(watchers[32]);
         watchers[20].updateParent(target);
         watchers[20].addChild(watchers[24]);
         watchers[20].addChild(watchers[21]);
         watchers[25].updateParent(target);
         watchers[25].addChild(watchers[26]);
         watchers[0].updateParent(target);
         watchers[0].addChild(watchers[22]);
         watchers[23].parentWatcher = watchers[22];
         watchers[22].addChild(watchers[23]);
         watchers[0].addChild(watchers[1]);
         watchers[1].addChild(watchers[6]);
         watchers[1].addChild(watchers[3]);
         watchers[1].addChild(watchers[12]);
         watchers[1].addChild(watchers[5]);
         watchers[1].addChild(watchers[14]);
         watchers[1].addChild(watchers[11]);
         watchers[1].addChild(watchers[2]);
         watchers[1].addChild(watchers[17]);
         watchers[1].addChild(watchers[10]);
         watchers[1].addChild(watchers[8]);
      }
   }
}

