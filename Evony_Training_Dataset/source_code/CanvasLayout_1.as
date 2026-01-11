// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.utilityClasses.CanvasLayout

package mx.containers.utilityClasses
{
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;
    import mx.core.mx_internal;
    import mx.core.IUIComponent;
    import mx.core.Container;
    import mx.core.EdgeMetrics;
    import mx.events.MoveEvent;
    import mx.core.IConstraintClient;
    import flash.display.DisplayObject;
    import mx.events.ChildExistenceChangedEvent;
    import mx.core.FlexVersion;
    import mx.containers.errors.ConstraintError;

    use namespace mx_internal;

    public class CanvasLayout extends Layout 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var r:Rectangle = new Rectangle();

        private var colSpanChildren:Array = [];
        private var constraintRegionsInUse:Boolean = false;
        private var rowSpanChildren:Array = [];
        private var constraintCache:Dictionary = new Dictionary(true);
        private var _contentArea:Rectangle;


        private function parseConstraints(_arg_1:IUIComponent=null):ChildConstraintInfo
        {
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:String;
            var _local_11:String;
            var _local_12:String;
            var _local_13:String;
            var _local_14:String;
            var _local_15:String;
            var _local_16:String;
            var _local_17:Array;
            var _local_18:int;
            var _local_30:ConstraintColumn;
            var _local_31:Boolean;
            var _local_32:ConstraintRow;
            var _local_2:LayoutConstraints = getLayoutConstraints(_arg_1);
            if (!_local_2)
            {
                return (null);
            };
            while (true)
            {
                _local_17 = parseConstraintExp(_local_2.left);
                if (!_local_17)
                {
                    _local_3 = NaN;
                }
                else
                {
                    if (_local_17.length == 1)
                    {
                        _local_3 = Number(_local_17[0]);
                    }
                    else
                    {
                        _local_10 = _local_17[0];
                        _local_3 = _local_17[1];
                    };
                };
                _local_17 = parseConstraintExp(_local_2.right);
                if (!_local_17)
                {
                    _local_4 = NaN;
                }
                else
                {
                    if (_local_17.length == 1)
                    {
                        _local_4 = Number(_local_17[0]);
                    }
                    else
                    {
                        _local_11 = _local_17[0];
                        _local_4 = _local_17[1];
                    };
                };
                _local_17 = parseConstraintExp(_local_2.horizontalCenter);
                if (!_local_17)
                {
                    _local_5 = NaN;
                }
                else
                {
                    if (_local_17.length == 1)
                    {
                        _local_5 = Number(_local_17[0]);
                    }
                    else
                    {
                        _local_12 = _local_17[0];
                        _local_5 = _local_17[1];
                    };
                };
                _local_17 = parseConstraintExp(_local_2.top);
                if (!_local_17)
                {
                    _local_6 = NaN;
                }
                else
                {
                    if (_local_17.length == 1)
                    {
                        _local_6 = Number(_local_17[0]);
                    }
                    else
                    {
                        _local_13 = _local_17[0];
                        _local_6 = _local_17[1];
                    };
                };
                _local_17 = parseConstraintExp(_local_2.bottom);
                if (!_local_17)
                {
                    _local_7 = NaN;
                }
                else
                {
                    if (_local_17.length == 1)
                    {
                        _local_7 = Number(_local_17[0]);
                    }
                    else
                    {
                        _local_14 = _local_17[0];
                        _local_7 = _local_17[1];
                    };
                };
                _local_17 = parseConstraintExp(_local_2.verticalCenter);
                if (!_local_17)
                {
                    _local_8 = NaN;
                }
                else
                {
                    if (_local_17.length == 1)
                    {
                        _local_8 = Number(_local_17[0]);
                    }
                    else
                    {
                        _local_15 = _local_17[0];
                        _local_8 = _local_17[1];
                    };
                };
                _local_17 = parseConstraintExp(_local_2.baseline);
                if (!_local_17)
                {
                    _local_9 = NaN;
                }
                else
                {
                    if (_local_17.length == 1)
                    {
                        _local_9 = Number(_local_17[0]);
                    }
                    else
                    {
                        _local_16 = _local_17[0];
                        _local_9 = _local_17[1];
                    };
                };
                break;
            };
            var _local_19:ContentColumnChild = new ContentColumnChild();
            var _local_20:Boolean;
            var _local_21:Number = 0;
            var _local_22:Number = 0;
            var _local_23:Number = 0;
            _local_18 = 0;
            while (_local_18 < IConstraintLayout(target).constraintColumns.length)
            {
                _local_30 = IConstraintLayout(target).constraintColumns[_local_18];
                if (_local_30.mx_internal::contentSize)
                {
                    if (_local_30.id == _local_10)
                    {
                        _local_19.leftCol = _local_30;
                        _local_19.leftOffset = _local_3;
                        _local_19.left = (_local_21 = _local_18);
                        _local_20 = true;
                    };
                    if (_local_30.id == _local_11)
                    {
                        _local_19.rightCol = _local_30;
                        _local_19.rightOffset = _local_4;
                        _local_19.right = (_local_22 = (_local_18 + 1));
                        _local_20 = true;
                    };
                    if (_local_30.id == _local_12)
                    {
                        _local_19.hcCol = _local_30;
                        _local_19.hcOffset = _local_5;
                        _local_19.hc = (_local_23 = (_local_18 + 1));
                        _local_20 = true;
                    };
                };
                _local_18++;
            };
            if (_local_20)
            {
                _local_19.child = _arg_1;
                if (((((_local_19.leftCol) && (!(_local_19.rightCol))) || ((_local_19.rightCol) && (!(_local_19.leftCol)))) || (_local_19.hcCol)))
                {
                    _local_19.span = 1;
                }
                else
                {
                    _local_19.span = (_local_22 - _local_21);
                };
                _local_31 = false;
                _local_18 = 0;
                while (_local_18 < colSpanChildren.length)
                {
                    if (_local_19.child == colSpanChildren[_local_18].child)
                    {
                        _local_31 = true;
                        break;
                    };
                    _local_18++;
                };
                if (!_local_31)
                {
                    colSpanChildren.push(_local_19);
                };
            };
            _local_20 = false;
            var _local_24:ContentRowChild = new ContentRowChild();
            var _local_25:Number = 0;
            var _local_26:Number = 0;
            var _local_27:Number = 0;
            var _local_28:Number = 0;
            _local_18 = 0;
            while (_local_18 < IConstraintLayout(target).constraintRows.length)
            {
                _local_32 = IConstraintLayout(target).constraintRows[_local_18];
                if (_local_32.mx_internal::contentSize)
                {
                    if (_local_32.id == _local_13)
                    {
                        _local_24.topRow = _local_32;
                        _local_24.topOffset = _local_6;
                        _local_24.top = (_local_25 = _local_18);
                        _local_20 = true;
                    };
                    if (_local_32.id == _local_14)
                    {
                        _local_24.bottomRow = _local_32;
                        _local_24.bottomOffset = _local_7;
                        _local_24.bottom = (_local_26 = (_local_18 + 1));
                        _local_20 = true;
                    };
                    if (_local_32.id == _local_15)
                    {
                        _local_24.vcRow = _local_32;
                        _local_24.vcOffset = _local_8;
                        _local_24.vc = (_local_27 = (_local_18 + 1));
                        _local_20 = true;
                    };
                    if (_local_32.id == _local_16)
                    {
                        _local_24.baselineRow = _local_32;
                        _local_24.baselineOffset = _local_9;
                        _local_24.baseline = (_local_28 = (_local_18 + 1));
                        _local_20 = true;
                    };
                };
                _local_18++;
            };
            if (_local_20)
            {
                _local_24.child = _arg_1;
                if ((((((_local_24.topRow) && (!(_local_24.bottomRow))) || ((_local_24.bottomRow) && (!(_local_24.topRow)))) || (_local_24.vcRow)) || (_local_24.baselineRow)))
                {
                    _local_24.span = 1;
                }
                else
                {
                    _local_24.span = (_local_26 - _local_25);
                };
                _local_31 = false;
                _local_18 = 0;
                while (_local_18 < rowSpanChildren.length)
                {
                    if (_local_24.child == rowSpanChildren[_local_18].child)
                    {
                        _local_31 = true;
                        break;
                    };
                    _local_18++;
                };
                if (!_local_31)
                {
                    rowSpanChildren.push(_local_24);
                };
            };
            var _local_29:ChildConstraintInfo = new ChildConstraintInfo(_local_3, _local_4, _local_5, _local_6, _local_7, _local_8, _local_9, _local_10, _local_11, _local_12, _local_13, _local_14, _local_15, _local_16);
            constraintCache[_arg_1] = _local_29;
            return (_local_29);
        }

        private function bound(_arg_1:Number, _arg_2:Number, _arg_3:Number):Number
        {
            if (_arg_1 < _arg_2)
            {
                _arg_1 = _arg_2;
            }
            else
            {
                if (_arg_1 > _arg_3)
                {
                    _arg_1 = _arg_3;
                }
                else
                {
                    _arg_1 = Math.floor(_arg_1);
                };
            };
            return (_arg_1);
        }

        private function shareRowSpace(_arg_1:ContentRowChild, _arg_2:Number):Number
        {
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_3:ConstraintRow = _arg_1.topRow;
            var _local_4:ConstraintRow = _arg_1.bottomRow;
            var _local_5:IUIComponent = _arg_1.child;
            var _local_6:Number = 0;
            var _local_7:Number = 0;
            var _local_8:Number = ((_arg_1.topOffset) ? _arg_1.topOffset : 0);
            var _local_9:Number = ((_arg_1.bottomOffset) ? _arg_1.bottomOffset : 0);
            if (((_local_3) && (_local_3.height)))
            {
                _local_6 = (_local_6 + _local_3.height);
            }
            else
            {
                if (((_local_4) && (!(_local_3))))
                {
                    _local_3 = IConstraintLayout(target).constraintRows[(_arg_1.bottom - 2)];
                    if (((_local_3) && (_local_3.height)))
                    {
                        _local_6 = (_local_6 + _local_3.height);
                    };
                };
            };
            if (((_local_4) && (_local_4.height)))
            {
                _local_7 = (_local_7 + _local_4.height);
            }
            else
            {
                if (((_local_3) && (!(_local_4))))
                {
                    _local_4 = IConstraintLayout(target).constraintRows[(_arg_1.top + 1)];
                    if (((_local_4) && (_local_4.height)))
                    {
                        _local_7 = (_local_7 + _local_4.height);
                    };
                };
            };
            if (((_local_3) && (isNaN(_local_3.height))))
            {
                _local_3.setActualHeight(Math.max(0, _local_3.maxHeight));
            };
            if (((_local_4) && (isNaN(_local_4.height))))
            {
                _local_4.setActualHeight(Math.max(0, _local_4.height));
            };
            var _local_10:Number = _local_5.getExplicitOrMeasuredHeight();
            if (_local_10)
            {
                if (!_arg_1.topRow)
                {
                    if (_local_10 > _local_6)
                    {
                        _local_12 = ((_local_10 - _local_6) + _local_9);
                    }
                    else
                    {
                        _local_12 = (_local_10 + _local_9);
                    };
                };
                if (!_arg_1.bottomRow)
                {
                    if (_local_10 > _local_7)
                    {
                        _local_11 = ((_local_10 - _local_7) + _local_8);
                    }
                    else
                    {
                        _local_11 = (_local_10 + _local_8);
                    };
                };
                if (((_arg_1.topRow) && (_arg_1.bottomRow)))
                {
                    _local_13 = (_local_10 / Number(_arg_1.span));
                    if ((_local_13 + _local_8) < _local_6)
                    {
                        _local_11 = _local_6;
                        _local_12 = ((_local_10 - (_local_6 - _local_8)) + _local_9);
                    }
                    else
                    {
                        _local_11 = (_local_13 + _local_8);
                    };
                    if ((_local_13 + _local_9) < _local_7)
                    {
                        _local_12 = _local_7;
                        _local_11 = ((_local_10 - (_local_7 - _local_9)) + _local_8);
                    }
                    else
                    {
                        _local_12 = (_local_13 + _local_9);
                    };
                };
                _local_12 = bound(_local_12, _local_4.minHeight, _local_4.maxHeight);
                _local_4.setActualHeight(_local_12);
                _arg_2 = (_arg_2 - _local_12);
                _local_11 = bound(_local_11, _local_3.minHeight, _local_3.maxHeight);
                _local_3.setActualHeight(_local_11);
                _arg_2 = (_arg_2 - _local_11);
            };
            return (_arg_2);
        }

        private function parseConstraintExp(_arg_1:String):Array
        {
            if (!_arg_1)
            {
                return (null);
            };
            var _local_2:String = _arg_1.replace(/:/g, " ");
            return (_local_2.split(/\s+/));
        }

        private function measureColumnsAndRows():void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_13:ConstraintColumn;
            var _local_14:ConstraintRow;
            var _local_15:Number;
            var _local_16:Number;
            var _local_17:Number;
            var _local_18:Number;
            var _local_19:ContentColumnChild;
            var _local_20:ContentRowChild;
            var _local_1:Array = IConstraintLayout(target).constraintColumns;
            var _local_2:Array = IConstraintLayout(target).constraintRows;
            if ((((!(_local_2.length)) > 0) && ((!(_local_1.length)) > 0)))
            {
                constraintRegionsInUse = false;
                return;
            };
            constraintRegionsInUse = true;
            var _local_5:Number = 0;
            var _local_6:Number = 0;
            var _local_7:EdgeMetrics = Container(target).viewMetrics;
            var _local_8:Number = ((Container(target).width - _local_7.left) - _local_7.right);
            var _local_9:Number = ((Container(target).height - _local_7.top) - _local_7.bottom);
            var _local_10:Array = [];
            var _local_11:Array = [];
            var _local_12:Array = [];
            if (_local_1.length > 0)
            {
                _local_3 = 0;
                while (_local_3 < _local_1.length)
                {
                    _local_13 = _local_1[_local_3];
                    if (!isNaN(_local_13.percentWidth))
                    {
                        _local_11.push(_local_13);
                    }
                    else
                    {
                        if (((!(isNaN(_local_13.width))) && (!(_local_13.mx_internal::contentSize))))
                        {
                            _local_10.push(_local_13);
                        }
                        else
                        {
                            _local_12.push(_local_13);
                            _local_13.mx_internal::contentSize = true;
                        };
                    };
                    _local_3++;
                };
                _local_3 = 0;
                while (_local_3 < _local_10.length)
                {
                    _local_13 = ConstraintColumn(_local_10[_local_3]);
                    _local_8 = (_local_8 - _local_13.width);
                    _local_3++;
                };
                if (_local_12.length > 0)
                {
                    if (colSpanChildren.length > 0)
                    {
                        colSpanChildren.sortOn("span");
                        _local_4 = 0;
                        while (_local_4 < colSpanChildren.length)
                        {
                            _local_19 = colSpanChildren[_local_4];
                            if (_local_19.span == 1)
                            {
                                if (_local_19.hcCol)
                                {
                                    _local_13 = ConstraintColumn(_local_1[_local_1.indexOf(_local_19.hcCol)]);
                                }
                                else
                                {
                                    if (_local_19.leftCol)
                                    {
                                        _local_13 = ConstraintColumn(_local_1[_local_1.indexOf(_local_19.leftCol)]);
                                    }
                                    else
                                    {
                                        if (_local_19.rightCol)
                                        {
                                            _local_13 = ConstraintColumn(_local_1[_local_1.indexOf(_local_19.rightCol)]);
                                        };
                                    };
                                };
                                _local_16 = _local_19.child.getExplicitOrMeasuredWidth();
                                if (_local_19.hcOffset)
                                {
                                    _local_16 = (_local_16 + _local_19.hcOffset);
                                }
                                else
                                {
                                    if (_local_19.leftOffset)
                                    {
                                        _local_16 = (_local_16 + _local_19.leftOffset);
                                    };
                                    if (_local_19.rightOffset)
                                    {
                                        _local_16 = (_local_16 + _local_19.rightOffset);
                                    };
                                };
                                if (!isNaN(_local_13.width))
                                {
                                    _local_16 = Math.max(_local_13.width, _local_16);
                                };
                                _local_16 = bound(_local_16, _local_13.minWidth, _local_13.maxWidth);
                                _local_13.setActualWidth(_local_16);
                                _local_8 = (_local_8 - _local_13.width);
                            }
                            else
                            {
                                _local_8 = shareColumnSpace(_local_19, _local_8);
                            };
                            _local_4++;
                        };
                        colSpanChildren = [];
                    };
                    _local_3 = 0;
                    while (_local_3 < _local_12.length)
                    {
                        _local_13 = _local_12[_local_3];
                        if (!_local_13.width)
                        {
                            _local_16 = bound(0, _local_13.minWidth, 0);
                            _local_13.setActualWidth(_local_16);
                        };
                        _local_3++;
                    };
                };
                _local_18 = _local_8;
                _local_3 = 0;
                while (_local_3 < _local_11.length)
                {
                    _local_13 = ConstraintColumn(_local_11[_local_3]);
                    if (_local_18 <= 0)
                    {
                        _local_16 = 0;
                    }
                    else
                    {
                        _local_16 = Math.round(((_local_18 * _local_13.percentWidth) / 100));
                    };
                    _local_16 = bound(_local_16, _local_13.minWidth, _local_13.maxWidth);
                    _local_13.setActualWidth(_local_16);
                    _local_8 = (_local_8 - _local_16);
                    _local_3++;
                };
                _local_3 = 0;
                while (_local_3 < _local_1.length)
                {
                    _local_13 = ConstraintColumn(_local_1[_local_3]);
                    _local_13.x = _local_5;
                    _local_5 = (_local_5 + _local_13.width);
                    _local_3++;
                };
            };
            _local_10 = [];
            _local_11 = [];
            _local_12 = [];
            if (_local_2.length > 0)
            {
                _local_3 = 0;
                while (_local_3 < _local_2.length)
                {
                    _local_14 = _local_2[_local_3];
                    if (!isNaN(_local_14.percentHeight))
                    {
                        _local_11.push(_local_14);
                    }
                    else
                    {
                        if (((!(isNaN(_local_14.height))) && (!(_local_14.mx_internal::contentSize))))
                        {
                            _local_10.push(_local_14);
                        }
                        else
                        {
                            _local_12.push(_local_14);
                            _local_14.mx_internal::contentSize = true;
                        };
                    };
                    _local_3++;
                };
                _local_3 = 0;
                while (_local_3 < _local_10.length)
                {
                    _local_14 = ConstraintRow(_local_10[_local_3]);
                    _local_9 = (_local_9 - _local_14.height);
                    _local_3++;
                };
                if (_local_12.length > 0)
                {
                    if (rowSpanChildren.length > 0)
                    {
                        rowSpanChildren.sortOn("span");
                        _local_4 = 0;
                        while (_local_4 < rowSpanChildren.length)
                        {
                            _local_20 = rowSpanChildren[_local_4];
                            if (_local_20.span == 1)
                            {
                                if (_local_20.vcRow)
                                {
                                    _local_14 = ConstraintRow(_local_2[_local_2.indexOf(_local_20.vcRow)]);
                                }
                                else
                                {
                                    if (_local_20.baselineRow)
                                    {
                                        _local_14 = ConstraintRow(_local_2[_local_2.indexOf(_local_20.baselineRow)]);
                                    }
                                    else
                                    {
                                        if (_local_20.topRow)
                                        {
                                            _local_14 = ConstraintRow(_local_2[_local_2.indexOf(_local_20.topRow)]);
                                        }
                                        else
                                        {
                                            if (_local_20.bottomRow)
                                            {
                                                _local_14 = ConstraintRow(_local_2[_local_2.indexOf(_local_20.bottomRow)]);
                                            };
                                        };
                                    };
                                };
                                _local_17 = _local_20.child.getExplicitOrMeasuredHeight();
                                if (_local_20.baselineOffset)
                                {
                                    _local_17 = (_local_17 + _local_20.baselineOffset);
                                }
                                else
                                {
                                    if (_local_20.vcOffset)
                                    {
                                        _local_17 = (_local_17 + _local_20.vcOffset);
                                    }
                                    else
                                    {
                                        if (_local_20.topOffset)
                                        {
                                            _local_17 = (_local_17 + _local_20.topOffset);
                                        };
                                        if (_local_20.bottomOffset)
                                        {
                                            _local_17 = (_local_17 + _local_20.bottomOffset);
                                        };
                                    };
                                };
                                if (!isNaN(_local_14.height))
                                {
                                    _local_17 = Math.max(_local_14.height, _local_17);
                                };
                                _local_17 = bound(_local_17, _local_14.minHeight, _local_14.maxHeight);
                                _local_14.setActualHeight(_local_17);
                                _local_9 = (_local_9 - _local_14.height);
                            }
                            else
                            {
                                _local_9 = shareRowSpace(_local_20, _local_9);
                            };
                            _local_4++;
                        };
                        rowSpanChildren = [];
                    };
                    _local_3 = 0;
                    while (_local_3 < _local_12.length)
                    {
                        _local_14 = ConstraintRow(_local_12[_local_3]);
                        if (!_local_14.height)
                        {
                            _local_17 = bound(0, _local_14.minHeight, 0);
                            _local_14.setActualHeight(_local_17);
                        };
                        _local_3++;
                    };
                };
                _local_18 = _local_9;
                _local_3 = 0;
                while (_local_3 < _local_11.length)
                {
                    _local_14 = ConstraintRow(_local_11[_local_3]);
                    if (_local_18 <= 0)
                    {
                        _local_17 = 0;
                    }
                    else
                    {
                        _local_17 = Math.round(((_local_18 * _local_14.percentHeight) / 100));
                    };
                    _local_17 = bound(_local_17, _local_14.minHeight, _local_14.maxHeight);
                    _local_14.setActualHeight(_local_17);
                    _local_9 = (_local_9 - _local_17);
                    _local_3++;
                };
                _local_3 = 0;
                while (_local_3 < _local_2.length)
                {
                    _local_14 = _local_2[_local_3];
                    _local_14.y = _local_6;
                    _local_6 = (_local_6 + _local_14.height);
                    _local_3++;
                };
            };
        }

        private function child_moveHandler(_arg_1:MoveEvent):void
        {
            if ((_arg_1.target is IUIComponent))
            {
                if (!IUIComponent(_arg_1.target).includeInLayout)
                {
                    return;
                };
            };
            var _local_2:Container = super.target;
            if (_local_2)
            {
                _local_2.invalidateSize();
                _local_2.invalidateDisplayList();
                _contentArea = null;
            };
        }

        private function applyAnchorStylesDuringMeasure(_arg_1:IUIComponent, _arg_2:Rectangle):void
        {
            var _local_13:int;
            var _local_3:IConstraintClient = (_arg_1 as IConstraintClient);
            if (!_local_3)
            {
                return;
            };
            var _local_4:ChildConstraintInfo = constraintCache[_local_3];
            if (!_local_4)
            {
                _local_4 = parseConstraints(_arg_1);
            };
            var _local_5:Number = _local_4.left;
            var _local_6:Number = _local_4.right;
            var _local_7:Number = _local_4.hc;
            var _local_8:Number = _local_4.top;
            var _local_9:Number = _local_4.bottom;
            var _local_10:Number = _local_4.vc;
            var _local_11:Array = IConstraintLayout(target).constraintColumns;
            var _local_12:Array = IConstraintLayout(target).constraintRows;
            var _local_14:Number = 0;
            if ((!(_local_11.length)) > 0)
            {
                if (!isNaN(_local_7))
                {
                    _arg_2.x = Math.round((((target.width - _arg_1.width) / 2) + _local_7));
                }
                else
                {
                    if (((!(isNaN(_local_5))) && (!(isNaN(_local_6)))))
                    {
                        _arg_2.x = _local_5;
                        _arg_2.width = (_arg_2.width + _local_6);
                    }
                    else
                    {
                        if (!isNaN(_local_5))
                        {
                            _arg_2.x = _local_5;
                        }
                        else
                        {
                            if (!isNaN(_local_6))
                            {
                                _arg_2.x = 0;
                                _arg_2.width = (_arg_2.width + _local_6);
                            };
                        };
                    };
                };
            }
            else
            {
                _arg_2.x = 0;
                _local_13 = 0;
                while (_local_13 < _local_11.length)
                {
                    _local_14 = (_local_14 + ConstraintColumn(_local_11[_local_13]).width);
                    _local_13++;
                };
                _arg_2.width = _local_14;
            };
            if ((!(_local_12.length)) > 0)
            {
                if (!isNaN(_local_10))
                {
                    _arg_2.y = Math.round((((target.height - _arg_1.height) / 2) + _local_10));
                }
                else
                {
                    if (((!(isNaN(_local_8))) && (!(isNaN(_local_9)))))
                    {
                        _arg_2.y = _local_8;
                        _arg_2.height = (_arg_2.height + _local_9);
                    }
                    else
                    {
                        if (!isNaN(_local_8))
                        {
                            _arg_2.y = _local_8;
                        }
                        else
                        {
                            if (!isNaN(_local_9))
                            {
                                _arg_2.y = 0;
                                _arg_2.height = (_arg_2.height + _local_9);
                            };
                        };
                    };
                };
            }
            else
            {
                _local_14 = 0;
                _arg_2.y = 0;
                _local_13 = 0;
                while (_local_13 < _local_12.length)
                {
                    _local_14 = (_local_14 + ConstraintRow(_local_12[_local_13]).height);
                    _local_13++;
                };
                _arg_2.height = _local_14;
            };
        }

        override public function measure():void
        {
            var _local_1:Container;
            var _local_5:EdgeMetrics;
            var _local_6:Rectangle;
            var _local_7:IUIComponent;
            var _local_8:ConstraintColumn;
            var _local_9:ConstraintRow;
            _local_1 = super.target;
            var _local_2:Number = 0;
            var _local_3:Number = 0;
            var _local_4:Number = 0;
            _local_5 = _local_1.viewMetrics;
            _local_4 = 0;
            while (_local_4 < _local_1.numChildren)
            {
                _local_7 = (_local_1.getChildAt(_local_4) as IUIComponent);
                parseConstraints(_local_7);
                _local_4++;
            };
            _local_4 = 0;
            while (_local_4 < IConstraintLayout(_local_1).constraintColumns.length)
            {
                _local_8 = IConstraintLayout(_local_1).constraintColumns[_local_4];
                if (_local_8.mx_internal::contentSize)
                {
                    _local_8.mx_internal::_width = NaN;
                };
                _local_4++;
            };
            _local_4 = 0;
            while (_local_4 < IConstraintLayout(_local_1).constraintRows.length)
            {
                _local_9 = IConstraintLayout(_local_1).constraintRows[_local_4];
                if (_local_9.mx_internal::contentSize)
                {
                    _local_9.mx_internal::_height = NaN;
                };
                _local_4++;
            };
            measureColumnsAndRows();
            _contentArea = null;
            _local_6 = measureContentArea();
            _local_1.measuredWidth = ((_local_6.width + _local_5.left) + _local_5.right);
            _local_1.measuredHeight = ((_local_6.height + _local_5.top) + _local_5.bottom);
        }

        private function target_childRemoveHandler(_arg_1:ChildExistenceChangedEvent):void
        {
            DisplayObject(_arg_1.relatedObject).removeEventListener(MoveEvent.MOVE, child_moveHandler);
            delete constraintCache[_arg_1.relatedObject];
        }

        override public function set target(_arg_1:Container):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_2:Container = super.target;
            if (_arg_1 != _local_2)
            {
                if (_local_2)
                {
                    _local_2.removeEventListener(ChildExistenceChangedEvent.CHILD_ADD, target_childAddHandler);
                    _local_2.removeEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, target_childRemoveHandler);
                    _local_4 = _local_2.numChildren;
                    _local_3 = 0;
                    while (_local_3 < _local_4)
                    {
                        DisplayObject(_local_2.getChildAt(_local_3)).removeEventListener(MoveEvent.MOVE, child_moveHandler);
                        _local_3++;
                    };
                };
                if (_arg_1)
                {
                    _arg_1.addEventListener(ChildExistenceChangedEvent.CHILD_ADD, target_childAddHandler);
                    _arg_1.addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, target_childRemoveHandler);
                    _local_4 = _arg_1.numChildren;
                    _local_3 = 0;
                    while (_local_3 < _local_4)
                    {
                        DisplayObject(_arg_1.getChildAt(_local_3)).addEventListener(MoveEvent.MOVE, child_moveHandler);
                        _local_3++;
                    };
                };
                super.target = _arg_1;
            };
        }

        private function measureContentArea():Rectangle
        {
            var _local_1:int;
            var _local_3:Array;
            var _local_4:Array;
            var _local_5:IUIComponent;
            var _local_6:LayoutConstraints;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:Number;
            if (_contentArea)
            {
                return (_contentArea);
            };
            _contentArea = new Rectangle();
            var _local_2:int = target.numChildren;
            if (((_local_2 == 0) && (constraintRegionsInUse)))
            {
                _local_3 = IConstraintLayout(target).constraintColumns;
                _local_4 = IConstraintLayout(target).constraintRows;
                if (_local_3.length > 0)
                {
                    _contentArea.right = (_local_3[(_local_3.length - 1)].x + _local_3[(_local_3.length - 1)].width);
                }
                else
                {
                    _contentArea.right = 0;
                };
                if (_local_4.length > 0)
                {
                    _contentArea.bottom = (_local_4[(_local_4.length - 1)].y + _local_4[(_local_4.length - 1)].height);
                }
                else
                {
                    _contentArea.bottom = 0;
                };
            };
            _local_1 = 0;
            while (_local_1 < _local_2)
            {
                _local_5 = (target.getChildAt(_local_1) as IUIComponent);
                _local_6 = getLayoutConstraints(_local_5);
                if (_local_5.includeInLayout)
                {
                    _local_7 = _local_5.x;
                    _local_8 = _local_5.y;
                    _local_9 = _local_5.getExplicitOrMeasuredWidth();
                    _local_10 = _local_5.getExplicitOrMeasuredHeight();
                    if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                    {
                        if (((!(isNaN(_local_5.percentWidth))) || (((_local_6) && (!(isNaN(_local_6.left)))) && (!(isNaN(_local_6.right))))))
                        {
                            _local_9 = _local_5.minWidth;
                        };
                    }
                    else
                    {
                        if (((!(isNaN(_local_5.percentWidth))) || ((((_local_6) && (!(isNaN(_local_6.left)))) && (!(isNaN(_local_6.right)))) && (isNaN(_local_5.explicitWidth)))))
                        {
                            _local_9 = _local_5.minWidth;
                        };
                    };
                    if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                    {
                        if (((!(isNaN(_local_5.percentHeight))) || (((_local_6) && (!(isNaN(_local_6.top)))) && (!(isNaN(_local_6.bottom))))))
                        {
                            _local_10 = _local_5.minHeight;
                        };
                    }
                    else
                    {
                        if (((!(isNaN(_local_5.percentHeight))) || ((((_local_6) && (!(isNaN(_local_6.top)))) && (!(isNaN(_local_6.bottom)))) && (isNaN(_local_5.explicitHeight)))))
                        {
                            _local_10 = _local_5.minHeight;
                        };
                    };
                    r.x = _local_7;
                    r.y = _local_8;
                    r.width = _local_9;
                    r.height = _local_10;
                    applyAnchorStylesDuringMeasure(_local_5, r);
                    _local_7 = r.x;
                    _local_8 = r.y;
                    _local_9 = r.width;
                    _local_10 = r.height;
                    if (isNaN(_local_7))
                    {
                        _local_7 = _local_5.x;
                    };
                    if (isNaN(_local_8))
                    {
                        _local_8 = _local_5.y;
                    };
                    _local_11 = _local_7;
                    _local_12 = _local_8;
                    if (isNaN(_local_9))
                    {
                        _local_9 = _local_5.width;
                    };
                    if (isNaN(_local_10))
                    {
                        _local_10 = _local_5.height;
                    };
                    _local_11 = (_local_11 + _local_9);
                    _local_12 = (_local_12 + _local_10);
                    _contentArea.right = Math.max(_contentArea.right, _local_11);
                    _contentArea.bottom = Math.max(_contentArea.bottom, _local_12);
                };
                _local_1++;
            };
            return (_contentArea);
        }

        private function shareColumnSpace(_arg_1:ContentColumnChild, _arg_2:Number):Number
        {
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_3:ConstraintColumn = _arg_1.leftCol;
            var _local_4:ConstraintColumn = _arg_1.rightCol;
            var _local_5:IUIComponent = _arg_1.child;
            var _local_6:Number = 0;
            var _local_7:Number = 0;
            var _local_8:Number = ((_arg_1.rightOffset) ? _arg_1.rightOffset : 0);
            var _local_9:Number = ((_arg_1.leftOffset) ? _arg_1.leftOffset : 0);
            if (((_local_3) && (_local_3.width)))
            {
                _local_6 = (_local_6 + _local_3.width);
            }
            else
            {
                if (((_local_4) && (!(_local_3))))
                {
                    _local_3 = IConstraintLayout(target).constraintColumns[(_arg_1.right - 2)];
                    if (((_local_3) && (_local_3.width)))
                    {
                        _local_6 = (_local_6 + _local_3.width);
                    };
                };
            };
            if (((_local_4) && (_local_4.width)))
            {
                _local_7 = (_local_7 + _local_4.width);
            }
            else
            {
                if (((_local_3) && (!(_local_4))))
                {
                    _local_4 = IConstraintLayout(target).constraintColumns[(_arg_1.left + 1)];
                    if (((_local_4) && (_local_4.width)))
                    {
                        _local_7 = (_local_7 + _local_4.width);
                    };
                };
            };
            if (((_local_3) && (isNaN(_local_3.width))))
            {
                _local_3.setActualWidth(Math.max(0, _local_3.maxWidth));
            };
            if (((_local_4) && (isNaN(_local_4.width))))
            {
                _local_4.setActualWidth(Math.max(0, _local_4.maxWidth));
            };
            var _local_10:Number = _local_5.getExplicitOrMeasuredWidth();
            if (_local_10)
            {
                if (!_arg_1.leftCol)
                {
                    if (_local_10 > _local_6)
                    {
                        _local_12 = ((_local_10 - _local_6) + _local_8);
                    }
                    else
                    {
                        _local_12 = (_local_10 + _local_8);
                    };
                };
                if (!_arg_1.rightCol)
                {
                    if (_local_10 > _local_7)
                    {
                        _local_11 = ((_local_10 - _local_7) + _local_9);
                    }
                    else
                    {
                        _local_11 = (_local_10 + _local_9);
                    };
                };
                if (((_arg_1.leftCol) && (_arg_1.rightCol)))
                {
                    _local_13 = (_local_10 / Number(_arg_1.span));
                    if ((_local_13 + _local_9) < _local_6)
                    {
                        _local_11 = _local_6;
                        _local_12 = ((_local_10 - (_local_6 - _local_9)) + _local_8);
                    }
                    else
                    {
                        _local_11 = (_local_13 + _local_9);
                    };
                    if ((_local_13 + _local_8) < _local_7)
                    {
                        _local_12 = _local_7;
                        _local_11 = ((_local_10 - (_local_7 - _local_8)) + _local_9);
                    }
                    else
                    {
                        _local_12 = (_local_13 + _local_8);
                    };
                };
                _local_11 = bound(_local_11, _local_3.minWidth, _local_3.maxWidth);
                _local_3.setActualWidth(_local_11);
                _arg_2 = (_arg_2 - _local_11);
                _local_12 = bound(_local_12, _local_4.minWidth, _local_4.maxWidth);
                _local_4.setActualWidth(_local_12);
                _arg_2 = (_arg_2 - _local_12);
            };
            return (_arg_2);
        }

        private function getLayoutConstraints(_arg_1:IUIComponent):LayoutConstraints
        {
            var _local_2:IConstraintClient = (_arg_1 as IConstraintClient);
            if (!_local_2)
            {
                return (null);
            };
            var _local_3:LayoutConstraints = new LayoutConstraints();
            _local_3.baseline = _local_2.getConstraintValue("baseline");
            _local_3.bottom = _local_2.getConstraintValue("bottom");
            _local_3.horizontalCenter = _local_2.getConstraintValue("horizontalCenter");
            _local_3.left = _local_2.getConstraintValue("left");
            _local_3.right = _local_2.getConstraintValue("right");
            _local_3.top = _local_2.getConstraintValue("top");
            _local_3.verticalCenter = _local_2.getConstraintValue("verticalCenter");
            return (_local_3);
        }

        override public function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:int;
            var _local_4:IUIComponent;
            var _local_10:ConstraintColumn;
            var _local_11:ConstraintRow;
            var _local_5:Container = super.target;
            var _local_6:int = _local_5.numChildren;
            _local_5.mx_internal::doingLayout = false;
            var _local_7:EdgeMetrics = _local_5.viewMetrics;
            _local_5.mx_internal::doingLayout = true;
            var _local_8:Number = ((_arg_1 - _local_7.left) - _local_7.right);
            var _local_9:Number = ((_arg_2 - _local_7.top) - _local_7.bottom);
            if (((IConstraintLayout(_local_5).constraintColumns.length > 0) || (IConstraintLayout(_local_5).constraintRows.length > 0)))
            {
                constraintRegionsInUse = true;
            };
            if (constraintRegionsInUse)
            {
                _local_3 = 0;
                while (_local_3 < _local_6)
                {
                    _local_4 = (_local_5.getChildAt(_local_3) as IUIComponent);
                    parseConstraints(_local_4);
                    _local_3++;
                };
                _local_3 = 0;
                while (_local_3 < IConstraintLayout(_local_5).constraintColumns.length)
                {
                    _local_10 = IConstraintLayout(_local_5).constraintColumns[_local_3];
                    if (_local_10.mx_internal::contentSize)
                    {
                        _local_10.mx_internal::_width = NaN;
                    };
                    _local_3++;
                };
                _local_3 = 0;
                while (_local_3 < IConstraintLayout(_local_5).constraintRows.length)
                {
                    _local_11 = IConstraintLayout(_local_5).constraintRows[_local_3];
                    if (_local_11.mx_internal::contentSize)
                    {
                        _local_11.mx_internal::_height = NaN;
                    };
                    _local_3++;
                };
                measureColumnsAndRows();
            };
            _local_3 = 0;
            while (_local_3 < _local_6)
            {
                _local_4 = (_local_5.getChildAt(_local_3) as IUIComponent);
                applyAnchorStylesDuringUpdateDisplayList(_local_8, _local_9, _local_4);
                _local_3++;
            };
        }

        private function applyAnchorStylesDuringUpdateDisplayList(_arg_1:Number, _arg_2:Number, _arg_3:IUIComponent=null):void
        {
            var _local_20:int;
            var _local_21:Number;
            var _local_22:Number;
            var _local_23:Number;
            var _local_24:Number;
            var _local_25:String;
            var _local_34:Number;
            var _local_35:Number;
            var _local_36:Number;
            var _local_37:Number;
            var _local_38:Number;
            var _local_39:Boolean;
            var _local_40:Boolean;
            var _local_41:Boolean;
            var _local_42:ConstraintColumn;
            var _local_43:Boolean;
            var _local_44:Boolean;
            var _local_45:Boolean;
            var _local_46:Boolean;
            var _local_47:ConstraintRow;
            var _local_4:IConstraintClient = (_arg_3 as IConstraintClient);
            if (!_local_4)
            {
                return;
            };
            var _local_5:ChildConstraintInfo = parseConstraints(_arg_3);
            var _local_6:Number = _local_5.left;
            var _local_7:Number = _local_5.right;
            var _local_8:Number = _local_5.hc;
            var _local_9:Number = _local_5.top;
            var _local_10:Number = _local_5.bottom;
            var _local_11:Number = _local_5.vc;
            var _local_12:Number = _local_5.baseline;
            var _local_13:String = _local_5.leftBoundary;
            var _local_14:String = _local_5.rightBoundary;
            var _local_15:String = _local_5.hcBoundary;
            var _local_16:String = _local_5.topBoundary;
            var _local_17:String = _local_5.bottomBoundary;
            var _local_18:String = _local_5.vcBoundary;
            var _local_19:String = _local_5.baselineBoundary;
            var _local_26:Boolean;
            var _local_27:Boolean;
            var _local_28:Boolean = (((!(_local_15)) && (!(_local_13))) && (!(_local_14)));
            var _local_29:Boolean = ((((!(_local_18)) && (!(_local_16))) && (!(_local_17))) && (!(_local_19)));
            var _local_30:Number = 0;
            var _local_31:Number = _arg_1;
            var _local_32:Number = 0;
            var _local_33:Number = _arg_2;
            if (!_local_28)
            {
                _local_39 = ((_local_13) ? true : false);
                _local_40 = ((_local_14) ? true : false);
                _local_41 = ((_local_15) ? true : false);
                _local_20 = 0;
                while (_local_20 < IConstraintLayout(target).constraintColumns.length)
                {
                    _local_42 = ConstraintColumn(IConstraintLayout(target).constraintColumns[_local_20]);
                    if (_local_39)
                    {
                        if (_local_13 == _local_42.id)
                        {
                            _local_30 = _local_42.x;
                            _local_39 = false;
                        };
                    };
                    if (_local_40)
                    {
                        if (_local_14 == _local_42.id)
                        {
                            _local_31 = (_local_42.x + _local_42.width);
                            _local_40 = false;
                        };
                    };
                    if (_local_41)
                    {
                        if (_local_15 == _local_42.id)
                        {
                            _local_35 = _local_42.width;
                            _local_37 = _local_42.x;
                            _local_41 = false;
                        };
                    };
                    _local_20++;
                };
                if (_local_39)
                {
                    _local_25 = resourceManager.getString("containers", "columnNotFound", [_local_13]);
                    throw (new ConstraintError(_local_25));
                };
                if (_local_40)
                {
                    _local_25 = resourceManager.getString("containers", "columnNotFound", [_local_14]);
                    throw (new ConstraintError(_local_25));
                };
                if (_local_41)
                {
                    _local_25 = resourceManager.getString("containers", "columnNotFound", [_local_15]);
                    throw (new ConstraintError(_local_25));
                };
            }
            else
            {
                if (!_local_28)
                {
                    _local_25 = resourceManager.getString("containers", "noColumnsFound");
                    throw (new ConstraintError(_local_25));
                };
            };
            _arg_1 = Math.round((_local_31 - _local_30));
            if (((!(isNaN(_local_6))) && (!(isNaN(_local_7)))))
            {
                _local_21 = ((_arg_1 - _local_6) - _local_7);
                if (_local_21 < _arg_3.minWidth)
                {
                    _local_21 = _arg_3.minWidth;
                };
            }
            else
            {
                if (!isNaN(_arg_3.percentWidth))
                {
                    _local_21 = ((_arg_3.percentWidth / 100) * _arg_1);
                    _local_21 = bound(_local_21, _arg_3.minWidth, _arg_3.maxWidth);
                    _local_26 = true;
                }
                else
                {
                    _local_21 = _arg_3.getExplicitOrMeasuredWidth();
                };
            };
            if (((!(_local_29)) && (IConstraintLayout(target).constraintRows.length > 0)))
            {
                _local_43 = ((_local_16) ? true : false);
                _local_44 = ((_local_17) ? true : false);
                _local_45 = ((_local_18) ? true : false);
                _local_46 = ((_local_19) ? true : false);
                _local_20 = 0;
                while (_local_20 < IConstraintLayout(target).constraintRows.length)
                {
                    _local_47 = ConstraintRow(IConstraintLayout(target).constraintRows[_local_20]);
                    if (_local_43)
                    {
                        if (_local_16 == _local_47.id)
                        {
                            _local_32 = _local_47.y;
                            _local_43 = false;
                        };
                    };
                    if (_local_44)
                    {
                        if (_local_17 == _local_47.id)
                        {
                            _local_33 = (_local_47.y + _local_47.height);
                            _local_44 = false;
                        };
                    };
                    if (_local_45)
                    {
                        if (_local_18 == _local_47.id)
                        {
                            _local_34 = _local_47.height;
                            _local_36 = _local_47.y;
                            _local_45 = false;
                        };
                    };
                    if (_local_46)
                    {
                        if (_local_19 == _local_47.id)
                        {
                            _local_38 = _local_47.y;
                            _local_46 = false;
                        };
                    };
                    _local_20++;
                };
                if (_local_43)
                {
                    _local_25 = resourceManager.getString("containers", "rowNotFound", [_local_16]);
                    throw (new ConstraintError(_local_25));
                };
                if (_local_44)
                {
                    _local_25 = resourceManager.getString("containers", "rowNotFound", [_local_17]);
                    throw (new ConstraintError(_local_25));
                };
                if (_local_45)
                {
                    _local_25 = resourceManager.getString("containers", "rowNotFound", [_local_18]);
                    throw (new ConstraintError(_local_25));
                };
                if (_local_46)
                {
                    _local_25 = resourceManager.getString("containers", "rowNotFound", [_local_19]);
                    throw (new ConstraintError(_local_25));
                };
            }
            else
            {
                if (((!(_local_29)) && (!(IConstraintLayout(target).constraintRows.length > 0))))
                {
                    _local_25 = resourceManager.getString("containers", "noRowsFound");
                    throw (new ConstraintError(_local_25));
                };
            };
            _arg_2 = Math.round((_local_33 - _local_32));
            if (((!(isNaN(_local_9))) && (!(isNaN(_local_10)))))
            {
                _local_22 = ((_arg_2 - _local_9) - _local_10);
                if (_local_22 < _arg_3.minHeight)
                {
                    _local_22 = _arg_3.minHeight;
                };
            }
            else
            {
                if (!isNaN(_arg_3.percentHeight))
                {
                    _local_22 = ((_arg_3.percentHeight / 100) * _arg_2);
                    _local_22 = bound(_local_22, _arg_3.minHeight, _arg_3.maxHeight);
                    _local_27 = true;
                }
                else
                {
                    _local_22 = _arg_3.getExplicitOrMeasuredHeight();
                };
            };
            if (!isNaN(_local_8))
            {
                if (_local_15)
                {
                    _local_23 = Math.round(((((_local_35 - _local_21) / 2) + _local_8) + _local_37));
                }
                else
                {
                    _local_23 = Math.round((((_arg_1 - _local_21) / 2) + _local_8));
                };
            }
            else
            {
                if (!isNaN(_local_6))
                {
                    if (_local_13)
                    {
                        _local_23 = (_local_30 + _local_6);
                    }
                    else
                    {
                        _local_23 = _local_6;
                    };
                }
                else
                {
                    if (!isNaN(_local_7))
                    {
                        if (_local_14)
                        {
                            _local_23 = ((_local_31 - _local_7) - _local_21);
                        }
                        else
                        {
                            _local_23 = ((_arg_1 - _local_7) - _local_21);
                        };
                    };
                };
            };
            if (!isNaN(_local_12))
            {
                if (_local_19)
                {
                    _local_24 = ((_local_38 - _arg_3.baselinePosition) + _local_12);
                }
                else
                {
                    _local_24 = _local_12;
                };
            };
            if (!isNaN(_local_11))
            {
                if (_local_18)
                {
                    _local_24 = Math.round(((((_local_34 - _local_22) / 2) + _local_11) + _local_36));
                }
                else
                {
                    _local_24 = Math.round((((_arg_2 - _local_22) / 2) + _local_11));
                };
            }
            else
            {
                if (!isNaN(_local_9))
                {
                    if (_local_16)
                    {
                        _local_24 = (_local_32 + _local_9);
                    }
                    else
                    {
                        _local_24 = _local_9;
                    };
                }
                else
                {
                    if (!isNaN(_local_10))
                    {
                        if (_local_17)
                        {
                            _local_24 = ((_local_33 - _local_10) - _local_22);
                        }
                        else
                        {
                            _local_24 = ((_arg_2 - _local_10) - _local_22);
                        };
                    };
                };
            };
            _local_23 = ((isNaN(_local_23)) ? _arg_3.x : _local_23);
            _local_24 = ((isNaN(_local_24)) ? _arg_3.y : _local_24);
            _arg_3.move(_local_23, _local_24);
            if (_local_26)
            {
                if ((_local_23 + _local_21) > _arg_1)
                {
                    _local_21 = Math.max((_arg_1 - _local_23), _arg_3.minWidth);
                };
            };
            if (_local_27)
            {
                if ((_local_24 + _local_22) > _arg_2)
                {
                    _local_22 = Math.max((_arg_2 - _local_24), _arg_3.minHeight);
                };
            };
            if (((!(isNaN(_local_21))) && (!(isNaN(_local_22)))))
            {
                _arg_3.setActualSize(_local_21, _local_22);
            };
        }

        private function target_childAddHandler(_arg_1:ChildExistenceChangedEvent):void
        {
            DisplayObject(_arg_1.relatedObject).addEventListener(MoveEvent.MOVE, child_moveHandler);
        }


    }
}//package mx.containers.utilityClasses

