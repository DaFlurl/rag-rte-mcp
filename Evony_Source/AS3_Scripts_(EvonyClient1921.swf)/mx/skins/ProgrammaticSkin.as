// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.ProgrammaticSkin

package mx.skins
{
    import mx.core.FlexShape;
    import mx.core.IFlexDisplayObject;
    import mx.core.IInvalidating;
    import mx.managers.ILayoutManagerClient;
    import mx.styles.ISimpleStyleClient;
    import mx.core.IProgrammaticSkin;
    import flash.geom.Matrix;
    import mx.styles.IStyleClient;
    import mx.core.UIComponentGlobals;
    import flash.display.Graphics;
    import mx.utils.GraphicsUtil;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ProgrammaticSkin extends FlexShape implements IFlexDisplayObject, IInvalidating, ILayoutManagerClient, ISimpleStyleClient, IProgrammaticSkin 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var tempMatrix:Matrix = new Matrix();

        private var _initialized:Boolean = false;
        private var _height:Number;
        private var invalidateDisplayListFlag:Boolean = false;
        private var _styleName:IStyleClient;
        private var _nestLevel:int = 0;
        private var _processedDescriptors:Boolean = false;
        private var _updateCompletePendingFlag:Boolean = true;
        private var _width:Number;

        public function ProgrammaticSkin()
        {
            _width = measuredWidth;
            _height = measuredHeight;
        }

        public function getStyle(_arg_1:String):*
        {
            return ((_styleName) ? _styleName.getStyle(_arg_1) : null);
        }

        protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
        }

        public function get nestLevel():int
        {
            return (_nestLevel);
        }

        public function set nestLevel(_arg_1:int):void
        {
            _nestLevel = _arg_1;
            invalidateDisplayList();
        }

        override public function get height():Number
        {
            return (_height);
        }

        public function get updateCompletePendingFlag():Boolean
        {
            return (_updateCompletePendingFlag);
        }

        protected function verticalGradientMatrix(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Matrix
        {
            return (rotatedGradientMatrix(_arg_1, _arg_2, _arg_3, _arg_4, 90));
        }

        public function validateSize(_arg_1:Boolean=false):void
        {
        }

        public function invalidateDisplayList():void
        {
            if (((!(invalidateDisplayListFlag)) && (nestLevel > 0)))
            {
                invalidateDisplayListFlag = true;
                UIComponentGlobals.layoutManager.invalidateDisplayList(this);
            };
        }

        public function set updateCompletePendingFlag(_arg_1:Boolean):void
        {
            _updateCompletePendingFlag = _arg_1;
        }

        protected function horizontalGradientMatrix(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Matrix
        {
            return (rotatedGradientMatrix(_arg_1, _arg_2, _arg_3, _arg_4, 0));
        }

        override public function set height(_arg_1:Number):void
        {
            _height = _arg_1;
            invalidateDisplayList();
        }

        public function set processedDescriptors(_arg_1:Boolean):void
        {
            _processedDescriptors = _arg_1;
        }

        public function validateDisplayList():void
        {
            invalidateDisplayListFlag = false;
            updateDisplayList(width, height);
        }

        public function get measuredWidth():Number
        {
            return (0);
        }

        override public function set width(_arg_1:Number):void
        {
            _width = _arg_1;
            invalidateDisplayList();
        }

        public function get measuredHeight():Number
        {
            return (0);
        }

        public function set initialized(_arg_1:Boolean):void
        {
            _initialized = _arg_1;
        }

        protected function drawRoundRect(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Object=null, _arg_6:Object=null, _arg_7:Object=null, _arg_8:Matrix=null, _arg_9:String="linear", _arg_10:Array=null, _arg_11:Object=null):void
        {
            var _local_13:Number;
            var _local_14:Array;
            var _local_15:Object;
            var _local_12:Graphics = graphics;
            if (((_arg_3 == 0) || (_arg_4 == 0)))
            {
                return;
            };
            if (_arg_6 !== null)
            {
                if ((_arg_6 is uint))
                {
                    _local_12.beginFill(uint(_arg_6), Number(_arg_7));
                }
                else
                {
                    if ((_arg_6 is Array))
                    {
                        _local_14 = ((_arg_7 is Array) ? (_arg_7 as Array) : [_arg_7, _arg_7]);
                        if (!_arg_10)
                        {
                            _arg_10 = [0, 0xFF];
                        };
                        _local_12.beginGradientFill(_arg_9, (_arg_6 as Array), _local_14, _arg_10, _arg_8);
                    };
                };
            };
            if (!_arg_5)
            {
                _local_12.drawRect(_arg_1, _arg_2, _arg_3, _arg_4);
            }
            else
            {
                if ((_arg_5 is Number))
                {
                    _local_13 = (Number(_arg_5) * 2);
                    _local_12.drawRoundRect(_arg_1, _arg_2, _arg_3, _arg_4, _local_13, _local_13);
                }
                else
                {
                    GraphicsUtil.drawRoundRectComplex(_local_12, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5.tl, _arg_5.tr, _arg_5.bl, _arg_5.br);
                };
            };
            if (_arg_11)
            {
                _local_15 = _arg_11.r;
                if ((_local_15 is Number))
                {
                    _local_13 = (Number(_local_15) * 2);
                    _local_12.drawRoundRect(_arg_11.x, _arg_11.y, _arg_11.w, _arg_11.h, _local_13, _local_13);
                }
                else
                {
                    GraphicsUtil.drawRoundRectComplex(_local_12, _arg_11.x, _arg_11.y, _arg_11.w, _arg_11.h, _local_15.tl, _local_15.tr, _local_15.bl, _local_15.br);
                };
            };
            if (_arg_6 !== null)
            {
                _local_12.endFill();
            };
        }

        public function get processedDescriptors():Boolean
        {
            return (_processedDescriptors);
        }

        public function set styleName(_arg_1:Object):void
        {
            if (_styleName != _arg_1)
            {
                _styleName = (_arg_1 as IStyleClient);
                invalidateDisplayList();
            };
        }

        public function setActualSize(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Boolean;
            if (_width != _arg_1)
            {
                _width = _arg_1;
                _local_3 = true;
            };
            if (_height != _arg_2)
            {
                _height = _arg_2;
                _local_3 = true;
            };
            if (_local_3)
            {
                invalidateDisplayList();
            };
        }

        public function styleChanged(_arg_1:String):void
        {
            invalidateDisplayList();
        }

        override public function get width():Number
        {
            return (_width);
        }

        public function invalidateProperties():void
        {
        }

        public function get initialized():Boolean
        {
            return (_initialized);
        }

        protected function rotatedGradientMatrix(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number):Matrix
        {
            tempMatrix.createGradientBox(_arg_3, _arg_4, ((_arg_5 * Math.PI) / 180), _arg_1, _arg_2);
            return (tempMatrix);
        }

        public function move(_arg_1:Number, _arg_2:Number):void
        {
            this.x = _arg_1;
            this.y = _arg_2;
        }

        public function get styleName():Object
        {
            return (_styleName);
        }

        public function validateNow():void
        {
            if (invalidateDisplayListFlag)
            {
                validateDisplayList();
            };
        }

        public function invalidateSize():void
        {
        }

        public function validateProperties():void
        {
        }


    }
}//package mx.skins

