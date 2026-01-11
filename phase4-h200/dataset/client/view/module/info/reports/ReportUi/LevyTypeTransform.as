// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.LevyTypeTransform

package view.module.info.reports.ReportUi
{
    import com.evony.Lang;
    import com.evony.common.constants.ObjConstants;

    public class LevyTypeTransform 
    {

        private static var instance:LevyTypeTransform = new (LevyTypeTransform)();

        private var typeId:String;


        public static function levyTypeTransf(_arg_1:int):String
        {
            switch (_arg_1)
            {
                case ObjConstants.ARMY_MISSION_CONSTRUCT:
                    instance.typeId = Lang.msg("任务筑城");
                    break;
                case ObjConstants.ARMY_MISSION_OCCUPY:
                    instance.typeId = Lang.msg("任务攻击");
                    break;
                case ObjConstants.ARMY_MISSION_SCOUT:
                    instance.typeId = Lang.msg("任务侦察");
                    break;
                case ObjConstants.ARMY_MISSION_SEND:
                    instance.typeId = Lang.msg("任务派遣");
                    break;
                case ObjConstants.ARMY_MISSION_TRANS:
                    instance.typeId = Lang.msg("任务运输");
                    break;
                case ObjConstants.ARMY_MISSION_COLONIZE:
                    instance.typeId = Lang.msg("任务殖民");
                    break;
                case ObjConstants.ARMY_MISSION_ANTI_COLONIAL:
                    instance.typeId = Lang.msg("任务反殖民");
                    break;
                case ObjConstants.ARMY_MISSION_SUPPRESS:
                    instance.typeId = Lang.msg("任务殖民");
                    break;
            };
            return (instance.typeId);
        }


    }
}//package view.module.info.reports.ReportUi