import mx.containers.utilityClasses.ConstraintColumn;
import mx.core.IUIComponent;
import mx.containers.utilityClasses.ConstraintRow;

class LayoutConstraints 
{

    public var baseline:*;
    public var left:*;
    public var bottom:*;
    public var top:*;
    public var horizontalCenter:*;
    public var verticalCenter:*;
    public var right:*;

    public function LayoutConstraints():void
    {
    }

}

class ChildConstraintInfo 
{

    public var baseline:Number;
    public var left:Number;
    public var baselineBoundary:String;
    public var leftBoundary:String;
    public var hcBoundary:String;
    public var top:Number;
    public var right:Number;
    public var topBoundary:String;
    public var rightBoundary:String;
    public var bottom:Number;
    public var vc:Number;
    public var bottomBoundary:String;
    public var vcBoundary:String;
    public var hc:Number;

    public function ChildConstraintInfo(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:String=null, _arg_9:String=null, _arg_10:String=null, _arg_11:String=null, _arg_12:String=null, _arg_13:String=null, _arg_14:String=null):void
    {
        this.left = _arg_1;
        this.right = _arg_2;
        this.hc = _arg_3;
        this.top = _arg_4;
        this.bottom = _arg_5;
        this.vc = _arg_6;
        this.baseline = _arg_7;
        this.leftBoundary = _arg_8;
        this.rightBoundary = _arg_9;
        this.hcBoundary = _arg_10;
        this.topBoundary = _arg_11;
        this.bottomBoundary = _arg_12;
        this.vcBoundary = _arg_13;
        this.baselineBoundary = _arg_14;
    }

}

class ContentColumnChild 
{

    public var rightCol:ConstraintColumn;
    public var hcCol:ConstraintColumn;
    public var left:Number;
    public var child:IUIComponent;
    public var rightOffset:Number;
    public var span:Number;
    public var hcOffset:Number;
    public var leftCol:ConstraintColumn;
    public var leftOffset:Number;
    public var hc:Number;
    public var right:Number;

    public function ContentColumnChild():void
    {
    }

}

class ContentRowChild 
{

    public var topRow:ConstraintRow;
    public var topOffset:Number;
    public var baseline:Number;
    public var baselineRow:ConstraintRow;
    public var span:Number;
    public var top:Number;
    public var vcOffset:Number;
    public var child:IUIComponent;
    public var bottomOffset:Number;
    public var bottom:Number;
    public var vc:Number;
    public var bottomRow:ConstraintRow;
    public var vcRow:ConstraintRow;
    public var baselineOffset:Number;

    public function ContentRowChild():void
    {
    }

}


