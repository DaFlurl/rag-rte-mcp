// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.quest.CommissionTypeLabel

package view.module.quest
{
    import mx.controls.Label;
    import com.evony.common.constants.CommonConstants;

    public class CommissionTypeLabel extends Label 
    {


        override public function initialize():void
        {
            super.initialize();
        }

        public function set type(_arg_1:int):void
        {
            switch (_arg_1)
            {
                case CommonConstants.COMMISSION_QUEST_TYPE_COLONY:
                    this.text = "Anti-Colonization";
                    return;
            };
        }


    }
}//package view.module.quest

