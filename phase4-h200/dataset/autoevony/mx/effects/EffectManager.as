// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.EffectManager

package mx.effects
{
    import flash.events.EventDispatcher;
    import mx.resources.IResourceManager;
    import flash.utils.Dictionary;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import mx.events.MoveEvent;
    import mx.events.FlexEvent;
    import mx.events.ResizeEvent;
    import mx.core.IUIComponent;
    import mx.core.UIComponent;
    import mx.events.EffectEvent;
    import mx.core.IDeferredInstantiationUIComponent;
    import mx.core.UIComponentCachePolicy;
    import flash.events.FocusEvent;
    import mx.core.IFlexDisplayObject;
    import mx.core.EventPriority;
    import mx.core.ApplicationGlobals;
    import mx.resources.ResourceManager;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class EffectManager extends EventDispatcher 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        mx_internal static var effectsPlaying:Array = [];
        private static var effectTriggersForEvent:Object = {};
        private static var eventsForEffectTriggers:Object = {};
        private static var targetsInfo:Array = [];
        private static var eventHandlingSuspendCount:Number = 0;
        mx_internal static var lastEffectCreated:Effect;
        private static var _resourceManager:IResourceManager;
        private static var effects:Dictionary = new Dictionary(true);


        public static function suspendEventHandling():void
        {
            eventHandlingSuspendCount++;
        }

        mx_internal static function registerEffectTrigger(_arg_1:String, _arg_2:String):void
        {
            var _local_3:Number;
            if (_arg_1 != "")
            {
                if (_arg_2 == "")
                {
                    _local_3 = _arg_1.length;
                    if (((_local_3 > 6) && (_arg_1.substring((_local_3 - 6)) == "Effect")))
                    {
                        _arg_2 = _arg_1.substring(0, (_local_3 - 6));
                    };
                };
                if (_arg_2 != "")
                {
                    effectTriggersForEvent[_arg_2] = _arg_1;
                    eventsForEffectTriggers[_arg_1] = _arg_2;
                };
            };
        }

        private static function removedEffectHandler(_arg_1:DisplayObject, _arg_2:DisplayObjectContainer, _arg_3:int, _arg_4:Event):void
        {
            suspendEventHandling();
            _arg_2.addChildAt(_arg_1, _arg_3);
            resumeEventHandling();
            createAndPlayEffect(_arg_4, _arg_1);
        }

        private static function createAndPlayEffect(_arg_1:Event, _arg_2:Object):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_9:String;
            var _local_10:String;
            var _local_11:Array;
            var _local_12:Array;
            var _local_13:Array;
            var _local_14:Array;
            var _local_15:EffectInstance;
            var _local_3:Effect = createEffectForType(_arg_2, _arg_1.type);
            if (!_local_3)
            {
                return;
            };
            if (((_local_3 is Zoom) && (_arg_1.type == MoveEvent.MOVE)))
            {
                _local_9 = resourceManager.getString("effects", "incorrectTrigger");
                throw (new Error(_local_9));
            };
            if (_arg_2.initialized == false)
            {
                _local_10 = _arg_1.type;
                if ((((((_local_10 == MoveEvent.MOVE) || (_local_10 == ResizeEvent.RESIZE)) || (_local_10 == FlexEvent.SHOW)) || (_local_10 == FlexEvent.HIDE)) || (_local_10 == Event.CHANGE)))
                {
                    _local_3 = null;
                    return;
                };
            };
            if ((_local_3.target is IUIComponent))
            {
                _local_11 = IUIComponent(_local_3.target).tweeningProperties;
                if (((_local_11) && (_local_11.length > 0)))
                {
                    _local_12 = _local_3.getAffectedProperties();
                    _local_4 = _local_11.length;
                    _local_6 = _local_12.length;
                    _local_5 = 0;
                    while (_local_5 < _local_4)
                    {
                        _local_7 = 0;
                        while (_local_7 < _local_6)
                        {
                            if (_local_11[_local_5] == _local_12[_local_7])
                            {
                                _local_3 = null;
                                return;
                            };
                            _local_7++;
                        };
                        _local_5++;
                    };
                };
            };
            if (((_local_3.target is UIComponent) && (UIComponent(_local_3.target).isEffectStarted)))
            {
                _local_13 = _local_3.getAffectedProperties();
                _local_5 = 0;
                while (_local_5 < _local_13.length)
                {
                    _local_14 = _local_3.target.getEffectsForProperty(_local_13[_local_5]);
                    if (_local_14.length > 0)
                    {
                        if (_arg_1.type == ResizeEvent.RESIZE)
                        {
                            return;
                        };
                        _local_7 = 0;
                        while (_local_7 < _local_14.length)
                        {
                            _local_15 = _local_14[_local_7];
                            if (((_arg_1.type == FlexEvent.SHOW) && (_local_15.hideOnEffectEnd)))
                            {
                                _local_15.target.removeEventListener(FlexEvent.SHOW, _local_15.eventHandler);
                                _local_15.hideOnEffectEnd = false;
                            };
                            _local_15.end();
                            _local_7++;
                        };
                    };
                    _local_5++;
                };
            };
            _local_3.triggerEvent = _arg_1;
            _local_3.addEventListener(EffectEvent.EFFECT_END, EffectManager.effectEndHandler);
            lastEffectCreated = _local_3;
            var _local_8:Array = _local_3.play();
            _local_4 = _local_8.length;
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                effectsPlaying.push(new EffectNode(_local_3, _local_8[_local_5]));
                _local_5++;
            };
            if (_local_3.suspendBackgroundProcessing)
            {
                UIComponent.suspendBackgroundProcessing();
            };
        }

        public static function endEffectsForTarget(_arg_1:IUIComponent):void
        {
            var _local_4:EffectInstance;
            var _local_2:int = effectsPlaying.length;
            var _local_3:int = (_local_2 - 1);
            while (_local_3 >= 0)
            {
                _local_4 = effectsPlaying[_local_3].instance;
                if (_local_4.target == _arg_1)
                {
                    _local_4.end();
                };
                _local_3--;
            };
        }

        private static function cacheOrUncacheTargetAsBitmap(_arg_1:IUIComponent, _arg_2:Boolean=true, _arg_3:Boolean=true):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:Object;
            _local_4 = targetsInfo.length;
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                if (targetsInfo[_local_5].target == _arg_1)
                {
                    _local_6 = targetsInfo[_local_5];
                    break;
                };
                _local_5++;
            };
            if (!_local_6)
            {
                _local_6 = {
                    "target":_arg_1,
                    "bitmapEffectsCount":0,
                    "vectorEffectsCount":0
                };
                targetsInfo.push(_local_6);
            };
            if (_arg_2)
            {
                if (_arg_3)
                {
                    _local_6.bitmapEffectsCount++;
                    if (((_local_6.vectorEffectsCount == 0) && (_arg_1 is IDeferredInstantiationUIComponent)))
                    {
                        IDeferredInstantiationUIComponent(_arg_1).cacheHeuristic = true;
                    };
                }
                else
                {
                    if ((((_local_6.vectorEffectsCount++ == 0) && (_arg_1 is IDeferredInstantiationUIComponent)) && (IDeferredInstantiationUIComponent(_arg_1).cachePolicy == UIComponentCachePolicy.AUTO)))
                    {
                        _arg_1.cacheAsBitmap = false;
                    };
                };
            }
            else
            {
                if (_arg_3)
                {
                    if (_local_6.bitmapEffectsCount != 0)
                    {
                        _local_6.bitmapEffectsCount--;
                    };
                    if ((_arg_1 is IDeferredInstantiationUIComponent))
                    {
                        IDeferredInstantiationUIComponent(_arg_1).cacheHeuristic = false;
                    };
                }
                else
                {
                    if (_local_6.vectorEffectsCount != 0)
                    {
                        if (((--_local_6.vectorEffectsCount == 0) && (!(_local_6.bitmapEffectsCount == 0))))
                        {
                            _local_4 = _local_6.bitmapEffectsCount;
                            _local_5 = 0;
                            while (_local_5 < _local_4)
                            {
                                if ((_arg_1 is IDeferredInstantiationUIComponent))
                                {
                                    IDeferredInstantiationUIComponent(_arg_1).cacheHeuristic = true;
                                };
                                _local_5++;
                            };
                        };
                    };
                };
                if (((_local_6.bitmapEffectsCount == 0) && (_local_6.vectorEffectsCount == 0)))
                {
                    _local_4 = targetsInfo.length;
                    _local_5 = 0;
                    while (_local_5 < _local_4)
                    {
                        if (targetsInfo[_local_5].target == _arg_1)
                        {
                            targetsInfo.splice(_local_5, 1);
                            return;
                        };
                        _local_5++;
                    };
                };
            };
        }

        mx_internal static function eventHandler(_arg_1:Event):void
        {
            var _local_2:FocusEvent;
            var _local_3:DisplayObject;
            var _local_4:int;
            var _local_5:DisplayObjectContainer;
            var _local_6:int;
            if (!(_arg_1.currentTarget is IFlexDisplayObject))
            {
                return;
            };
            if (eventHandlingSuspendCount > 0)
            {
                return;
            };
            if (((_arg_1 is FocusEvent) && ((_arg_1.type == FocusEvent.FOCUS_OUT) || (_arg_1.type == FocusEvent.FOCUS_IN))))
            {
                _local_2 = FocusEvent(_arg_1);
                if (((_local_2.relatedObject) && ((_local_2.currentTarget.contains(_local_2.relatedObject)) || (_local_2.currentTarget == _local_2.relatedObject))))
                {
                    return;
                };
            };
            if ((((_arg_1.type == Event.ADDED) || (_arg_1.type == Event.REMOVED)) && (!(_arg_1.target == _arg_1.currentTarget))))
            {
                return;
            };
            if (_arg_1.type == Event.REMOVED)
            {
                if ((_arg_1.target is UIComponent))
                {
                    if (UIComponent(_arg_1.target).initialized == false)
                    {
                        return;
                    };
                    if (UIComponent(_arg_1.target).isEffectStarted)
                    {
                        _local_4 = 0;
                        while (_local_4 < UIComponent(_arg_1.target)._effectsStarted.length)
                        {
                            if (UIComponent(_arg_1.target)._effectsStarted[_local_4].triggerEvent.type == Event.REMOVED)
                            {
                                return;
                            };
                            _local_4++;
                        };
                    };
                };
                _local_3 = (_arg_1.target as DisplayObject);
                if (_local_3 != null)
                {
                    _local_5 = (_local_3.parent as DisplayObjectContainer);
                    if (_local_5 != null)
                    {
                        _local_6 = _local_5.getChildIndex(_local_3);
                        if (_local_6 >= 0)
                        {
                            if ((_local_3 is UIComponent))
                            {
                                UIComponent(_local_3).callLater(removedEffectHandler, [_local_3, _local_5, _local_6, _arg_1]);
                            };
                        };
                    };
                };
            }
            else
            {
                createAndPlayEffect(_arg_1, _arg_1.currentTarget);
            };
        }

        mx_internal static function endBitmapEffect(_arg_1:IUIComponent):void
        {
            cacheOrUncacheTargetAsBitmap(_arg_1, false, true);
        }

        private static function animateSameProperty(_arg_1:Effect, _arg_2:Effect, _arg_3:EffectInstance):Boolean
        {
            var _local_4:Array;
            var _local_5:Array;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            if (_arg_1.target == _arg_3.target)
            {
                _local_4 = _arg_1.getAffectedProperties();
                _local_5 = _arg_2.getAffectedProperties();
                _local_6 = _local_4.length;
                _local_7 = _local_5.length;
                _local_8 = 0;
                while (_local_8 < _local_6)
                {
                    _local_9 = 0;
                    while (_local_9 < _local_7)
                    {
                        if (_local_4[_local_8] == _local_5[_local_9])
                        {
                            return (true);
                        };
                        _local_9++;
                    };
                    _local_8++;
                };
            };
            return (false);
        }

        mx_internal static function effectFinished(_arg_1:EffectInstance):void
        {
            delete effects[_arg_1];
        }

        mx_internal static function effectsInEffect():Boolean
        {
            var _local_1:*;
            for (_local_1 in effects)
            {
                return (true);
            };
            return (false);
        }

        mx_internal static function effectEndHandler(_arg_1:EffectEvent):void
        {
            var _local_5:DisplayObject;
            var _local_6:DisplayObjectContainer;
            var _local_2:IEffectInstance = _arg_1.effectInstance;
            var _local_3:int = effectsPlaying.length;
            var _local_4:int = (_local_3 - 1);
            while (_local_4 >= 0)
            {
                if (effectsPlaying[_local_4].instance == _local_2)
                {
                    effectsPlaying.splice(_local_4, 1);
                    break;
                };
                _local_4--;
            };
            if (Object(_local_2).hideOnEffectEnd == true)
            {
                _local_2.target.removeEventListener(FlexEvent.SHOW, Object(_local_2).eventHandler);
                _local_2.target.setVisible(false, true);
            };
            if (((_local_2.triggerEvent) && (_local_2.triggerEvent.type == Event.REMOVED)))
            {
                _local_5 = (_local_2.target as DisplayObject);
                if (_local_5 != null)
                {
                    _local_6 = (_local_5.parent as DisplayObjectContainer);
                    if (_local_6 != null)
                    {
                        suspendEventHandling();
                        _local_6.removeChild(_local_5);
                        resumeEventHandling();
                    };
                };
            };
            if (_local_2.suspendBackgroundProcessing)
            {
                UIComponent.resumeBackgroundProcessing();
            };
        }

        mx_internal static function startBitmapEffect(_arg_1:IUIComponent):void
        {
            cacheOrUncacheTargetAsBitmap(_arg_1, true, true);
        }

        mx_internal static function setStyle(_arg_1:String, _arg_2:*):void
        {
            var _local_3:String = eventsForEffectTriggers[_arg_1];
            if (((!(_local_3 == null)) && (!(_local_3 == ""))))
            {
                _arg_2.addEventListener(_local_3, EffectManager.eventHandler, false, EventPriority.EFFECT);
            };
        }

        mx_internal static function getEventForEffectTrigger(effectTrigger:String):String
        {
            if (eventsForEffectTriggers)
            {
                try
                {
                    return (eventsForEffectTriggers[effectTrigger]);
                }
                catch(e:Error)
                {
                    return ("");
                };
            };
            return ("");
        }

        mx_internal static function createEffectForType(target:Object, type:String):Effect
        {
            var cls:Class;
            var effectObj:Effect;
            var doc:Object;
            var trigger:String = effectTriggersForEvent[type];
            if (trigger == "")
            {
                trigger = (type + "Effect");
            };
            var value:Object = target.getStyle(trigger);
            if (!value)
            {
                return (null);
            };
            if ((value is Class))
            {
                cls = Class(value);
                return (new (cls)(target));
            };
            try
            {
                if ((value is String))
                {
                    doc = target.parentDocument;
                    if (!doc)
                    {
                        doc = ApplicationGlobals.application;
                    };
                    effectObj = doc[value];
                }
                else
                {
                    if ((value is Effect))
                    {
                        effectObj = Effect(value);
                    };
                };
                if (effectObj)
                {
                    effectObj.target = target;
                    return (effectObj);
                };
            }
            catch(e:Error)
            {
            };
            var effectClass:Class = Class(target.systemManager.getDefinitionByName(("mx.effects." + value)));
            if (effectClass)
            {
                return (new (effectClass)(target));
            };
            return (null);
        }

        mx_internal static function effectStarted(_arg_1:EffectInstance):void
        {
            effects[_arg_1] = 1;
        }

        public static function resumeEventHandling():void
        {
            eventHandlingSuspendCount--;
        }

        mx_internal static function startVectorEffect(_arg_1:IUIComponent):void
        {
            cacheOrUncacheTargetAsBitmap(_arg_1, true, false);
        }

        mx_internal static function endVectorEffect(_arg_1:IUIComponent):void
        {
            cacheOrUncacheTargetAsBitmap(_arg_1, false, false);
        }

        private static function get resourceManager():IResourceManager
        {
            if (!_resourceManager)
            {
                _resourceManager = ResourceManager.getInstance();
            };
            return (_resourceManager);
        }


    }
}//package mx.effects

import mx.effects.Effect;
import mx.effects.EffectInstance;

class EffectNode 
{

    public var factory:Effect;
    public var instance:EffectInstance;

    public function EffectNode(_arg_1:Effect, _arg_2:EffectInstance)
    {
        this.factory = _arg_1;
        this.instance = _arg_2;
    }

}


