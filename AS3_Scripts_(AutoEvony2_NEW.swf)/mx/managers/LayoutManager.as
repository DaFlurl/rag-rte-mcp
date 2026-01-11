// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.LayoutManager

package mx.managers
{
    import flash.events.EventDispatcher;
    import mx.core.UIComponent;
    import mx.managers.layoutClasses.PriorityQueue;
    import flash.display.Stage;
    import mx.events.FlexEvent;
    import mx.core.ApplicationGlobals;
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class LayoutManager extends EventDispatcher implements ILayoutManager 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var instance:LayoutManager;

        private var invalidateClientPropertiesFlag:Boolean = false;
        private var invalidateDisplayListFlag:Boolean = false;
        private var invalidateClientSizeFlag:Boolean = false;
        private var originalFrameRate:Number;
        private var invalidatePropertiesFlag:Boolean = false;
        private var invalidateSizeFlag:Boolean = false;
        private var callLaterPending:Boolean = false;
        private var _usePhasedInstantiation:Boolean = false;
        private var callLaterObject:UIComponent;
        private var targetLevel:int = 2147483647;

        private var updateCompleteQueue:PriorityQueue = new PriorityQueue();
        private var invalidatePropertiesQueue:PriorityQueue = new PriorityQueue();
        private var invalidateSizeQueue:PriorityQueue = new PriorityQueue();
        private var invalidateDisplayListQueue:PriorityQueue = new PriorityQueue();


        public static function getInstance():LayoutManager
        {
            if (!instance)
            {
                instance = new (LayoutManager)();
            };
            return (instance);
        }


        public function set usePhasedInstantiation(value:Boolean):void
        {
            var sm:ISystemManager;
            var stage:Stage;
            if (_usePhasedInstantiation != value)
            {
                _usePhasedInstantiation = value;
                try
                {
                    sm = SystemManagerGlobals.topLevelSystemManagers[0];
                    stage = SystemManagerGlobals.topLevelSystemManagers[0].stage;
                    if (stage)
                    {
                        if (value)
                        {
                            originalFrameRate = stage.frameRate;
                            stage.frameRate = 1000;
                        }
                        else
                        {
                            stage.frameRate = originalFrameRate;
                        };
                    };
                }
                catch(e:SecurityError)
                {
                };
            };
        }

        private function waitAFrame():void
        {
            callLaterObject.callLater(doPhasedInstantiation);
        }

        public function validateClient(_arg_1:ILayoutManagerClient, _arg_2:Boolean=false):void
        {
            var _local_3:ILayoutManagerClient;
            var _local_4:int;
            var _local_5:Boolean;
            var _local_6:int = targetLevel;
            if (targetLevel == int.MAX_VALUE)
            {
                targetLevel = _arg_1.nestLevel;
            };
            while ((!(_local_5)))
            {
                _local_5 = true;
                _local_3 = ILayoutManagerClient(invalidatePropertiesQueue.removeSmallestChild(_arg_1));
                while (_local_3)
                {
                    _local_3.validateProperties();
                    if (!_local_3.updateCompletePendingFlag)
                    {
                        updateCompleteQueue.addObject(_local_3, _local_3.nestLevel);
                        _local_3.updateCompletePendingFlag = true;
                    };
                    _local_3 = ILayoutManagerClient(invalidatePropertiesQueue.removeSmallestChild(_arg_1));
                };
                if (invalidatePropertiesQueue.isEmpty())
                {
                    invalidatePropertiesFlag = false;
                    invalidateClientPropertiesFlag = false;
                };
                _local_3 = ILayoutManagerClient(invalidateSizeQueue.removeLargestChild(_arg_1));
                while (_local_3)
                {
                    _local_3.validateSize();
                    if (!_local_3.updateCompletePendingFlag)
                    {
                        updateCompleteQueue.addObject(_local_3, _local_3.nestLevel);
                        _local_3.updateCompletePendingFlag = true;
                    };
                    if (invalidateClientPropertiesFlag)
                    {
                        _local_3 = ILayoutManagerClient(invalidatePropertiesQueue.removeSmallestChild(_arg_1));
                        if (_local_3)
                        {
                            invalidatePropertiesQueue.addObject(_local_3, _local_3.nestLevel);
                            _local_5 = false;
                            break;
                        };
                    };
                    _local_3 = ILayoutManagerClient(invalidateSizeQueue.removeLargestChild(_arg_1));
                };
                if (invalidateSizeQueue.isEmpty())
                {
                    invalidateSizeFlag = false;
                    invalidateClientSizeFlag = false;
                };
                if (!_arg_2)
                {
                    _local_3 = ILayoutManagerClient(invalidateDisplayListQueue.removeSmallestChild(_arg_1));
                    while (_local_3)
                    {
                        _local_3.validateDisplayList();
                        if (!_local_3.updateCompletePendingFlag)
                        {
                            updateCompleteQueue.addObject(_local_3, _local_3.nestLevel);
                            _local_3.updateCompletePendingFlag = true;
                        };
                        if (invalidateClientPropertiesFlag)
                        {
                            _local_3 = ILayoutManagerClient(invalidatePropertiesQueue.removeSmallestChild(_arg_1));
                            if (_local_3)
                            {
                                invalidatePropertiesQueue.addObject(_local_3, _local_3.nestLevel);
                                _local_5 = false;
                                break;
                            };
                        };
                        if (invalidateClientSizeFlag)
                        {
                            _local_3 = ILayoutManagerClient(invalidateSizeQueue.removeLargestChild(_arg_1));
                            if (_local_3)
                            {
                                invalidateSizeQueue.addObject(_local_3, _local_3.nestLevel);
                                _local_5 = false;
                                break;
                            };
                        };
                        _local_3 = ILayoutManagerClient(invalidateDisplayListQueue.removeSmallestChild(_arg_1));
                    };
                    if (invalidateDisplayListQueue.isEmpty())
                    {
                        invalidateDisplayListFlag = false;
                    };
                };
            };
            if (_local_6 == int.MAX_VALUE)
            {
                targetLevel = int.MAX_VALUE;
                if (!_arg_2)
                {
                    _local_3 = ILayoutManagerClient(updateCompleteQueue.removeLargestChild(_arg_1));
                    while (_local_3)
                    {
                        if (!_local_3.initialized)
                        {
                            _local_3.initialized = true;
                        };
                        _local_3.dispatchEvent(new FlexEvent(FlexEvent.UPDATE_COMPLETE));
                        _local_3.updateCompletePendingFlag = false;
                        _local_3 = ILayoutManagerClient(updateCompleteQueue.removeLargestChild(_arg_1));
                    };
                };
            };
        }

        private function validateProperties():void
        {
            var _local_1:ILayoutManagerClient = ILayoutManagerClient(invalidatePropertiesQueue.removeSmallest());
            while (_local_1)
            {
                _local_1.validateProperties();
                if (!_local_1.updateCompletePendingFlag)
                {
                    updateCompleteQueue.addObject(_local_1, _local_1.nestLevel);
                    _local_1.updateCompletePendingFlag = true;
                };
                _local_1 = ILayoutManagerClient(invalidatePropertiesQueue.removeSmallest());
            };
            if (invalidatePropertiesQueue.isEmpty())
            {
                invalidatePropertiesFlag = false;
            };
        }

        public function invalidateProperties(_arg_1:ILayoutManagerClient):void
        {
            if (((!(invalidatePropertiesFlag)) && (ApplicationGlobals.application.systemManager)))
            {
                invalidatePropertiesFlag = true;
                if (!callLaterPending)
                {
                    if (!callLaterObject)
                    {
                        callLaterObject = new UIComponent();
                        callLaterObject.systemManager = ApplicationGlobals.application.systemManager;
                        callLaterObject.callLater(waitAFrame);
                    }
                    else
                    {
                        callLaterObject.callLater(doPhasedInstantiation);
                    };
                    callLaterPending = true;
                };
            };
            if (targetLevel <= _arg_1.nestLevel)
            {
                invalidateClientPropertiesFlag = true;
            };
            invalidatePropertiesQueue.addObject(_arg_1, _arg_1.nestLevel);
        }

        public function invalidateDisplayList(_arg_1:ILayoutManagerClient):void
        {
            if (((!(invalidateDisplayListFlag)) && (ApplicationGlobals.application.systemManager)))
            {
                invalidateDisplayListFlag = true;
                if (!callLaterPending)
                {
                    if (!callLaterObject)
                    {
                        callLaterObject = new UIComponent();
                        callLaterObject.systemManager = ApplicationGlobals.application.systemManager;
                        callLaterObject.callLater(waitAFrame);
                    }
                    else
                    {
                        callLaterObject.callLater(doPhasedInstantiation);
                    };
                    callLaterPending = true;
                };
            }
            else
            {
                if (((!(invalidateDisplayListFlag)) && (!(ApplicationGlobals.application.systemManager))))
                {
                };
            };
            invalidateDisplayListQueue.addObject(_arg_1, _arg_1.nestLevel);
        }

        private function validateDisplayList():void
        {
            var _local_1:ILayoutManagerClient = ILayoutManagerClient(invalidateDisplayListQueue.removeSmallest());
            while (_local_1)
            {
                _local_1.validateDisplayList();
                if (!_local_1.updateCompletePendingFlag)
                {
                    updateCompleteQueue.addObject(_local_1, _local_1.nestLevel);
                    _local_1.updateCompletePendingFlag = true;
                };
                _local_1 = ILayoutManagerClient(invalidateDisplayListQueue.removeSmallest());
            };
            if (invalidateDisplayListQueue.isEmpty())
            {
                invalidateDisplayListFlag = false;
            };
        }

        public function validateNow():void
        {
            var _local_1:int;
            if (!usePhasedInstantiation)
            {
                _local_1 = 0;
                while (((callLaterPending) && (_local_1++ < 100)))
                {
                    doPhasedInstantiation();
                };
            };
        }

        private function validateSize():void
        {
            var _local_1:ILayoutManagerClient = ILayoutManagerClient(invalidateSizeQueue.removeLargest());
            while (_local_1)
            {
                _local_1.validateSize();
                if (!_local_1.updateCompletePendingFlag)
                {
                    updateCompleteQueue.addObject(_local_1, _local_1.nestLevel);
                    _local_1.updateCompletePendingFlag = true;
                };
                _local_1 = ILayoutManagerClient(invalidateSizeQueue.removeLargest());
            };
            if (invalidateSizeQueue.isEmpty())
            {
                invalidateSizeFlag = false;
            };
        }

        private function doPhasedInstantiation():void
        {
            var _local_1:ILayoutManagerClient;
            if (usePhasedInstantiation)
            {
                if (invalidatePropertiesFlag)
                {
                    validateProperties();
                    ApplicationGlobals.application.dispatchEvent(new Event("validatePropertiesComplete"));
                }
                else
                {
                    if (invalidateSizeFlag)
                    {
                        validateSize();
                        ApplicationGlobals.application.dispatchEvent(new Event("validateSizeComplete"));
                    }
                    else
                    {
                        if (invalidateDisplayListFlag)
                        {
                            validateDisplayList();
                            ApplicationGlobals.application.dispatchEvent(new Event("validateDisplayListComplete"));
                        };
                    };
                };
            }
            else
            {
                if (invalidatePropertiesFlag)
                {
                    validateProperties();
                };
                if (invalidateSizeFlag)
                {
                    validateSize();
                };
                if (invalidateDisplayListFlag)
                {
                    validateDisplayList();
                };
            };
            if ((((invalidatePropertiesFlag) || (invalidateSizeFlag)) || (invalidateDisplayListFlag)))
            {
                callLaterObject.callLater(doPhasedInstantiation);
            }
            else
            {
                usePhasedInstantiation = false;
                callLaterPending = false;
                _local_1 = ILayoutManagerClient(updateCompleteQueue.removeLargest());
                while (_local_1)
                {
                    if (((!(_local_1.initialized)) && (_local_1.processedDescriptors)))
                    {
                        _local_1.initialized = true;
                    };
                    _local_1.dispatchEvent(new FlexEvent(FlexEvent.UPDATE_COMPLETE));
                    _local_1.updateCompletePendingFlag = false;
                    _local_1 = ILayoutManagerClient(updateCompleteQueue.removeLargest());
                };
                dispatchEvent(new FlexEvent(FlexEvent.UPDATE_COMPLETE));
            };
        }

        public function isInvalid():Boolean
        {
            return (((invalidatePropertiesFlag) || (invalidateSizeFlag)) || (invalidateDisplayListFlag));
        }

        public function get usePhasedInstantiation():Boolean
        {
            return (_usePhasedInstantiation);
        }

        public function invalidateSize(_arg_1:ILayoutManagerClient):void
        {
            if (((!(invalidateSizeFlag)) && (ApplicationGlobals.application.systemManager)))
            {
                invalidateSizeFlag = true;
                if (!callLaterPending)
                {
                    if (!callLaterObject)
                    {
                        callLaterObject = new UIComponent();
                        callLaterObject.systemManager = ApplicationGlobals.application.systemManager;
                        callLaterObject.callLater(waitAFrame);
                    }
                    else
                    {
                        callLaterObject.callLater(doPhasedInstantiation);
                    };
                    callLaterPending = true;
                };
            };
            if (targetLevel <= _arg_1.nestLevel)
            {
                invalidateClientSizeFlag = true;
            };
            invalidateSizeQueue.addObject(_arg_1, _arg_1.nestLevel);
        }


    }
}//package mx.managers

