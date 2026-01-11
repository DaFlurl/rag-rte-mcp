// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_alliance_oldAlliance_allianceManage_allianceExchange_AllianceSendMailWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.alliance.oldAlliance.allianceManage.allianceExchange.AllianceSendMail;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_alliance_oldAlliance_allianceManage_allianceExchange_AllianceSendMailWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AllianceSendMail.watcherSetupUtil = new (_view_module_alliance_oldAlliance_allianceManage_allianceExchange_AllianceSendMailWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("receiveName", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[2] = new PropertyWatcher("isSendAll", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[3] = new PropertyWatcher("selected", {
                "valueCommit":true,
                "click":true
            }, [_arg_3[2]], null);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[2].addChild(_arg_4[3]);
        }


    }
}//package 

