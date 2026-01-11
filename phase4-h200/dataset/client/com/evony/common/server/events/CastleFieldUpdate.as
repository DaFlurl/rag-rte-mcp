// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.CastleFieldUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.FieldBean;
    import com.evony.common.beans.*;

    public class CastleFieldUpdate extends BaseBean 
    {

        public var bean:FieldBean;
        public var updateType:int;
        public var castleId:int;

        public function CastleFieldUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.bean != null)
            {
                this.bean = new FieldBean(_arg_2.bean);
            };
            if (_arg_2.castleId != null)
            {
                this.castleId = _arg_2.castleId;
            };
            if (_arg_2.updateType != null)
            {
                this.updateType = _arg_2.updateType;
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.bean = this.bean.toObject();
            _local_1.castleId = this.castleId;
            _local_1.updateType = this.updateType;
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- CastleFieldUpdate ----\n";
            if (bean != null)
            {
                _local_2 = (_local_2 + this.bean.toDebugString((_arg_1 + "bean.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "bean = null\n"));
            };
            _local_2 = (_local_2 + (((_arg_1 + "castleId = ") + this.castleId) + "\n"));
            return (_local_2 + (((_arg_1 + "updateType = ") + this.updateType) + "\n"));
        }

        public function copyTo(_arg_1:CastleFieldUpdate):void
        {
            if (bean != null)
            {
                this.bean.copyTo(_arg_1.bean);
            }
            else
            {
                _arg_1.bean = null;
            };
            _arg_1.castleId = this.castleId;
            _arg_1.updateType = this.updateType;
        }


    }
}//package com.evony.common.server.events

