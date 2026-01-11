// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.FoodTooltip

package view.module.playerInfo
{
    import view.ui.BaseTooltip;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.ColorLabel;
    import mx.controls.Label;
    import com.evony.common.beans.CastleResourceBean;
    import com.evony.common.beans.ResourceInfoBean;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Image;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import com.evony.Lang;
    import com.evony.Context;
    import com.evony.common.constants.ColonyConstants;
    import com.evony.util.UIUtil;
    import flash.utils.getDefinitionByName;
    import mx.binding.utils.ChangeWatcher;
    import mx.binding.utils.BindingUtils;
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

    public class FoodTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _646773496amountTxt:ColorLabel;
        public var _FoodTooltip_ColorLabel2:ColorLabel;
        private var _1916557630actualOutputStyle:String;
        private var _344734926increaseRateTxt:ColorLabel;
        public var _FoodTooltip_Label10:Label;
        private var _153687562castleResourceBean:CastleResourceBean;
        private var _106248338maxColorStyle:String;
        private var _1638798203yieldColorStyle:String;
        private var _848170085consumption:int;
        private var _775408687actualOutput:int;
        private var _542315307consumptionTxt:ColorLabel;
        private var _1866161089actualOutputTxt:ColorLabel;
        public var _FoodTooltip_Label2:Label;
        public var _FoodTooltip_Label3:Label;
        public var _FoodTooltip_Label4:Label;
        public var _FoodTooltip_Label5:Label;
        public var _FoodTooltip_Label6:Label;
        public var _FoodTooltip_Label7:Label;
        public var _FoodTooltip_Label8:Label;
        public var _FoodTooltip_Label9:Label;
        private var _3019696bean:ResourceInfoBean;
        public var _FoodTooltip_Text1:Text;
        private var _891695499armyColorStyle:String;
        public var _FoodTooltip_Label1:Label;
        private var _1489939320consumptionColor:int;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "5";
                            this.top = "5";
                            this.right = "5";
                            this.bottom = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_FoodTooltip_Label1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"controls/Public/line1.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_FoodTooltip_Label2",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"PropertyName1",
                                                                                "width":150
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":ColorLabel,
                                                                        "id":"amountTxt",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":100});
                                                                        }
                                                                    })]});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Image,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"source":"controls/Public/line1.png"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_FoodTooltip_Label3",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"PropertyName1",
                                                                                "width":150
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":ColorLabel,
                                                                        "id":"_FoodTooltip_ColorLabel2",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"tooltipsValue1",
                                                                                "percentWidth":100
                                                                            });
                                                                        }
                                                                    })]});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Image,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"source":"controls/Public/line1.png"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_FoodTooltip_Label4",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"PropertyName1",
                                                                                "width":150
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":ColorLabel,
                                                                        "id":"increaseRateTxt",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"tooltipsValue1",
                                                                                "percentWidth":100
                                                                            });
                                                                        }
                                                                    })]});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Image,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"source":"controls/Public/line1.png"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_FoodTooltip_Label5",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"PropertyName1",
                                                                                "width":150
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_FoodTooltip_Label6",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"tooltipsValue1",
                                                                                "percentWidth":100
                                                                            });
                                                                        }
                                                                    })]});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Image,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"source":"controls/Public/line1.png"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_FoodTooltip_Label7",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"PropertyName1",
                                                                                "width":150
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_FoodTooltip_Label8",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"tooltipsValue1",
                                                                                "percentWidth":100
                                                                            });
                                                                        }
                                                                    })]});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Image,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"source":"controls/Public/line1.png"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_FoodTooltip_Label9",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"PropertyName1",
                                                                                "width":150
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":ColorLabel,
                                                                        "id":"consumptionTxt",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":100});
                                                                        }
                                                                    })]});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Image,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"source":"controls/Public/line1.png"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_FoodTooltip_Label10",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"PropertyName1",
                                                                                "width":150
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":ColorLabel,
                                                                        "id":"actualOutputTxt",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":100});
                                                                        }
                                                                    })]});
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"controls/Public/line1.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_FoodTooltip_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":99,
                                            "styleName":"ParamgraphText1"
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        private var watchers:Array = [];
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function FoodTooltip()
        {
            mx_internal::_document = this;
            this.styleName = "tooltips";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            FoodTooltip._watcherSetupUtil = _arg_1;
        }


        private function set actualOutput(_arg_1:int):void
        {
            var _local_2:Object = this._775408687actualOutput;
            if (_local_2 !== _arg_1)
            {
                this._775408687actualOutput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "actualOutput", _local_2, _arg_1));
            };
        }

        private function set actualOutputStyle(_arg_1:String):void
        {
            var _local_2:Object = this._1916557630actualOutputStyle;
            if (_local_2 !== _arg_1)
            {
                this._1916557630actualOutputStyle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "actualOutputStyle", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get yieldColorStyle():String
        {
            return (this._1638798203yieldColorStyle);
        }

        [Bindable(event="propertyChange")]
        private function get armyColorStyle():String
        {
            return (this._891695499armyColorStyle);
        }

        [Bindable(event="propertyChange")]
        private function get castleResourceBean():CastleResourceBean
        {
            return (this._153687562castleResourceBean);
        }

        private function _FoodTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("粮食");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FoodTooltip_Label1.text = _arg_1;
            }, "_FoodTooltip_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("当前数量") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FoodTooltip_Label2.text = _arg_1;
            }, "_FoodTooltip_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():Number
            {
                return (Math.floor(this.bean.amount));
            }, function (_arg_1:Number):void
            {
                amountTxt.myText = _arg_1;
            }, "amountTxt.myText");
            result[2] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.maxColorStyle);
            }, function (_arg_1:Object):void
            {
                amountTxt.styleName = _arg_1;
            }, "amountTxt.styleName");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("容量上限") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FoodTooltip_Label3.text = _arg_1;
            }, "_FoodTooltip_Label3.text");
            result[4] = binding;
            binding = new Binding(this, function ():Number
            {
                return (Math.floor(this.bean.max));
            }, function (_arg_1:Number):void
            {
                _FoodTooltip_ColorLabel2.myText = _arg_1;
            }, "_FoodTooltip_ColorLabel2.myText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("粮食产量") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FoodTooltip_Label4.text = _arg_1;
            }, "_FoodTooltip_Label4.text");
            result[6] = binding;
            binding = new Binding(this, function ():Number
            {
                return (Math.floor(this.bean.increaseRate));
            }, function (_arg_1:Number):void
            {
                increaseRateTxt.myText = _arg_1;
            }, "increaseRateTxt.myText");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Context.getInstance().getCurCastle().colonization == ColonyConstants.CASTLE_COLONIZATION_SUZERAIN) ? "Colonies Tributes:" : "Tributes paid:");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FoodTooltip_Label5.text = _arg_1;
            }, "_FoodTooltip_Label5.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(Context.getInstance().getCurCastle().resource.colonyFood);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FoodTooltip_Label6.text = _arg_1;
            }, "_FoodTooltip_Label6.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Context.getInstance().getCurCastle().resource.supplyFood >= 0) ? "Supplied from other cities:" : "Supplies to other cities:");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FoodTooltip_Label7.text = _arg_1;
            }, "_FoodTooltip_Label7.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(Context.getInstance().getCurCastle().resource.supplyFood);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FoodTooltip_Label8.text = _arg_1;
            }, "_FoodTooltip_Label8.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("军队耗粮") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FoodTooltip_Label9.text = _arg_1;
            }, "_FoodTooltip_Label9.text");
            result[12] = binding;
            binding = new Binding(this, function ():Number
            {
                return (Math.floor(this.consumption));
            }, function (_arg_1:Number):void
            {
                consumptionTxt.myText = _arg_1;
            }, "consumptionTxt.myText");
            result[13] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.armyColorStyle);
            }, function (_arg_1:Object):void
            {
                consumptionTxt.styleName = _arg_1;
            }, "consumptionTxt.styleName");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("实际产量") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FoodTooltip_Label10.text = _arg_1;
            }, "_FoodTooltip_Label10.text");
            result[15] = binding;
            binding = new Binding(this, function ():Number
            {
                return (Math.floor(this.actualOutput));
            }, function (_arg_1:Number):void
            {
                actualOutputTxt.myText = _arg_1;
            }, "actualOutputTxt.myText");
            result[16] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.yieldColorStyle);
            }, function (_arg_1:Object):void
            {
                actualOutputTxt.styleName = _arg_1;
            }, "actualOutputTxt.styleName");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("资源信息提示");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FoodTooltip_Text1.text = _arg_1;
            }, "_FoodTooltip_Text1.text");
            result[18] = binding;
            return (result);
        }

        public function set actualOutputTxt(_arg_1:ColorLabel):void
        {
            var _local_2:Object = this._1866161089actualOutputTxt;
            if (_local_2 !== _arg_1)
            {
                this._1866161089actualOutputTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "actualOutputTxt", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get maxColorStyle():String
        {
            return (this._106248338maxColorStyle);
        }

        public function set onReouceChange(_arg_1:int):void
        {
            this.consumption = -(this.castleResourceBean.troopCostFood);
            this.actualOutput = Math.floor((((this.bean.increaseRate + this.consumption) + Context.getInstance().getCurCastle().resource.colonyFood) + Context.getInstance().getCurCastle().resource.supplyFood));
            this.actualOutputStyle = ((this.actualOutput > 0) ? "tooltipsValue2" : "tooltipsValue3");
            this.maxColorStyle = ((this.actualOutput > 0) ? "tooltipsValue1" : "tooltipsValue3");
            this.armyColorStyle = ((Context.getInstance().getCurCastle().resource.troopCostFood > 0) ? "tooltipsValue3" : "tooltipsValue1");
            this.yieldColorStyle = ((this.actualOutput > 0) ? "tooltipsValue1" : "tooltipsValue3");
        }

        public function set increaseRateTxt(_arg_1:ColorLabel):void
        {
            var _local_2:Object = this._344734926increaseRateTxt;
            if (_local_2 !== _arg_1)
            {
                this._344734926increaseRateTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "increaseRateTxt", _local_2, _arg_1));
            };
        }

        private function set armyColorStyle(_arg_1:String):void
        {
            var _local_2:Object = this._891695499armyColorStyle;
            if (_local_2 !== _arg_1)
            {
                this._891695499armyColorStyle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyColorStyle", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:FoodTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _FoodTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_FoodTooltipWatcherSetupUtil");
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
        private function get consumptionColor():int
        {
            return (this._1489939320consumptionColor);
        }

        private function set yieldColorStyle(_arg_1:String):void
        {
            var _local_2:Object = this._1638798203yieldColorStyle;
            if (_local_2 !== _arg_1)
            {
                this._1638798203yieldColorStyle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "yieldColorStyle", _local_2, _arg_1));
            };
        }

        private function set maxColorStyle(_arg_1:String):void
        {
            var _local_2:Object = this._106248338maxColorStyle;
            if (_local_2 !== _arg_1)
            {
                this._106248338maxColorStyle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxColorStyle", _local_2, _arg_1));
            };
        }

        private function set consumptionColor(_arg_1:int):void
        {
            var _local_2:Object = this._1489939320consumptionColor;
            if (_local_2 !== _arg_1)
            {
                this._1489939320consumptionColor = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "consumptionColor", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get actualOutput():int
        {
            return (this._775408687actualOutput);
        }

        public function set consumptionTxt(_arg_1:ColorLabel):void
        {
            var _local_2:Object = this._542315307consumptionTxt;
            if (_local_2 !== _arg_1)
            {
                this._542315307consumptionTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "consumptionTxt", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get consumption():int
        {
            return (this._848170085consumption);
        }

        [Bindable(event="propertyChange")]
        private function get actualOutputStyle():String
        {
            return (this._1916557630actualOutputStyle);
        }

        [Bindable(event="propertyChange")]
        public function get actualOutputTxt():ColorLabel
        {
            return (this._1866161089actualOutputTxt);
        }

        private function _FoodTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("粮食");
            _local_1 = (Lang.msg("当前数量") + ": ");
            _local_1 = Math.floor(this.bean.amount);
            _local_1 = this.maxColorStyle;
            _local_1 = (Lang.msg("容量上限") + ": ");
            _local_1 = Math.floor(this.bean.max);
            _local_1 = (Lang.msg("粮食产量") + ": ");
            _local_1 = Math.floor(this.bean.increaseRate);
            _local_1 = ((Context.getInstance().getCurCastle().colonization == ColonyConstants.CASTLE_COLONIZATION_SUZERAIN) ? "Colonies Tributes:" : "Tributes paid:");
            _local_1 = UIUtil.FormatInt(Context.getInstance().getCurCastle().resource.colonyFood);
            _local_1 = ((Context.getInstance().getCurCastle().resource.supplyFood >= 0) ? "Supplied from other cities:" : "Supplies to other cities:");
            _local_1 = UIUtil.FormatInt(Context.getInstance().getCurCastle().resource.supplyFood);
            _local_1 = (Lang.msg("军队耗粮") + ": ");
            _local_1 = Math.floor(this.consumption);
            _local_1 = this.armyColorStyle;
            _local_1 = (Lang.msg("实际产量") + ": ");
            _local_1 = Math.floor(this.actualOutput);
            _local_1 = this.yieldColorStyle;
            _local_1 = Lang.msg("资源信息提示");
        }

        [Bindable(event="propertyChange")]
        public function get consumptionTxt():ColorLabel
        {
            return (this._542315307consumptionTxt);
        }

        private function set bean(_arg_1:ResourceInfoBean):void
        {
            var _local_2:Object = this._3019696bean;
            if (_local_2 !== _arg_1)
            {
                this._3019696bean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bean", _local_2, _arg_1));
            };
        }

        override public function refresh():void
        {
            var _local_1:ChangeWatcher;
            this.bean = Context.getInstance().getCurCastle().resource.food;
            this.castleResourceBean = Context.getInstance().getCurCastle().resource;
            for each (_local_1 in this.watchers)
            {
                _local_1.unwatch();
            };
            watchers[0] = BindingUtils.bindProperty(this, "onReouceChange", bean, "amount");
            watchers[1] = BindingUtils.bindProperty(this, "onReouceChange", castleResourceBean, "troopCostFood");
        }

        private function set consumption(_arg_1:int):void
        {
            var _local_2:Object = this._848170085consumption;
            if (_local_2 !== _arg_1)
            {
                this._848170085consumption = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "consumption", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get bean():ResourceInfoBean
        {
            return (this._3019696bean);
        }

        private function set castleResourceBean(_arg_1:CastleResourceBean):void
        {
            var _local_2:Object = this._153687562castleResourceBean;
            if (_local_2 !== _arg_1)
            {
                this._153687562castleResourceBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleResourceBean", _local_2, _arg_1));
            };
        }

        public function set amountTxt(_arg_1:ColorLabel):void
        {
            var _local_2:Object = this._646773496amountTxt;
            if (_local_2 !== _arg_1)
            {
                this._646773496amountTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "amountTxt", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get amountTxt():ColorLabel
        {
            return (this._646773496amountTxt);
        }

        [Bindable(event="propertyChange")]
        public function get increaseRateTxt():ColorLabel
        {
            return (this._344734926increaseRateTxt);
        }


    }
}//package view.module.playerInfo

