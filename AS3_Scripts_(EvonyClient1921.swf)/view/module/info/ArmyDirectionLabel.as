// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.ArmyDirectionLabel

package view.module.info
{
    import mx.controls.Label;
    import com.evony.common.constants.ArmyConstants;
    import com.evony.Lang;

    public class ArmyDirectionLabel extends Label 
    {


        override public function initialize():void
        {
            super.initialize();
        }

        public function set direction(_arg_1:int):void
        {
            if (_arg_1 == ArmyConstants.ARMY_BACKWARD)
            {
                this.text = Lang.msg("军队返回");
            }
            else
            {
                if (_arg_1 == ArmyConstants.ARMY_STAY)
                {
                    this.text = Lang.msg("驻扎");
                }
                else
                {
                    if (_arg_1 == ArmyConstants.ARMY_FORWARD)
                    {
                        this.text = Lang.msg("进军");
                    }
                    else
                    {
                        this.text = Lang.msg("进军");
                    };
                };
            };
        }


    }
}//package view.module.info

