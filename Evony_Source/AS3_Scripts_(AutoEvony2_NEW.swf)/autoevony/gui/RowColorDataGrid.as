// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.RowColorDataGrid

package autoevony.gui
{
    import mx.controls.DataGrid;
    import autoevony.common.Utils;
    import flash.display.Sprite;

    public class RowColorDataGrid extends DataGrid 
    {


        override protected function drawRowBackground(_arg_1:Sprite, _arg_2:int, _arg_3:Number, _arg_4:Number, _arg_5:uint, _arg_6:int):void
        {
            var _local_7:* = null;
            if (dataProvider != null)
            {
                if (_arg_6 < dataProvider.length)
                {
                    _local_7 = dataProvider[_arg_6];
                };
                if ((((_local_7) && (!(_local_7.bgColor == null))) && (Utils.hasValue(_local_7.bgColor))))
                {
                    _arg_5 = _local_7.bgColor;
                };
            };
            super.drawRowBackground(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
        }


    }
}//package autoevony.gui

