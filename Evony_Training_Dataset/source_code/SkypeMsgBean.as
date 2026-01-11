// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.skype.SkypeMsgBean

package com.skype
{
    internal class SkypeMsgBean 
    {

        internal var addedAt:Number = 0;
        internal var callback:Function = null;
        internal var message:String = null;
        internal var isGroup:Boolean = false;
        internal var receiver:String = null;

        public function SkypeMsgBean(_arg_1:String, _arg_2:String, _arg_3:Boolean=false, _arg_4:Function=null)
        {
            this.addedAt = new Date().getTime();
            this.receiver = _arg_1;
            this.message = _arg_2;
            this.isGroup = _arg_3;
            this.callback = _arg_4;
        }

    }
}//package com.skype

