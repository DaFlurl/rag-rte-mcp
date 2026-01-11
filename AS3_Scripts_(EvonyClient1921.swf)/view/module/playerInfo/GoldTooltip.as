// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.GoldTooltip

package view.module.playerInfo
{
    import view.ui.BaseTooltip;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.controls.Label;
    import com.evony.common.beans.CastleResourceBean;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Image;
    import mx.formatters.NumberFormatter;
    import mx.core.mx_internal;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import com.evony.util.UIUtil;
    import com.evony.Context;
    import com.evony.common.constants.ColonyConstants;
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

    public class GoldTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _2112150940heroSalary:int;
        public var _GoldTooltip_Text1:Text;
        private var _1583469176incomeStyle:String;
        private var _1257695661heroSalaryStyle:String;
        public var _GoldTooltip_Label1:Label;
        public var _GoldTooltip_Label11:Label;
        public var _GoldTooltip_Label3:Label;
        public var _GoldTooltip_Label4:Label;
        public var _GoldTooltip_Label5:Label;
        public var _GoldTooltip_Label6:Label;
        public var _GoldTooltip_Label7:Label;
        public var _GoldTooltip_Label8:Label;
        public var _GoldTooltip_Label9:Label;
        private var _3019696bean:CastleResourceBean;
        public var _GoldTooltip_Label10:Label;
        public var _GoldTooltip_Label2:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalAlign = "center";
                            this.left = "5";
                            this.right = "5";
                            this.top = "5";
                            this.bottom = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"tooltip",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_GoldTooltip_Label1",
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
                                                            "id":"_GoldTooltip_Label2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "width":120
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_GoldTooltip_Label3",
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
                                                            "id":"_GoldTooltip_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "width":120
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_GoldTooltip_Label5",
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
                                                            "id":"_GoldTooltip_Label6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "width":120
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_GoldTooltip_Label7",
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
                                                            "id":"_GoldTooltip_Label8",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "width":120
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_GoldTooltip_Label9",
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
                                                            "id":"_GoldTooltip_Label10",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "width":120
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_GoldTooltip_Label11",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":100});
                                                            }
                                                        })]});
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
                                    "id":"_GoldTooltip_Text1",
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
        public var formatter:NumberFormatter = new NumberFormatter();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function GoldTooltip()
        {
            mx_internal::_document = this;
            this.styleName = "tooltips";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            GoldTooltip._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get incomeStyle():String
        {
            return (this._1583469176incomeStyle);
        }

        override public function initialize():void
        {
            var target:GoldTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _GoldTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_GoldTooltipWatcherSetupUtil");
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

        private function set incomeStyle(_arg_1:String):void
        {
            var _local_2:Object = this._1583469176incomeStyle;
            if (_local_2 !== _arg_1)
            {
                this._1583469176incomeStyle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "incomeStyle", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get heroSalaryStyle():String
        {
            return (this._1257695661heroSalaryStyle);
        }

        private function _GoldTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("黄金");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldTooltip_Label1.text = _arg_1;
            }, "_GoldTooltip_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("当前数量") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldTooltip_Label2.text = _arg_1;
            }, "_GoldTooltip_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = formatter.format(UIUtil.FormatInt(this.bean.gold));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldTooltip_Label3.text = _arg_1;
            }, "_GoldTooltip_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.incomeStyle);
            }, function (_arg_1:Object):void
            {
                _GoldTooltip_Label3.styleName = _arg_1;
            }, "_GoldTooltip_Label3.styleName");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("征税收入") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldTooltip_Label4.text = _arg_1;
            }, "_GoldTooltip_Label4.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(this.bean.taxIncome);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldTooltip_Label5.text = _arg_1;
            }, "_GoldTooltip_Label5.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Context.getInstance().getCurCastle().colonization == ColonyConstants.CASTLE_COLONIZATION_SUZERAIN) ? "Colonies Tributes" : "Tributes paid");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldTooltip_Label6.text = _arg_1;
            }, "_GoldTooltip_Label6.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(this.bean.colonyGold);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldTooltip_Label7.text = _arg_1;
            }, "_GoldTooltip_Label7.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("将领俸禄") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldTooltip_Label8.text = _arg_1;
            }, "_GoldTooltip_Label8.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(heroSalary);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldTooltip_Label9.text = _arg_1;
            }, "_GoldTooltip_Label9.text");
            result[9] = binding;
            binding = new Binding(this, function ():Object
            {
                return (heroSalaryStyle);
            }, function (_arg_1:Object):void
            {
                _GoldTooltip_Label9.styleName = _arg_1;
            }, "_GoldTooltip_Label9.styleName");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("实际收入") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldTooltip_Label10.text = _arg_1;
            }, "_GoldTooltip_Label10.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(((this.bean.taxIncome - this.bean.herosSalary) + this.bean.colonyGold));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldTooltip_Label11.text = _arg_1;
            }, "_GoldTooltip_Label11.text");
            result[12] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.incomeStyle);
            }, function (_arg_1:Object):void
            {
                _GoldTooltip_Label11.styleName = _arg_1;
            }, "_GoldTooltip_Label11.styleName");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("资源信息提示");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldTooltip_Text1.text = _arg_1;
            }, "_GoldTooltip_Text1.text");
            result[14] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get bean():CastleResourceBean
        {
            return (this._3019696bean);
        }

        private function set heroSalary(_arg_1:int):void
        {
            var _local_2:Object = this._2112150940heroSalary;
            if (_local_2 !== _arg_1)
            {
                this._2112150940heroSalary = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroSalary", _local_2, _arg_1));
            };
        }

        private function _GoldTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("黄金");
            _local_1 = (Lang.msg("当前数量") + ": ");
            _local_1 = formatter.format(UIUtil.FormatInt(this.bean.gold));
            _local_1 = this.incomeStyle;
            _local_1 = (Lang.msg("征税收入") + ": ");
            _local_1 = UIUtil.FormatInt(this.bean.taxIncome);
            _local_1 = ((Context.getInstance().getCurCastle().colonization == ColonyConstants.CASTLE_COLONIZATION_SUZERAIN) ? "Colonies Tributes" : "Tributes paid");
            _local_1 = UIUtil.FormatInt(this.bean.colonyGold);
            _local_1 = (Lang.msg("将领俸禄") + ": ");
            _local_1 = UIUtil.FormatInt(heroSalary);
            _local_1 = heroSalaryStyle;
            _local_1 = (Lang.msg("实际收入") + ": ");
            _local_1 = UIUtil.FormatInt(((this.bean.taxIncome - this.bean.herosSalary) + this.bean.colonyGold));
            _local_1 = this.incomeStyle;
            _local_1 = Lang.msg("资源信息提示");
        }

        [Bindable(event="propertyChange")]
        private function get heroSalary():int
        {
            return (this._2112150940heroSalary);
        }

        public function set onGoldChange(_arg_1:int):void
        {
            formatter.useThousandsSeparator = true;
            if (this.bean != null)
            {
                incomeStyle = ((this.bean.taxIncome > this.bean.herosSalary) ? "tooltipsValue1" : "tooltipsValue3");
                heroSalary = ((this.bean.herosSalary > 0) ? -(this.bean.herosSalary) : 0);
                heroSalaryStyle = ((this.bean.herosSalary > 0) ? "tooltipsValue3" : "tooltipsValue1");
            };
        }

        private function set heroSalaryStyle(_arg_1:String):void
        {
            var _local_2:Object = this._1257695661heroSalaryStyle;
            if (_local_2 !== _arg_1)
            {
                this._1257695661heroSalaryStyle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroSalaryStyle", _local_2, _arg_1));
            };
        }

        override public function refresh():void
        {
            var _local_1:ChangeWatcher;
            this.bean = Context.getInstance().getCurCastle().resource;
            for each (_local_1 in this.watchers)
            {
                _local_1.unwatch();
            };
            watchers[0] = BindingUtils.bindProperty(this, "onGoldChange", bean, "gold");
            watchers[1] = BindingUtils.bindProperty(this, "onGoldChange", bean, "herosSalary");
            watchers[2] = BindingUtils.bindProperty(this, "onGoldChange", bean, "taxIncome");
        }

        private function set bean(_arg_1:CastleResourceBean):void
        {
            var _local_2:Object = this._3019696bean;
            if (_local_2 !== _arg_1)
            {
                this._3019696bean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bean", _local_2, _arg_1));
            };
        }


    }
}//package view.module.playerInfo

