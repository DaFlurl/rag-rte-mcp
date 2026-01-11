// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.core.collections.GradientStopsCollection

package com.degrafa.core.collections
{
    import com.degrafa.paint.GradientStop;

    public class GradientStopsCollection extends DegrafaCollection 
    {

        public function GradientStopsCollection(_arg_1:Array=null, _arg_2:Boolean=false)
        {
            super(GradientStop, _arg_1, _arg_2);
        }

        public function addItem(_arg_1:GradientStop):GradientStop
        {
            return (super._addItem(_arg_1));
        }

        public function addItemAt(_arg_1:GradientStop, _arg_2:Number):GradientStop
        {
            return (super._addItemAt(_arg_1, _arg_2));
        }

        public function getItemIndex(_arg_1:GradientStop):int
        {
            return (super._getItemIndex(_arg_1));
        }

        public function removeItemAt(_arg_1:Number):GradientStop
        {
            return (super._removeItemAt(_arg_1));
        }

        public function getItemAt(_arg_1:Number):GradientStop
        {
            return (super._getItemAt(_arg_1));
        }

        public function setItemIndex(_arg_1:GradientStop, _arg_2:Number):Boolean
        {
            return (super._setItemIndex(_arg_1, _arg_2));
        }

        public function removeItem(_arg_1:GradientStop):GradientStop
        {
            return (super._removeItem(_arg_1));
        }

        public function addItems(_arg_1:GradientStopsCollection):GradientStopsCollection
        {
            super.concat(_arg_1.items);
            return (this);
        }


    }
}//package com.degrafa.core.collections

