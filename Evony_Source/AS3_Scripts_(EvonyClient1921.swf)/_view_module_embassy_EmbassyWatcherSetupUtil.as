// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_embassy_EmbassyWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.embassy.Embassy;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_embassy_EmbassyWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            Embassy.watcherSetupUtil = new (_view_module_embassy_EmbassyWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[4] = new PropertyWatcher("stayArmysDP", {"propertyChange":true}, [_arg_3[4], _arg_3[7]], _arg_2);
            _arg_4[5] = new PropertyWatcher("length", {"collectionChange":true}, [_arg_3[4]], null);
            _arg_4[6] = new PropertyWatcher("buildingLevel", {"propertyChange":true}, [_arg_3[4]], _arg_2);
            _arg_4[1] = new PropertyWatcher("allianceStr", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[7] = new PropertyWatcher("isAllowStay", {"propertyChange":true}, [_arg_3[5]], _arg_2);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[4].addChild(_arg_4[5]);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[7].updateParent(_arg_1);
        }


    }
}//package 

