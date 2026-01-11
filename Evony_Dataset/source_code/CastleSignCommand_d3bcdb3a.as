// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.CastleSignCommand

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.castle.CastleSignResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class CastleSignCommand 
    {

        public var _saveCastleSignList_callback:Function;
        public var _deleteCastleSign_callback:Function;
        private var sender:Sender;


        public function deleteCastleSign(_arg_1:int, _arg_2:Function=null):CastleSignResponse
        {
            this._deleteCastleSign_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.id = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("castle.deleteCastleSign", _local_3);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function saveCastleSignList(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null):CastleSignResponse
        {
            this._saveCastleSignList_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.id = _arg_1;
            _local_5.x = _arg_2;
            _local_5.y = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("castle.saveCastleSignList", _local_5);
            };
            return (null);
        }


    }
}//package com.evony.client.action

