// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.StratagemCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class StratagemCommands 
    {

        private var sender:Sender;
        public var _useStratagem_callback:Function;


        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function useStratagem(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._useStratagem_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.heroId = _arg_2;
            _local_5.straId = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("stratagem.useStratagem", _local_5);
            };
            return (null);
        }


    }
}//package com.evony.client.action

