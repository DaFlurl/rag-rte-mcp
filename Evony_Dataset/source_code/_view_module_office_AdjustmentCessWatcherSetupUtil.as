// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_office_AdjustmentCessWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.office.AdjustmentCess;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_office_AdjustmentCessWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AdjustmentCess.watcherSetupUtil = new (_view_module_office_AdjustmentCessWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("curCastle", {"propertyChange":true}, [_arg_3[2], _arg_3[1], _arg_3[3], _arg_3[0]], _arg_2);
            _arg_4[1] = new PropertyWatcher("resource", {"propertyChange":true}, [_arg_3[2], _arg_3[1], _arg_3[3], _arg_3[0]], null);
            _arg_4[2] = new PropertyWatcher("curPopulation", {"propertyChange":true}, [_arg_3[3], _arg_3[0]], null);
            _arg_4[4] = new PropertyWatcher("texRate", {"propertyChange":true}, [_arg_3[2]], null);
            _arg_4[3] = new PropertyWatcher("support", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[7] = new PropertyWatcher("valueControl", {"propertyChange":true}, [_arg_3[3]], _arg_2);
            _arg_4[8] = new PropertyWatcher("value", {
                "valueCommit":true,
                "change":true
            }, [_arg_3[3]], null);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[1].addChild(_arg_4[2]);
            _arg_4[1].addChild(_arg_4[4]);
            _arg_4[1].addChild(_arg_4[3]);
            _arg_4[7].updateParent(_arg_1);
            _arg_4[7].addChild(_arg_4[8]);
        }


    }
}//package 

