// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_castleList_ColonyInfoWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.castleList.ColonyInfoWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_castleList_ColonyInfoWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ColonyInfoWin.watcherSetupUtil = new (_view_castleList_ColonyInfoWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("colonyBean", {"propertyChange":true}, [_arg_3[4], _arg_3[30], _arg_3[16], _arg_3[18], _arg_3[3], _arg_3[27], _arg_3[2], _arg_3[13], _arg_3[21], _arg_3[1], _arg_3[24], _arg_3[10], _arg_3[0]], _arg_2);
            _arg_4[3] = new PropertyWatcher("lordName", {"propertyChange":true}, [_arg_3[2]], null);
            _arg_4[4] = new PropertyWatcher("prestige", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[17] = new PropertyWatcher("isCanLevy", {"propertyChange":true}, [_arg_3[30], _arg_3[21], _arg_3[24], _arg_3[27]], null);
            _arg_4[2] = new PropertyWatcher("position", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[5] = new PropertyWatcher("allianceName", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[1] = new PropertyWatcher("cityName", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[6] = new PropertyWatcher("_curPage", {"propertyChange":true}, [_arg_3[5]], _arg_2);
            _arg_4[9] = new PropertyWatcher("abandBtn", {"propertyChange":true}, [_arg_3[7]], _arg_2);
            _arg_4[24] = new PropertyWatcher("dataArr", {"propertyChange":true}, [_arg_3[31]], _arg_2);
            _arg_4[7] = new PropertyWatcher("_totalPage", {"propertyChange":true}, [_arg_3[5]], _arg_2);
            _arg_4[10] = new PropertyWatcher("currCastleBean", {"propertyChange":true}, [_arg_3[8], _arg_3[11], _arg_3[14]], _arg_2);
            _arg_4[14] = new PropertyWatcher("herosArray", {"propertyChange":true}, [_arg_3[14]], null);
            _arg_4[13] = new PropertyWatcher("strTroop", {"propertyChange":true}, [_arg_3[11]], null);
            _arg_4[11] = new PropertyWatcher("resource", {"propertyChange":true}, [_arg_3[8]], null);
            _arg_4[12] = new PropertyWatcher("castleBean", {"propertyChange":true}, [_arg_3[17], _arg_3[15], _arg_3[9], _arg_3[12]], _arg_2);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[3]);
            _arg_4[0].addChild(_arg_4[4]);
            _arg_4[0].addChild(_arg_4[17]);
            _arg_4[0].addChild(_arg_4[2]);
            _arg_4[0].addChild(_arg_4[5]);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[9].updateParent(_arg_1);
            _arg_4[24].updateParent(_arg_1);
            _arg_4[7].updateParent(_arg_1);
            _arg_4[10].updateParent(_arg_1);
            _arg_4[10].addChild(_arg_4[14]);
            _arg_4[10].addChild(_arg_4[13]);
            _arg_4[10].addChild(_arg_4[11]);
            _arg_4[12].updateParent(_arg_1);
        }


    }
}//package 

