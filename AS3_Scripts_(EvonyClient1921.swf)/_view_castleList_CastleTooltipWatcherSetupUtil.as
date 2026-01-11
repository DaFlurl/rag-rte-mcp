// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_castleList_CastleTooltipWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.castleList.CastleTooltip;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_castleList_CastleTooltipWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            CastleTooltip.watcherSetupUtil = new (_view_castleList_CastleTooltipWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("colonyInfo", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[16] = new PropertyWatcher("hasBuilding", {"propertyChange":true}, [_arg_3[15], _arg_3[13], _arg_3[16], _arg_3[14]], _arg_2);
            _arg_4[18] = new PropertyWatcher("buildingBean", {"propertyChange":true}, [_arg_3[18]], _arg_2);
            _arg_4[21] = new PropertyWatcher("techBean", {"propertyChange":true}, [_arg_3[24]], _arg_2);
            _arg_4[8] = new PropertyWatcher("populationStyle", {"propertyChange":true}, [_arg_3[8]], _arg_2);
            _arg_4[0] = new PropertyWatcher("hasColony", {"propertyChange":true}, [_arg_3[4], _arg_3[1], _arg_3[3], _arg_3[0]], _arg_2);
            _arg_4[19] = new PropertyWatcher("hasTech", {"propertyChange":true}, [_arg_3[19], _arg_3[21], _arg_3[20], _arg_3[22]], _arg_2);
            _arg_4[13] = new PropertyWatcher("foodStyle", {"propertyChange":true}, [_arg_3[10]], _arg_2);
            _arg_4[2] = new PropertyWatcher("castleBean", {"propertyChange":true}, [_arg_3[9], _arg_3[11], _arg_3[6], _arg_3[7], _arg_3[12], _arg_3[5]], _arg_2);
            _arg_4[4] = new PropertyWatcher("fieldId", {"propertyChange":true}, [_arg_3[6]], null);
            _arg_4[6] = new PropertyWatcher("resource", {"propertyChange":true}, [_arg_3[9], _arg_3[11], _arg_3[7], _arg_3[12]], null);
            _arg_4[7] = new PropertyWatcher("curPopulation", {"propertyChange":true}, [_arg_3[7]], null);
            _arg_4[15] = new PropertyWatcher("complaint", {"propertyChange":true}, [_arg_3[12]], null);
            _arg_4[11] = new PropertyWatcher("food", {"propertyChange":true}, [_arg_3[9]], null);
            _arg_4[12] = new PropertyWatcher("amount", {"propertyChange":true}, [_arg_3[9]], null);
            _arg_4[14] = new PropertyWatcher("support", {"propertyChange":true}, [_arg_3[11]], null);
            _arg_4[3] = new PropertyWatcher("name", {"propertyChange":true}, [_arg_3[5]], null);
            _arg_4[22] = new PropertyWatcher("hasWar", {"propertyChange":true}, [_arg_3[26], _arg_3[28], _arg_3[29], _arg_3[25]], _arg_2);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[16].updateParent(_arg_1);
            _arg_4[18].updateParent(_arg_1);
            _arg_4[21].updateParent(_arg_1);
            _arg_4[8].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[19].updateParent(_arg_1);
            _arg_4[13].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[2].addChild(_arg_4[4]);
            _arg_4[2].addChild(_arg_4[6]);
            _arg_4[6].addChild(_arg_4[7]);
            _arg_4[6].addChild(_arg_4[15]);
            _arg_4[6].addChild(_arg_4[11]);
            _arg_4[11].addChild(_arg_4[12]);
            _arg_4[6].addChild(_arg_4[14]);
            _arg_4[2].addChild(_arg_4[3]);
            _arg_4[22].updateParent(_arg_1);
        }


    }
}//package 

