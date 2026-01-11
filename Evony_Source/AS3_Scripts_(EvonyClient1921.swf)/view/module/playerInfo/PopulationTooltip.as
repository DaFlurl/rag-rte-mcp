// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.PopulationTooltip

package view.module.playerInfo
{
    import view.ui.BaseTooltip;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import com.evony.common.beans.CastleResourceBean;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Image;
    import mx.core.mx_internal;
    import com.evony.Lang;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import mx.binding.utils.ChangeWatcher;
    import com.evony.Context;
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

    public class PopulationTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _892481550status:String;
        public var _PopulationTooltip_Label10:Label;
        public var _PopulationTooltip_Label12:Label;
        public var _PopulationTooltip_Label13:Label;
        public var _PopulationTooltip_Label11:Label;
        private var _389662442availabilityStyle:String;
        public var _PopulationTooltip_Label1:Label;
        public var _PopulationTooltip_Label2:Label;
        public var _PopulationTooltip_Label3:Label;
        public var _PopulationTooltip_Label4:Label;
        public var _PopulationTooltip_Label5:Label;
        public var _PopulationTooltip_Label6:Label;
        public var _PopulationTooltip_Label7:Label;
        public var _PopulationTooltip_Label8:Label;
        public var _PopulationTooltip_Label9:Label;
        private var _3019696bean:CastleResourceBean;
        private var _1156095904maxPopulationStyle:String;
        private var _902265633statusStyle:String;

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
                                                "id":"_PopulationTooltip_Label1",
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
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "visible":false,
                                            "includeInLayout":false,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_PopulationTooltip_Label2",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"PropertyName1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_PopulationTooltip_Label3",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"tooltipsValue1"});
                                                }
                                            })]
                                        });
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
                                                            "id":"_PopulationTooltip_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "width":160
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PopulationTooltip_Label5",
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
                                                            "id":"_PopulationTooltip_Label6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "width":160
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PopulationTooltip_Label7",
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
                                                            "id":"_PopulationTooltip_Label8",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "width":160
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PopulationTooltip_Label9",
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
                                                            "id":"_PopulationTooltip_Label10",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "width":160
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PopulationTooltip_Label11",
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
                                                            "id":"_PopulationTooltip_Label12",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "width":160
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PopulationTooltip_Label13",
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

        public function PopulationTooltip()
        {
            mx_internal::_document = this;
            this.styleName = "tooltips";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            PopulationTooltip._watcherSetupUtil = _arg_1;
        }


        private function _PopulationTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("人口");
            _local_1 = Lang.msg("建筑人口");
            _local_1 = int(this.bean.buildPeople);
            _local_1 = (Lang.msg("当前人口") + ": ");
            _local_1 = int(this.bean.curPopulation);
            _local_1 = availabilityStyle;
            _local_1 = (Lang.msg("人口上限") + ": ");
            _local_1 = int(this.bean.maxPopulation);
            _local_1 = (Lang.msg("劳动人口") + ": ");
            _local_1 = int(this.bean.workPeople);
            _local_1 = (((int(((this.bean.curPopulation - this.bean.buildPeople) - this.bean.workPeople)) >= 0) ? Lang.msg("富余劳动力") : Lang.msg("劳动力短缺")) + ": ");
            _local_1 = Math.abs(((this.bean.curPopulation - this.bean.buildPeople) - this.bean.workPeople));
            _local_1 = availabilityStyle;
            _local_1 = (Lang.msg("人口变化") + ": ");
            _local_1 = this.status;
            _local_1 = statusStyle;
        }

        public function set onStatusChange(_arg_1:int):void
        {
            switch (this.bean.populationDirection)
            {
                case 1:
                    this.status = Lang.msg("上升");
                    statusStyle = "tooltipsValue2";
                    if (this.bean.curPopulation > 0)
                    {
                        this.maxPopulationStyle = "tooltipsValue1";
                    }
                    else
                    {
                        this.maxPopulationStyle = "tooltipsValue3";
                    };
                    break;
                case 0:
                    this.status = Lang.msg("稳定");
                    statusStyle = "tooltipsValue1";
                    this.maxPopulationStyle = "tooltipsValue1";
                    break;
                case -1:
                    this.status = Lang.msg("下降");
                    statusStyle = "tooltipsValue3";
                    this.maxPopulationStyle = "tooltipsValue3";
                    break;
            };
            if (this.bean.curPopulation < 1)
            {
                this.availabilityStyle = "tooltipsValue3";
                return;
            };
            if (int(((this.bean.curPopulation - this.bean.buildPeople) - this.bean.workPeople)) > 0)
            {
                this.availabilityStyle = "tooltipsValue1";
            }
            else
            {
                this.availabilityStyle = "tooltipsValue3";
            };
        }

        override public function initialize():void
        {
            var target:PopulationTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _PopulationTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_PopulationTooltipWatcherSetupUtil");
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

        private function _PopulationTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("人口");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PopulationTooltip_Label1.text = _arg_1;
            }, "_PopulationTooltip_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("建筑人口");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PopulationTooltip_Label2.text = _arg_1;
            }, "_PopulationTooltip_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = int(this.bean.buildPeople);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PopulationTooltip_Label3.text = _arg_1;
            }, "_PopulationTooltip_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("当前人口") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PopulationTooltip_Label4.text = _arg_1;
            }, "_PopulationTooltip_Label4.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = int(this.bean.curPopulation);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PopulationTooltip_Label5.text = _arg_1;
            }, "_PopulationTooltip_Label5.text");
            result[4] = binding;
            binding = new Binding(this, function ():Object
            {
                return (availabilityStyle);
            }, function (_arg_1:Object):void
            {
                _PopulationTooltip_Label5.styleName = _arg_1;
            }, "_PopulationTooltip_Label5.styleName");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("人口上限") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PopulationTooltip_Label6.text = _arg_1;
            }, "_PopulationTooltip_Label6.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = int(this.bean.maxPopulation);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PopulationTooltip_Label7.text = _arg_1;
            }, "_PopulationTooltip_Label7.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("劳动人口") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PopulationTooltip_Label8.text = _arg_1;
            }, "_PopulationTooltip_Label8.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = int(this.bean.workPeople);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PopulationTooltip_Label9.text = _arg_1;
            }, "_PopulationTooltip_Label9.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (((int(((this.bean.curPopulation - this.bean.buildPeople) - this.bean.workPeople)) >= 0) ? Lang.msg("富余劳动力") : Lang.msg("劳动力短缺")) + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PopulationTooltip_Label10.text = _arg_1;
            }, "_PopulationTooltip_Label10.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Math.abs(((this.bean.curPopulation - this.bean.buildPeople) - this.bean.workPeople));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PopulationTooltip_Label11.text = _arg_1;
            }, "_PopulationTooltip_Label11.text");
            result[11] = binding;
            binding = new Binding(this, function ():Object
            {
                return (availabilityStyle);
            }, function (_arg_1:Object):void
            {
                _PopulationTooltip_Label11.styleName = _arg_1;
            }, "_PopulationTooltip_Label11.styleName");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("人口变化") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PopulationTooltip_Label12.text = _arg_1;
            }, "_PopulationTooltip_Label12.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.status;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PopulationTooltip_Label13.text = _arg_1;
            }, "_PopulationTooltip_Label13.text");
            result[14] = binding;
            binding = new Binding(this, function ():Object
            {
                return (statusStyle);
            }, function (_arg_1:Object):void
            {
                _PopulationTooltip_Label13.styleName = _arg_1;
            }, "_PopulationTooltip_Label13.styleName");
            result[15] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get availabilityStyle():String
        {
            return (this._389662442availabilityStyle);
        }

        private function set availabilityStyle(_arg_1:String):void
        {
            var _local_2:Object = this._389662442availabilityStyle;
            if (_local_2 !== _arg_1)
            {
                this._389662442availabilityStyle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "availabilityStyle", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get bean():CastleResourceBean
        {
            return (this._3019696bean);
        }

        private function set maxPopulationStyle(_arg_1:String):void
        {
            var _local_2:Object = this._1156095904maxPopulationStyle;
            if (_local_2 !== _arg_1)
            {
                this._1156095904maxPopulationStyle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxPopulationStyle", _local_2, _arg_1));
            };
        }

        private function set statusStyle(_arg_1:String):void
        {
            var _local_2:Object = this._902265633statusStyle;
            if (_local_2 !== _arg_1)
            {
                this._902265633statusStyle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statusStyle", _local_2, _arg_1));
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
            watchers[0] = BindingUtils.bindProperty(this, "onStatusChange", bean, "curPopulation");
            watchers[1] = BindingUtils.bindProperty(this, "onStatusChange", bean, "buildPeople");
            watchers[2] = BindingUtils.bindProperty(this, "onStatusChange", bean, "workPeople");
            watchers[3] = BindingUtils.bindProperty(this, "onStatusChange", bean, "populationDirection");
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

        private function set status(_arg_1:String):void
        {
            var _local_2:Object = this._892481550status;
            if (_local_2 !== _arg_1)
            {
                this._892481550status = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "status", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get statusStyle():String
        {
            return (this._902265633statusStyle);
        }

        [Bindable(event="propertyChange")]
        private function get maxPopulationStyle():String
        {
            return (this._1156095904maxPopulationStyle);
        }

        [Bindable(event="propertyChange")]
        private function get status():String
        {
            return (this._892481550status);
        }


    }
}//package view.module.playerInfo

