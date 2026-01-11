// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_playerInfo_TruceChangeWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.playerInfo.TruceChangeWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_playerInfo_TruceChangeWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            TruceChangeWin.watcherSetupUtil = new (_view_module_playerInfo_TruceChangeWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[6] = new PropertyWatcher("choiseArr", {"propertyChange":true}, [_arg_3[6]], _arg_2);
            _arg_4[6].updateParent(_arg_1);
        }


    }
}//package 

