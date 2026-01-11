// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.ItemUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.ItemBean;
    import com.evony.common.CommonUtil;

    public class ItemUpdate extends BaseBean 
    {

        public var itemsArray:ArrayCollection = new ArrayCollection();

        public function ItemUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:ItemBean;
            var _local_6:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.items)
            {
                _local_5 = null;
                _local_6 = 0;
                while (_local_6 < _arg_2.items.length)
                {
                    _local_5 = new ItemBean(_arg_2.items[_local_6]);
                    this.itemsArray.addItem(_local_5);
                    _local_6++;
                };
            };
        }

        public function copyTo(_arg_1:ItemUpdate):void
        {
            CommonUtil.arrayCopy(this.itemsArray, _arg_1.itemsArray);
        }

        public function toObject():Object
        {
            return ({});
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "---- ItemUpdate ----\n";
            var _local_3:int;
            while (_local_3 < this.itemsArray.length)
            {
                _local_2 = (_local_2 + this.getItems(_local_3).toDebugString((((_arg_1 + "items[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function getItems(_arg_1:int):ItemBean
        {
            return (this.itemsArray[_arg_1] as ItemBean);
        }

        public function setItems(_arg_1:ItemBean, _arg_2:int):void
        {
            this.itemsArray[_arg_2] = _arg_1;
        }


    }
}//package com.evony.common.server.events

