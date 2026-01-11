// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.ArmyMissionLabel

package view.module.info
{
    import mx.controls.Label;
    import com.evony.Lang;
    import com.evony.common.constants.ObjConstants;

    public class ArmyMissionLabel extends Label 
    {


        override public function initialize():void
        {
            super.initialize();
        }

        public function set missionType(_arg_1:int):void
        {
            switch (_arg_1)
            {
                case ObjConstants.ARMY_MISSION_CONSTRUCT:
                    this.text = Lang.msg("筑城");
                    return;
                case ObjConstants.ARMY_MISSION_OCCUPY:
                    this.text = Lang.msg("攻击");
                    return;
                case ObjConstants.ARMY_MISSION_SCOUT:
                    this.text = Lang.msg("侦察");
                    return;
                case ObjConstants.ARMY_MISSION_SEND:
                    this.text = Lang.msg("派遣");
                    return;
                case ObjConstants.ARMY_MISSION_TRANS:
                    this.text = Lang.msg("运输");
                    return;
                case ObjConstants.ARMY_MISSION_COLONIZE:
                    this.text = Lang.msg("殖民");
                    return;
                case ObjConstants.ARMY_MISSION_ANTI_COLONIAL:
                    this.text = Lang.msg("协助反殖民");
                    return;
                case ObjConstants.ARMY_MISSION_SUPPRESS:
                    this.text = Lang.msg("镇压");
                    return;
                default:
                    this.text = ("mission." + _arg_1);
            };
        }


    }
}//package view.module.info

