// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.trainningField.TroopInput

package view.module.trainningField
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.eum.TroopEum;
    import view.ui.NumberRegulate;
    import mx.controls.Image;
    import mx.controls.Label;
    import mx.binding.utils.ChangeWatcher;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import view.module.barrack.ArmyInfoTooltip;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import com.evony.eum.TroopEumDefine;
    import com.evony.factory.ImageManager;
    import flash.events.MouseEvent;
    import mx.events.FlexEvent;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.filters.*;
    import flash.system.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class TroopInput extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var troopEuDef:TroopEum;
        private var _288459765distance:Number;
        private var _102976443limit:int;
        private var _1909260316numInput:NumberRegulate;
        private var _390231223maxLimit:int;
        private var _1185090783imgSrc:Object;
        private var _358134206buttonFlag:int = 0;
        public var _TroopInput_Image1:Image;
        public var _TroopInput_Label1:Label;
        private var _618148268troopType:int;
        private var isMax:Boolean = false;
        private var c:ChangeWatcher;
        private var _101759fun:Function;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":185,
                    "height":30,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Label,
                        "id":"_TroopInput_Label1",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"PropertyValue2",
                                "x":36,
                                "width":70
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"_TroopInput_Image1",
                        "events":{
                            "added":"___TroopInput_Image1_added",
                            "mouseOut":"___TroopInput_Image1_mouseOut",
                            "mouseMove":"___TroopInput_Image1_mouseMove",
                            "mouseOver":"___TroopInput_Image1_mouseOver"
                        },
                        "stylesFactory":function ():void
                        {
                            this.verticalCenter = "0";
                            this.left = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":25,
                                "height":25
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":NumberRegulate,
                        "id":"numInput",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "right";
                            this.right = "4";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":76,
                                "isProduce":true
                            });
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function TroopInput()
        {
            mx_internal::_document = this;
            this.width = 185;
            this.height = 30;
            this.styleName = "armyTiles";
            this.addEventListener("creationComplete", ___TroopInput_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TroopInput._watcherSetupUtil = _arg_1;
        }


        private function _TroopInput_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.limit;
            _local_1 = this.imgSrc;
            _local_1 = ((this.limit > (this.maxLimit + numInput.preValue)) ? (this.maxLimit + numInput.preValue) : this.limit);
            _local_1 = this.fun;
            _local_1 = this.troopType;
            _local_1 = this.buttonFlag;
            _local_1 = this.distance;
        }

        private function hideArmyTooltip():void
        {
            ArmyInfoTooltip.hide();
        }

        public function set limit(_arg_1:int):void
        {
            var _local_2:Object = this._102976443limit;
            if (_local_2 !== _arg_1)
            {
                this._102976443limit = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "limit", _local_2, _arg_1));
            };
        }

        public function set buttonFlag(_arg_1:int):void
        {
            var _local_2:Object = this._358134206buttonFlag;
            if (_local_2 !== _arg_1)
            {
                this._358134206buttonFlag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buttonFlag", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:TroopInput;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TroopInput_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_trainningField_TroopInputWatcherSetupUtil");
                var _local_2:* = watcherSetupUtilClass;
                (_local_2["init"](null));
            };
            _watcherSetupUtil.setup(this, function (_arg_1:String):*
            {
                return (target[_arg_1]);
            }, bindings, watchers);
            var i:uint;
            while (i < bindings.length)
            {
                Binding(bindings[i]).execute();
                i++;
            };
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            super.initialize();
        }

        public function set maxLimit(_arg_1:int):void
        {
            var _local_2:Object = this._390231223maxLimit;
            if (_local_2 !== _arg_1)
            {
                this._390231223maxLimit = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxLimit", _local_2, _arg_1));
            };
        }

        public function ___TroopInput_Image1_added(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get imgSrc():Object
        {
            return (this._1185090783imgSrc);
        }

        private function _TroopInput_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.limit;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopInput_Label1.text = _arg_1;
            }, "_TroopInput_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.imgSrc);
            }, function (_arg_1:Object):void
            {
                _TroopInput_Image1.source = _arg_1;
            }, "_TroopInput_Image1.source");
            result[1] = binding;
            binding = new Binding(this, function ():int
            {
                return ((this.limit > (this.maxLimit + numInput.preValue)) ? (this.maxLimit + numInput.preValue) : this.limit);
            }, function (_arg_1:int):void
            {
                numInput.valueMax = _arg_1;
            }, "numInput.valueMax");
            result[2] = binding;
            binding = new Binding(this, function ():Function
            {
                return (this.fun);
            }, function (_arg_1:Function):void
            {
                numInput.onValueChange = _arg_1;
            }, "numInput.onValueChange");
            result[3] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troopType);
            }, function (_arg_1:int):void
            {
                numInput.type = _arg_1;
            }, "numInput.type");
            result[4] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.buttonFlag);
            }, function (_arg_1:int):void
            {
                numInput.buttonFlag = _arg_1;
            }, "numInput.buttonFlag");
            result[5] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.distance);
            }, function (_arg_1:Number):void
            {
                numInput.dis = _arg_1;
            }, "numInput.dis");
            result[6] = binding;
            return (result);
        }

        private function init():void
        {
            this.troopEuDef = TroopEumDefine.getTroopEumByType(troopType);
            this.imgSrc = ImageManager.getTroopSmallLogo(troopType);
            if (c != null)
            {
                c.unwatch();
            };
        }

        public function ___TroopInput_Image1_mouseMove(_arg_1:MouseEvent):void
        {
            onArmyMouseMove(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get maxLimit():int
        {
            return (this._390231223maxLimit);
        }

        public function ___TroopInput_Image1_mouseOver(_arg_1:MouseEvent):void
        {
            showArmyTooltip(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get limit():int
        {
            return (this._102976443limit);
        }

        [Bindable(event="propertyChange")]
        public function get troopType():int
        {
            return (this._618148268troopType);
        }

        public function set numInput(_arg_1:NumberRegulate):void
        {
            var _local_2:Object = this._1909260316numInput;
            if (_local_2 !== _arg_1)
            {
                this._1909260316numInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "numInput", _local_2, _arg_1));
            };
        }

        private function set imgSrc(_arg_1:Object):void
        {
            var _local_2:Object = this._1185090783imgSrc;
            if (_local_2 !== _arg_1)
            {
                this._1185090783imgSrc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "imgSrc", _local_2, _arg_1));
            };
        }

        public function ___TroopInput_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        public function get buttonFlag():int
        {
            return (this._358134206buttonFlag);
        }

        public function set troopType(_arg_1:int):void
        {
            var _local_2:Object = this._618148268troopType;
            if (_local_2 !== _arg_1)
            {
                this._618148268troopType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopType", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get numInput():NumberRegulate
        {
            return (this._1909260316numInput);
        }

        private function onArmyMouseMove(_arg_1:MouseEvent):void
        {
            ArmyInfoTooltip.move2Mouse(_arg_1);
        }

        public function ___TroopInput_Image1_mouseOut(_arg_1:MouseEvent):void
        {
            hideArmyTooltip();
        }

        private function showArmyTooltip(_arg_1:MouseEvent):void
        {
            ArmyInfoTooltip.show(this.troopType, _arg_1);
        }

        public function set distance(_arg_1:Number):void
        {
            var _local_2:Object = this._288459765distance;
            if (_local_2 !== _arg_1)
            {
                this._288459765distance = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "distance", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get distance():Number
        {
            return (this._288459765distance);
        }

        public function set fun(_arg_1:Function):void
        {
            var _local_2:Object = this._101759fun;
            if (_local_2 !== _arg_1)
            {
                this._101759fun = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fun", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get fun():Function
        {
            return (this._101759fun);
        }


    }
}//package view.module.trainningField

