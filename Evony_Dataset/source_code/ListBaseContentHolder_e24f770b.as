// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.listClasses.ListBaseContentHolder

package mx.controls.listClasses
{
    import mx.core.UIComponent;
    import flash.display.Shape;
    import flash.display.Sprite;
    import mx.collections.IViewCursor;
    import flash.display.Graphics;
    import mx.core.FlexSprite;
    import mx.core.FlexShape;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ListBaseContentHolder extends UIComponent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var topOffset:Number = 0;
        public var rightOffset:Number = 0;
        private var maskShape:Shape;
        public var selectionLayer:Sprite;
        private var parentList:ListBase;
        public var iterator:IViewCursor;
        public var bottomOffset:Number = 0;
        public var leftOffset:Number = 0;
        mx_internal var allowItemSizeChangeNotification:Boolean = true;

        public var visibleData:Object = {};
        public var listItems:Array = [];
        public var rowInfo:Array = [];

        public function ListBaseContentHolder(_arg_1:ListBase)
        {
            var _local_2:Graphics;
            super();
            this.parentList = _arg_1;
            setStyle("backgroundColor", "");
            setStyle("borderStyle", "none");
            if (!selectionLayer)
            {
                selectionLayer = new FlexSprite();
                selectionLayer.name = "selectionLayer";
                selectionLayer.mouseEnabled = false;
                addChild(selectionLayer);
                _local_2 = selectionLayer.graphics;
                _local_2.beginFill(0, 0);
                _local_2.drawRect(0, 0, 10, 10);
                _local_2.endFill();
            };
        }

        override public function set focusPane(_arg_1:Sprite):void
        {
            var _local_2:Graphics;
            if (_arg_1)
            {
                if (!maskShape)
                {
                    maskShape = new FlexShape();
                    maskShape.name = "mask";
                    _local_2 = maskShape.graphics;
                    _local_2.beginFill(0xFFFFFF);
                    _local_2.drawRect(-2, -2, (parentList.width + 2), (parentList.height + 2));
                    _local_2.endFill();
                    addChild(maskShape);
                };
                maskShape.visible = false;
                _arg_1.mask = maskShape;
            }
            else
            {
                if (parentList.focusPane.mask == maskShape)
                {
                    parentList.focusPane.mask = null;
                };
            };
            parentList.focusPane = _arg_1;
            _arg_1.x = x;
            _arg_1.y = y;
        }

        public function get heightExcludingOffsets():Number
        {
            return ((height + topOffset) - bottomOffset);
        }

        public function get widthExcludingOffsets():Number
        {
            return ((width + leftOffset) - rightOffset);
        }

        override public function invalidateSize():void
        {
            if (allowItemSizeChangeNotification)
            {
                parentList.invalidateList();
            };
        }

        mx_internal function getParentList():ListBase
        {
            return (parentList);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Graphics = selectionLayer.graphics;
            _local_3.clear();
            if (((_arg_1 > 0) && (_arg_2 > 0)))
            {
                _local_3.beginFill(0x808080, 0);
                _local_3.drawRect(0, 0, _arg_1, _arg_2);
                _local_3.endFill();
            };
            if (maskShape)
            {
                maskShape.width = _arg_1;
                maskShape.height = _arg_2;
            };
        }


    }
}//package mx.controls.listClasses

