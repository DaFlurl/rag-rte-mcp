// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.production.ResourceProduction

package view.module.office.production
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.NumericStepper;
    import com.evony.common.beans.ResourceProduceDataBean;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import view.ui.MyHRule;
    import com.evony.Lang;
    import com.evony.common.beans.TroopBean;
    import com.evony.Context;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.events.KeyboardEvent;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import com.evony.util.UIUtil;
    import mx.events.NumericStepperEvent;
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

    public class ResourceProduction extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1025021810myLabel6:Label;
        private var _725549318paidResource:String;
        private var _426003098myPercentage:NumericStepper;
        private var _1352500747productionTotal:int;
        private var _1060223401myName:Label;
        public var onDataChange:Function;
        private var _1958246796resourceProduceDataBean:ResourceProduceDataBean = null;
        private var receiveStr:String;
        private var _1710905144myLabel11:Label;
        private var _606023895myMaxLabour:Label;
        private var _1710905145myLabel10:Label;
        private var _1250036969myDemand:Label;
        private var _110877per:int;
        private var _lookLabelOnOff:String = "ON";
        private var _2145056751receiveResource:String;
        private var _1025021807myLabel9:Label;
        private var paidStr:String;
        private var _1025021809myLabel7:Label;
        private var _1025021808myLabel8:Label;
        private var _1025021815myLabel1:Label;
        private var _1025021811myLabel5:Label;
        private var _1025021813myLabel3:Label;
        private var _1023856850productivity:Number;
        private var _1025021814myLabel2:Label;
        private var _1415454966armyCost:int = 0;
        private var _1025021812myLabel4:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalAlign = "center";
                            this.verticalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentHeight":100,
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "1";
                                        this.right = "1";
                                        this.top = "1";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":27,
                                            "styleName":"textBackGroundFillColor",
                                            "verticalScrollPolicy":"off",
                                            "horizontalScrollPolicy":"off",
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"myName",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "center";
                                                    this.verticalCenter = "4";
                                                    this.horizontalCenter = "0";
                                                    this.fontSize = 13;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "styleName":"focusColor"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"myLabel1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":22,
                                            "styleName":"tableContent2"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"myMaxLabour",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":22,
                                            "styleName":"tableContent2"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"myDemand",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":22,
                                            "styleName":"tableContent2"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":NumericStepper,
                                    "id":"myPercentage",
                                    "events":{
                                        "change":"__myPercentage_change",
                                        "keyUp":"__myPercentage_keyUp"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "minimum":0,
                                            "maximum":100,
                                            "width":80,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"myLabel2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"tableContent7",
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"myLabel10",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"tableContent2",
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"myLabel11",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"myLabel3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":22,
                                            "styleName":"tableContent2"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"myLabel4",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":22,
                                            "styleName":"tableContent2"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"myLabel5",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"myLabel6",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"myLabel7",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"myLabel8",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"myLabel9",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var _676507419typeName:String = Lang.msg("总体的");
        private var _1843183744_troops:TroopBean = Context.getInstance().getCurCastle().troop;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ResourceProduction()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ResourceProduction._watcherSetupUtil = _arg_1;
        }


        private function set _troops(_arg_1:TroopBean):void
        {
            var _local_2:Object = this._1843183744_troops;
            if (_local_2 !== _arg_1)
            {
                this._1843183744_troops = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_troops", _local_2, _arg_1));
            };
        }

        public function set myMaxLabour(_arg_1:Label):void
        {
            var _local_2:Object = this._606023895myMaxLabour;
            if (_local_2 !== _arg_1)
            {
                this._606023895myMaxLabour = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myMaxLabour", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get typeName():String
        {
            return (this._676507419typeName);
        }

        [Bindable(event="propertyChange")]
        private function get armyCost():int
        {
            return (this._1415454966armyCost);
        }

        [Bindable(event="propertyChange")]
        private function get productionTotal():int
        {
            return (this._1352500747productionTotal);
        }

        [Bindable(event="propertyChange")]
        public function get myMaxLabour():Label
        {
            return (this._606023895myMaxLabour);
        }

        public function set myName(_arg_1:Label):void
        {
            var _local_2:Object = this._1060223401myName;
            if (_local_2 !== _arg_1)
            {
                this._1060223401myName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myName", _local_2, _arg_1));
            };
        }

        private function _ResourceProduction_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.typeName;
            _local_1 = this.resourceProduceDataBean.productionCapacity;
            _local_1 = this.resourceProduceDataBean.maxLabour;
            _local_1 = int(((this.resourceProduceDataBean.maxLabour * this.myPercentage.value) / 100));
            _local_1 = int((((this.resourceProduceDataBean.productionCapacity * this.myPercentage.value) * productivity) / 10000));
            _local_1 = this.receiveResource;
            _local_1 = this.paidResource;
            _local_1 = ((parseInt(this.paidResource) >= 0) ? "tableContent2" : "tableContent4");
            _local_1 = int(this.resourceProduceDataBean.naturalPercentage);
            _local_1 = int((((this.resourceProduceDataBean.technologicalPercentage * this.myPercentage.value) * productivity) / 10000));
            _local_1 = this.armyCost;
            _local_1 = ((this.armyCost >= 0) ? "tableContent2" : "tableContent4");
            _local_1 = int((((this.resourceProduceDataBean.heroPercentage * this.myPercentage.value) * productivity) / 10000));
            _local_1 = int((((this.resourceProduceDataBean.fieldPercentage * this.myPercentage.value) * productivity) / 10000));
            _local_1 = int((((this.resourceProduceDataBean.cimeliaPercentage * this.myPercentage.value) * productivity) / 10000));
            _local_1 = this.productionTotal;
            _local_1 = ((this.productionTotal > 0) ? "tableContent7" : "tableContent4");
        }

        public function set myLabel2(_arg_1:Label):void
        {
            var _local_2:Object = this._1025021814myLabel2;
            if (_local_2 !== _arg_1)
            {
                this._1025021814myLabel2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myLabel2", _local_2, _arg_1));
            };
        }

        public function set myLabel3(_arg_1:Label):void
        {
            var _local_2:Object = this._1025021813myLabel3;
            if (_local_2 !== _arg_1)
            {
                this._1025021813myLabel3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myLabel3", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get myDemand():Label
        {
            return (this._1250036969myDemand);
        }

        public function set myLabel4(_arg_1:Label):void
        {
            var _local_2:Object = this._1025021812myLabel4;
            if (_local_2 !== _arg_1)
            {
                this._1025021812myLabel4 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myLabel4", _local_2, _arg_1));
            };
        }

        public function set myLabel1(_arg_1:Label):void
        {
            var _local_2:Object = this._1025021815myLabel1;
            if (_local_2 !== _arg_1)
            {
                this._1025021815myLabel1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myLabel1", _local_2, _arg_1));
            };
        }

        public function set myLabel5(_arg_1:Label):void
        {
            var _local_2:Object = this._1025021811myLabel5;
            if (_local_2 !== _arg_1)
            {
                this._1025021811myLabel5 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myLabel5", _local_2, _arg_1));
            };
        }

        public function set myLabel6(_arg_1:Label):void
        {
            var _local_2:Object = this._1025021810myLabel6;
            if (_local_2 !== _arg_1)
            {
                this._1025021810myLabel6 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myLabel6", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get per():int
        {
            return (this._110877per);
        }

        public function set myLabel7(_arg_1:Label):void
        {
            var _local_2:Object = this._1025021809myLabel7;
            if (_local_2 !== _arg_1)
            {
                this._1025021809myLabel7 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myLabel7", _local_2, _arg_1));
            };
        }

        private function set resourceProduceDataBean(_arg_1:ResourceProduceDataBean):void
        {
            var _local_2:Object = this._1958246796resourceProduceDataBean;
            if (_local_2 !== _arg_1)
            {
                this._1958246796resourceProduceDataBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resourceProduceDataBean", _local_2, _arg_1));
            };
        }

        public function set myLabel8(_arg_1:Label):void
        {
            var _local_2:Object = this._1025021808myLabel8;
            if (_local_2 !== _arg_1)
            {
                this._1025021808myLabel8 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myLabel8", _local_2, _arg_1));
            };
        }

        public function __myPercentage_keyUp(_arg_1:KeyboardEvent):void
        {
            eventChange();
        }

        private function set armyCost(_arg_1:int):void
        {
            var _local_2:Object = this._1415454966armyCost;
            if (_local_2 !== _arg_1)
            {
                this._1415454966armyCost = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyCost", _local_2, _arg_1));
            };
        }

        private function set productionTotal(_arg_1:int):void
        {
            var _local_2:Object = this._1352500747productionTotal;
            if (_local_2 !== _arg_1)
            {
                this._1352500747productionTotal = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "productionTotal", _local_2, _arg_1));
            };
        }

        public function set myLabel9(_arg_1:Label):void
        {
            var _local_2:Object = this._1025021807myLabel9;
            if (_local_2 !== _arg_1)
            {
                this._1025021807myLabel9 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myLabel9", _local_2, _arg_1));
            };
        }

        public function set myDemand(_arg_1:Label):void
        {
            var _local_2:Object = this._1250036969myDemand;
            if (_local_2 !== _arg_1)
            {
                this._1250036969myDemand = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myDemand", _local_2, _arg_1));
            };
        }

        private function set per(_arg_1:int):void
        {
            var _local_2:Object = this._110877per;
            if (_local_2 !== _arg_1)
            {
                this._110877per = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "per", _local_2, _arg_1));
            };
        }

        public function set myProductivity(_arg_1:Number):void
        {
            this.productivity = _arg_1;
            reFresh();
        }

        [Bindable(event="propertyChange")]
        private function get receiveResource():String
        {
            return (this._2145056751receiveResource);
        }

        private function set receiveResource(_arg_1:String):void
        {
            var _local_2:Object = this._2145056751receiveResource;
            if (_local_2 !== _arg_1)
            {
                this._2145056751receiveResource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "receiveResource", _local_2, _arg_1));
            };
        }

        private function _ResourceProduction_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.typeName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myName.text = _arg_1;
            }, "myName.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.resourceProduceDataBean.productionCapacity;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myLabel1.text = _arg_1;
            }, "myLabel1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.resourceProduceDataBean.maxLabour;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myMaxLabour.text = _arg_1;
            }, "myMaxLabour.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = int(((this.resourceProduceDataBean.maxLabour * this.myPercentage.value) / 100));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myDemand.text = _arg_1;
            }, "myDemand.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = int((((this.resourceProduceDataBean.productionCapacity * this.myPercentage.value) * productivity) / 10000));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myLabel2.text = _arg_1;
            }, "myLabel2.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.receiveResource;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myLabel10.text = _arg_1;
            }, "myLabel10.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.paidResource;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myLabel11.text = _arg_1;
            }, "myLabel11.text");
            result[6] = binding;
            binding = new Binding(this, function ():Object
            {
                return ((parseInt(this.paidResource) >= 0) ? "tableContent2" : "tableContent4");
            }, function (_arg_1:Object):void
            {
                myLabel11.styleName = _arg_1;
            }, "myLabel11.styleName");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = int(this.resourceProduceDataBean.naturalPercentage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myLabel3.text = _arg_1;
            }, "myLabel3.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = int((((this.resourceProduceDataBean.technologicalPercentage * this.myPercentage.value) * productivity) / 10000));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myLabel4.text = _arg_1;
            }, "myLabel4.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.armyCost;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myLabel5.text = _arg_1;
            }, "myLabel5.text");
            result[10] = binding;
            binding = new Binding(this, function ():Object
            {
                return ((this.armyCost >= 0) ? "tableContent2" : "tableContent4");
            }, function (_arg_1:Object):void
            {
                myLabel5.styleName = _arg_1;
            }, "myLabel5.styleName");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = int((((this.resourceProduceDataBean.heroPercentage * this.myPercentage.value) * productivity) / 10000));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myLabel6.text = _arg_1;
            }, "myLabel6.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = int((((this.resourceProduceDataBean.fieldPercentage * this.myPercentage.value) * productivity) / 10000));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myLabel7.text = _arg_1;
            }, "myLabel7.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = int((((this.resourceProduceDataBean.cimeliaPercentage * this.myPercentage.value) * productivity) / 10000));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myLabel8.text = _arg_1;
            }, "myLabel8.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.productionTotal;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myLabel9.text = _arg_1;
            }, "myLabel9.text");
            result[15] = binding;
            binding = new Binding(this, function ():Object
            {
                return ((this.productionTotal > 0) ? "tableContent7" : "tableContent4");
            }, function (_arg_1:Object):void
            {
                myLabel9.styleName = _arg_1;
            }, "myLabel9.styleName");
            result[16] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get myName():Label
        {
            return (this._1060223401myName);
        }

        [Bindable(event="propertyChange")]
        public function get myPercentage():NumericStepper
        {
            return (this._426003098myPercentage);
        }

        public function countTotal():void
        {
            if (((!(this.resourceProduceDataBean == null)) && (!(this.paidResource == null))))
            {
                trace(("上缴：" + parseInt(this.paidResource)));
                this.productionTotal = ((((((((int((((this.resourceProduceDataBean.productionCapacity * this.myPercentage.value) * productivity) / 10000)) + int(this.resourceProduceDataBean.naturalPercentage)) + int((((this.resourceProduceDataBean.technologicalPercentage * this.myPercentage.value) * productivity) / 10000))) + this.armyCost) + int((((this.resourceProduceDataBean.heroPercentage * this.myPercentage.value) * productivity) / 10000))) + int((((this.resourceProduceDataBean.fieldPercentage * this.myPercentage.value) * productivity) / 10000))) + int((((this.resourceProduceDataBean.cimeliaPercentage * this.myPercentage.value) * productivity) / 10000))) + parseInt(this.receiveStr)) + parseInt(this.paidStr));
            };
        }

        public function set myResourceProduceDataBean(_arg_1:ResourceProduceDataBean):void
        {
            this.resourceProduceDataBean = _arg_1;
            this.myPercentage.value = this.resourceProduceDataBean.commenceRate;
            countTotal();
            switch (resourceProduceDataBean.typeid)
            {
                case 1:
                    this.typeName = Lang.msg("粮食");
                    this.armyCost = -(Context.getInstance().getCurCastle().resource.troopCostFood);
                    return;
                case 2:
                    this.typeName = Lang.msg("木材");
                    return;
                case 3:
                    this.typeName = Lang.msg("石料");
                    return;
                case 4:
                    this.typeName = Lang.msg("铁矿");
                    return;
            };
        }

        [Bindable(event="propertyChange")]
        private function get _troops():TroopBean
        {
            return (this._1843183744_troops);
        }

        [Bindable(event="propertyChange")]
        public function get myLabel1():Label
        {
            return (this._1025021815myLabel1);
        }

        [Bindable(event="propertyChange")]
        public function get myLabel4():Label
        {
            return (this._1025021812myLabel4);
        }

        [Bindable(event="propertyChange")]
        public function get myLabel5():Label
        {
            return (this._1025021811myLabel5);
        }

        public function set myLabel10(_arg_1:Label):void
        {
            var _local_2:Object = this._1710905145myLabel10;
            if (_local_2 !== _arg_1)
            {
                this._1710905145myLabel10 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myLabel10", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get myLabel7():Label
        {
            return (this._1025021809myLabel7);
        }

        [Bindable(event="propertyChange")]
        public function get myLabel8():Label
        {
            return (this._1025021808myLabel8);
        }

        [Bindable(event="propertyChange")]
        public function get myLabel2():Label
        {
            return (this._1025021814myLabel2);
        }

        [Bindable(event="propertyChange")]
        public function get myLabel3():Label
        {
            return (this._1025021813myLabel3);
        }

        [Bindable(event="propertyChange")]
        public function get myLabel6():Label
        {
            return (this._1025021810myLabel6);
        }

        override public function initialize():void
        {
            var target:ResourceProduction;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ResourceProduction_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_production_ResourceProductionWatcherSetupUtil");
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

        [Bindable(event="propertyChange")]
        private function get resourceProduceDataBean():ResourceProduceDataBean
        {
            return (this._1958246796resourceProduceDataBean);
        }

        [Bindable(event="propertyChange")]
        public function get myLabel9():Label
        {
            return (this._1025021807myLabel9);
        }

        public function set _receiveResource(_arg_1:Number):void
        {
            this.receiveStr = String(_arg_1);
            this.receiveResource = UIUtil.FormatInt(_arg_1);
        }

        public function set myLabel11(_arg_1:Label):void
        {
            var _local_2:Object = this._1710905144myLabel11;
            if (_local_2 !== _arg_1)
            {
                this._1710905144myLabel11 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myLabel11", _local_2, _arg_1));
            };
        }

        private function set productivity(_arg_1:Number):void
        {
            var _local_2:Object = this._1023856850productivity;
            if (_local_2 !== _arg_1)
            {
                this._1023856850productivity = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "productivity", _local_2, _arg_1));
            };
        }

        public function set _paidResource(_arg_1:Number):void
        {
            this.paidStr = String(_arg_1);
            this.paidResource = UIUtil.FormatInt(_arg_1);
        }

        private function reFresh():void
        {
            countTotal();
        }

        [Bindable(event="propertyChange")]
        public function get myLabel10():Label
        {
            return (this._1710905145myLabel10);
        }

        [Bindable(event="propertyChange")]
        public function get myLabel11():Label
        {
            return (this._1710905144myLabel11);
        }

        private function set typeName(_arg_1:String):void
        {
            var _local_2:Object = this._676507419typeName;
            if (_local_2 !== _arg_1)
            {
                this._676507419typeName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeName", _local_2, _arg_1));
            };
        }

        public function __myPercentage_change(_arg_1:NumericStepperEvent):void
        {
            eventChange();
        }

        [Bindable(event="propertyChange")]
        private function get productivity():Number
        {
            return (this._1023856850productivity);
        }

        public function set myPercentage(_arg_1:NumericStepper):void
        {
            var _local_2:Object = this._426003098myPercentage;
            if (_local_2 !== _arg_1)
            {
                this._426003098myPercentage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myPercentage", _local_2, _arg_1));
            };
        }

        private function eventChange():void
        {
            if (this.onDataChange != null)
            {
                this.onDataChange.apply(this, [int(this.myDemand.text), this.resourceProduceDataBean, this.myPercentage.value]);
            };
            reFresh();
        }

        [Bindable(event="propertyChange")]
        private function get paidResource():String
        {
            return (this._725549318paidResource);
        }

        private function set paidResource(_arg_1:String):void
        {
            var _local_2:Object = this._725549318paidResource;
            if (_local_2 !== _arg_1)
            {
                this._725549318paidResource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "paidResource", _local_2, _arg_1));
            };
        }

        public function set lookLabelOnOff(_arg_1:String):void
        {
            this._lookLabelOnOff = _arg_1;
            if (this._lookLabelOnOff == "OFF")
            {
                this.myLabel1.visible = (this.myLabel2.visible = (this.myLabel3.visible = (this.myLabel4.visible = (this.myLabel5.visible = (this.myLabel6.visible = (this.myLabel7.visible = (this.myLabel8.visible = (this.myLabel9.visible = false))))))));
                this.myMaxLabour.visible = false;
                this.myDemand.visible = false;
                this.myPercentage.value = 0;
            };
        }


    }
}//package view.module.office.production

