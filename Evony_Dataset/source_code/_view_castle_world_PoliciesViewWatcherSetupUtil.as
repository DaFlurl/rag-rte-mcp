// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_castle_world_PoliciesViewWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.castle.world.PoliciesView;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_castle_world_PoliciesViewWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            PoliciesView.watcherSetupUtil = new (_view_castle_world_PoliciesViewWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("comData", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[1].updateParent(_arg_1);
        }


    }
}//package 

