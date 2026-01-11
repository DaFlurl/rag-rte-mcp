// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.ProgressBar

package mx.controls
{
    import mx.core.UIComponent;
    import mx.core.IFontContextComponent;
    import mx.core.IUITextField;
    import mx.core.IFlexDisplayObject;
    import flash.utils.Timer;
    import flash.events.Event;
    import mx.core.FlexVersion;
    import flash.display.DisplayObject;
    import mx.core.UITextField;
    import flash.events.IEventDispatcher;
    import flash.events.ProgressEvent;
    import flash.events.TimerEvent;
    import flash.text.TextLineMetrics;
    import mx.core.IFlexModuleFactory;
    import mx.styles.ISimpleStyleClient;
    import flash.display.Graphics;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ProgressBar extends UIComponent implements IFontContextComponent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _direction:String = "right";
        private var stopPolledMode:Boolean = false;
        mx_internal var _labelField:IUITextField;
        mx_internal var _determinateBar:IFlexDisplayObject;
        private var sourceChanged:Boolean = false;
        private var _interval:Number = 30;
        private var trackSkinChanged:Boolean = false;
        mx_internal var _content:UIComponent;
        private var _source:Object;
        mx_internal var _track:IFlexDisplayObject;
        mx_internal var _bar:UIComponent;
        mx_internal var _barMask:IFlexDisplayObject;
        private var barSkinChanged:Boolean = false;
        private var _stringSource:String;
        private var _labelPlacement:String = "bottom";
        private var _value:Number = 0;
        private var indeterminateChanged:Boolean = true;
        private var _mode:String = "event";
        private var stringSourceChanged:Boolean = false;
        private var modeChanged:Boolean = false;
        private var _conversion:Number = 1;
        mx_internal var _indeterminateBar:IFlexDisplayObject;
        private var indeterminateSkinChanged:Boolean = false;
        private var _indeterminate:Boolean = false;
        private var pollTimer:Timer;
        private var _minimum:Number = 0;
        private var labelOverride:String;
        private var _maximum:Number = 0;
        private var visibleChanged:Boolean = false;
        private var indeterminatePlaying:Boolean = false;
        private var _label:String;

        public function ProgressBar()
        {
            pollTimer = new Timer(_interval);
            cacheAsBitmap = true;
        }

        [Bindable("minimumChanged")]
        public function get minimum():Number
        {
            return (_minimum);
        }

        [Bindable("conversionChanged")]
        public function get conversion():Number
        {
            return (_conversion);
        }

        private function completeHandler(_arg_1:Event):void
        {
            dispatchEvent(_arg_1);
            invalidateDisplayList();
        }

        [Bindable("sourceChanged")]
        public function get source():Object
        {
            return (_source);
        }

        public function set minimum(_arg_1:Number):void
        {
            if ((((!(isNaN(_arg_1))) && (_mode == ProgressBarMode.MANUAL)) && (!(_arg_1 == _minimum))))
            {
                _minimum = _arg_1;
                invalidateDisplayList();
                dispatchEvent(new Event("minimumChanged"));
            };
        }

        [Bindable("maximumChanged")]
        public function get maximum():Number
        {
            return (_maximum);
        }

        override protected function createChildren():void
        {
            var _local_1:Class;
            super.createChildren();
            if (!_content)
            {
                _content = new UIComponent();
                addChild(_content);
            };
            if (!_bar)
            {
                _bar = new UIComponent();
                _content.addChild(_bar);
            };
            if (!_barMask)
            {
                if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
                {
                    _local_1 = getStyle("maskSkin");
                    _barMask = new (_local_1)();
                }
                else
                {
                    _barMask = new UIComponent();
                };
                _barMask.visible = true;
                _bar.addChild(DisplayObject(_barMask));
                UIComponent(_bar).mask = DisplayObject(_barMask);
            };
            if (!_labelField)
            {
                _labelField = IUITextField(createInFontContext(UITextField));
                _labelField.styleName = this;
                addChild(DisplayObject(_labelField));
            };
        }

        public function set source(value:Object):void
        {
            if ((value is String))
            {
                _stringSource = String(value);
                try
                {
                    value = document[_stringSource];
                }
                catch(e:Error)
                {
                    stringSourceChanged = true;
                };
            };
            if (((_source) && (_source is IEventDispatcher)))
            {
                removeSourceListeners();
            };
            if (value)
            {
                _source = value;
                sourceChanged = true;
                modeChanged = true;
                indeterminateChanged = true;
                invalidateProperties();
                invalidateDisplayList();
            }
            else
            {
                if (_source != null)
                {
                    _source = null;
                    sourceChanged = true;
                    indeterminateChanged = true;
                    invalidateProperties();
                    invalidateDisplayList();
                    pollTimer.reset();
                };
            };
        }

        public function set conversion(_arg_1:Number):void
        {
            if ((((!(isNaN(_arg_1))) && (Number(_arg_1) > 0)) && (!(_arg_1 == _conversion))))
            {
                _conversion = Number(_arg_1);
                invalidateDisplayList();
                dispatchEvent(new Event("conversionChanged"));
            };
        }

        public function set maximum(_arg_1:Number):void
        {
            if ((((!(isNaN(_arg_1))) && (_mode == ProgressBarMode.MANUAL)) && (!(_arg_1 == _maximum))))
            {
                _maximum = _arg_1;
                invalidateDisplayList();
                dispatchEvent(new Event("maximumChanged"));
            };
        }

        public function set mode(_arg_1:String):void
        {
            if (_arg_1 != _mode)
            {
                if (_mode == ProgressBarMode.POLLED)
                {
                    stopPolledMode = true;
                };
                _mode = _arg_1;
                modeChanged = true;
                indeterminateChanged = true;
                invalidateProperties();
                invalidateDisplayList();
            };
        }

        private function removeSourceListeners():void
        {
            _source.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
            _source.removeEventListener(Event.COMPLETE, completeHandler);
        }

        private function stopPlayingIndeterminate():void
        {
            if (indeterminatePlaying)
            {
                indeterminatePlaying = false;
                pollTimer.removeEventListener(TimerEvent.TIMER, updateIndeterminateHandler);
                if (_mode != ProgressBarMode.POLLED)
                {
                    pollTimer.reset();
                };
            };
        }

        [Bindable("labelPlacementChanged")]
        public function get labelPlacement():String
        {
            return (_labelPlacement);
        }

        private function progressHandler(_arg_1:ProgressEvent):void
        {
            _setProgress(_arg_1.bytesLoaded, _arg_1.bytesTotal);
        }

        override protected function measure():void
        {
            var _local_1:Number;
            var _local_2:Number;
            super.measure();
            var _local_3:Number = NaN;
            var _local_4:Number = NaN;
            var _local_5:Number = getStyle("trackHeight");
            var _local_6:Number = _track.measuredWidth;
            var _local_7:Number = ((isNaN(_local_5)) ? _track.measuredHeight : _local_5);
            var _local_8:Number = getStyle("horizontalGap");
            var _local_9:Number = getStyle("verticalGap");
            var _local_10:Number = getStyle("paddingLeft");
            var _local_11:Number = getStyle("paddingRight");
            var _local_12:Number = getStyle("paddingTop");
            var _local_13:Number = getStyle("paddingBottom");
            var _local_14:Number = getStyle("labelWidth");
            var _local_15:TextLineMetrics = measureText(predictLabelText());
            var _local_16:Number = ((isNaN(_local_14)) ? (_local_15.width + UITextField.TEXT_WIDTH_PADDING) : _local_14);
            var _local_17:Number = (_local_15.height + UITextField.TEXT_HEIGHT_PADDING);
            switch (labelPlacement)
            {
                case ProgressBarLabelPlacement.LEFT:
                case ProgressBarLabelPlacement.RIGHT:
                    _local_1 = ((((_local_16 + _local_6) + _local_10) + _local_11) + _local_8);
                    _local_2 = ((Math.max(_local_17, _local_7) + _local_12) + _local_13);
                    measuredMinWidth = _local_1;
                    break;
                case ProgressBarLabelPlacement.CENTER:
                    _local_1 = (((Math.max(_local_16, _local_6) + _local_10) + _local_11) + _local_8);
                    _local_2 = ((Math.max(_local_17, _local_7) + _local_12) + _local_13);
                    measuredMinWidth = _local_16;
                    break;
                default:
                    _local_1 = ((Math.max(_local_16, _local_6) + _local_10) + _local_11);
                    _local_2 = ((((_local_17 + _local_7) + _local_12) + _local_13) + _local_9);
                    measuredMinWidth = _local_16;
            };
            measuredWidth = _local_1;
            measuredMinHeight = (measuredHeight = _local_2);
            if (!isNaN(_local_3))
            {
                measuredMinWidth = _local_3;
            };
            if (!isNaN(_local_4))
            {
                measuredMinHeight = _local_4;
            };
        }

        public function get fontContext():IFlexModuleFactory
        {
            return (moduleFactory);
        }

        private function predictLabelText():String
        {
            var _local_2:Number;
            if (label == null)
            {
                return ("");
            };
            var _local_1:String = label;
            if (_maximum != 0)
            {
                _local_2 = _maximum;
            }
            else
            {
                _local_2 = 100000;
            };
            if (_local_1)
            {
                if (_indeterminate)
                {
                    _local_1 = _local_1.replace("%1", String(Math.floor((_local_2 / _conversion))));
                    _local_1 = _local_1.replace("%2", "??");
                    _local_1 = _local_1.replace("%3", "");
                    _local_1 = _local_1.replace("%%", "");
                }
                else
                {
                    _local_1 = _local_1.replace("%1", String(Math.floor((_local_2 / _conversion))));
                    _local_1 = _local_1.replace("%2", String(Math.floor((_local_2 / _conversion))));
                    _local_1 = _local_1.replace("%3", "100");
                    _local_1 = _local_1.replace("%%", "%");
                };
            };
            var _local_3:String = getFullLabelText();
            if (_local_1.length > _local_3.length)
            {
                return (_local_1);
            };
            return (_local_3);
        }

        [Bindable("change")]
        public function get value():Number
        {
            return (_value);
        }

        public function set indeterminate(_arg_1:Boolean):void
        {
            _indeterminate = _arg_1;
            indeterminateChanged = true;
            invalidateProperties();
            invalidateDisplayList();
            dispatchEvent(new Event("indeterminateChanged"));
        }

        private function createBar():void
        {
            if (_determinateBar)
            {
                _bar.removeChild(DisplayObject(_determinateBar));
                _determinateBar = null;
            };
            var _local_1:Class = getStyle("barSkin");
            if (_local_1)
            {
                _determinateBar = new (_local_1)();
                if ((_determinateBar is ISimpleStyleClient))
                {
                    ISimpleStyleClient(_determinateBar).styleName = this;
                };
                _bar.addChild(DisplayObject(_determinateBar));
            };
        }

        private function createIndeterminateBar():void
        {
            if (_indeterminateBar)
            {
                _bar.removeChild(DisplayObject(_indeterminateBar));
                _indeterminateBar = null;
            };
            var _local_1:Class = getStyle("indeterminateSkin");
            if (_local_1)
            {
                _indeterminateBar = new (_local_1)();
                if ((_indeterminateBar is ISimpleStyleClient))
                {
                    ISimpleStyleClient(_indeterminateBar).styleName = this;
                };
                _indeterminateBar.visible = false;
                _bar.addChild(DisplayObject(_indeterminateBar));
            };
        }

        [Bindable("directionChanged")]
        public function get direction():String
        {
            return (_direction);
        }

        private function addSourceListeners():void
        {
            _source.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            _source.addEventListener(Event.COMPLETE, completeHandler);
        }

        private function updateIndeterminateHandler(_arg_1:Event):void
        {
            if (_indeterminateBar.x < 1)
            {
                _indeterminateBar.x = (_indeterminateBar.x + 1);
            }
            else
            {
                _indeterminateBar.x = -(getStyle("indeterminateMoveInterval") - 2);
            };
        }

        private function updatePolledHandler(_arg_1:Event):void
        {
            var _local_2:Object;
            var _local_3:Number;
            var _local_4:Number;
            if (_source)
            {
                _local_2 = _source;
                _local_3 = _local_2.bytesLoaded;
                _local_4 = _local_2.bytesTotal;
                if (((!(isNaN(_local_3))) && (!(isNaN(_local_4)))))
                {
                    _setProgress(_local_3, _local_4);
                    if (((percentComplete >= 100) && (_value > 0)))
                    {
                        pollTimer.reset();
                    };
                };
            };
        }

        public function set labelPlacement(_arg_1:String):void
        {
            if (_arg_1 != _labelPlacement)
            {
                _labelPlacement = _arg_1;
            };
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("labelPlacementChanged"));
        }

        [Bindable("modeChanged")]
        public function get mode():String
        {
            return (_mode);
        }

        [Bindable("progress")]
        public function get percentComplete():Number
        {
            if (((_value < _minimum) || (_maximum < _minimum)))
            {
                return (0);
            };
            if ((_maximum - _minimum) == 0)
            {
                return (0);
            };
            var _local_1:Number = ((100 * (_value - _minimum)) / (_maximum - _minimum));
            if (((isNaN(_local_1)) || (_local_1 < 0)))
            {
                return (0);
            };
            if (_local_1 > 100)
            {
                return (100);
            };
            return (_local_1);
        }

        public function setProgress(_arg_1:Number, _arg_2:Number):void
        {
            if (_mode == ProgressBarMode.MANUAL)
            {
                _setProgress(_arg_1, _arg_2);
            };
        }

        private function createTrack():void
        {
            if (_track)
            {
                _content.removeChild(DisplayObject(_track));
                _track = null;
            };
            var _local_1:Class = getStyle("trackSkin");
            if (_local_1)
            {
                _track = new (_local_1)();
                if ((_track is ISimpleStyleClient))
                {
                    ISimpleStyleClient(_track).styleName = this;
                };
                _content.addChildAt(DisplayObject(_track), 0);
            };
        }

        [Bindable("indeterminateChanged")]
        public function get indeterminate():Boolean
        {
            return (_indeterminate);
        }

        private function startPlayingIndeterminate():void
        {
            if (!indeterminatePlaying)
            {
                indeterminatePlaying = true;
                pollTimer.addEventListener(TimerEvent.TIMER, updateIndeterminateHandler, false, 0, true);
                pollTimer.start();
            };
        }

        override public function styleChanged(_arg_1:String):void
        {
            var _local_2:Boolean;
            super.styleChanged(_arg_1);
            if (((_arg_1 == null) || (_arg_1 == "styleName")))
            {
                barSkinChanged = (trackSkinChanged = (indeterminateSkinChanged = true));
                _local_2 = true;
            }
            else
            {
                if (_arg_1 == "barSkin")
                {
                    barSkinChanged = true;
                    _local_2 = true;
                }
                else
                {
                    if (_arg_1 == "trackSkin")
                    {
                        trackSkinChanged = true;
                        _local_2 = true;
                    }
                    else
                    {
                        if (_arg_1 == "indeterminateSkin")
                        {
                            indeterminateSkinChanged = true;
                            _local_2 = true;
                        };
                    };
                };
            };
            if (_local_2)
            {
                invalidateProperties();
                invalidateSize();
                invalidateDisplayList();
            };
        }

        private function getFullLabelText():String
        {
            var _local_1:Number = Math.max(_value, 0);
            var _local_2:Number = Math.max(_maximum, 0);
            var _local_3:String = label;
            if (_local_3)
            {
                if (_indeterminate)
                {
                    _local_3 = _local_3.replace("%1", String(Math.floor((_local_1 / _conversion))));
                    _local_3 = _local_3.replace("%2", "??");
                    _local_3 = _local_3.replace("%3", "");
                    _local_3 = _local_3.replace("%%", "");
                }
                else
                {
                    _local_3 = _local_3.replace("%1", String(Math.floor((_local_1 / _conversion))));
                    _local_3 = _local_3.replace("%2", String(Math.floor((_local_2 / _conversion))));
                    _local_3 = _local_3.replace("%3", String(Math.floor(percentComplete)));
                    _local_3 = _local_3.replace("%%", "%");
                };
            };
            return (_local_3);
        }

        override protected function commitProperties():void
        {
            var index:int;
            super.commitProperties();
            if (((hasFontContextChanged()) && (!(_labelField == null))))
            {
                index = getChildIndex(DisplayObject(_labelField));
                removeChild(DisplayObject(_labelField));
                _labelField = IUITextField(createInFontContext(UITextField));
                _labelField.styleName = this;
                addChildAt(DisplayObject(_labelField), index);
            };
            if (trackSkinChanged)
            {
                trackSkinChanged = false;
                createTrack();
            };
            if (barSkinChanged)
            {
                barSkinChanged = false;
                createBar();
            };
            if (indeterminateSkinChanged)
            {
                indeterminateSkinChanged = false;
                createIndeterminateBar();
            };
            if (stringSourceChanged)
            {
                stringSourceChanged = false;
                try
                {
                    _source = document[_stringSource];
                }
                catch(e:Error)
                {
                };
            };
            if (sourceChanged)
            {
                sourceChanged = false;
                dispatchEvent(new Event("sourceChanged"));
            };
            if (modeChanged)
            {
                modeChanged = false;
                if (_source)
                {
                    if (_mode == ProgressBarMode.EVENT)
                    {
                        if ((_source is IEventDispatcher))
                        {
                            addSourceListeners();
                        }
                        else
                        {
                            _source = null;
                        };
                    }
                    else
                    {
                        if ((_source is IEventDispatcher))
                        {
                            removeSourceListeners();
                        };
                    };
                };
                if (_mode == ProgressBarMode.POLLED)
                {
                    pollTimer.addEventListener(TimerEvent.TIMER, updatePolledHandler, false, 0, true);
                    pollTimer.start();
                }
                else
                {
                    if (stopPolledMode)
                    {
                        stopPolledMode = false;
                        pollTimer.removeEventListener(TimerEvent.TIMER, updatePolledHandler);
                        pollTimer.reset();
                    };
                };
                dispatchEvent(new Event("modeChanged"));
            };
        }

        override protected function resourcesChanged():void
        {
            super.resourcesChanged();
            label = labelOverride;
        }

        public function set fontContext(_arg_1:IFlexModuleFactory):void
        {
            this.moduleFactory = _arg_1;
        }

        override public function set visible(_arg_1:Boolean):void
        {
            super.visible = _arg_1;
            visibleChanged = true;
            invalidateDisplayList();
        }

        public function set label(_arg_1:String):void
        {
            labelOverride = _arg_1;
            _label = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("controls", "label"));
            invalidateDisplayList();
            dispatchEvent(new Event("labelChanged"));
        }

        override protected function childrenCreated():void
        {
            super.childrenCreated();
            trackSkinChanged = true;
            barSkinChanged = true;
            indeterminateSkinChanged = true;
        }

        private function layoutContent(_arg_1:Number, _arg_2:Number):void
        {
            _track.move(0, 0);
            _track.setActualSize(_arg_1, _arg_2);
            _bar.move(0, 0);
            _determinateBar.move(0, 0);
            _indeterminateBar.setActualSize((_arg_1 + getStyle("indeterminateMoveInterval")), _arg_2);
        }

        private function _setProgress(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:ProgressEvent;
            if ((((enabled) && (!(isNaN(_arg_1)))) && (!(isNaN(_arg_2)))))
            {
                _value = _arg_1;
                _maximum = _arg_2;
                dispatchEvent(new Event(Event.CHANGE));
                _local_3 = new ProgressEvent(ProgressEvent.PROGRESS);
                _local_3.bytesLoaded = _arg_1;
                _local_3.bytesTotal = _arg_2;
                dispatchEvent(_local_3);
                if (_indeterminate)
                {
                    startPlayingIndeterminate();
                };
                if (((_value == _maximum) && (_value > 0)))
                {
                    if (_indeterminate)
                    {
                        stopPlayingIndeterminate();
                    };
                    if (mode != ProgressBarMode.EVENT)
                    {
                        dispatchEvent(new Event(Event.COMPLETE));
                    };
                };
                invalidateDisplayList();
            };
        }

        [Bindable("labelChanged")]
        public function get label():String
        {
            return (_label);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_16:Number;
            var _local_17:Graphics;
            var _local_18:Number;
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Number = getStyle("horizontalGap");
            var _local_4:Number = getStyle("verticalGap");
            var _local_5:Number = getStyle("paddingLeft");
            var _local_6:Number = getStyle("paddingRight");
            var _local_7:Number = getStyle("paddingTop");
            var _local_8:Number = getStyle("paddingBottom");
            var _local_9:Number = _local_5;
            var _local_10:Number = _local_7;
            var _local_11:Number = getStyle("labelWidth");
            var _local_12:Number = getStyle("trackHeight");
            _local_12 = ((isNaN(_local_12)) ? _track.measuredHeight : _local_12);
            var _local_13:TextLineMetrics = measureText(predictLabelText());
            var _local_14:Number = ((isNaN(_local_11)) ? (_local_13.width + UITextField.TEXT_WIDTH_PADDING) : _local_11);
            var _local_15:Number = (_local_13.height + UITextField.TEXT_HEIGHT_PADDING);
            switch (labelPlacement)
            {
                case ProgressBarLabelPlacement.TOP:
                    _labelField.move(_local_9, _local_10);
                    _labelField.setActualSize(_local_14, _local_15);
                    _content.move(_local_9, ((_local_10 + _local_15) + _local_4));
                    layoutContent(((_arg_1 - _local_9) - _local_6), _local_12);
                    break;
                case ProgressBarLabelPlacement.RIGHT:
                    _local_16 = ((((_arg_1 - _local_9) - _local_6) - _local_14) - _local_3);
                    _labelField.move(((_local_9 + _local_16) + _local_3), ((_arg_2 - _local_15) / 2));
                    _labelField.setActualSize(_local_14, _local_15);
                    _content.move(_local_9, (_local_10 + ((_local_15 - _local_12) / 2)));
                    layoutContent(_local_16, _local_12);
                    break;
                case ProgressBarLabelPlacement.LEFT:
                    _labelField.move(_local_9, (_local_10 + ((_arg_2 - _local_15) / 2)));
                    _labelField.setActualSize(_local_14, _local_15);
                    _content.move(((_local_9 + _local_14) + _local_3), (_local_10 + ((_local_15 - _local_12) / 2)));
                    layoutContent(((((_arg_1 - _local_9) - _local_14) - _local_4) - _local_6), _local_12);
                    break;
                case ProgressBarLabelPlacement.CENTER:
                    _labelField.move(((_arg_1 - _local_14) / 2), ((_arg_2 - _local_15) / 2));
                    _labelField.setActualSize(_local_14, _local_15);
                    _content.move(_local_9, _local_10);
                    layoutContent((_arg_1 - _local_6), (_arg_2 - _local_8));
                    break;
                default:
                    _labelField.move(_local_9, ((_local_10 + _local_12) + _local_4));
                    _labelField.setActualSize(_local_14, _local_15);
                    _content.move(_local_9, _local_10);
                    layoutContent(((_arg_1 - _local_9) - _local_6), _local_12);
            };
            if (_barMask)
            {
                _barMask.move(0, 0);
                if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
                {
                    _barMask.setActualSize(_track.width, _track.height);
                }
                else
                {
                    _local_17 = UIComponent(_barMask).graphics;
                    _local_17.clear();
                    _local_17.beginFill(0xFFFF00);
                    _local_17.drawRect(1, 1, (_track.width - 2), (_track.height - 2));
                    _local_17.endFill();
                };
            };
            _labelField.text = getFullLabelText();
            _indeterminateBar.visible = _indeterminate;
            if (((indeterminateChanged) || (visibleChanged)))
            {
                indeterminateChanged = false;
                visibleChanged = false;
                _indeterminateBar.visible = _indeterminate;
                if (((((_indeterminate) && (_source == null)) && (_mode == ProgressBarMode.EVENT)) && (visible)))
                {
                    startPlayingIndeterminate();
                }
                else
                {
                    stopPlayingIndeterminate();
                };
            };
            if (_indeterminate)
            {
                _determinateBar.setActualSize(_track.width, _track.height);
            }
            else
            {
                _local_18 = Math.max(0, ((_track.width * percentComplete) / 100));
                _determinateBar.setActualSize(_local_18, _track.height);
                _determinateBar.x = ((direction == ProgressBarDirection.RIGHT) ? 0 : (_track.width - _local_18));
            };
        }

        public function set direction(_arg_1:String):void
        {
            if (((_arg_1 == ProgressBarDirection.LEFT) || (_arg_1 == ProgressBarDirection.RIGHT)))
            {
                _direction = _arg_1;
            };
            invalidateDisplayList();
            dispatchEvent(new Event("directionChanged"));
        }


    }
}//package mx.controls

