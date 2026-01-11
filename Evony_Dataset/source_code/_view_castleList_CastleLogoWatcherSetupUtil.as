// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_castleList_CastleLogoWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.castleList.CastleLogo;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_castleList_CastleLogoWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            CastleLogo.watcherSetupUtil = new (_view_castleList_CastleLogoWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[4] = new PropertyWatcher("markPicPath", {"propertyChange":true}, [_arg_3[3]], _arg_2);
            _arg_4[0] = new PropertyWatcher("castleBean", {"propertyChange":true}, [_arg_3[4], _arg_3[1], _arg_3[0]], _arg_2);
            _arg_4[5] = new PropertyWatcher("colonization", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[1] = new PropertyWatcher("logUrl", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[2] = new PropertyWatcher("name", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[5]);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[0].addChild(_arg_4[2]);
        }


    }
}//package 

