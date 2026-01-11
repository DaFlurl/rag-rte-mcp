// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.FieldStatusLabel

package view.module.office
{
    import mx.controls.Label;
    import com.evony.Lang;
    import com.evony.common.constants.FieldConstants;

    public class FieldStatusLabel extends Label 
    {


        override public function initialize():void
        {
            super.initialize();
        }

        public function set myStatus(_arg_1:int):void
        {
            switch (_arg_1)
            {
                case FieldConstants.STAUTS_IDLE:
                    this.text = Lang.msg("空闲");
                    return;
                case FieldConstants.STAUTS_INCOMINE:
                    this.text = Lang.msg("有人正在过来");
                    return;
                case FieldConstants.STAUTS_OCCUPIED:
                    this.text = Lang.msg("占领");
                    return;
                case FieldConstants.STAUTS_CASTLE:
                    this.text = Lang.msg("已建城");
                    return;
            };
        }


    }
}//package view.module.office

