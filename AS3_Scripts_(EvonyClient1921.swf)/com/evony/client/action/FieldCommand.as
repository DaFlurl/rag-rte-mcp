// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.FieldCommand

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.field.CastleFieldInfoResponse;
    import com.evony.common.module.field.OtherFieldInfoResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class FieldCommand 
    {

        private var sender:Sender;
        public var _getCastleFieldInfo_callback:Function;
        public var _giveUpField_callback:Function;
        public var _getOtherFieldInfo_callback:Function;


        public function giveUpField(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._giveUpField_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.fieldId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("field.giveUpField", _local_3);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function getCastleFieldInfo(_arg_1:int, _arg_2:Function=null):CastleFieldInfoResponse
        {
            this._getCastleFieldInfo_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("field.getCastleFieldInfo", _local_3);
            };
            return (null);
        }

        public function getOtherFieldInfo(_arg_1:int, _arg_2:int, _arg_3:Function=null):OtherFieldInfoResponse
        {
            this._getOtherFieldInfo_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.fieldId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("field.getOtherFieldInfo", _local_4);
            };
            return (null);
        }


    }
}//package com.evony.client.action

