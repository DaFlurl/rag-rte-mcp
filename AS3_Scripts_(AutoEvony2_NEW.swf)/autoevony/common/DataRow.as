// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.common.DataRow

package autoevony.common
{
    import flash.events.EventDispatcher;
    import mx.collections.ArrayCollection;
    import mx.events.PropertyChangeEvent;

    public class DataRow extends EventDispatcher 
    {

        private var _3059381col5:Object;
        private var _3059382col6:Object;
        private var _3059383col7:Object;
        private var _3059384col8:Object;
        private var _3059385col9:Object;
        private var _94840735col10:Object;
        private var _204859874bgColor:Object;
        private var _102727412label:Object = "";
        private var _3059376col0:Object;
        private var _3059377col1:Object;
        private var _3059378col2:Object;
        private var _3059379col3:Object;
        private var _3059380col4:Object;


        public static function copyRowArray(_arg_1:ArrayCollection, _arg_2:ArrayCollection):void
        {
            var _local_3:int = (_arg_2.length - 1);
            while (_local_3 >= _arg_1.length)
            {
                _arg_2.removeItemAt(_local_3);
                _local_3--;
            };
            _local_3 = 0;
            while (_local_3 < Math.min(_arg_2.length, _arg_1.length))
            {
                if (!_arg_2[_local_3].same(_arg_1[_local_3]))
                {
                    _arg_2.setItemAt(_arg_1[_local_3], _local_3);
                };
                _local_3++;
            };
            _local_3 = _arg_2.length;
            while (_local_3 < _arg_1.length)
            {
                _arg_2.addItem(_arg_1[_local_3]);
                _local_3++;
            };
        }


        [Bindable(event="propertyChange")]
        public function get bgColor():Object
        {
            return (this._204859874bgColor);
        }

        [Bindable(event="propertyChange")]
        public function get col10():Object
        {
            return (this._94840735col10);
        }

        [Bindable(event="propertyChange")]
        public function get col0():Object
        {
            return (this._3059376col0);
        }

        [Bindable(event="propertyChange")]
        public function get col1():Object
        {
            return (this._3059377col1);
        }

        [Bindable(event="propertyChange")]
        public function get col2():Object
        {
            return (this._3059378col2);
        }

        [Bindable(event="propertyChange")]
        public function get col4():Object
        {
            return (this._3059380col4);
        }

        [Bindable(event="propertyChange")]
        public function get col5():Object
        {
            return (this._3059381col5);
        }

        [Bindable(event="propertyChange")]
        public function get col6():Object
        {
            return (this._3059382col6);
        }

        [Bindable(event="propertyChange")]
        public function get col7():Object
        {
            return (this._3059383col7);
        }

        [Bindable(event="propertyChange")]
        public function get col8():Object
        {
            return (this._3059384col8);
        }

        [Bindable(event="propertyChange")]
        public function get col9():Object
        {
            return (this._3059385col9);
        }

        [Bindable(event="propertyChange")]
        public function get col3():Object
        {
            return (this._3059379col3);
        }

        public function set bgColor(_arg_1:Object):void
        {
            var _local_2:Object = this._204859874bgColor;
            if (_local_2 !== _arg_1)
            {
                this._204859874bgColor = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bgColor", _local_2, _arg_1));
            };
        }

        public function set col10(_arg_1:Object):void
        {
            var _local_2:Object = this._94840735col10;
            if (_local_2 !== _arg_1)
            {
                this._94840735col10 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "col10", _local_2, _arg_1));
            };
        }

        public function set col0(_arg_1:Object):void
        {
            var _local_2:Object = this._3059376col0;
            if (_local_2 !== _arg_1)
            {
                this._3059376col0 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "col0", _local_2, _arg_1));
            };
        }

        public function set col1(_arg_1:Object):void
        {
            var _local_2:Object = this._3059377col1;
            if (_local_2 !== _arg_1)
            {
                this._3059377col1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "col1", _local_2, _arg_1));
            };
        }

        public function set col5(_arg_1:Object):void
        {
            var _local_2:Object = this._3059381col5;
            if (_local_2 !== _arg_1)
            {
                this._3059381col5 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "col5", _local_2, _arg_1));
            };
        }

        public function set col2(_arg_1:Object):void
        {
            var _local_2:Object = this._3059378col2;
            if (_local_2 !== _arg_1)
            {
                this._3059378col2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "col2", _local_2, _arg_1));
            };
        }

        public function set col6(_arg_1:Object):void
        {
            var _local_2:Object = this._3059382col6;
            if (_local_2 !== _arg_1)
            {
                this._3059382col6 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "col6", _local_2, _arg_1));
            };
        }

        private function same(_arg_1:DataRow):Boolean
        {
            if (this.col0 != _arg_1.col0)
            {
                return (false);
            };
            if (this.col1 != _arg_1.col1)
            {
                return (false);
            };
            if (this.col2 != _arg_1.col2)
            {
                return (false);
            };
            if (this.col3 != _arg_1.col3)
            {
                return (false);
            };
            if (this.col4 != _arg_1.col4)
            {
                return (false);
            };
            if (this.col5 != _arg_1.col5)
            {
                return (false);
            };
            if (this.col6 != _arg_1.col6)
            {
                return (false);
            };
            if (this.col7 != _arg_1.col7)
            {
                return (false);
            };
            if (this.col8 != _arg_1.col8)
            {
                return (false);
            };
            if (this.col9 != _arg_1.col9)
            {
                return (false);
            };
            if (this.col10 != _arg_1.col10)
            {
                return (false);
            };
            if (this.label != _arg_1.label)
            {
                return (false);
            };
            if (this.bgColor != _arg_1.bgColor)
            {
                return (false);
            };
            return (true);
        }

        public function set col7(_arg_1:Object):void
        {
            var _local_2:Object = this._3059383col7;
            if (_local_2 !== _arg_1)
            {
                this._3059383col7 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "col7", _local_2, _arg_1));
            };
        }

        public function set col4(_arg_1:Object):void
        {
            var _local_2:Object = this._3059380col4;
            if (_local_2 !== _arg_1)
            {
                this._3059380col4 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "col4", _local_2, _arg_1));
            };
        }

        public function set col8(_arg_1:Object):void
        {
            var _local_2:Object = this._3059384col8;
            if (_local_2 !== _arg_1)
            {
                this._3059384col8 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "col8", _local_2, _arg_1));
            };
        }

        public function set col9(_arg_1:Object):void
        {
            var _local_2:Object = this._3059385col9;
            if (_local_2 !== _arg_1)
            {
                this._3059385col9 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "col9", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get label():Object
        {
            return (this._102727412label);
        }

        public function set col3(_arg_1:Object):void
        {
            var _local_2:Object = this._3059379col3;
            if (_local_2 !== _arg_1)
            {
                this._3059379col3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "col3", _local_2, _arg_1));
            };
        }

        public function set label(_arg_1:Object):void
        {
            var _local_2:Object = this._102727412label;
            if (_local_2 !== _arg_1)
            {
                this._102727412label = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "label", _local_2, _arg_1));
            };
        }


    }
}//package autoevony.common

