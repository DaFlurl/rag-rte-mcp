// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.core.collections.DisplayObjectCollection

package com.degrafa.core.collections
{
    import flash.display.DisplayObject;

    public class DisplayObjectCollection extends DegrafaCollection 
    {

        public function DisplayObjectCollection(_arg_1:Array=null, _arg_2:Boolean=false)
        {
            super(DisplayObject, _arg_1, _arg_2);
        }

        public function addItem(_arg_1:DisplayObject):DisplayObject
        {
            return (super._addItem(_arg_1));
        }

        public function addItemAt(_arg_1:DisplayObject, _arg_2:Number):DisplayObject
        {
            return (super._addItemAt(_arg_1, _arg_2));
        }

        public function getItemIndex(_arg_1:DisplayObject):int
        {
            return (super._getItemIndex(_arg_1));
        }

        public function removeItemAt(_arg_1:Number):DisplayObject
        {
            return (super._removeItemAt(_arg_1));
        }

        public function getItemAt(_arg_1:Number):DisplayObject
        {
            return (super._getItemAt(_arg_1));
        }

        public function setItemIndex(_arg_1:DisplayObject, _arg_2:Number):Boolean
        {
            return (super._setItemIndex(_arg_1, _arg_2));
        }

        public function removeItem(_arg_1:DisplayObject):DisplayObject
        {
            return (super._removeItem(_arg_1));
        }

        public function addItems(_arg_1:DisplayObjectCollection):DisplayObjectCollection
        {
            super.concat(_arg_1.items);
            return (this);
        }


    }
}//package com.degrafa.core.collections

