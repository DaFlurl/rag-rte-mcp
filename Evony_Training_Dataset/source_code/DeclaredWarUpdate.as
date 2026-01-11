// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.DeclaredWarUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.PlayerDeclaredWarBean;
    import com.evony.common.CommonUtil;

    public class DeclaredWarUpdate extends BaseBean 
    {

        public var declaredWarBeansArray:ArrayCollection = new ArrayCollection();

        public function DeclaredWarUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            var _local_6:PlayerDeclaredWarBean;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.declaredWarBeans)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.declaredWarBeans.length)
                {
                    _local_6 = new PlayerDeclaredWarBean(_arg_2.declaredWarBeans[_local_5]);
                    this.declaredWarBeansArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        public function copyTo(_arg_1:DeclaredWarUpdate):void
        {
            CommonUtil.arrayCopy(this.declaredWarBeansArray, _arg_1.declaredWarBeansArray);
        }

        public function setDeclaredWarBeans(_arg_1:PlayerDeclaredWarBean, _arg_2:int):void
        {
            this.declaredWarBeansArray[_arg_2] = _arg_1;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "---- DeclaredWarUpdate ----\n";
            var _local_3:int;
            while (_local_3 < this.declaredWarBeansArray.length)
            {
                _local_2 = (_local_2 + this.getDeclaredWarBeans(_local_3).toDebugString((((_arg_1 + "declaredWarBeans[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function toObject():Object
        {
            return (new Object());
        }

        public function getDeclaredWarBeans(_arg_1:int):PlayerDeclaredWarBean
        {
            return (this.declaredWarBeansArray[_arg_1] as PlayerDeclaredWarBean);
        }


    }
}//package com.evony.common.server.events

