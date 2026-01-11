// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_playerInfo_NameChangeWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.playerInfo.NameChangeWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_playerInfo_NameChangeWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            NameChangeWin.watcherSetupUtil = new (_view_module_playerInfo_NameChangeWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[3] = new PropertyWatcher("playerInfo", {"propertyChange":true}, [_arg_3[3]], _arg_2);
            _arg_4[4] = new PropertyWatcher("userName", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[3].addChild(_arg_4[4]);
        }


    }
}//package 

