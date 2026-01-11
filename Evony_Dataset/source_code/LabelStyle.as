// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.mail.LabelStyle

package view.module.mail
{
    import mx.controls.Label;
    import com.evony.common.constants.MailConstants;

    public class LabelStyle extends Label 
    {


        override public function initialize():void
        {
            super.initialize();
        }

        public function set mineLabelStyle(_arg_1:int):void
        {
            if (_arg_1 == MailConstants.IS_READ)
            {
                this.styleName = "commonNormalColor";
            }
            else
            {
                if (_arg_1 == MailConstants.NOT_READ)
                {
                    this.styleName = "commonUsualStyleNotRead";
                };
            };
        }


    }
}//package view.module.mail

