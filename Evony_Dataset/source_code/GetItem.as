// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.GetItem

package view.module.info.reports.ReportUi
{
    import com.evony.eum.ItemEumDefine;

    public class GetItem 
    {

        private static var instance:GetItem = new (GetItem)();

        private var itemAry:Array;


        public static function getItems(_arg_1:String):String
        {
            var _local_3:int;
            var _local_2:String = new String();
            instance.itemAry = _arg_1.split(",");
            if (instance.itemAry.length > 1)
            {
                _local_3 = 0;
                while (_local_3 < instance.itemAry.length)
                {
                    _local_2 = (_local_2 + ItemEumDefine.getItemEum(instance.itemAry[_local_3]).name);
                    _local_2 = (_local_2 + ",");
                    _local_3++;
                };
            }
            else
            {
                _local_2 = ItemEumDefine.getItemEum(_arg_1).name;
            };
            return (_local_2);
        }


    }
}//package view.module.info.reports.ReportUi

