// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.FortificationsUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.FortificationsBean;
    import com.evony.common.beans.*;

    public class FortificationsUpdate extends BaseBean 
    {

        public var fortification:FortificationsBean;
        public var castleId:int;

        public function FortificationsUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.castleId != null)
            {
                this.castleId = _arg_2.castleId;
            };
            if (_arg_2.fortification != null)
            {
                this.fortification = new FortificationsBean(_arg_2.fortification);
            };
        }

        public function copyTo(_arg_1:FortificationsUpdate):void
        {
            _arg_1.castleId = this.castleId;
            if (fortification != null)
            {
                this.fortification.copyTo(_arg_1.fortification);
            }
            else
            {
                _arg_1.fortification = null;
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.castleId = this.castleId;
            _local_1.fortification = this.fortification.toObject();
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- FortificationsUpdate ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "castleId = ") + this.castleId) + "\n"));
            if (fortification != null)
            {
                _local_2 = (_local_2 + this.fortification.toDebugString((_arg_1 + "fortification.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "fortification = null\n"));
            };
            return (_local_2);
        }


    }
}//package com.evony.common.server.events

