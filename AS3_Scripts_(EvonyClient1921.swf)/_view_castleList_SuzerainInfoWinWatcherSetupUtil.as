// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_castleList_SuzerainInfoWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.castleList.SuzerainInfoWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_castleList_SuzerainInfoWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            SuzerainInfoWin.watcherSetupUtil = new (_view_castleList_SuzerainInfoWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("colonyBean", {"propertyChange":true}, [_arg_3[2], _arg_3[4], _arg_3[6], _arg_3[1], _arg_3[3], _arg_3[5]], _arg_2);
            _arg_4[4] = new PropertyWatcher("lordName", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[5] = new PropertyWatcher("prestige", {"propertyChange":true}, [_arg_3[5]], null);
            _arg_4[3] = new PropertyWatcher("position", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[6] = new PropertyWatcher("allianceName", {"propertyChange":true}, [_arg_3[6]], null);
            _arg_4[2] = new PropertyWatcher("cityName", {"propertyChange":true}, [_arg_3[2]], null);
            _arg_4[0] = new PropertyWatcher("enableBtn", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[1].addChild(_arg_4[4]);
            _arg_4[1].addChild(_arg_4[5]);
            _arg_4[1].addChild(_arg_4[3]);
            _arg_4[1].addChild(_arg_4[6]);
            _arg_4[1].addChild(_arg_4[2]);
            _arg_4[0].updateParent(_arg_1);
        }


    }
}//package 

