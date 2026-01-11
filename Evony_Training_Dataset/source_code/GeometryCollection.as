// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.core.collections.GeometryCollection

package com.degrafa.core.collections
{
    import com.degrafa.IGeometry;

    public class GeometryCollection extends DegrafaCollection 
    {

        public function GeometryCollection(_arg_1:Array=null, _arg_2:Boolean=false)
        {
            super(IGeometry, _arg_1, _arg_2);
        }

        public function addItem(_arg_1:IGeometry):IGeometry
        {
            return (super._addItem(_arg_1));
        }

        public function addItemAt(_arg_1:IGeometry, _arg_2:Number):IGeometry
        {
            return (super._addItemAt(_arg_1, _arg_2));
        }

        public function getItemIndex(_arg_1:IGeometry):int
        {
            return (super._getItemIndex(_arg_1));
        }

        public function removeItemAt(_arg_1:Number):IGeometry
        {
            return (super._removeItemAt(_arg_1));
        }

        public function getItemAt(_arg_1:Number):IGeometry
        {
            return (super._getItemAt(_arg_1));
        }

        public function setItemIndex(_arg_1:IGeometry, _arg_2:Number):Boolean
        {
            return (super._setItemIndex(_arg_1, _arg_2));
        }

        public function removeItem(_arg_1:IGeometry):IGeometry
        {
            return (super._removeItem(_arg_1));
        }

        public function addItems(_arg_1:GeometryCollection):GeometryCollection
        {
            super.concat(_arg_1.items);
            return (this);
        }


    }
}//package com.degrafa.core.collections

