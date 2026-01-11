// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.ViewStack

package mx.containers
{
    import mx.core.Container;
    import mx.managers.IHistoryManagerClient;
    import mx.graphics.RoundedRectangle;
    import mx.events.ChildExistenceChangedEvent;
    import mx.core.EdgeMetrics;
    import flash.display.DisplayObject;
    import mx.core.ContainerCreationPolicy;
    import mx.events.IndexChangedEvent;
    import mx.effects.Effect;
    import mx.effects.EffectManager;
    import mx.events.EffectEvent;
    import mx.events.FlexEvent;
    import mx.core.IInvalidating;
    import mx.core.UIComponent;
    import mx.core.ScrollPolicy;
    import mx.core.IUIComponent;
    import mx.automation.IAutomationObject;
    import mx.managers.HistoryManager;
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ViewStack extends Container implements IHistoryManagerClient 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var dispatchChangeEventPending:Boolean = false;
        private var historyManagementEnabledChanged:Boolean = false;
        mx_internal var vsPreferredHeight:Number;
        private var initialSelectedIndex:int = -1;
        private var firstTime:Boolean = true;
        mx_internal var _historyManagementEnabled:Boolean = false;
        private var overlayChild:Container;
        private var overlayTargetArea:RoundedRectangle;
        private var proposedSelectedIndex:int = -1;
        private var needToInstantiateSelectedChild:Boolean = false;
        private var bSaveState:Boolean = false;
        mx_internal var vsMinHeight:Number;
        private var bInLoadState:Boolean = false;
        mx_internal var vsPreferredWidth:Number;
        private var _resizeToContent:Boolean = false;
        mx_internal var vsMinWidth:Number;
        private var lastIndex:int = -1;
        private var _selectedIndex:int = -1;

        public function ViewStack()
        {
            addEventListener(ChildExistenceChangedEvent.CHILD_ADD, childAddHandler);
            addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, childRemoveHandler);
        }

        protected function get contentHeight():Number
        {
            var _local_1:EdgeMetrics = viewMetricsAndPadding;
            return ((unscaledHeight - _local_1.top) - _local_1.bottom);
        }

        public function set selectedChild(_arg_1:Container):void
        {
            var _local_2:int = getChildIndex(DisplayObject(_arg_1));
            if (((_local_2 >= 0) && (_local_2 < numChildren)))
            {
                selectedIndex = _local_2;
            };
        }

        override mx_internal function setActualCreationPolicies(_arg_1:String):void
        {
            var _local_2:int;
            var _local_3:Container;
            super.setActualCreationPolicies(_arg_1);
            if (((_arg_1 == ContainerCreationPolicy.ALL) && (numChildren > 0)))
            {
                _local_2 = 0;
                while (_local_2 < numChildren)
                {
                    _local_3 = (getChildAt(_local_2) as Container);
                    if (((_local_3) && (_local_3.numChildrenCreated == -1)))
                    {
                        _local_3.createComponentsFromDescriptors();
                    };
                    _local_2++;
                };
            };
        }

        private function dispatchChangeEvent(_arg_1:int, _arg_2:int):void
        {
            var _local_3:IndexChangedEvent = new IndexChangedEvent(IndexChangedEvent.CHANGE);
            _local_3.oldIndex = _arg_1;
            _local_3.newIndex = _arg_2;
            _local_3.relatedObject = getChildAt(_arg_2);
            dispatchEvent(_local_3);
        }

        protected function get contentY():Number
        {
            return (getStyle("paddingTop"));
        }

        protected function commitSelectedIndex(_arg_1:int):void
        {
            var _local_3:Container;
            var _local_4:Effect;
            if (numChildren == 0)
            {
                _selectedIndex = -1;
                return;
            };
            if (_arg_1 < 0)
            {
                _arg_1 = 0;
            }
            else
            {
                if (_arg_1 > (numChildren - 1))
                {
                    _arg_1 = (numChildren - 1);
                };
            };
            if (((!(lastIndex == -1)) && (lastIndex < numChildren)))
            {
                Container(getChildAt(lastIndex)).endEffectsStarted();
            };
            if (_selectedIndex != -1)
            {
                selectedChild.endEffectsStarted();
            };
            lastIndex = _selectedIndex;
            if (_arg_1 == lastIndex)
            {
                return;
            };
            _selectedIndex = _arg_1;
            if (initialSelectedIndex == -1)
            {
                initialSelectedIndex = _selectedIndex;
            };
            if (((!(lastIndex == -1)) && (!(_arg_1 == -1))))
            {
                dispatchChangeEventPending = true;
            };
            var _local_2:Boolean;
            if (((!(lastIndex == -1)) && (lastIndex < numChildren)))
            {
                _local_3 = Container(getChildAt(lastIndex));
                _local_3.setVisible(false);
                if (_local_3.getStyle("hideEffect"))
                {
                    _local_4 = EffectManager.lastEffectCreated;
                    if (_local_4)
                    {
                        _local_4.addEventListener(EffectEvent.EFFECT_END, hideEffectEndHandler);
                        _local_2 = true;
                    };
                };
            };
            if (!_local_2)
            {
                hideEffectEndHandler(null);
            };
        }

        private function instantiateSelectedChild():void
        {
            if (!selectedChild)
            {
                return;
            };
            if (((selectedChild) && (selectedChild.numChildrenCreated == -1)))
            {
                if (initialized)
                {
                    selectedChild.addEventListener(FlexEvent.CREATION_COMPLETE, childCreationCompleteHandler);
                };
                selectedChild.createComponentsFromDescriptors(true);
            };
            if ((selectedChild is IInvalidating))
            {
                IInvalidating(selectedChild).invalidateSize();
            };
            invalidateSize();
            invalidateDisplayList();
        }

        private function initializeHandler(_arg_1:FlexEvent):void
        {
            overlayChild.removeEventListener(FlexEvent.INITIALIZE, initializeHandler);
            UIComponent(overlayChild).addOverlay(overlayColor, overlayTargetArea);
        }

        public function set historyManagementEnabled(_arg_1:Boolean):void
        {
            if (_arg_1 != _historyManagementEnabled)
            {
                _historyManagementEnabled = _arg_1;
                historyManagementEnabledChanged = true;
                invalidateProperties();
            };
        }

        override public function get horizontalScrollPolicy():String
        {
            return (ScrollPolicy.OFF);
        }

        private function childAddHandler(_arg_1:ChildExistenceChangedEvent):void
        {
            var _local_4:IUIComponent;
            var _local_2:DisplayObject = _arg_1.relatedObject;
            var _local_3:int = getChildIndex(_local_2);
            if ((_local_2 is IUIComponent))
            {
                _local_4 = IUIComponent(_local_2);
                _local_4.visible = false;
            };
            if (((numChildren == 1) && (proposedSelectedIndex == -1)))
            {
                proposedSelectedIndex = 0;
                invalidateProperties();
            }
            else
            {
                if ((((_local_3 <= selectedIndex) && (numChildren > 1)) && (proposedSelectedIndex == -1)))
                {
                    selectedIndex++;
                };
            };
            if ((_local_2 is IAutomationObject))
            {
                IAutomationObject(_local_2).showInAutomationHierarchy = true;
            };
        }

        private function addedToStageHandler(_arg_1:Event):void
        {
            if (historyManagementEnabled)
            {
                HistoryManager.register(this);
            };
        }

        public function get resizeToContent():Boolean
        {
            return (_resizeToContent);
        }

        public function saveState():Object
        {
            var _local_1:int = ((_selectedIndex == -1) ? 0 : _selectedIndex);
            return ({"selectedIndex":_local_1});
        }

        override public function get autoLayout():Boolean
        {
            return (true);
        }

        override mx_internal function removeOverlay():void
        {
            if (overlayChild)
            {
                UIComponent(overlayChild).removeOverlay();
                overlayChild = null;
            };
        }

        private function removedFromStageHandler(_arg_1:Event):void
        {
            HistoryManager.unregister(this);
        }

        [Bindable("valueCommit")]
        [Bindable("creationComplete")]
        public function get selectedChild():Container
        {
            if (selectedIndex == -1)
            {
                return (null);
            };
            return (Container(getChildAt(selectedIndex)));
        }

        private function hideEffectEndHandler(_arg_1:EffectEvent):void
        {
            if (_arg_1)
            {
                _arg_1.currentTarget.removeEventListener(EffectEvent.EFFECT_END, hideEffectEndHandler);
            };
            needToInstantiateSelectedChild = true;
            invalidateProperties();
            if (bSaveState)
            {
                HistoryManager.save();
                bSaveState = false;
            };
        }

        private function childCreationCompleteHandler(_arg_1:FlexEvent):void
        {
            _arg_1.target.removeEventListener(FlexEvent.CREATION_COMPLETE, childCreationCompleteHandler);
            _arg_1.target.dispatchEvent(new FlexEvent(FlexEvent.SHOW));
        }

        override public function set horizontalScrollPolicy(_arg_1:String):void
        {
        }

        public function get historyManagementEnabled():Boolean
        {
            return (_historyManagementEnabled);
        }

        public function loadState(_arg_1:Object):void
        {
            var _local_2:int = ((_arg_1) ? int(_arg_1.selectedIndex) : 0);
            if (_local_2 == -1)
            {
                _local_2 = initialSelectedIndex;
            };
            if (_local_2 == -1)
            {
                _local_2 = 0;
            };
            if (_local_2 != _selectedIndex)
            {
                bInLoadState = true;
                selectedIndex = _local_2;
                bInLoadState = false;
            };
        }

        protected function get contentWidth():Number
        {
            var _local_1:EdgeMetrics = viewMetricsAndPadding;
            return ((unscaledWidth - _local_1.left) - _local_1.right);
        }

        override protected function commitProperties():void
        {
            super.commitProperties();
            if (historyManagementEnabledChanged)
            {
                if (historyManagementEnabled)
                {
                    HistoryManager.register(this);
                }
                else
                {
                    HistoryManager.unregister(this);
                };
                historyManagementEnabledChanged = false;
            };
            if (proposedSelectedIndex != -1)
            {
                commitSelectedIndex(proposedSelectedIndex);
                proposedSelectedIndex = -1;
            };
            if (needToInstantiateSelectedChild)
            {
                instantiateSelectedChild();
                needToInstantiateSelectedChild = false;
            };
            if (dispatchChangeEventPending)
            {
                dispatchChangeEvent(lastIndex, selectedIndex);
                dispatchChangeEventPending = false;
            };
            if (firstTime)
            {
                firstTime = false;
                addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true);
                addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true);
            };
        }

        public function set resizeToContent(_arg_1:Boolean):void
        {
            if (_arg_1 != _resizeToContent)
            {
                _resizeToContent = _arg_1;
                if (_arg_1)
                {
                    invalidateSize();
                };
            };
        }

        override public function createComponentsFromDescriptors(_arg_1:Boolean=true):void
        {
            if (actualCreationPolicy == ContainerCreationPolicy.ALL)
            {
                super.createComponentsFromDescriptors();
                return;
            };
            var _local_2:int = numChildren;
            var _local_3:int = ((childDescriptors) ? childDescriptors.length : 0);
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                createComponentFromDescriptor(childDescriptors[_local_4], false);
                _local_4++;
            };
            numChildrenCreated = (numChildren - _local_2);
            processedDescriptors = true;
        }

        override protected function measure():void
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            var _local_8:Container;
            super.measure();
            _local_1 = 0;
            _local_2 = 0;
            _local_3 = 0;
            _local_4 = 0;
            if (((vsPreferredWidth) && (!(_resizeToContent))))
            {
                measuredMinWidth = vsMinWidth;
                measuredMinHeight = vsMinHeight;
                measuredWidth = vsPreferredWidth;
                measuredHeight = vsPreferredHeight;
                return;
            };
            if (((numChildren > 0) && (!(selectedIndex == -1))))
            {
                _local_8 = Container(getChildAt(selectedIndex));
                _local_1 = _local_8.minWidth;
                _local_3 = _local_8.getExplicitOrMeasuredWidth();
                _local_2 = _local_8.minHeight;
                _local_4 = _local_8.getExplicitOrMeasuredHeight();
            };
            var _local_5:EdgeMetrics = viewMetricsAndPadding;
            var _local_6:Number = (_local_5.left + _local_5.right);
            _local_1 = (_local_1 + _local_6);
            _local_3 = (_local_3 + _local_6);
            var _local_7:Number = (_local_5.top + _local_5.bottom);
            _local_2 = (_local_2 + _local_7);
            _local_4 = (_local_4 + _local_7);
            measuredMinWidth = _local_1;
            measuredMinHeight = _local_2;
            measuredWidth = _local_3;
            measuredHeight = _local_4;
            if (((selectedChild) && (Container(selectedChild).numChildrenCreated == -1)))
            {
                return;
            };
            if (numChildren == 0)
            {
                return;
            };
            vsMinWidth = _local_1;
            vsMinHeight = _local_2;
            vsPreferredWidth = _local_3;
            vsPreferredHeight = _local_4;
        }

        override public function set verticalScrollPolicy(_arg_1:String):void
        {
        }

        public function set selectedIndex(_arg_1:int):void
        {
            if (_arg_1 == selectedIndex)
            {
                return;
            };
            proposedSelectedIndex = _arg_1;
            invalidateProperties();
            if ((((historyManagementEnabled) && (!(_selectedIndex == -1))) && (!(bInLoadState))))
            {
                bSaveState = true;
            };
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
        }

        override mx_internal function addOverlay(_arg_1:uint, _arg_2:RoundedRectangle=null):void
        {
            if (overlayChild)
            {
                removeOverlay();
            };
            overlayChild = selectedChild;
            if (!overlayChild)
            {
                return;
            };
            overlayColor = _arg_1;
            overlayTargetArea = _arg_2;
            if (((selectedChild) && (selectedChild.numChildrenCreated == -1)))
            {
                selectedChild.addEventListener(FlexEvent.INITIALIZE, initializeHandler);
            }
            else
            {
                initializeHandler(null);
            };
        }

        override public function set autoLayout(_arg_1:Boolean):void
        {
        }

        override public function get verticalScrollPolicy():String
        {
            return (ScrollPolicy.OFF);
        }

        [Bindable("change")]
        [Bindable("valueCommit")]
        [Bindable("creationComplete")]
        public function get selectedIndex():int
        {
            return ((proposedSelectedIndex == -1) ? _selectedIndex : proposedSelectedIndex);
        }

        private function childRemoveHandler(_arg_1:ChildExistenceChangedEvent):void
        {
            var _local_2:DisplayObject = _arg_1.relatedObject;
            var _local_3:int = getChildIndex(_local_2);
            if (_local_3 > selectedIndex)
            {
                return;
            };
            var _local_4:int = selectedIndex;
            if (((_local_3 < _local_4) || (_local_4 == (numChildren - 1))))
            {
                if (_local_4 == 0)
                {
                    selectedIndex = -1;
                    _selectedIndex = -1;
                }
                else
                {
                    selectedIndex--;
                };
            }
            else
            {
                if (_local_3 == _local_4)
                {
                    needToInstantiateSelectedChild = true;
                    invalidateProperties();
                };
            };
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_8:Container;
            var _local_9:Number;
            var _local_10:Number;
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:int = numChildren;
            var _local_4:Number = contentWidth;
            var _local_5:Number = contentHeight;
            var _local_6:Number = contentX;
            var _local_7:Number = contentY;
            if (selectedIndex != -1)
            {
                _local_8 = Container(getChildAt(selectedIndex));
                _local_9 = _local_4;
                _local_10 = _local_5;
                if (!isNaN(_local_8.percentWidth))
                {
                    if (_local_9 > _local_8.maxWidth)
                    {
                        _local_9 = _local_8.maxWidth;
                    };
                }
                else
                {
                    if (_local_9 > _local_8.explicitWidth)
                    {
                        _local_9 = _local_8.explicitWidth;
                    };
                };
                if (!isNaN(_local_8.percentHeight))
                {
                    if (_local_10 > _local_8.maxHeight)
                    {
                        _local_10 = _local_8.maxHeight;
                    };
                }
                else
                {
                    if (_local_10 > _local_8.explicitHeight)
                    {
                        _local_10 = _local_8.explicitHeight;
                    };
                };
                if (((!(_local_8.width == _local_9)) || (!(_local_8.height == _local_10))))
                {
                    _local_8.setActualSize(_local_9, _local_10);
                };
                if (((!(_local_8.x == _local_6)) || (!(_local_8.y == _local_7))))
                {
                    _local_8.move(_local_6, _local_7);
                };
                _local_8.visible = true;
            };
        }

        protected function get contentX():Number
        {
            return (getStyle("paddingLeft"));
        }


    }
}//package mx.containers

