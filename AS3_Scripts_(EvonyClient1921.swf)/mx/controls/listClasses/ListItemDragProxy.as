// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.listClasses.ListItemDragProxy

package mx.controls.listClasses
{
    import mx.core.UIComponent;
    import flash.display.DisplayObject;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ListItemDragProxy extends UIComponent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";


        override protected function createChildren():void
        {
            var _local_4:IListItemRenderer;
            var _local_5:IListItemRenderer;
            var _local_6:ListBaseContentHolder;
            var _local_7:BaseListData;
            super.createChildren();
            var _local_1:Array = ListBase(owner).selectedItems;
            var _local_2:int = _local_1.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = ListBase(owner).itemToItemRenderer(_local_1[_local_3]);
                if (_local_4)
                {
                    _local_5 = ListBase(owner).createItemRenderer(_local_1[_local_3]);
                    _local_5.styleName = ListBase(owner);
                    if ((_local_5 is IDropInListItemRenderer))
                    {
                        _local_7 = IDropInListItemRenderer(_local_4).listData;
                        IDropInListItemRenderer(_local_5).listData = ((_local_1[_local_3]) ? _local_7 : null);
                    };
                    _local_5.data = _local_1[_local_3];
                    addChild(DisplayObject(_local_5));
                    _local_6 = (_local_4.parent as ListBaseContentHolder);
                    _local_5.setActualSize(_local_4.width, _local_4.height);
                    _local_5.x = (_local_4.x + _local_6.leftOffset);
                    _local_5.y = (_local_4.y + _local_6.topOffset);
                    measuredHeight = Math.max(measuredHeight, (_local_5.y + _local_5.height));
                    measuredWidth = Math.max(measuredWidth, (_local_5.x + _local_5.width));
                    _local_5.visible = true;
                };
                _local_3++;
            };
            invalidateDisplayList();
        }

        override protected function measure():void
        {
            var _local_3:IListItemRenderer;
            super.measure();
            var _local_1:Number = 0;
            var _local_2:Number = 0;
            var _local_4:int;
            while (_local_4 < numChildren)
            {
                _local_3 = (getChildAt(_local_4) as IListItemRenderer);
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
}//package mx.controls.listClasses

