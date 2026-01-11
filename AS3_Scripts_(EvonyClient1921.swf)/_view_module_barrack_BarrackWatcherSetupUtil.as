// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_barrack_BarrackWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.barrack.Barrack;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_barrack_BarrackWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            Barrack.watcherSetupUtil = new (_view_module_barrack_BarrackWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("needAllTime", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[5] = new PropertyWatcher("buildingBean", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[6] = new PropertyWatcher("level", {"propertyChange":true}, [_arg_3[2]], null);
            _arg_4[4] = new PropertyWatcher("remainAmount", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[7] = new PropertyWatcher("produceAmount", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[5].addChild(_arg_4[6]);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[7].updateParent(_arg_1);
        }


    }
}//package 

