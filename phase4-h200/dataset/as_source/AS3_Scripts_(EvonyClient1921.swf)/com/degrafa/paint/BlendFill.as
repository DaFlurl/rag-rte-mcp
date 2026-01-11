// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.paint.BlendFill

package com.degrafa.paint
{
    import com.degrafa.core.DegrafaObject;
    import com.degrafa.core.IGraphicsFill;
    import com.degrafa.core.IBlend;
    import mx.graphics.IFill;
    import com.degrafa.IGeometryComposition;
    import flash.geom.Rectangle;
    import mx.events.PropertyChangeEvent;
    import flash.display.Graphics;
    import com.degrafa.core.ITransformablePaint;

    [Bindable(event="propertyChange")]
    public class BlendFill extends DegrafaObject implements IGraphicsFill, IBlend 
    {

        private var _blendMode:String = "normal";
        private var _fill:IFill;
        private var _requester:IGeometryComposition;

        public function BlendFill(_arg_1:IFill=null, _arg_2:String="normal")
        {
            this.fill = _arg_1;
            this.blendMode = _arg_2;
        }

        public function get lastRectangle():Rectangle
        {
            return (null);
        }

        public function get fill():IFill
        {
            return (_fill);
        }

        public function set fill(_arg_1:IFill):void
        {
            if (_fill != _arg_1)
            {
                if ((_fill is IGraphicsFill))
                {
                    (_fill as IGraphicsFill).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler, false);
                };
                if ((_arg_1 is IGraphicsFill))
                {
                    (_arg_1 as IGraphicsFill).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler, false, 0, true);
                };
                initChange("fill", _fill, (_fill = _arg_1), this);
            };
        }

        public function get restartFunction():Function
        {
            return (null);
        }

        public function end(_arg_1:Graphics):void
        {
            if (fill != null)
            {
                fill.end(_arg_1);
            };
        }

        public function get blendMode():String
        {
            return (_blendMode);
        }

        public function get lastArgs():Array
        {
            return (null);
        }

        private function propertyChangeHandler(_arg_1:PropertyChangeEvent):void
        {
            dispatchEvent(_arg_1);
        }

        public function set blendMode(_arg_1:String):void
        {
            if (_blendMode != _arg_1)
            {
                initChange("blendMode", _blendMode, (_blendMode = _arg_1), this);
            };
        }

        public function begin(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            if (fill != null)
            {
                if ((fill is ITransformablePaint))
                {
                    (fill as ITransformablePaint).requester = _requester;
                };
                fill.begin(_arg_1, _arg_2);
                _requester = null;
            };
        }

        public function set requester(_arg_1:IGeometryComposition):void
        {
            _requester = _arg_1;
        }


    }
}//package com.degrafa.paint

