// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_office_production_ResourceProductionWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.office.production.ResourceProduction;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_office_production_ResourceProductionWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ResourceProduction.watcherSetupUtil = new (_view_module_office_production_ResourceProductionWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[15] = new PropertyWatcher("productionTotal", {"propertyChange":true}, [_arg_3[15], _arg_3[16]], _arg_2);
            _arg_4[8] = new PropertyWatcher("paidResource", {"propertyChange":true}, [_arg_3[6], _arg_3[7]], _arg_2);
            _arg_4[0] = new PropertyWatcher("typeName", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[6] = new PropertyWatcher("productivity", {"propertyChange":true}, [_arg_3[13], _arg_3[4], _arg_3[9], _arg_3[14], _arg_3[12]], _arg_2);
            _arg_4[7] = new PropertyWatcher("receiveResource", {"propertyChange":true}, [_arg_3[5]], _arg_2);
            _arg_4[4] = new PropertyWatcher("myPercentage", {"propertyChange":true}, [_arg_3[13], _arg_3[4], _arg_3[9], _arg_3[14], _arg_3[3], _arg_3[12]], _arg_2);
            _arg_4[5] = new PropertyWatcher("value", {
                "valueCommit":true,
                "change":true
            }, [_arg_3[13], _arg_3[4], _arg_3[9], _arg_3[14], _arg_3[3], _arg_3[12]], null);
            _arg_4[1] = new PropertyWatcher("resourceProduceDataBean", {"propertyChange":true}, [_arg_3[2], _arg_3[13], _arg_3[4], _arg_3[9], _arg_3[8], _arg_3[1], _arg_3[14], _arg_3[3], _arg_3[12]], _arg_2);
            _arg_4[9] = new PropertyWatcher("naturalPercentage", {"propertyChange":true}, [_arg_3[8]], null);
            _arg_4[2] = new PropertyWatcher("productionCapacity", {"propertyChange":true}, [_arg_3[4], _arg_3[1]], null);
            _arg_4[14] = new PropertyWatcher("cimeliaPercentage", {"propertyChange":true}, [_arg_3[14]], null);
            _arg_4[13] = new PropertyWatcher("fieldPercentage", {"propertyChange":true}, [_arg_3[13]], null);
            _arg_4[10] = new PropertyWatcher("technologicalPercentage", {"propertyChange":true}, [_arg_3[9]], null);
            _arg_4[12] = new PropertyWatcher("heroPercentage", {"propertyChange":true}, [_arg_3[12]], null);
            _arg_4[3] = new PropertyWatcher("maxLabour", {"propertyChange":true}, [_arg_3[2], _arg_3[3]], null);
            _arg_4[11] = new PropertyWatcher("armyCost", {"propertyChange":true}, [_arg_3[11], _arg_3[10]], _arg_2);
            _arg_4[15].updateParent(_arg_1);
            _arg_4[8].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[7].updateParent(_arg_1);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[4].addChild(_arg_4[5]);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[1].addChild(_arg_4[9]);
            _arg_4[1].addChild(_arg_4[2]);
            _arg_4[1].addChild(_arg_4[14]);
            _arg_4[1].addChild(_arg_4[13]);
            _arg_4[1].addChild(_arg_4[10]);
            _arg_4[1].addChild(_arg_4[12]);
            _arg_4[1].addChild(_arg_4[3]);
            _arg_4[11].updateParent(_arg_1);
        }


    }
}//package 

