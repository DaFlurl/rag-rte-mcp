// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.CommonUtil

package com.evony.common
{
    import mx.collections.ArrayCollection;

    public class CommonUtil 
    {


        public static function arrayCopy(_arg_1:ArrayCollection, _arg_2:ArrayCollection):void
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return;
            };
            _arg_2.removeAll();
            var _local_3:int;
            while (_local_3 < _arg_1.length)
            {
                _arg_2.addItem(_arg_1[_local_3]);
                _local_3++;
            };
        }


    }
}//package com.evony.common

