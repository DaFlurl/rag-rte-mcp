// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_castleInfo_GoldBuyResourceWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.castleInfo.GoldBuyResourceWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_castleInfo_GoldBuyResourceWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            GoldBuyResourceWin.watcherSetupUtil = new (_view_castleInfo_GoldBuyResourceWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[39] = new PropertyWatcher("remainStone", {"propertyChange":true}, [_arg_3[33]], _arg_2);
            _arg_4[47] = new PropertyWatcher("remainIron", {"propertyChange":true}, [_arg_3[40]], _arg_2);
            _arg_4[31] = new PropertyWatcher("remainWood", {"propertyChange":true}, [_arg_3[26]], _arg_2);
            _arg_4[28] = new PropertyWatcher("buyWood", {"propertyChange":true}, [_arg_3[23]], _arg_2);
            _arg_4[36] = new PropertyWatcher("buyStone", {"propertyChange":true}, [_arg_3[30]], _arg_2);
            _arg_4[19] = new PropertyWatcher("useMadel", {"propertyChange":true}, [_arg_3[17], _arg_3[36], _arg_3[29], _arg_3[22]], _arg_2);
            _arg_4[44] = new PropertyWatcher("buyIron", {"propertyChange":true}, [_arg_3[37]], _arg_2);
            _arg_4[15] = new PropertyWatcher("buyFood", {"propertyChange":true}, [_arg_3[14]], _arg_2);
            _arg_4[52] = new PropertyWatcher("playerInfo", {"propertyChange":true}, [_arg_3[45]], _arg_2);
            _arg_4[53] = new PropertyWatcher("medal", {"propertyChange":true}, [_arg_3[45]], null);
            _arg_4[23] = new PropertyWatcher("remainFood", {"propertyChange":true}, [_arg_3[19]], _arg_2);
            _arg_4[18] = new PropertyWatcher("maxMadel", {"propertyChange":true}, [_arg_3[17], _arg_3[36], _arg_3[29], _arg_3[22]], _arg_2);
            _arg_4[2] = new PropertyWatcher("buyResourceBean", {"propertyChange":true}, [_arg_3[17], _arg_3[2], _arg_3[36], _arg_3[8], _arg_3[11], _arg_3[29], _arg_3[5], _arg_3[22]], _arg_2);
            _arg_4[42] = new PropertyWatcher("ironRemain", {"propertyChange":true}, [_arg_3[36]], null);
            _arg_4[12] = new PropertyWatcher("forIron", {"propertyChange":true}, [_arg_3[36], _arg_3[11]], null);
            _arg_4[3] = new PropertyWatcher("forFood", {"propertyChange":true}, [_arg_3[17], _arg_3[2]], null);
            _arg_4[9] = new PropertyWatcher("forStone", {"propertyChange":true}, [_arg_3[8], _arg_3[29]], null);
            _arg_4[34] = new PropertyWatcher("stoneRemain", {"propertyChange":true}, [_arg_3[29]], null);
            _arg_4[20] = new PropertyWatcher("foodRemain", {"propertyChange":true}, [_arg_3[17]], null);
            _arg_4[6] = new PropertyWatcher("forWood", {"propertyChange":true}, [_arg_3[5], _arg_3[22]], null);
            _arg_4[26] = new PropertyWatcher("woodRemain", {"propertyChange":true}, [_arg_3[22]], null);
            _arg_4[39].updateParent(_arg_1);
            _arg_4[47].updateParent(_arg_1);
            _arg_4[31].updateParent(_arg_1);
            _arg_4[28].updateParent(_arg_1);
            _arg_4[36].updateParent(_arg_1);
            _arg_4[19].updateParent(_arg_1);
            _arg_4[44].updateParent(_arg_1);
            _arg_4[15].updateParent(_arg_1);
            _arg_4[52].updateParent(_arg_1);
            _arg_4[52].addChild(_arg_4[53]);
            _arg_4[23].updateParent(_arg_1);
            _arg_4[18].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[2].addChild(_arg_4[42]);
            _arg_4[2].addChild(_arg_4[12]);
            _arg_4[2].addChild(_arg_4[3]);
            _arg_4[2].addChild(_arg_4[9]);
            _arg_4[2].addChild(_arg_4[34]);
            _arg_4[2].addChild(_arg_4[20]);
            _arg_4[2].addChild(_arg_4[6]);
            _arg_4[2].addChild(_arg_4[26]);
        }


    }
}//package 

