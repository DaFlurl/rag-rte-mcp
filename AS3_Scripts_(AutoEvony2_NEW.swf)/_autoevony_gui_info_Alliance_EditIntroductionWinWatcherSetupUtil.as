// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_info_Alliance_EditIntroductionWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.info.Alliance.EditIntroductionWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_info_Alliance_EditIntroductionWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            EditIntroductionWin.watcherSetupUtil = new (_autoevony_gui_info_Alliance_EditIntroductionWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("unionArray", {"propertyChange":true}, [_arg_3[0], _arg_3[1], _arg_3[2]], _arg_2);
            _arg_4[2] = new PropertyWatcher("allianceNote", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[3] = new PropertyWatcher("allianceName", {"propertyChange":true}, [_arg_3[2]], null);
            _arg_4[1] = new PropertyWatcher("allianceInfo", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[2]);
            _arg_4[0].addChild(_arg_4[3]);
            _arg_4[0].addChild(_arg_4[1]);
        }


    }
}//package 

