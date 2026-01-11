// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_rank_cj_inlineComponent1WatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.rank.cj_inlineComponent1;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_rank_cj_inlineComponent1WatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            cj_inlineComponent1.watcherSetupUtil = new (_view_module_rank_cj_inlineComponent1WatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[3] = new PropertyWatcher("noleftPicPath", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[8] = new PropertyWatcher("showBuffPic", {"propertyChange":true}, [_arg_3[9], _arg_3[11], _arg_3[16], _arg_3[18], _arg_3[14], _arg_3[3], _arg_3[7]], _arg_2);
            _arg_4[12] = new PropertyWatcher("smallPicPath", {"propertyChange":true}, [_arg_3[20]], _arg_2);
            _arg_4[11] = new PropertyWatcher("percentBarW", {"propertyChange":true}, [_arg_3[15], _arg_3[13], _arg_3[8], _arg_3[10], _arg_3[12]], _arg_2);
            _arg_4[0] = new PropertyWatcher("data", {"dataChange":true}, [_arg_3[17], _arg_3[2], _arg_3[4], _arg_3[6], _arg_3[1], _arg_3[5], _arg_3[0]], _arg_2);
            _arg_4[9] = new PropertyWatcher("manual", null, [_arg_3[4]], null);
            _arg_4[10] = new PropertyWatcher("award", null, [_arg_3[6]], null);
            _arg_4[1] = new PropertyWatcher("isFinish", null, [_arg_3[1], _arg_3[5], _arg_3[0]], null);
            _arg_4[7] = new PropertyWatcher("questId", null, [_arg_3[2]], null);
            _arg_4[5] = new PropertyWatcher("description", null, [_arg_3[2]], null);
            _arg_4[6] = new PropertyWatcher("name", null, [_arg_3[17], _arg_3[2]], null);
            _arg_4[13] = new PropertyWatcher("toolTipStr", {"propertyChange":true}, [_arg_3[21]], _arg_2);
            _arg_4[2] = new PropertyWatcher("leftPicPath", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[8].updateParent(_arg_1);
            _arg_4[12].updateParent(_arg_1);
            _arg_4[11].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[9]);
            _arg_4[0].addChild(_arg_4[10]);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[0].addChild(_arg_4[7]);
            _arg_4[0].addChild(_arg_4[5]);
            _arg_4[0].addChild(_arg_4[6]);
            _arg_4[13].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
        }


    }
}//package 

