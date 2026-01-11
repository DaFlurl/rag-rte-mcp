// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_playerInfo_PlayerFaceSelectWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.playerInfo.PlayerFaceSelect;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_playerInfo_PlayerFaceSelectWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            PlayerFaceSelect.watcherSetupUtil = new (_view_module_playerInfo_PlayerFaceSelectWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[5] = new PropertyWatcher("faceSource", {"propertyChange":true}, [_arg_3[6]], _arg_2);
            _arg_4[2] = new PropertyWatcher("SexFlag", {"propertyChange":true}, [_arg_3[2], _arg_3[4]], _arg_2);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
        }


    }
}//package 

