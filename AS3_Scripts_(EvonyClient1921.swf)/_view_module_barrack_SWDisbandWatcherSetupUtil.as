// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_barrack_SWDisbandWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.barrack.SWDisband;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_barrack_SWDisbandWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            SWDisband.watcherSetupUtil = new (_view_module_barrack_SWDisbandWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("dataAry", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[8] = new PropertyWatcher("curAmount", {"propertyChange":true}, [_arg_3[8], _arg_3[10]], _arg_2);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[8].updateParent(_arg_1);
        }


    }
}//package 

