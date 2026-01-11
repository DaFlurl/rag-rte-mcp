// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.SenderImpl

package com.evony
{
    import com.evony.common.Sender;
    import com.evony.net.client.GameClient;
    import com.evony.common.MouseManager;

    public class SenderImpl implements Sender 
    {

        private var client:GameClient;

        public function SenderImpl(_arg_1:GameClient)
        {
            this.client = _arg_1;
        }

        public function sendMessage(_arg_1:String, _arg_2:Object):void
        {
            if (Context.getInstance().bVisitor)
            {
                if (((!(_arg_1 == "visit.helpIncreaseProduction")) && (!(_arg_1 == "visit.visitorComment"))))
                {
                    return;
                };
            };
            if (Context.getInstance().getCurCastle() == null)
            {
                if (_arg_1 == "quest.getQuestType")
                {
                    return;
                };
            };
            MouseManager.setBusy();
            client.sendMessage(_arg_1, _arg_2);
        }


    }
}//package com.evony

