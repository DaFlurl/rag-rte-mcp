// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.as3xls.xls.style.XFormat

package com.as3xls.xls.style
{
    public class XFormat 
    {

        private var _format:uint;
        private var _type:uint;

        public function XFormat(_arg_1:uint, _arg_2:uint)
        {
            this._type = _arg_1;
            this._format = _arg_2;
        }

        public function get format():uint
        {
            return (this._format);
        }

        public function get type():uint
        {
            return (this._type);
        }


    }
}//package com.as3xls.xls.style

