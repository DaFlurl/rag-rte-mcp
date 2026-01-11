// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.TargetPositionLabel

package view.ui
{
    import mx.controls.Label;
    import mx.events.PropertyChangeEvent;
    import com.evony.Coordinate;
    import com.evony.common.beans.ArmyBean;

    public class TargetPositionLabel extends Label 
    {

        private var _3575610type:String;


        override public function initialize():void
        {
            super.initialize();
        }

        [Bindable(event="propertyChange")]
        public function get type():String
        {
            return (this._3575610type);
        }

        public function set type(_arg_1:String):void
        {
            var _local_2:Object = this._3575610type;
            if (_local_2 !== _arg_1)
            {
                this._3575610type = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "type", _local_2, _arg_1));
            };
        }

        public function set fieldOb(_arg_1:Object):void
        {
            var _local_3:String;
            var _local_4:Coordinate;
            var _local_2:ArmyBean = (_arg_1 as ArmyBean);
            if (type == "start")
            {
                _local_4 = new Coordinate(_local_2.startFieldId);
                _local_3 = ((_local_2.startPosName == null) ? "--" : _local_2.startPosName);
            }
            else
            {
                _local_4 = new Coordinate(_local_2.targetFieldId);
                _local_3 = ((_local_2.targetPosName == null) ? "--" : _local_2.targetPosName);
            };
            if (((_local_4.x < 0) || (_local_4.y < 0)))
            {
                this.text = (_local_3 + "(- -)");
            }
            else
            {
                this.text = (((((_local_3 + "(") + _local_4.x) + ",") + _local_4.y) + ")");
            };
        }


    }
}//package view.ui

