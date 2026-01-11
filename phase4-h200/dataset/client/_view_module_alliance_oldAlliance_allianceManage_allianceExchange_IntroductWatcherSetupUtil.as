// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_alliance_oldAlliance_allianceManage_allianceExchange_IntroductWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.alliance.oldAlliance.allianceManage.allianceExchange.Introduct;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_alliance_oldAlliance_allianceManage_allianceExchange_IntroductWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            Introduct.watcherSetupUtil = new (_view_module_alliance_oldAlliance_allianceManage_allianceExchange_IntroductWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("unionArray", {"propertyChange":true}, [_arg_3[1], _arg_3[5], _arg_3[0]], _arg_2);
            _arg_4[1] = new PropertyWatcher("allianceInfo", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[6] = new PropertyWatcher("allianceName", {"propertyChange":true}, [_arg_3[5]], null);
            _arg_4[2] = new PropertyWatcher("allianceNote", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[0].addChild(_arg_4[6]);
            _arg_4[0].addChild(_arg_4[2]);
        }


    }
}//package 

