// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_CreatPlayerPanelWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.CreatPlayerPanel;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_CreatPlayerPanelWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            CreatPlayerPanel.watcherSetupUtil = new (_view_CreatPlayerPanelWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[13] = new PropertyWatcher("countryName", {"propertyChange":true}, [_arg_3[13]], _arg_2);
            _arg_4[5] = new PropertyWatcher("faceSource", {"propertyChange":true}, [_arg_3[5]], _arg_2);
            _arg_4[13].updateParent(_arg_1);
            _arg_4[5].updateParent(_arg_1);
        }


    }
}//package 

