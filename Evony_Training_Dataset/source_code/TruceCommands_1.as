// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.TruceCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class TruceCommands 
    {

        public var _setDreamTruce_callback:Function;
        public var _changeDreamTruceTime_callback:Function;
        public var _cancelDreamTruce_callback:Function;
        private var sender:Sender;


        public function cancelDreamTruce(_arg_1:String, _arg_2:Function=null):CommandResponse
        {
            this._cancelDreamTruce_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.password = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("truce.cancelDreamTruce", _local_3);
            };
            return (null);
        }

        public function changeDreamTruceTime(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Function=null):CommandResponse
        {
            this._changeDreamTruceTime_callback = _arg_5;
            var _local_6:Object = new Object();
            _local_6.hour = _arg_1;
            _local_6.minute = _arg_2;
            _local_6.second = _arg_3;
            _local_6.password = _arg_4;
            if (this.sender != null)
            {
                sender.sendMessage("truce.changeDreamTruceTime", _local_6);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function setDreamTruce(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Function=null):CommandResponse
        {
            this._setDreamTruce_callback = _arg_5;
            var _local_6:Object = new Object();
            _local_6.hour = _arg_1;
            _local_6.minute = _arg_2;
            _local_6.second = _arg_3;
            _local_6.password = _arg_4;
            if (this.sender != null)
            {
                sender.sendMessage("truce.setDreamTruce", _local_6);
            };
            return (null);
        }


    }
}//package com.evony.client.action

