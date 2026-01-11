// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.FieldPositionLabel

package view.ui
{
    import mx.controls.Label;
    import com.evony.Coordinate;
    import com.evony.Context;

    public class FieldPositionLabel extends Label 
    {


        override public function initialize():void
        {
            super.initialize();
        }

        public function set fieldId(_arg_1:int):void
        {
            var _local_2:Coordinate = new Coordinate(_arg_1);
            if ((((_local_2.x < 0) || (_local_2.y < 0)) || (Context.getInstance().bVisitor)))
            {
                this.text = "(- -)";
            }
            else
            {
                this.text = (((("(" + _local_2.x) + ",") + _local_2.y) + ")");
            };
        }


    }
}//package view.ui

