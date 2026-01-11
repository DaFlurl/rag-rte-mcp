// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.NavBar

package mx.controls
{
    import mx.containers.Box;
    import mx.collections.IList;
    import mx.core.IFactory;
    import mx.core.ClassFactory;
    import mx.containers.ViewStack;
    import mx.containers.BoxDirection;
    import mx.core.Container;
    import mx.events.IndexChangedEvent;
    import mx.core.FlexVersion;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import mx.events.ItemClickEvent;
    import flash.display.InteractiveObject;
    import flash.events.MouseEvent;
    import mx.core.ScrollPolicy;
    import mx.events.ChildExistenceChangedEvent;
    import mx.core.UIComponent;
    import mx.core.IFlexDisplayObject;
    import mx.events.CollectionEvent;
    import mx.collections.ArrayCollection;
    import mx.events.FlexEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class NavBar extends Box 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var _labelField:String = "label";
        private var _iconField:String = "icon";
        private var _dataProvider:IList;
        private var measurementHasBeenCalled:Boolean = false;
        private var _toolTipField:String = "toolTip";
        mx_internal var navItemFactory:IFactory = new ClassFactory(Button);
        private var pendingTargetStack:Object;
        private var lastToolTip:String = null;
        private var _labelFunction:Function;
        mx_internal var targetStack:ViewStack;
        private var _selectedIndex:int = -1;
        private var dataProviderChanged:Boolean = false;

        public function NavBar()
        {
            direction = BoxDirection.HORIZONTAL;
            showInAutomationHierarchy = true;
        }

        [Bindable("iconFieldChanged")]
        public function get iconField():String
        {
            return (_iconField);
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            var _local_2:int;
            var _local_3:int;
            if (_arg_1 != enabled)
            {
                super.enabled = _arg_1;
                _local_2 = numChildren;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    if (targetStack)
                    {
                        Button(getChildAt(_local_3)).enabled = ((_arg_1) && (Container(targetStack.getChildAt(_local_3)).enabled));
                    }
                    else
                    {
                        Button(getChildAt(_local_3)).enabled = _arg_1;
                    };
                    _local_3++;
                };
            };
        }

        protected function updateNavItemIcon(_arg_1:int, _arg_2:Class):void
        {
            var _local_3:Button = Button(getChildAt(_arg_1));
            _local_3.setStyle("icon", _arg_2);
        }

        private function childIndexChangeHandler(_arg_1:IndexChangedEvent):void
        {
            if (_arg_1.target == this)
            {
                return;
            };
            setChildIndex(getChildAt(_arg_1.oldIndex), _arg_1.newIndex);
            resetNavItems();
        }

        protected function hiliteSelectedNavItem(_arg_1:int):void
        {
        }

        private function checkPendingTargetStack():void
        {
            if (pendingTargetStack)
            {
                _setTargetViewStack(pendingTargetStack);
                pendingTargetStack = null;
            };
        }

        private function setTargetViewStack(_arg_1:Object):void
        {
            if (((!(measurementHasBeenCalled)) && (_arg_1)))
            {
                pendingTargetStack = _arg_1;
                invalidateProperties();
            }
            else
            {
                _setTargetViewStack(_arg_1);
            };
        }

        override public function get baselinePosition():Number
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                return (super.baselinePosition);
            };
            if (!validateBaselinePosition())
            {
                return (NaN);
            };
            if (numChildren == 0)
            {
                return (super.baselinePosition);
            };
            var _local_1:Button = Button(getChildAt(0));
            validateNow();
            return (_local_1.y + _local_1.baselinePosition);
        }

        private function enabledChangedHandler(_arg_1:Event):void
        {
            var _local_2:int = targetStack.getChildIndex(DisplayObject(_arg_1.target));
            Button(getChildAt(_local_2)).enabled = ((enabled) && (_arg_1.target.enabled));
        }

        private function labelChangedHandler(_arg_1:Event):void
        {
            var _local_2:int = targetStack.getChildIndex(DisplayObject(_arg_1.target));
            updateNavItemLabel(_local_2, Container(_arg_1.target).label);
        }

        override protected function createChildren():void
        {
            super.createChildren();
            if (dataProviderChanged)
            {
                createNavChildren();
                dataProviderChanged = false;
            };
        }

        override public function notifyStyleChangeInChildren(_arg_1:String, _arg_2:Boolean):void
        {
            super.notifyStyleChangeInChildren(_arg_1, true);
        }

        protected function clickHandler(_arg_1:MouseEvent):void
        {
            var _local_2:int = getChildIndex(DisplayObject(_arg_1.currentTarget));
            if (targetStack)
            {
                targetStack.selectedIndex = _local_2;
            };
            _selectedIndex = _local_2;
            var _local_3:ItemClickEvent = new ItemClickEvent(ItemClickEvent.ITEM_CLICK);
            _local_3.label = Button(_arg_1.currentTarget).label;
            _local_3.index = _local_2;
            _local_3.relatedObject = InteractiveObject(_arg_1.currentTarget);
            _local_3.item = ((_dataProvider) ? _dataProvider.getItemAt(_local_2) : null);
            dispatchEvent(_local_3);
            _arg_1.stopImmediatePropagation();
        }

        override public function get horizontalScrollPolicy():String
        {
            return (ScrollPolicy.OFF);
        }

        public function set iconField(_arg_1:String):void
        {
            _iconField = _arg_1;
            if (_dataProvider)
            {
                dataProvider = _dataProvider;
            };
            dispatchEvent(new Event("iconFieldChanged"));
        }

        private function childAddHandler(_arg_1:ChildExistenceChangedEvent):void
        {
            if (_arg_1.target == this)
            {
                return;
            };
            if (_arg_1.relatedObject.parent != targetStack)
            {
                return;
            };
            var _local_2:Container = Container(_arg_1.relatedObject);
            var _local_3:Button = Button(createNavItem(itemToLabel(_local_2), _local_2.icon));
            var _local_4:int = _local_2.parent.getChildIndex(DisplayObject(_local_2));
            setChildIndex(_local_3, _local_4);
            if (_local_2.toolTip)
            {
                _local_3.toolTip = _local_2.toolTip;
                _local_2.toolTip = null;
            };
            _local_2.addEventListener("labelChanged", labelChangedHandler);
            _local_2.addEventListener("iconChanged", iconChangedHandler);
            _local_2.addEventListener("enabledChanged", enabledChangedHandler);
            _local_2.addEventListener("toolTipChanged", toolTipChangedHandler);
            _local_3.enabled = ((enabled) && (_local_2.enabled));
            callLater(resetNavItems);
        }

        public function itemToLabel(data:Object):String
        {
            if (data == null)
            {
                return ("");
            };
            if (labelFunction != null)
            {
                return (labelFunction(data));
            };
            if ((data is XML))
            {
                try
                {
                    if (data[labelField].length() != 0)
                    {
                        data = data[labelField];
                    };
                }
                catch(e:Error)
                {
                };
            }
            else
            {
                if ((data is Object))
                {
                    try
                    {
                        if (data[labelField] != null)
                        {
                            data = data[labelField];
                        };
                    }
                    catch(e:Error)
                    {
                    };
                };
            };
            if ((data is String))
            {
                return (String(data));
            };
            if ((data is Number))
            {
                return (data.toString());
            };
            return ("");
        }

        private function createNavChildren():void
        {
            var item:Object;
            var navItem:Button;
            var label:String;
            var iconValue:Object;
            var icon:Class;
            if (!_dataProvider)
            {
                return;
            };
            var n:int = _dataProvider.length;
            var i:int;
            while (i < n)
            {
                item = _dataProvider.getItemAt(i);
                if (((item is String) && (labelFunction == null)))
                {
                    navItem = Button(createNavItem(String(item)));
                }
                else
                {
                    label = itemToLabel(item);
                    if (iconField)
                    {
                        iconValue = null;
                        try
                        {
                            iconValue = item[iconField];
                        }
                        catch(e:Error)
                        {
                        };
                        icon = ((iconValue is String) ? Class(systemManager.getDefinitionByName(String(iconValue))) : Class(iconValue));
                        navItem = Button(createNavItem(label, icon));
                    }
                    else
                    {
                        navItem = Button(createNavItem(label, null));
                    };
                    if (toolTipField)
                    {
                        try
                        {
                            navItem.toolTip = ((item[toolTipField] === undefined) ? null : item[toolTipField]);
                        }
                        catch(e:Error)
                        {
                        };
                    };
                };
                navItem.enabled = enabled;
                i = (i + 1);
            };
            resetNavItems();
        }

        public function set toolTipField(_arg_1:String):void
        {
            _toolTipField = _arg_1;
            if (_dataProvider)
            {
                dataProvider = _dataProvider;
            };
            dispatchEvent(new Event("toolTipFieldChanged"));
        }

        private function _setTargetViewStack(_arg_1:Object):void
        {
            var _local_2:ViewStack;
            var _local_4:int;
            var _local_5:Container;
            var _local_6:int;
            var _local_7:Button;
            if ((_arg_1 is ViewStack))
            {
                _local_2 = ViewStack(_arg_1);
            }
            else
            {
                if (_arg_1)
                {
                    _local_2 = parentDocument[_arg_1];
                }
                else
                {
                    _local_2 = null;
                };
            };
            if (targetStack)
            {
                targetStack.removeEventListener(ChildExistenceChangedEvent.CHILD_ADD, childAddHandler);
                targetStack.removeEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, childRemoveHandler);
                targetStack.removeEventListener(Event.CHANGE, changeHandler);
                targetStack.removeEventListener(IndexChangedEvent.CHILD_INDEX_CHANGE, childIndexChangeHandler);
                _local_4 = targetStack.numChildren;
                _local_6 = 0;
                while (_local_6 < _local_4)
                {
                    _local_5 = Container(targetStack.getChildAt(_local_6));
                    _local_5.removeEventListener("labelChanged", labelChangedHandler);
                    _local_5.removeEventListener("iconChanged", iconChangedHandler);
                    _local_5.removeEventListener("enabledChanged", enabledChangedHandler);
                    _local_5.removeEventListener("toolTipChanged", toolTipChangedHandler);
                    _local_6++;
                };
            };
            removeAllChildren();
            _selectedIndex = -1;
            targetStack = _local_2;
            if (!targetStack)
            {
                return;
            };
            targetStack.addEventListener(ChildExistenceChangedEvent.CHILD_ADD, childAddHandler);
            targetStack.addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, childRemoveHandler);
            targetStack.addEventListener(Event.CHANGE, changeHandler);
            targetStack.addEventListener(IndexChangedEvent.CHILD_INDEX_CHANGE, childIndexChangeHandler);
            _local_4 = targetStack.numChildren;
            _local_6 = 0;
            while (_local_6 < _local_4)
            {
                _local_5 = Container(targetStack.getChildAt(_local_6));
                _local_7 = Button(createNavItem(itemToLabel(_local_5), _local_5.icon));
                if (_local_5.toolTip)
                {
                    _local_7.toolTip = _local_5.toolTip;
                    _local_5.toolTip = null;
                };
                _local_5.addEventListener("labelChanged", labelChangedHandler);
                _local_5.addEventListener("iconChanged", iconChangedHandler);
                _local_5.addEventListener("enabledChanged", enabledChangedHandler);
                _local_5.addEventListener("toolTipChanged", toolTipChangedHandler);
                _local_7.enabled = ((enabled) && (_local_5.enabled));
                _local_6++;
            };
            var _local_3:int = targetStack.selectedIndex;
            if (((_local_3 == -1) && (targetStack.numChildren > 0)))
            {
                _local_3 = 0;
            };
            if (_local_3 != -1)
            {
                hiliteSelectedNavItem(_local_3);
            };
            resetNavItems();
            invalidateDisplayList();
        }

        private function toolTipChangedHandler(_arg_1:Event):void
        {
            var _local_2:int = targetStack.getChildIndex(DisplayObject(_arg_1.target));
            var _local_3:UIComponent = UIComponent(getChildAt(_local_2));
            if (UIComponent(_arg_1.target).toolTip)
            {
                _local_3.toolTip = UIComponent(_arg_1.target).toolTip;
                lastToolTip = UIComponent(_arg_1.target).toolTip;
                UIComponent(_arg_1.target).toolTip = null;
            }
            else
            {
                if (!lastToolTip)
                {
                    _local_3.toolTip = UIComponent(_arg_1.target).toolTip;
                    lastToolTip = "placeholder";
                    UIComponent(_arg_1.target).toolTip = null;
                }
                else
                {
                    lastToolTip = null;
                };
            };
        }

        protected function createNavItem(_arg_1:String, _arg_2:Class=null):IFlexDisplayObject
        {
            return (null);
        }

        [Bindable("collectionChange")]
        public function get dataProvider():Object
        {
            return ((targetStack) ? targetStack : _dataProvider);
        }

        protected function updateNavItemLabel(_arg_1:int, _arg_2:String):void
        {
            var _local_3:Button = Button(getChildAt(_arg_1));
            _local_3.label = _arg_2;
        }

        override public function set horizontalScrollPolicy(_arg_1:String):void
        {
        }

        override protected function commitProperties():void
        {
            super.commitProperties();
            if (!measurementHasBeenCalled)
            {
                checkPendingTargetStack();
                measurementHasBeenCalled = true;
            };
            if (dataProviderChanged)
            {
                dataProviderChanged = false;
                createNavChildren();
            };
            if (blocker)
            {
                blocker.visible = false;
            };
        }

        public function set labelField(_arg_1:String):void
        {
            _labelField = _arg_1;
            if (_dataProvider)
            {
                dataProvider = _dataProvider;
            };
            dispatchEvent(new Event("labelFieldChanged"));
        }

        private function iconChangedHandler(_arg_1:Event):void
        {
            var _local_2:int = targetStack.getChildIndex(DisplayObject(_arg_1.target));
            updateNavItemIcon(_local_2, Container(_arg_1.target).icon);
        }

        protected function resetNavItems():void
        {
        }

        [Bindable("toolTipFieldChanged")]
        public function get toolTipField():String
        {
            return (_toolTipField);
        }

        public function set labelFunction(_arg_1:Function):void
        {
            _labelFunction = _arg_1;
            if (_dataProvider)
            {
                dataProvider = _dataProvider;
            };
            dispatchEvent(new Event("labelFunctionChanged"));
        }

        [Bindable("labelFieldChanged")]
        public function get labelField():String
        {
            return (_labelField);
        }

        override public function set verticalScrollPolicy(_arg_1:String):void
        {
        }

        private function childRemoveHandler(_arg_1:ChildExistenceChangedEvent):void
        {
            if (_arg_1.target == this)
            {
                return;
            };
            _arg_1.relatedObject.removeEventListener("labelChanged", labelChangedHandler);
            _arg_1.relatedObject.removeEventListener("iconChanged", iconChangedHandler);
            _arg_1.relatedObject.removeEventListener("enabledChanged", enabledChangedHandler);
            _arg_1.relatedObject.removeEventListener("toolTipChanged", toolTipChangedHandler);
            var _local_2:ViewStack = ViewStack(_arg_1.target);
            removeChildAt(_local_2.getChildIndex(_arg_1.relatedObject));
            callLater(resetNavItems);
        }

        [Bindable("labelFunctionChanged")]
        public function get labelFunction():Function
        {
            return (_labelFunction);
        }

        override public function get verticalScrollPolicy():String
        {
            return (ScrollPolicy.OFF);
        }

        public function set dataProvider(_arg_1:Object):void
        {
            var _local_2:String;
            var _local_3:String;
            if ((((((_arg_1) && (!(_arg_1 is String))) && (!(_arg_1 is ViewStack))) && (!(_arg_1 is Array))) && (!(_arg_1 is IList))))
            {
                _local_2 = resourceManager.getString("controls", "errWrongContainer", [id]);
                throw (new Error(_local_2));
            };
            if (_dataProvider)
            {
                _dataProvider.removeEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler);
            };
            if (((_arg_1 is String) && ((document) && (document[_arg_1]))))
            {
                _arg_1 = document[_arg_1];
            };
            if (((_arg_1 is String) || (_arg_1 is ViewStack)))
            {
                setTargetViewStack(_arg_1);
                return;
            };
            if (((((_arg_1 is IList) && (IList(_arg_1).length > 0)) && (IList(_arg_1).getItemAt(0) is DisplayObject)) || (((_arg_1 is Array) && ((_arg_1 as Array).length > 0)) && (_arg_1[0] is DisplayObject))))
            {
                _local_3 = ((id) ? (((className + " '") + id) + "'") : ("a " + className));
                _local_2 = resourceManager.getString("controls", "errWrongType", [_local_3]);
                throw (new Error(_local_2));
            };
            setTargetViewStack(null);
            removeAllChildren();
            if ((_arg_1 is IList))
            {
                _dataProvider = IList(_arg_1);
            }
            else
            {
                if ((_arg_1 is Array))
                {
                    _dataProvider = new ArrayCollection((_arg_1 as Array));
                }
                else
                {
                    _dataProvider = null;
                };
            };
            dataProviderChanged = true;
            invalidateProperties();
            if (_dataProvider)
            {
                _dataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler, false, 0, true);
            };
            if (inheritingStyles == UIComponent.STYLE_UNINITIALIZED)
            {
                return;
            };
            dispatchEvent(new Event("collectionChange"));
        }

        private function changeHandler(_arg_1:Event):void
        {
            if (_arg_1.target == dataProvider)
            {
                hiliteSelectedNavItem(Object(_arg_1.target).selectedIndex);
            };
        }

        private function collectionChangeHandler(_arg_1:Event):void
        {
            dataProvider = dataProvider;
        }

        public function set selectedIndex(_arg_1:int):void
        {
            _selectedIndex = _arg_1;
            if (targetStack)
            {
                targetStack.selectedIndex = _arg_1;
            };
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
        }

        [Bindable("itemClick")]
        [Bindable("valueCommit")]
        public function get selectedIndex():int
        {
            return (_selectedIndex);
        }


    }
}//package mx.controls

