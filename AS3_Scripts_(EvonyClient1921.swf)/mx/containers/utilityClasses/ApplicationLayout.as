// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.utilityClasses.ApplicationLayout

package mx.containers.utilityClasses
{
    import mx.core.IFlexDisplayObject;
    import mx.core.Container;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ApplicationLayout extends BoxLayout 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";


        override public function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:int;
            var _local_9:int;
            var _local_10:IFlexDisplayObject;
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Container = super.target;
            if ((((_local_3.horizontalScrollBar) && (getHorizontalAlignValue() > 0)) || ((_local_3.verticalScrollBar) && (getVerticalAlignValue() > 0))))
            {
                _local_4 = _local_3.getStyle("paddingLeft");
                _local_5 = _local_3.getStyle("paddingTop");
                _local_6 = 0;
                _local_7 = 0;
                _local_8 = _local_3.numChildren;
                _local_9 = 0;
                while (_local_9 < _local_8)
                {
                    _local_10 = IFlexDisplayObject(_local_3.getChildAt(_local_9));
                    if (_local_10.x < _local_4)
                    {
                        _local_6 = Math.max(_local_6, (_local_4 - _local_10.x));
                    };
                    if (_local_10.y < _local_5)
                    {
                        _local_7 = Math.max(_local_7, (_local_5 - _local_10.y));
                    };
                    _local_9++;
                };
                if (((!(_local_6 == 0)) || (!(_local_7 == 0))))
                {
                    _local_9 = 0;
                    while (_local_9 < _local_8)
                    {
                        _local_10 = IFlexDisplayObject(_local_3.getChildAt(_local_9));
                        _local_10.move((_local_10.x + _local_6), (_local_10.y + _local_7));
                        _local_9++;
                    };
                };
            };
        }


    }
}//package mx.containers.utilityClasses

