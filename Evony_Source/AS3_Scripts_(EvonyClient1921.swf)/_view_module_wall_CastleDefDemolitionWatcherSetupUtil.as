// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_wall_CastleDefDemolitionWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.wall.CastleDefDemolition;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_wall_CastleDefDemolitionWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            CastleDefDemolition.watcherSetupUtil = new (_view_module_wall_CastleDefDemolitionWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("dataAry", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[7] = new PropertyWatcher("curAmount", {"propertyChange":true}, [_arg_3[9], _arg_3[7]], _arg_2);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[7].updateParent(_arg_1);
        }


    }
}//package 

