// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_barrack_SWEnlistWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.barrack.SWEnlist;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_barrack_SWEnlistWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            SWEnlist.watcherSetupUtil = new (_view_module_barrack_SWEnlistWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[31] = new PropertyWatcher("produceAllTime", {"propertyChange":true}, [_arg_3[31]], _arg_2);
            _arg_4[25] = new PropertyWatcher("produceMaxNum", {"propertyChange":true}, [_arg_3[30], _arg_3[24]], _arg_2);
            _arg_4[0] = new PropertyWatcher("imgSrc", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[2] = new PropertyWatcher("dataAry", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[7] = new PropertyWatcher("troopEum", {"propertyChange":true}, [_arg_3[32], _arg_3[17], _arg_3[15], _arg_3[13], _arg_3[19], _arg_3[9], _arg_3[21], _arg_3[11], _arg_3[7], _arg_3[22]], _arg_2);
            _arg_4[20] = new PropertyWatcher("foodRequest", {"propertyChange":true}, [_arg_3[19]], null);
            _arg_4[14] = new PropertyWatcher("speed", {"propertyChange":true}, [_arg_3[13]], null);
            _arg_4[16] = new PropertyWatcher("load", {"propertyChange":true}, [_arg_3[15]], null);
            _arg_4[8] = new PropertyWatcher("attack", {"propertyChange":true}, [_arg_3[7]], null);
            _arg_4[22] = new PropertyWatcher("population", {"propertyChange":true}, [_arg_3[21]], null);
            _arg_4[18] = new PropertyWatcher("life", {"propertyChange":true}, [_arg_3[17]], null);
            _arg_4[10] = new PropertyWatcher("defence", {"propertyChange":true}, [_arg_3[9]], null);
            _arg_4[12] = new PropertyWatcher("range", {"propertyChange":true}, [_arg_3[11]], null);
            _arg_4[23] = new PropertyWatcher("name", {"propertyChange":true}, [_arg_3[22]], null);
            _arg_4[32] = new PropertyWatcher("desc", {"propertyChange":true}, [_arg_3[32]], null);
            _arg_4[30] = new PropertyWatcher("curAmount", {"propertyChange":true}, [_arg_3[29]], _arg_2);
            _arg_4[31].updateParent(_arg_1);
            _arg_4[25].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[7].updateParent(_arg_1);
            _arg_4[7].addChild(_arg_4[20]);
            _arg_4[7].addChild(_arg_4[14]);
            _arg_4[7].addChild(_arg_4[16]);
            _arg_4[7].addChild(_arg_4[8]);
            _arg_4[7].addChild(_arg_4[22]);
            _arg_4[7].addChild(_arg_4[18]);
            _arg_4[7].addChild(_arg_4[10]);
            _arg_4[7].addChild(_arg_4[12]);
            _arg_4[7].addChild(_arg_4[23]);
            _arg_4[7].addChild(_arg_4[32]);
            _arg_4[30].updateParent(_arg_1);
        }


    }
}//package 

