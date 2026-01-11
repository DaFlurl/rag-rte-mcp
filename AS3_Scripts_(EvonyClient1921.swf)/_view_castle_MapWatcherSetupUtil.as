// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_castle_MapWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.castle.Map;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.RepeaterItemWatcher;

    public class _view_castle_MapWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            Map.watcherSetupUtil = new (_view_castle_MapWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[2] = new PropertyWatcher("CoordinateData", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[1] = new PropertyWatcher("castleName", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[3] = new PropertyWatcher("rp", {"propertyChange":true}, [_arg_3[4], _arg_3[3]], _arg_2);
            _arg_4[4] = new PropertyWatcher("dataProvider", {"collectionChange":true}, [_arg_3[4], _arg_3[3]], null);
            _arg_4[5] = new RepeaterItemWatcher(_arg_4[4]);
            _arg_4[8] = new PropertyWatcher("y", null, [_arg_3[4]], null);
            _arg_4[6] = new PropertyWatcher("name", null, [_arg_3[3]], null);
            _arg_4[7] = new PropertyWatcher("x", null, [_arg_3[4]], null);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[3].addChild(_arg_4[4]);
            _arg_4[4].addChild(_arg_4[5]);
            _arg_4[5].addChild(_arg_4[8]);
            _arg_4[5].addChild(_arg_4[6]);
            _arg_4[5].addChild(_arg_4[7]);
        }


    }
}//package 

