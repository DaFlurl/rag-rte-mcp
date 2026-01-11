// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.Repeater

package mx.core
{
    import mx.collections.ICollectionView;
    import mx.collections.IViewCursor;
    import flash.events.Event;
    import mx.events.FlexEvent;
    import mx.automation.IAutomationObject;
    import flash.display.DisplayObject;
    import mx.collections.CursorBookmark;
    import mx.collections.errors.ItemPendingError;
    import mx.collections.ItemResponder;
    import mx.events.CollectionEventKind;
    import mx.events.CollectionEvent;
    import mx.collections.ArrayCollection;
    import mx.collections.IList;
    import mx.collections.ListCollectionView;
    import mx.collections.XMLListCollection;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Repeater extends UIComponent implements IRepeater 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _container:Container;
        private var _count:int = -1;
        private var descriptorIndex:int;
        public var childDescriptors:Array;
        mx_internal var createdComponents:Array;
        private var collection:ICollectionView;
        private var _currentIndex:int;
        private var created:Boolean = false;
        private var iterator:IViewCursor;
        private var _startingIndex:int = 0;
        private var _recycleChildren:Boolean = false;


        public function get container():IContainer
        {
            return (_container as IContainer);
        }

        private function createComponentFromDescriptor(_arg_1:int, _arg_2:int, _arg_3:Boolean):IFlexDisplayObject
        {
            var _local_4:UIComponentDescriptor = childDescriptors[_arg_2];
            if (!_local_4.document)
            {
                _local_4.document = document;
            };
            _local_4.instanceIndices = ((instanceIndices) ? instanceIndices : []);
            _local_4.instanceIndices.push(_arg_1);
            _local_4.repeaters = repeaters;
            _local_4.repeaters.push(this);
            _local_4.repeaterIndices = repeaterIndices;
            _local_4.repeaterIndices.push((startingIndex + _arg_1));
            _local_4.invalidateProperties();
            var _local_5:IFlexDisplayObject = Container(container).createComponentFromDescriptor(_local_4, _arg_3);
            _local_4.instanceIndices = null;
            _local_4.repeaters = null;
            _local_4.repeaterIndices = null;
            dispatchEvent(new Event("nextRepeaterItem"));
            return (_local_5);
        }

        private function responderResultHandler(_arg_1:Object, _arg_2:Object):void
        {
            execute();
        }

        private function removeAllChildRepeaters(_arg_1:Container):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:Repeater;
            if (_arg_1.childRepeaters)
            {
                _local_2 = _arg_1.childRepeaters.length;
                _local_3 = (_local_2 - 1);
                while (_local_3 >= 0)
                {
                    _local_4 = _arg_1.childRepeaters[_local_3];
                    if (hasDescendant(_local_4))
                    {
                        removeRepeater(_local_4);
                    };
                    _local_3--;
                };
            };
        }

        private function recycle():void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_6:int;
            var _local_7:Repeater;
            var _local_8:IRepeaterClient;
            var _local_9:int;
            var _local_10:int;
            var _local_11:IRepeaterClient;
            var _local_12:IRepeaterClient;
            dispatchEvent(new FlexEvent(FlexEvent.REPEAT_START));
            var _local_1:int;
            var _local_5:int;
            if ((((collection) && (collection.length > 0)) && ((collection.length - startingIndex) > 0)))
            {
                _local_1 = positiveMin((collection.length - startingIndex), count);
                _local_6 = 0;
                _local_2 = 0;
                while (_local_2 < _local_1)
                {
                    _currentIndex = (startingIndex + _local_2);
                    dispatchEvent(new FlexEvent(FlexEvent.REPEAT));
                    if (childDescriptors)
                    {
                        _local_3 = childDescriptors.length;
                        if (createdComponents.length >= ((_local_2 + 1) * _local_3))
                        {
                            _local_4 = 0;
                            while (_local_4 < _local_3)
                            {
                                _local_8 = createdComponents[((_local_2 * _local_3) + _local_4)];
                                if ((_local_8 is Repeater))
                                {
                                    _local_7 = Repeater(_local_8);
                                    resetRepeaterIndices(_local_7, _currentIndex);
                                    _local_7.owner = this;
                                    _local_7.execute();
                                }
                                else
                                {
                                    resetRepeaterIndices(_local_8, _currentIndex);
                                    if ((_local_8 is IDeferredInstantiationUIComponent))
                                    {
                                        IDeferredInstantiationUIComponent(_local_8).executeBindings(true);
                                    };
                                };
                                _local_5++;
                                _local_4++;
                            };
                        }
                        else
                        {
                            _local_4 = 0;
                            while (_local_4 < _local_3)
                            {
                                _local_9 = container.numChildren;
                                _local_10 = (getIndexForFirstChild() + numCreatedChildren);
                                _local_11 = IRepeaterClient(createComponentFromDescriptor(_local_2, _local_4, true));
                                createdComponents.push(_local_11);
                                if ((_local_11 is IUIComponent))
                                {
                                    IUIComponent(_local_11).owner = this;
                                };
                                if ((_local_11 is IAutomationObject))
                                {
                                    IAutomationObject(_local_11).showInAutomationHierarchy = true;
                                };
                                if ((_local_11 is Repeater))
                                {
                                    _local_7 = Repeater(_local_11);
                                    _local_7.reindexDescendants(_local_9, _local_10);
                                }
                                else
                                {
                                    container.setChildIndex(DisplayObject(_local_11), _local_10);
                                };
                                _local_5++;
                                _local_4++;
                            };
                        };
                    };
                    _local_2++;
                };
            };
            _currentIndex = -1;
            _local_2 = (createdComponents.length - 1);
            while (_local_2 >= _local_5)
            {
                _local_12 = createdComponents.pop();
                if ((_local_12 is Repeater))
                {
                    removeRepeater(Repeater(_local_12));
                }
                else
                {
                    if (_local_12)
                    {
                        if ((_local_12 is Container))
                        {
                            removeAllChildren(Container(_local_12));
                            removeAllChildRepeaters(Container(_local_12));
                        };
                        if (container.contains(DisplayObject(_local_12)))
                        {
                            container.removeChild(DisplayObject(_local_12));
                        };
                        if ((_local_12 is IDeferredInstantiationUIComponent))
                        {
                            IDeferredInstantiationUIComponent(_local_12).deleteReferenceOnParentDocument(IFlexDisplayObject(parentDocument));
                        };
                    };
                };
                _local_2--;
            };
            dispatchEvent(new FlexEvent(FlexEvent.REPEAT_END));
        }

        [Bindable("countChanged")]
        public function get count():int
        {
            return (_count);
        }

        private function reindexDescendants(_arg_1:int, _arg_2:int):void
        {
            var _local_5:IRepeaterClient;
            var _local_3:int = (container.numChildren - _arg_1);
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = IRepeaterClient(container.getChildAt((_arg_1 + _local_4)));
                container.setChildIndex(DisplayObject(_local_5), (_arg_2 + _local_4));
                _local_4++;
            };
        }

        private function adjustIndices(_arg_1:IRepeaterClient, _arg_2:int):void
        {
            var _local_3:Array = _arg_1.repeaters;
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:int = _local_3.length;
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                if (_local_3[_local_5] == this)
                {
                    _arg_1.repeaterIndices[_local_5] = (_arg_1.repeaterIndices[_local_5] + _arg_2);
                    _arg_1.instanceIndices[_local_5] = (_arg_1.instanceIndices[_local_5] + _arg_2);
                    return;
                };
                _local_5++;
            };
        }

        private function positiveMin(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int;
            if (_arg_1 >= 0)
            {
                if (_arg_2 >= 0)
                {
                    if (_arg_1 < _arg_2)
                    {
                        _local_3 = _arg_1;
                    }
                    else
                    {
                        _local_3 = _arg_2;
                    };
                }
                else
                {
                    _local_3 = _arg_1;
                };
            }
            else
            {
                _local_3 = _arg_2;
            };
            return (_local_3);
        }

        mx_internal function getItemAt(index:int):Object
        {
            var result:Object;
            if (iterator)
            {
                try
                {
                    iterator.seek(CursorBookmark.FIRST, index);
                    result = iterator.current;
                }
                catch(itemPendingError:ItemPendingError)
                {
                    itemPendingError.addResponder(new ItemResponder(responderResultHandler, responderFaultHandler));
                };
            };
            return (result);
        }

        public function set count(_arg_1:int):void
        {
            _count = _arg_1;
            execute();
            dispatchEvent(new Event("countChanged"));
        }

        private function addItems(_arg_1:int, _arg_2:int):void
        {
            var _local_3:int;
            var _local_6:IRepeaterClient;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:IFlexDisplayObject;
            var _local_14:Repeater;
            if (startingIndex > _arg_2)
            {
                return;
            };
            var _local_4:int = -1;
            var _local_5:int = container.numChildren;
            if (_arg_2 == (collection.length - 1))
            {
                _local_3 = (_local_5 - 1);
                while (_local_3 >= 0)
                {
                    _local_6 = IRepeaterClient(container.getChildAt(_local_3));
                    _local_7 = getRepeaterIndex(_local_6);
                    if (_local_7 != -1)
                    {
                        _local_4 = (_local_3 + 1);
                        break;
                    };
                    _local_3--;
                };
            }
            else
            {
                _local_8 = ((_arg_2 - _arg_1) + 1);
                _local_3 = 0;
                while (_local_3 < _local_5)
                {
                    _local_6 = IRepeaterClient(container.getChildAt(_local_3));
                    _local_7 = getRepeaterIndex(_local_6);
                    if (_local_7 != -1)
                    {
                        if ((((_arg_1 <= _local_7) && (_local_7 <= _arg_2)) && (_local_4 == -1)))
                        {
                            _local_4 = _local_3;
                        };
                        if (_local_7 >= _arg_1)
                        {
                            adjustIndices(_local_6, _local_8);
                        };
                    };
                    _local_3++;
                };
            };
            if (count == -1)
            {
                _local_5 = _arg_2;
            }
            else
            {
                _local_5 = positiveMin(((startingIndex + count) - 1), _arg_2);
            };
            _local_3 = Math.max(startingIndex, _arg_1);
            while (_local_3 <= _local_5)
            {
                _local_9 = childDescriptors.length;
                _currentIndex = _local_3;
                dispatchEvent(new FlexEvent(FlexEvent.REPEAT));
                _local_10 = 0;
                while (_local_10 < _local_9)
                {
                    _local_11 = container.numChildren;
                    _local_12 = (getIndexForFirstChild() + numCreatedChildren);
                    _local_13 = createComponentFromDescriptor((_local_3 - startingIndex), _local_10, true);
                    createdComponents.push(_local_13);
                    if ((_local_13 is IUIComponent))
                    {
                        IUIComponent(_local_13).owner = this;
                    };
                    if ((_local_13 is IAutomationObject))
                    {
                        IAutomationObject(_local_13).showInAutomationHierarchy = true;
                    };
                    if ((_local_13 is Repeater))
                    {
                        _local_14 = Repeater(_local_13);
                        _local_14.owner = this;
                        _local_14.reindexDescendants(_local_11, _local_12);
                    }
                    else
                    {
                        container.setChildIndex(DisplayObject(_local_13), _local_12);
                    };
                    _local_10++;
                };
                _local_3++;
            };
            _currentIndex = -1;
        }

        private function get numCreatedChildren():int
        {
            var _local_3:IFlexDisplayObject;
            var _local_4:Repeater;
            var _local_1:int;
            var _local_2:int;
            while (_local_2 < createdComponents.length)
            {
                _local_3 = createdComponents[_local_2];
                if ((_local_3 is Repeater))
                {
                    _local_4 = Repeater(_local_3);
                    _local_1 = (_local_1 + _local_4.numCreatedChildren);
                }
                else
                {
                    _local_1 = (_local_1 + 1);
                };
                _local_2++;
            };
            return (_local_1);
        }

        private function removeChildRepeater(_arg_1:Container, _arg_2:Repeater):void
        {
            var _local_3:int;
            var _local_4:int = _arg_1.childRepeaters.length;
            while (_local_3 < _local_4)
            {
                if (_arg_1.repeaters[_local_3] == _arg_2)
                {
                    _arg_1.repeaters.splice(_local_3, 1);
                    return;
                };
                _local_3++;
            };
        }

        private function removeAllChildren(_arg_1:IContainer):void
        {
            var _local_4:IRepeaterClient;
            var _local_2:int = _arg_1.numChildren;
            var _local_3:int = (_local_2 - 1);
            while (_local_3 >= 0)
            {
                _local_4 = IRepeaterClient(_arg_1.getChildAt(_local_3));
                if (hasDescendant(_local_4))
                {
                    if ((_local_4 is Container))
                    {
                        removeAllChildren(Container(_local_4));
                        removeAllChildRepeaters(Container(_local_4));
                    };
                    _arg_1.removeChildAt(_local_3);
                    if ((_local_4 is IDeferredInstantiationUIComponent))
                    {
                        IDeferredInstantiationUIComponent(_local_4).deleteReferenceOnParentDocument(IFlexDisplayObject(parentDocument));
                    };
                };
                _local_3--;
            };
        }

        [Bindable("nextRepeaterItem")]
        public function get currentItem():Object
        {
            var result:Object;
            var message:String;
            if (_currentIndex == -1)
            {
                message = resourceManager.getString("core", "notExecuting");
                throw (new Error(message));
            };
            if (iterator)
            {
                try
                {
                    iterator.seek(CursorBookmark.FIRST, _currentIndex);
                    result = iterator.current;
                }
                catch(itemPendingError:ItemPendingError)
                {
                    itemPendingError.addResponder(new ItemResponder(responderResultHandler, responderFaultHandler));
                };
            };
            return (result);
        }

        private function resetRepeaterIndices(_arg_1:IRepeaterClient, _arg_2:int):void
        {
            var _local_4:Container;
            var _local_5:int;
            var _local_6:int;
            var _local_7:IRepeaterClient;
            var _local_3:Array = _arg_1.repeaterIndices;
            _local_3[(_local_3.length - 1)] = _arg_2;
            _arg_1.repeaterIndices = _local_3;
            if ((_arg_1 is Container))
            {
                _local_4 = Container(_arg_1);
                _local_5 = _local_4.numChildren;
                _local_6 = 0;
                while (_local_6 < _local_5)
                {
                    _local_7 = IRepeaterClient(_local_4.getChildAt(_local_6));
                    resetRepeaterIndices(_local_7, _arg_2);
                    _local_6++;
                };
            };
        }

        public function get recycleChildren():Boolean
        {
            return (_recycleChildren);
        }

        private function collectionChangedHandler(_arg_1:CollectionEvent):void
        {
            switch (_arg_1.kind)
            {
                case CollectionEventKind.UPDATE:
                    return;
                default:
                    execute();
            };
        }

        private function getIndexForRepeater(_arg_1:Repeater, _arg_2:LocationInfo):void
        {
            var _local_5:IFlexDisplayObject;
            var _local_6:Repeater;
            var _local_3:int;
            var _local_4:int = createdComponents.length;
            while (_local_3 < _local_4)
            {
                _local_5 = createdComponents[_local_3];
                if (_local_5 == _arg_1)
                {
                    _arg_2.found = true;
                    return;
                };
                if ((_local_5 is Repeater))
                {
                    _local_6 = Repeater(_local_5);
                    _local_6.getIndexForRepeater(_arg_1, _arg_2);
                    if (_arg_2.found) break;
                }
                else
                {
                    _arg_2.index = (_arg_2.index + 1);
                };
                _local_3++;
            };
        }

        private function hasDescendant(_arg_1:Object):Boolean
        {
            var _local_2:Array = _arg_1.repeaters;
            if (_local_2 == null)
            {
                return (false);
            };
            var _local_3:int = _local_2.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                if (_local_2[_local_4] == this)
                {
                    return (true);
                };
                _local_4++;
            };
            return (false);
        }

        public function initializeRepeater(_arg_1:IContainer, _arg_2:Boolean):void
        {
            _container = Container(_arg_1);
            descriptorIndex = _arg_1.numChildren;
            created = true;
            if (collection)
            {
                createComponentsFromDescriptors(_arg_2);
            };
            if (owner == null)
            {
                owner = Container(_arg_1);
            };
        }

        [Bindable("collectionChange")]
        public function get dataProvider():Object
        {
            return (collection);
        }

        private function removeItems(_arg_1:int, _arg_2:int):void
        {
            var _local_3:int;
            var _local_4:IRepeaterClient;
            var _local_5:int;
            var _local_6:Repeater;
            if (((createdComponents) && (createdComponents.length > 0)))
            {
                _local_3 = (createdComponents.length - 1);
                while (_local_3 >= 0)
                {
                    _local_4 = createdComponents[_local_3];
                    _local_5 = getRepeaterIndex(_local_4);
                    if ((((_arg_1 <= _local_5) && ((_local_5 < _arg_2) || (_arg_2 == -1))) || (_local_5 >= dataProvider.length)))
                    {
                        if ((_local_4 is Repeater))
                        {
                            _local_6 = Repeater(_local_4);
                            removeRepeater(_local_6);
                        }
                        else
                        {
                            if (container.contains(DisplayObject(_local_4)))
                            {
                                container.removeChild(DisplayObject(_local_4));
                            };
                        };
                        if ((_local_4 is IDeferredInstantiationUIComponent))
                        {
                            IDeferredInstantiationUIComponent(_local_4).deleteReferenceOnParentDocument(IFlexDisplayObject(parentDocument));
                        };
                        createdComponents.splice(_local_3, 1);
                    }
                    else
                    {
                        if ((((_arg_1 <= _local_5) && (!(_arg_2 == -1))) && (_local_5 >= _arg_2)))
                        {
                            adjustIndices(_local_4, ((_arg_2 - _arg_1) + 1));
                            if ((_local_4 is IDeferredInstantiationUIComponent))
                            {
                                IDeferredInstantiationUIComponent(_local_4).executeBindings(true);
                            };
                        };
                    };
                    _local_3--;
                };
            };
        }

        private function getIndexForFirstChild():int
        {
            var _local_5:IFlexDisplayObject;
            var _local_6:Repeater;
            var _local_1:LocationInfo = new LocationInfo();
            var _local_2:int;
            var _local_3:Array = Container(container).createdComponents;
            var _local_4:int = ((_local_3) ? _local_3.length : 0);
            while (_local_2 < _local_4)
            {
                _local_5 = Container(container).createdComponents[_local_2];
                if (_local_5 == this)
                {
                    _local_1.found = true;
                    break;
                };
                if ((_local_5 is Repeater))
                {
                    _local_6 = Repeater(_local_5);
                    _local_6.getIndexForRepeater(this, _local_1);
                    if (_local_1.found) break;
                }
                else
                {
                    _local_1.index = (_local_1.index + 1);
                };
                _local_2++;
            };
            return ((_local_1.found) ? _local_1.index : container.numChildren);
        }

        private function createComponentsFromDescriptors(_arg_1:Boolean):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:IFlexDisplayObject;
            dispatchEvent(new FlexEvent(FlexEvent.REPEAT_START));
            createdComponents = [];
            if ((((collection) && (collection.length > 0)) && ((collection.length - startingIndex) > 0)))
            {
                _local_2 = positiveMin((collection.length - startingIndex), count);
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _currentIndex = (startingIndex + _local_3);
                    dispatchEvent(new FlexEvent(FlexEvent.REPEAT));
                    if (((childDescriptors) && (childDescriptors.length > 0)))
                    {
                        _local_4 = childDescriptors.length;
                        _local_5 = 0;
                        while (_local_5 < _local_4)
                        {
                            _local_6 = createComponentFromDescriptor(_local_3, _local_5, _arg_1);
                            createdComponents.push(_local_6);
                            if ((_local_6 is IUIComponent))
                            {
                                IUIComponent(_local_6).owner = this;
                            };
                            if ((_local_6 is IAutomationObject))
                            {
                                IAutomationObject(_local_6).showInAutomationHierarchy = true;
                            };
                            _local_5++;
                        };
                    };
                    _local_3++;
                };
                _currentIndex = -1;
            };
            dispatchEvent(new FlexEvent(FlexEvent.REPEAT_END));
        }

        private function sort():void
        {
            execute();
        }

        private function removeRepeater(_arg_1:Repeater):void
        {
            _arg_1.removeAllChildren(_arg_1.container);
            _arg_1.removeAllChildRepeaters(Container(_arg_1.container));
            removeChildRepeater(Container(container), _arg_1);
            _arg_1.deleteReferenceOnParentDocument(IFlexDisplayObject(parentDocument));
            _arg_1.dataProvider = null;
        }

        public function executeChildBindings():void
        {
            var _local_3:IRepeaterClient;
            var _local_1:int = container.numChildren;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                _local_3 = IRepeaterClient(container.getChildAt(_local_2));
                if (((hasDescendant(_local_3)) && (_local_3 is IDeferredInstantiationUIComponent)))
                {
                    IDeferredInstantiationUIComponent(_local_3).executeBindings();
                };
                _local_2++;
            };
        }

        [Bindable("nextRepeaterItem")]
        public function get currentIndex():int
        {
            var _local_1:String;
            if (_currentIndex == -1)
            {
                _local_1 = resourceManager.getString("core", "notExecuting");
                throw (new Error(_local_1));
            };
            return (_currentIndex);
        }

        public function set startingIndex(_arg_1:int):void
        {
            _startingIndex = _arg_1;
            execute();
            dispatchEvent(new Event("startingIndexChanged"));
        }

        private function responderFaultHandler(_arg_1:Object, _arg_2:Object):void
        {
        }

        override public function toString():String
        {
            return ((Object(container).toString() + ".") + super.toString());
        }

        private function recreate():void
        {
            removeAllChildren(container);
            removeAllChildRepeaters(Container(container));
            var _local_1:int = container.numChildren;
            var _local_2:int = getIndexForFirstChild();
            createComponentsFromDescriptors(true);
            if (_local_1 != _local_2)
            {
                reindexDescendants(_local_1, _local_2);
            };
        }

        [Bindable("startingIndexChanged")]
        public function get startingIndex():int
        {
            return (_startingIndex);
        }

        private function getRepeaterIndex(_arg_1:IRepeaterClient):int
        {
            var _local_2:Array = _arg_1.repeaters;
            if (_local_2 == null)
            {
                return (-1);
            };
            var _local_3:int = _local_2.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                if (_local_2[_local_4] == this)
                {
                    return (_arg_1.repeaterIndices[_local_4]);
                };
                _local_4++;
            };
            return (-1);
        }

        private function execute():void
        {
            if (!created)
            {
                return;
            };
            if ((((recycleChildren) && (createdComponents)) && (createdComponents.length > 0)))
            {
                recycle();
            }
            else
            {
                recreate();
            };
        }

        override public function set showInAutomationHierarchy(_arg_1:Boolean):void
        {
        }

        public function set recycleChildren(_arg_1:Boolean):void
        {
            _recycleChildren = _arg_1;
        }

        public function set dataProvider(_arg_1:Object):void
        {
            var _local_3:XMLList;
            var _local_4:Array;
            var _local_2:Boolean;
            if (collection)
            {
                _local_2 = true;
                collection.removeEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangedHandler);
                collection = null;
                iterator = null;
            };
            if ((_arg_1 is Array))
            {
                collection = new ArrayCollection((_arg_1 as Array));
            }
            else
            {
                if ((_arg_1 is ICollectionView))
                {
                    collection = ICollectionView(_arg_1);
                }
                else
                {
                    if ((_arg_1 is IList))
                    {
                        collection = new ListCollectionView(IList(_arg_1));
                    }
                    else
                    {
                        if ((_arg_1 is XMLList))
                        {
                            collection = new XMLListCollection((_arg_1 as XMLList));
                        }
                        else
                        {
                            if ((_arg_1 is XML))
                            {
                                _local_3 = new XMLList();
                                _local_3 = (_local_3 + _arg_1);
                                collection = new XMLListCollection(_local_3);
                            }
                            else
                            {
                                if (_arg_1 != null)
                                {
                                    _local_4 = [_arg_1];
                                    collection = new ArrayCollection(_local_4);
                                };
                            };
                        };
                    };
                };
            };
            if (collection)
            {
                collection.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangedHandler, false, 0, true);
                iterator = collection.createCursor();
            };
            dispatchEvent(new Event("collectionChange"));
            if (((collection) || (_local_2)))
            {
                execute();
            };
        }

        private function updateItems(_arg_1:int, _arg_2:int):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:IRepeaterClient;
            var _local_6:int;
            if (recycleChildren)
            {
                _local_3 = container.numChildren;
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    _local_5 = IRepeaterClient(container.getChildAt(_local_4));
                    _local_6 = getRepeaterIndex(_local_5);
                    if ((((!(_local_6 == -1)) && (_arg_1 <= _local_6)) && (_local_6 <= _arg_2)))
                    {
                        if ((_local_5 is IDeferredInstantiationUIComponent))
                        {
                            IDeferredInstantiationUIComponent(_local_5).executeBindings(true);
                        };
                    };
                    _local_4++;
                };
            }
            else
            {
                removeItems(_arg_1, _arg_2);
                addItems(_arg_1, _arg_2);
            };
        }


    }
}//package mx.core

class LocationInfo 
{

    public var index:int = 0;
    public var found:Boolean = false;


}


