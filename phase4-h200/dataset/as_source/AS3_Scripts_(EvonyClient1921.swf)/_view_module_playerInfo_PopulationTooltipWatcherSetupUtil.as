// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_playerInfo_PopulationTooltipWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.playerInfo.PopulationTooltip;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_playerInfo_PopulationTooltipWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            PopulationTooltip.watcherSetupUtil = new (_view_module_playerInfo_PopulationTooltipWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[15] = new PropertyWatcher("status", {"propertyChange":true}, [_arg_3[14]], _arg_2);
            _arg_4[2] = new PropertyWatcher("bean", {"propertyChange":true}, [_arg_3[2], _arg_3[4], _arg_3[9], _arg_3[11], _arg_3[10], _arg_3[7]], _arg_2);
            _arg_4[3] = new PropertyWatcher("buildPeople", {"propertyChange":true}, [_arg_3[2], _arg_3[11], _arg_3[10]], null);
            _arg_4[8] = new PropertyWatcher("maxPopulation", {"propertyChange":true}, [_arg_3[7]], null);
            _arg_4[10] = new PropertyWatcher("workPeople", {"propertyChange":true}, [_arg_3[9], _arg_3[11], _arg_3[10]], null);
            _arg_4[5] = new PropertyWatcher("curPopulation", {"propertyChange":true}, [_arg_3[4], _arg_3[11], _arg_3[10]], null);
            _arg_4[16] = new PropertyWatcher("statusStyle", {"propertyChange":true}, [_arg_3[15]], _arg_2);
            _arg_4[6] = new PropertyWatcher("availabilityStyle", {"propertyChange":true}, [_arg_3[12], _arg_3[5]], _arg_2);
            _arg_4[15].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[2].addChild(_arg_4[3]);
            _arg_4[2].addChild(_arg_4[8]);
            _arg_4[2].addChild(_arg_4[10]);
            _arg_4[2].addChild(_arg_4[5]);
            _arg_4[16].updateParent(_arg_1);
            _arg_4[6].updateParent(_arg_1);
        }


    }
}//package 

