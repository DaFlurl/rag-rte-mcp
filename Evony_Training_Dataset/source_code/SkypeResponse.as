// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.skype.SkypeResponse

package com.skype
{
    public class SkypeResponse 
    {

        public var msg:String;
        public var errorMsg:String;
        public var ok:int;

        public function SkypeResponse(_arg_1:int, _arg_2:String="", _arg_3:String="")
        {
            this.ok = _arg_1;
            this.msg = _arg_2;
            this.errorMsg = _arg_3;
        }

    }
}//package com.skype

