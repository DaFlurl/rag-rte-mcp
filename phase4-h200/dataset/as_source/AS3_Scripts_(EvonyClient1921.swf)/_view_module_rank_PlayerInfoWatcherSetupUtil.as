// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_rank_PlayerInfoWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.rank.PlayerInfo;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_rank_PlayerInfoWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            PlayerInfo.watcherSetupUtil = new (_view_module_rank_PlayerInfoWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[8] = new PropertyWatcher("memberInfo", {"propertyChange":true}, [_arg_3[17], _arg_3[19], _arg_3[8], _arg_3[23], _arg_3[21], _arg_3[16], _arg_3[14], _arg_3[25], _arg_3[10], _arg_3[12]], _arg_2);
            _arg_4[15] = new PropertyWatcher("honor", {"propertyChange":true}, [_arg_3[14]], null);
            _arg_4[21] = new PropertyWatcher("userName", {"propertyChange":true}, [_arg_3[19]], null);
            _arg_4[18] = new PropertyWatcher("titleId", {"propertyChange":true}, [_arg_3[16]], null);
            _arg_4[25] = new PropertyWatcher("office", {"propertyChange":true}, [_arg_3[23]], null);
            _arg_4[19] = new PropertyWatcher("faceUrl", {"propertyChange":true}, [_arg_3[17]], null);
            _arg_4[11] = new PropertyWatcher("prestige", {"propertyChange":true}, [_arg_3[10]], null);
            _arg_4[13] = new PropertyWatcher("castleCount", {"propertyChange":true}, [_arg_3[12]], null);
            _arg_4[9] = new PropertyWatcher("population", {"propertyChange":true}, [_arg_3[8]], null);
            _arg_4[23] = new PropertyWatcher("alliance", {"propertyChange":true}, [_arg_3[21]], null);
            _arg_4[27] = new PropertyWatcher("ranking", {"propertyChange":true}, [_arg_3[25]], null);
            _arg_4[8].updateParent(_arg_1);
            _arg_4[8].addChild(_arg_4[15]);
            _arg_4[8].addChild(_arg_4[21]);
            _arg_4[8].addChild(_arg_4[18]);
            _arg_4[8].addChild(_arg_4[25]);
            _arg_4[8].addChild(_arg_4[19]);
            _arg_4[8].addChild(_arg_4[11]);
            _arg_4[8].addChild(_arg_4[13]);
            _arg_4[8].addChild(_arg_4[9]);
            _arg_4[8].addChild(_arg_4[23]);
            _arg_4[8].addChild(_arg_4[27]);
        }


    }
}//package 

