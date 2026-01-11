// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.dataGridClasses.DataGridDragProxy

package mx.controls.dataGridClasses
{
    import mx.core.UIComponent;
    import mx.controls.listClasses.IListItemRenderer;
    import flash.geom.Point;
    import flash.display.DisplayObject;
    import mx.controls.listClasses.IDropInListItemRenderer;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DataGridDragProxy extends UIComponent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";


        override protected function createChildren():void
        {
            var _local_4:IListItemRenderer;
            var _local_5:UIComponent;
            var _local_6:Object;
            var _local_7:Number;
            var _local_8:int;
            var _local_9:int;
            var _local_10:DataGridColumn;
            var _local_11:IListItemRenderer;
            var _local_12:DataGridListData;
            var _local_13:Point;
            super.createChildren();
            var _local_1:Array = DataGridBase(owner).selectedItems;
            var _local_2:int = _local_1.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = DataGridBase(owner).itemToItemRenderer(_local_1[_local_3]);
                if (_local_4)
                {
                    _local_6 = _local_1[_local_3];
                    _local_5 = new UIComponent();
                    addChild(DisplayObject(_local_5));
                    _local_7 = 0;
                    if (DataGridBase(owner).visibleLockedColumns)
                    {
                        _local_8 = DataGridBase(owner).visibleLockedColumns.length;
                        _local_9 = 0;
                        while (_local_9 < _local_8)
                        {
                            _local_10 = DataGridBase(owner).visibleLockedColumns[_local_9];
                            _local_11 = DataGridBase(owner).createColumnItemRenderer(_local_10, false, _local_6);
                            _local_12 = new DataGridListData(_local_10.itemToLabel(_local_6), _local_10.dataField, _local_10.colNum, "", DataGridBase(owner));
                            if ((_local_11 is IDropInListItemRenderer))
                            {
                                IDropInListItemRenderer(_local_11).listData = ((_local_6) ? _local_12 : null);
                            };
                            _local_11.data = _local_6;
                            _local_11.styleName = DataGridBase(owner);
                            _local_11.visible = true;
                            _local_5.addChild(DisplayObject(_local_11));
                            _local_11.setActualSize(_local_10.width, _local_4.height);
                            _local_11.move(_local_7, 0);
                            _local_7 = (_local_7 + _local_10.width);
                            _local_9++;
                        };
                    };
                    _local_8 = DataGridBase(owner).visibleColumns.length;
                    _local_9 = 0;
                    while (_local_9 < _local_8)
                    {
                        _local_10 = DataGridBase(owner).visibleColumns[_local_9];
                        _local_11 = DataGridBase(owner).createColumnItemRenderer(_local_10, false, _local_6);
                        _local_12 = new DataGridListData(_local_10.itemToLabel(_local_6), _local_10.dataField, _local_10.colNum, "", DataGridBase(owner));
                        if ((_local_11 is IDropInListItemRenderer))
                        {
                            IDropInListItemRenderer(_local_11).listData = ((_local_6) ? _local_12 : null);
                        };
                        _local_11.data = _local_6;
                        _local_11.styleName = DataGridBase(owner);
                        _local_11.visible = true;
                        _local_5.addChild(DisplayObject(_local_11));
                        _local_11.setActualSize(_local_10.width, _local_4.height);
                        _local_11.move(_local_7, 0);
                        _local_7 = (_local_7 + _local_10.width);
                        _local_9++;
                    };
                    _local_5.setActualSize(_local_7, _local_4.height);
                    _local_13 = new Point(0, 0);
                    _local_13 = DisplayObject(_local_4).localToGlobal(_local_13);
                    _local_13 = DataGridBase(owner).globalToLocal(_local_13);
                    _local_5.y = _local_13.y;
                    measuredHeight = (_local_5.y + _local_5.height);
                    measuredWidth = _local_7;
                };
                _local_3++;
            };
            invalidateDisplayList();
        }

        override protected function measure():void
        {
            var _local_3:UIComponent;
            super.measure();
            var _local_1:Number = 0;
            var _local_2:Number = 0;
            var _local_4:int;
            while (_local_4 < numChildren)
            {
                _local_3 = (getChildAt(_local_4) as UIComponent);
                if (_local_3)
                {
                    _local_1 = Math.max(_local_1, (_local_3.x + _local_3.width));
                    _local_2 = Math.max(_local_2, (_local_3.y + _local_3.height));
                };
                _local_4++;
            };
            measuredWidth = (measuredMinWidth = _local_1);
            measuredHeight = (measuredMinHeight = _local_2);
        }


    }
}//package mx.controls.dataGridClasses

