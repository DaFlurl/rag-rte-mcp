// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.scrollClasses.ScrollThumb

package mx.controls.scrollClasses
{
    import mx.controls.Button;
    import mx.events.ScrollEventDetail;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ScrollThumb extends Button 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var lastY:Number;
        private var datamin:Number;
        private var ymax:Number;
        private var ymin:Number;
        private var datamax:Number;

        public function ScrollThumb()
        {
            explicitMinHeight = 10;
            stickyHighlighting = true;
        }

        private function stopDragThumb():void
        {
            var _local_1:ScrollBar = ScrollBar(parent);
            _local_1.isScrolling = false;
            _local_1.dispatchScrollEvent(_local_1.oldPosition, ScrollEventDetail.THUMB_POSITION);
            _local_1.oldPosition = NaN;
            systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
        }

        override protected function mouseDownHandler(_arg_1:MouseEvent):void
        {
            super.mouseDownHandler(_arg_1);
            var _local_2:ScrollBar = ScrollBar(parent);
            _local_2.oldPosition = _local_2.scrollPosition;
            lastY = _arg_1.localY;
            systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
        }

        private function mouseMoveHandler(_arg_1:MouseEvent):void
        {
            if (ymin == ymax)
            {
                return;
            };
            var _local_2:Point = new Point(_arg_1.stageX, _arg_1.stageY);
            _local_2 = globalToLocal(_local_2);
            var _local_3:Number = (_local_2.y - lastY);
            _local_3 = (_local_3 + y);
            if (_local_3 < ymin)
            {
                _local_3 = ymin;
            }
            else
            {
                if (_local_3 > ymax)
                {
                    _local_3 = ymax;
                };
            };
            var _local_4:ScrollBar = ScrollBar(parent);
            _local_4.isScrolling = true;
            $y = _local_3;
            var _local_5:Number = _local_4.scrollPosition;
            var _local_6:Number = (Math.round((((datamax - datamin) * (y - ymin)) / (ymax - ymin))) + datamin);
            _local_4.scrollPosition = _local_6;
            _local_4.dispatchScrollEvent(_local_5, ScrollEventDetail.THUMB_TRACK);
            _arg_1.updateAfterEvent();
        }

        override mx_internal function buttonReleased():void
        {
            super.buttonReleased();
            stopDragThumb();
        }

        mx_internal function setRange(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):void
        {
            this.ymin = _arg_1;
            this.ymax = _arg_2;
            this.datamin = _arg_3;
            this.datamax = _arg_4;
        }


    }
}//package mx.controls.scrollClasses

