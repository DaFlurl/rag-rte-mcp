// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_barrack_SWProduceUIWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.barrack.SWProduceUI;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_barrack_SWProduceUIWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            SWProduceUI.watcherSetupUtil = new (_view_module_barrack_SWProduceUIWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[5] = new PropertyWatcher("vsSelectIndex", {"propertyChange":true}, [_arg_3[3]], _arg_2);
            _arg_4[3] = new PropertyWatcher("typeName", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[1] = new PropertyWatcher("bean", {"propertyChange":true}, [_arg_3[2], _arg_3[7], _arg_3[5], _arg_3[0]], _arg_2);
            _arg_4[4] = new PropertyWatcher("num", {"propertyChange":true}, [_arg_3[2]], null);
            _arg_4[2] = new PropertyWatcher("type", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[10] = new PropertyWatcher("costTime", {"propertyChange":true}, [_arg_3[7]], null);
            _arg_4[7] = new PropertyWatcher("endTime", {"propertyChange":true}, [_arg_3[5]], null);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[1].addChild(_arg_4[4]);
            _arg_4[1].addChild(_arg_4[2]);
            _arg_4[1].addChild(_arg_4[10]);
            _arg_4[1].addChild(_arg_4[7]);
        }


    }
}//package 

