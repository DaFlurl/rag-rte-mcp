// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_info_Alliance_AllianceMembersWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.info.Alliance.AllianceMembers;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_info_Alliance_AllianceMembersWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AllianceMembers.watcherSetupUtil = new (_autoevony_gui_info_Alliance_AllianceMembersWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[5] = new PropertyWatcher("membersArray", {"propertyChange":true}, [_arg_3[3], _arg_3[8], _arg_3[10]], _arg_2);
            _arg_4[7] = new PropertyWatcher("length", {"collectionChange":true}, [_arg_3[8], _arg_3[10]], null);
            _arg_4[0] = new PropertyWatcher("memberLevel", {"propertyChange":true}, [_arg_3[0], _arg_3[1], _arg_3[2], _arg_3[8], _arg_3[9], _arg_3[10]], _arg_2);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[5].addChild(_arg_4[7]);
            _arg_4[0].updateParent(_arg_1);
        }


    }
}//package 

