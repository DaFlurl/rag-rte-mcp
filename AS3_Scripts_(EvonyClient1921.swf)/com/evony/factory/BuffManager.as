// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.factory.BuffManager

package com.evony.factory
{
    import com.evony.common.constants.CommonConstants;
    import view.castle.PLayerBuffConstants;
    import com.evony.common.beans.BuffBean;
    import mx.collections.ArrayCollection;

    public class BuffManager 
    {

        private static var instance:BuffManager = new (BuffManager)();
        private static var buffFilterArr:Array = [CommonConstants.INCGOLDPRODUCEEFFORTBUFF, CommonConstants.INCFOODPRODUCEEFFORTBUFF, CommonConstants.INCWOODPRODUCEEFFORTBUFF, CommonConstants.INCSTONEPRODUCEEFFORTBUFF, CommonConstants.INCIRONPRODUCEEFFORTBUFF, CommonConstants.DECPRODUCEMILITIAEFFORTBUFF, "DecProduceCavalryEffortBuff", CommonConstants.DECPRODUCEMACHINEEFFORTBUFF, CommonConstants.DECPRODUCEBUILDEFFORTBUFF, CommonConstants.INCCASTLESUPPORTEFFORTBUFF, CommonConstants.INCGETITEMRATEAFTERWAREFFORTBUFF, CommonConstants.INCHURTEDSOLIDEREFFORTBUFF, "TruceAgreementBuff", "DecProcduceCavalryEffortBuf"];

        private var buffArr:Array = [PLayerBuffConstants.INCGOLDPRODUCE_BUFF, PLayerBuffConstants.INCFOODPRODUCE_BUFF, PLayerBuffConstants.INCWOODPRODUCE_BUFF, PLayerBuffConstants.INCSTONEPRODUCE_BUFF, PLayerBuffConstants.INCIRONPRODUCE_BUFF, PLayerBuffConstants.PLAYERINCARMYATTACH_BUFF, PLayerBuffConstants.PLAYERINCARMYDEFENCE_BUFF, PLayerBuffConstants.TROOPRELIVE_BUFF, PLayerBuffConstants.PLAYERPEACE_BUFF];


        public static function sortBuffArray(_arg_1:ArrayCollection):void
        {
            var _local_3:int;
            var _local_4:BuffBean;
            if (_arg_1.length <= 1)
            {
                return;
            };
            var _local_2:int;
            while (_local_2 < _arg_1.length)
            {
                _local_3 = 0;
                while (_local_3 < ((_arg_1.length - 1) - _local_2))
                {
                    if (instance.getSortId(_arg_1.getItemAt(_local_3).typeId) > instance.getSortId(_arg_1.getItemAt((_local_3 + 1)).typeId))
                    {
                        _local_4 = new BuffBean();
                        _local_4 = (_arg_1.getItemAt(_local_3) as BuffBean);
                        _arg_1.setItemAt(_arg_1.getItemAt((_local_3 + 1)), _local_3);
                        _arg_1.setItemAt(_local_4, (_local_3 + 1));
                    };
                    _local_3++;
                };
                _local_2++;
            };
        }

        public static function buffFilter(_arg_1:ArrayCollection):ArrayCollection
        {
            var _local_5:String;
            var _local_2:int = _arg_1.length;
            var _local_3:ArrayCollection = new ArrayCollection();
            var _local_4:int;
            while (_local_4 < _local_2)
            {
                _local_3.addItem(_arg_1[_local_4]);
                for each (_local_5 in buffFilterArr)
                {
                    if (_local_5 == _arg_1[_local_4].typeId)
                    {
                        _local_3.removeItemAt((_local_3.length - 1));
                    };
                };
                _local_4++;
            };
            return (_local_3);
        }


        private function getSortId(_arg_1:String):int
        {
            var _local_2:int;
            var _local_3:int;
            while (_local_3 < buffArr.length)
            {
                if (_arg_1 == buffArr[_local_3])
                {
                    _local_2 = _local_3;
                    break;
                };
                _local_3++;
            };
            return (_local_2);
        }


    }
}//package com.evony.factory

