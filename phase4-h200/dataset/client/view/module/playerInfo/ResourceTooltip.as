// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.ResourceTooltip

package view.module.playerInfo
{
    import view.ui.BaseTooltip;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.ColorLabel;
    import mx.controls.Label;
    import mx.controls.Text;
    import com.evony.common.beans.ResourceInfoBean;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Image;
    import mx.core.mx_internal;
    import com.evony.Lang;
    import com.evony.Context;
    import com.evony.common.constants.ColonyConstants;
    import com.evony.util.UIUtil;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
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

    public class ResourceTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _646773496amountTxt:ColorLabel;
        public var _ResourceTooltip_Label1:Label;
        public var _ResourceTooltip_Label2:Label;
        public var _ResourceTooltip_Label3:Label;
        public var _ResourceTooltip_Label4:Label;
        public var _ResourceTooltip_Label5:Label;
        public var _ResourceTooltip_Label6:Label;
        private var _676507419typeName:String;
        private var _106248338maxColorStyle:String;
        public var _ResourceTooltip_Text1:Text;
        private var _1508118377colonyValue:Number;
        public var _ResourceTooltip_ColorLabel2:ColorLabel;
        public var _ResourceTooltip_ColorLabel3:ColorLabel;
        private var _3019696bean:ResourceInfoBean;
        private var typeId:int = 0;

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
                            return ({
                                "styleName":"tooltip",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ResourceTooltip_Label1",
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
                                                            "id":"_ResourceTooltip_Label2",
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
                                                            "id":"_ResourceTooltip_Label3",
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
                                                            "id":"_ResourceTooltip_ColorLabel2",
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
                                                            "id":"_ResourceTooltip_Label4",
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
                                                            "id":"_ResourceTooltip_Label5",
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
                                                            "id":"_ResourceTooltip_Label6",
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
                                                            "id":"_ResourceTooltip_ColorLabel3",
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
                                    "id":"_ResourceTooltip_Text1",
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
                                })]
                            });
                        }
                    })]});
            }
        });
        private var watchers:Array = [];
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ResourceTooltip()
        {
            mx_internal::_document = this;
            this.styleName = "tooltips";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ResourceTooltip._watcherSetupUtil = _arg_1;
        }


        public function set _typeName(_arg_1:int):void
        {
            switch (_arg_1)
            {
                case 1:
                    this.typeName = Lang.msg("木材");
                    this.typeId = 1;
                    return;
                case 2:
                    this.typeName = Lang.msg("石料");
                    this.typeId = 2;
                    return;
                case 3:
                    this.typeName = Lang.msg("铁矿");
                    this.typeId = 3;
                    return;
            };
        }

        private function _ResourceTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.typeName;
            _local_1 = (Lang.msg("当前数量") + ": ");
            _local_1 = Math.floor(this.bean.amount);
            _local_1 = this.maxColorStyle;
            _local_1 = (Lang.msg("容量上限") + ": ");
            _local_1 = Math.floor(this.bean.max);
            _local_1 = ((Context.getInstance().getCurCastle().colonization == ColonyConstants.CASTLE_COLONIZATION_SUZERAIN) ? "Colonies Tributes" : "Tributes paid");
            _local_1 = UIUtil.FormatInt(colonyValue);
            _local_1 = (Lang.msg("实际产量") + ": ");
            _local_1 = Math.floor((this.bean.increaseRate + colonyValue));
            _local_1 = Lang.msg("资源信息提示");
        }

        [Bindable(event="propertyChange")]
        private function get maxColorStyle():String
        {
            return (this._106248338maxColorStyle);
        }

        [Bindable(event="propertyChange")]
        private function get colonyValue():Number
        {
            return (this._1508118377colonyValue);
        }

        override public function initialize():void
        {
            var target:ResourceTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ResourceTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_ResourceTooltipWatcherSetupUtil");
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

        public function set onReouceChange(_arg_1:int):void
        {
            maxColorStyle = ((int(this.bean.amount) > 0) ? "tooltipsValue1" : "tooltipsValue3");
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

        private function set colonyValue(_arg_1:Number):void
        {
            var _local_2:Object = this._1508118377colonyValue;
            if (_local_2 !== _arg_1)
            {
                this._1508118377colonyValue = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyValue", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get bean():ResourceInfoBean
        {
            return (this._3019696bean);
        }

        private function _ResourceTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.typeName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceTooltip_Label1.text = _arg_1;
            }, "_ResourceTooltip_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("当前数量") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceTooltip_Label2.text = _arg_1;
            }, "_ResourceTooltip_Label2.text");
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
                _ResourceTooltip_Label3.text = _arg_1;
            }, "_ResourceTooltip_Label3.text");
            result[4] = binding;
            binding = new Binding(this, function ():Number
            {
                return (Math.floor(this.bean.max));
            }, function (_arg_1:Number):void
            {
                _ResourceTooltip_ColorLabel2.myText = _arg_1;
            }, "_ResourceTooltip_ColorLabel2.myText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Context.getInstance().getCurCastle().colonization == ColonyConstants.CASTLE_COLONIZATION_SUZERAIN) ? "Colonies Tributes" : "Tributes paid");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceTooltip_Label4.text = _arg_1;
            }, "_ResourceTooltip_Label4.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(colonyValue);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceTooltip_Label5.text = _arg_1;
            }, "_ResourceTooltip_Label5.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("实际产量") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceTooltip_Label6.text = _arg_1;
            }, "_ResourceTooltip_Label6.text");
            result[8] = binding;
            binding = new Binding(this, function ():Number
            {
                return (Math.floor((this.bean.increaseRate + colonyValue)));
            }, function (_arg_1:Number):void
            {
                _ResourceTooltip_ColorLabel3.myText = _arg_1;
            }, "_ResourceTooltip_ColorLabel3.myText");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("资源信息提示");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceTooltip_Text1.text = _arg_1;
            }, "_ResourceTooltip_Text1.text");
            result[10] = binding;
            return (result);
        }

        override public function refresh():void
        {
            var _local_1:ChangeWatcher;
            if (this.typeId != 0)
            {
                switch (this.typeId)
                {
                    case 1:
                        this.bean = Context.getInstance().getCurCastle().resource.wood;
                        this.colonyValue = Context.getInstance().getCurCastle().resource.colonyWood;
                        break;
                    case 2:
                        this.bean = Context.getInstance().getCurCastle().resource.stone;
                        this.colonyValue = Context.getInstance().getCurCastle().resource.colonyStone;
                        break;
                    case 3:
                        this.bean = Context.getInstance().getCurCastle().resource.iron;
                        this.colonyValue = Context.getInstance().getCurCastle().resource.colonyIron;
                        break;
                };
                for each (_local_1 in this.watchers)
                {
                    _local_1.unwatch();
                };
                watchers[0] = BindingUtils.bindProperty(this, "onReouceChange", bean, "amount");
                watchers[1] = BindingUtils.bindProperty(this, "onReouceChange", bean, "increaseRate");
            };
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

        private function set typeName(_arg_1:String):void
        {
            var _local_2:Object = this._676507419typeName;
            if (_local_2 !== _arg_1)
            {
                this._676507419typeName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get typeName():String
        {
            return (this._676507419typeName);
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


    }
}//package view.module.playerInfo

