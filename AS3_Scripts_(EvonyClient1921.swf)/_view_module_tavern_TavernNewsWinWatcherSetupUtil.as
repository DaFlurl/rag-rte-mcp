// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_tavern_TavernNewsWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.tavern.TavernNewsWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_tavern_TavernNewsWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            TavernNewsWin.watcherSetupUtil = new (_view_module_tavern_TavernNewsWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[11] = new PropertyWatcher("heroFilterArray", {"propertyChange":true}, [_arg_3[10]], _arg_2);
            _arg_4[10] = new PropertyWatcher("heroArray", {"propertyChange":true}, [_arg_3[9]], _arg_2);
            _arg_4[6] = new PropertyWatcher("curHeroDetail", {"propertyChange":true}, [_arg_3[8], _arg_3[6], _arg_3[7]], _arg_2);
            _arg_4[8] = new PropertyWatcher("introduce", {"propertyChange":true}, [_arg_3[7]], null);
            _arg_4[9] = new PropertyWatcher("introduce2", {"propertyChange":true}, [_arg_3[8]], null);
            _arg_4[7] = new PropertyWatcher("logourl", {"propertyChange":true}, [_arg_3[6]], null);
            _arg_4[11].updateParent(_arg_1);
            _arg_4[10].updateParent(_arg_1);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[6].addChild(_arg_4[8]);
            _arg_4[6].addChild(_arg_4[9]);
            _arg_4[6].addChild(_arg_4[7]);
        }


    }
}//package 

