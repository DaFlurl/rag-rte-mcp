// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_wall_CastleDefTypeUIWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.wall.CastleDefTypeUI;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_wall_CastleDefTypeUIWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            CastleDefTypeUI.watcherSetupUtil = new (_view_module_wall_CastleDefTypeUIWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("imgSrc", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[3] = new PropertyWatcher("fce", {"propertyChange":true}, [_arg_3[3]], _arg_2);
            _arg_4[4] = new PropertyWatcher("name", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[2] = new PropertyWatcher("btnEnable", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[6] = new PropertyWatcher("curAmount", {"propertyChange":true}, [_arg_3[5]], _arg_2);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[3].addChild(_arg_4[4]);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[6].updateParent(_arg_1);
        }


    }
}//package 

