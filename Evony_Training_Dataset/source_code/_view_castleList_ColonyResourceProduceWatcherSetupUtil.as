// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_castleList_ColonyResourceProduceWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.castleList.ColonyResourceProduce;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_castleList_ColonyResourceProduceWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ColonyResourceProduce.watcherSetupUtil = new (_view_castleList_ColonyResourceProduceWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("_resource", {"propertyChange":true}, [_arg_3[15], _arg_3[13], _arg_3[4], _arg_3[9], _arg_3[6], _arg_3[1], _arg_3[3], _arg_3[10], _arg_3[7], _arg_3[12], _arg_3[0]], _arg_2);
            _arg_4[6] = new PropertyWatcher("troopCostFood", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[35] = new PropertyWatcher("herosSalary", {"propertyChange":true}, [_arg_3[13]], null);
            _arg_4[38] = new PropertyWatcher("curPopulation", {"propertyChange":true}, [_arg_3[15]], null);
            _arg_4[34] = new PropertyWatcher("taxIncome", {"propertyChange":true}, [_arg_3[13]], null);
            _arg_4[19] = new PropertyWatcher("stone", {"propertyChange":true}, [_arg_3[6], _arg_3[7]], null);
            _arg_4[20] = new PropertyWatcher("amount", {"propertyChange":true}, [_arg_3[6]], null);
            _arg_4[22] = new PropertyWatcher("increaseRate", {"propertyChange":true}, [_arg_3[7]], null);
            _arg_4[12] = new PropertyWatcher("wood", {"propertyChange":true}, [_arg_3[4], _arg_3[3]], null);
            _arg_4[13] = new PropertyWatcher("amount", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[15] = new PropertyWatcher("increaseRate", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[2] = new PropertyWatcher("food", {"propertyChange":true}, [_arg_3[1], _arg_3[0]], null);
            _arg_4[3] = new PropertyWatcher("amount", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[5] = new PropertyWatcher("increaseRate", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[26] = new PropertyWatcher("iron", {"propertyChange":true}, [_arg_3[9], _arg_3[10]], null);
            _arg_4[27] = new PropertyWatcher("amount", {"propertyChange":true}, [_arg_3[9]], null);
            _arg_4[29] = new PropertyWatcher("increaseRate", {"propertyChange":true}, [_arg_3[10]], null);
            _arg_4[33] = new PropertyWatcher("gold", {"propertyChange":true}, [_arg_3[12]], null);
            _arg_4[8] = new PropertyWatcher("castleBean", {"propertyChange":true}, [_arg_3[2], _arg_3[8], _arg_3[11], _arg_3[14], _arg_3[5]], _arg_2);
            _arg_4[9] = new PropertyWatcher("resource", {"propertyChange":true}, [_arg_3[2], _arg_3[8], _arg_3[11], _arg_3[14], _arg_3[5]], null);
            _arg_4[17] = new PropertyWatcher("colonyWood", {"propertyChange":true}, [_arg_3[5]], null);
            _arg_4[31] = new PropertyWatcher("colonyIron", {"propertyChange":true}, [_arg_3[11]], null);
            _arg_4[37] = new PropertyWatcher("colonyGold", {"propertyChange":true}, [_arg_3[14]], null);
            _arg_4[10] = new PropertyWatcher("colonyFood", {"propertyChange":true}, [_arg_3[2]], null);
            _arg_4[24] = new PropertyWatcher("colonyStone", {"propertyChange":true}, [_arg_3[8]], null);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[1].addChild(_arg_4[6]);
            _arg_4[1].addChild(_arg_4[35]);
            _arg_4[1].addChild(_arg_4[38]);
            _arg_4[1].addChild(_arg_4[34]);
            _arg_4[1].addChild(_arg_4[19]);
            _arg_4[19].addChild(_arg_4[20]);
            _arg_4[19].addChild(_arg_4[22]);
            _arg_4[1].addChild(_arg_4[12]);
            _arg_4[12].addChild(_arg_4[13]);
            _arg_4[12].addChild(_arg_4[15]);
            _arg_4[1].addChild(_arg_4[2]);
            _arg_4[2].addChild(_arg_4[3]);
            _arg_4[2].addChild(_arg_4[5]);
            _arg_4[1].addChild(_arg_4[26]);
            _arg_4[26].addChild(_arg_4[27]);
            _arg_4[26].addChild(_arg_4[29]);
            _arg_4[1].addChild(_arg_4[33]);
            _arg_4[8].updateParent(_arg_1);
            _arg_4[8].addChild(_arg_4[9]);
            _arg_4[9].addChild(_arg_4[17]);
            _arg_4[9].addChild(_arg_4[31]);
            _arg_4[9].addChild(_arg_4[37]);
            _arg_4[9].addChild(_arg_4[10]);
            _arg_4[9].addChild(_arg_4[24]);
        }


    }
}//package 

