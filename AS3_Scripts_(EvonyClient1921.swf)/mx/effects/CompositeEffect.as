// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.CompositeEffect

package mx.effects
{
    import mx.effects.effectClasses.CompositeEffectInstance;
    import mx.effects.effectClasses.PropertyChanges;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class CompositeEffect extends Effect 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _affectedProperties:Array;
        private var childTargets:Array;
        public var children:Array = [];

        public function CompositeEffect(_arg_1:Object=null)
        {
            super(_arg_1);
            instanceClass = CompositeEffectInstance;
        }

        override public function createInstances(_arg_1:Array=null):Array
        {
            if (!_arg_1)
            {
                _arg_1 = this.targets;
            };
            childTargets = _arg_1;
            var _local_2:IEffectInstance = createInstance();
            childTargets = null;
            return ((_local_2) ? [_local_2] : []);
        }

        override protected function initInstance(_arg_1:IEffectInstance):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:Effect;
            super.initInstance(_arg_1);
            var _local_2:CompositeEffectInstance = CompositeEffectInstance(_arg_1);
            var _local_3:Object = childTargets;
            if (!(_local_3 is Array))
            {
                _local_3 = [_local_3];
            };
            if (children)
            {
                _local_4 = children.length;
                _local_5 = 0;
                while (_local_5 < _local_4)
                {
                    _local_6 = children[_local_5];
                    if (propertyChangesArray != null)
                    {
                        _local_6.propertyChangesArray = propertyChangesArray;
                    };
                    if (((_local_6.filterObject == null) && (filterObject)))
                    {
                        _local_6.filterObject = filterObject;
                    };
                    if (effectTargetHost)
                    {
                        _local_6.effectTargetHost = effectTargetHost;
                    };
                    if (_local_6.targets.length == 0)
                    {
                        _local_2.addChildSet(children[_local_5].createInstances(_local_3));
                    }
                    else
                    {
                        _local_2.addChildSet(children[_local_5].createInstances(_local_6.targets));
                    };
                    _local_5++;
                };
            };
        }

        override mx_internal function captureValues(_arg_1:Array, _arg_2:Boolean):Array
        {
            var _local_5:Effect;
            var _local_3:int = children.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = children[_local_4];
                _arg_1 = _local_5.captureValues(_arg_1, _arg_2);
                _local_4++;
            };
            return (_arg_1);
        }

        public function addChild(_arg_1:IEffect):void
        {
            children.push(_arg_1);
            _affectedProperties = null;
        }

        override mx_internal function applyStartValues(_arg_1:Array, _arg_2:Array):void
        {
            var _local_5:Effect;
            var _local_6:Array;
            var _local_3:int = children.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = children[_local_4];
                _local_6 = ((_local_5.targets.length > 0) ? _local_5.targets : _arg_2);
                if (((_local_5.filterObject == null) && (filterObject)))
                {
                    _local_5.filterObject = filterObject;
                };
                _local_5.applyStartValues(_arg_1, _local_6);
                _local_4++;
            };
        }

        override public function createInstance(_arg_1:Object=null):IEffectInstance
        {
            if (!childTargets)
            {
                childTargets = [_arg_1];
            };
            var _local_2:IEffectInstance = super.createInstance(_arg_1);
            childTargets = null;
            return (_local_2);
        }

        override protected function filterInstance(_arg_1:Array, _arg_2:Object):Boolean
        {
            var _local_3:Array;
            var _local_4:int;
            var _local_5:int;
            if (filterObject)
            {
                _local_3 = targets;
                if (_local_3.length == 0)
                {
                    _local_3 = childTargets;
                };
                _local_4 = _local_3.length;
                _local_5 = 0;
                while (_local_5 < _local_4)
                {
                    if (filterObject.filterInstance(_arg_1, effectTargetHost, _local_3[_local_5]))
                    {
                        return (true);
                    };
                    _local_5++;
                };
                return (false);
            };
            return (true);
        }

        override public function captureStartValues():void
        {
            var _local_1:Array = getChildrenTargets();
            propertyChangesArray = [];
            var _local_2:int = _local_1.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                propertyChangesArray.push(new PropertyChanges(_local_1[_local_3]));
                _local_3++;
            };
            propertyChangesArray = captureValues(propertyChangesArray, true);
            endValuesCaptured = false;
        }

        private function getChildrenTargets():Array
        {
            var _local_3:Array;
            var _local_4:Effect;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:String;
            var _local_1:Array = [];
            var _local_2:Object = {};
            _local_5 = children.length;
            _local_6 = 0;
            while (_local_6 < _local_5)
            {
                _local_4 = children[_local_6];
                if ((_local_4 is CompositeEffect))
                {
                    _local_3 = CompositeEffect(_local_4).getChildrenTargets();
                    _local_7 = _local_3.length;
                    _local_8 = 0;
                    while (_local_8 < _local_7)
                    {
                        if (_local_3[_local_8] != null)
                        {
                            _local_2[_local_3[_local_8].toString()] = _local_3[_local_8];
                        };
                        _local_8++;
                    };
                }
                else
                {
                    if (_local_4.targets != null)
                    {
                        _local_7 = _local_4.targets.length;
                        _local_8 = 0;
                        while (_local_8 < _local_7)
                        {
                            if (_local_4.targets[_local_8] != null)
                            {
                                _local_2[_local_4.targets[_local_8].toString()] = _local_4.targets[_local_8];
                            };
                            _local_8++;
                        };
                    };
                };
                _local_6++;
            };
            _local_5 = targets.length;
            _local_6 = 0;
            while (_local_6 < _local_5)
            {
                if (targets[_local_6] != null)
                {
                    _local_2[targets[_local_6].toString()] = targets[_local_6];
                };
                _local_6++;
            };
            for (_local_9 in _local_2)
            {
                _local_1.push(_local_2[_local_9]);
            };
            return (_local_1);
        }

        override public function getAffectedProperties():Array
        {
            var _local_1:Array;
            var _local_2:int;
            var _local_3:int;
            if (!_affectedProperties)
            {
                _local_1 = [];
                _local_2 = children.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _local_1 = _local_1.concat(children[_local_3].getAffectedProperties());
                    _local_3++;
                };
                _affectedProperties = _local_1;
            };
            return (_affectedProperties);
        }


    }
}//package mx.effects

