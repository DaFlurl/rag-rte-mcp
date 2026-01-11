// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.core.collections.FilterCollection

package com.degrafa.core.collections
{
    import flash.filters.BitmapFilter;

    public class FilterCollection extends DegrafaCollection 
    {

        public function FilterCollection(_arg_1:Array=null, _arg_2:Boolean=false)
        {
            super(BitmapFilter, _arg_1, _arg_2);
        }

        public function addItem(_arg_1:BitmapFilter):BitmapFilter
        {
            return (super._addItem(_arg_1));
        }

        public function addItemAt(_arg_1:BitmapFilter, _arg_2:Number):BitmapFilter
        {
            return (super._addItemAt(_arg_1, _arg_2));
        }

        public function getItemIndex(_arg_1:BitmapFilter):int
        {
            return (super._getItemIndex(_arg_1));
        }

        public function removeItemAt(_arg_1:Number):BitmapFilter
        {
            return (super._removeItemAt(_arg_1));
        }

        public function getItemAt(_arg_1:Number):BitmapFilter
        {
            return (super._getItemAt(_arg_1));
        }

        public function setItemIndex(_arg_1:BitmapFilter, _arg_2:Number):Boolean
        {
            return (super._setItemIndex(_arg_1, _arg_2));
        }

        public function removeItem(_arg_1:BitmapFilter):BitmapFilter
        {
            return (super._removeItem(_arg_1));
        }

        public function addItems(_arg_1:FilterCollection):FilterCollection
        {
            super.concat(_arg_1.items);
            return (this);
        }


    }
}//package com.degrafa.core.collections

