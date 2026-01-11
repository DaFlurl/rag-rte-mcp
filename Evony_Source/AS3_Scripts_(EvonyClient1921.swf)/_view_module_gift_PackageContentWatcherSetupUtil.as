// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_gift_PackageContentWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.gift.PackageContent;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_gift_PackageContentWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            PackageContent.watcherSetupUtil = new (_view_module_gift_PackageContentWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("packageContentBean", {"propertyChange":true}, [_arg_3[4], _arg_3[9], _arg_3[1], _arg_3[3], _arg_3[7], _arg_3[5]], _arg_2);
            _arg_4[6] = new PropertyWatcher("claimedTime", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[2] = new PropertyWatcher("packageName", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[4] = new PropertyWatcher("status", {"propertyChange":true}, [_arg_3[3], _arg_3[7], _arg_3[5]], null);
            _arg_4[10] = new PropertyWatcher("desc", {"propertyChange":true}, [_arg_3[9]], null);
            _arg_4[12] = new PropertyWatcher("giftList", {"propertyChange":true}, [_arg_3[11]], _arg_2);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[1].addChild(_arg_4[6]);
            _arg_4[1].addChild(_arg_4[2]);
            _arg_4[1].addChild(_arg_4[4]);
            _arg_4[1].addChild(_arg_4[10]);
            _arg_4[12].updateParent(_arg_1);
        }


    }
}//package 

