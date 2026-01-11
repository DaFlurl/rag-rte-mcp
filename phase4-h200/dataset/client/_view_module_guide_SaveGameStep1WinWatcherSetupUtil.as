// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_guide_SaveGameStep1WinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.guide.SaveGameStep1Win;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_guide_SaveGameStep1WinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            SaveGameStep1Win.watcherSetupUtil = new (_view_module_guide_SaveGameStep1WinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("emailError", {"propertyChange":true}, [_arg_3[1], _arg_3[0]], _arg_2);
            _arg_4[1] = new PropertyWatcher("text", {"valueCommit":true}, [_arg_3[1], _arg_3[0]], null);
            _arg_4[2] = new PropertyWatcher("passwordError", {"propertyChange":true}, [_arg_3[2], _arg_3[3]], _arg_2);
            _arg_4[3] = new PropertyWatcher("text", {"valueCommit":true}, [_arg_3[2], _arg_3[3]], null);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[2].addChild(_arg_4[3]);
        }


    }
}//package 

