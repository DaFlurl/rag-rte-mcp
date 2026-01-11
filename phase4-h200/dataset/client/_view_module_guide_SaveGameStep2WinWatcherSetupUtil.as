// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_guide_SaveGameStep2WinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.guide.SaveGameStep2Win;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_guide_SaveGameStep2WinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            SaveGameStep2Win.watcherSetupUtil = new (_view_module_guide_SaveGameStep2WinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("preSetName", {"propertyChange":true}, [_arg_3[2], _arg_3[4], _arg_3[3], _arg_3[5]], _arg_2);
            _arg_4[2] = new PropertyWatcher("faceSource", {"propertyChange":true}, [_arg_3[6]], _arg_2);
            _arg_4[0] = new PropertyWatcher("needSelName", {"propertyChange":true}, [_arg_3[1], _arg_3[0]], _arg_2);
            _arg_4[4] = new PropertyWatcher("SexFlag", {"propertyChange":true}, [_arg_3[8], _arg_3[10]], _arg_2);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[4].updateParent(_arg_1);
        }


    }
}//package 

