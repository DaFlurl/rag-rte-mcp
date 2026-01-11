// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_alliance_oldAlliance_allianceMember_AllianceRetireWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.alliance.oldAlliance.allianceMember.AllianceRetire;
    import mx.core.IFlexModuleFactory;

    public class _view_module_alliance_oldAlliance_allianceMember_AllianceRetireWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AllianceRetire.watcherSetupUtil = new (_view_module_alliance_oldAlliance_allianceMember_AllianceRetireWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
        }


    }
}//package 

