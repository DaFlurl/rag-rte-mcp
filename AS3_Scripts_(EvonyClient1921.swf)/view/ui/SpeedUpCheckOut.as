// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.SpeedUpCheckOut

package view.ui
{
    import com.evony.common.constants.CommonConstants;
    import com.evony.eum.BuildingEumDefine;
    import com.evony.common.beans.BuildingBean;
    import com.evony.eum.TechEumDefine;
    import com.evony.common.beans.AvailableResearchListBean;

    public class SpeedUpCheckOut 
    {

        private static var limitTime:Number = CommonConstants.FREE_SPEED_TIME_LIMIT;//300


        public static function checkOutBuilding(_arg_1:BuildingBean):Boolean
        {
            trace(("need time:" + BuildingEumDefine.getTime(_arg_1)));
            return (BuildingEumDefine.getTime(_arg_1) > limitTime);
        }

        public static function checkOutTech(_arg_1:AvailableResearchListBean):Boolean
        {
            trace(("need time:" + TechEumDefine.getTime(_arg_1)));
            return (TechEumDefine.getTime(_arg_1) > limitTime);
        }


    }
}//package view.ui

