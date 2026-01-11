// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.SupportTooltip

package view.module.playerInfo
{
    import view.ui.BaseTooltip;
    import mx.binding.IBindingClient;
    import com.evony.Lang;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.CastleResourceBean;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Image;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import com.evony.Context;
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

    public class SupportTooltip extends BaseTooltip implements IBindingClient 
    {

        private static const statusUp:String = Lang.msg("民心上升");
        private static const statusDown:String = Lang.msg("民心下降");
        private static const statusNormal:String = Lang.msg("民心稳定");
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _892481550status:String;
        private var _3019696bean:CastleResourceBean;
        private var _734168929peopleStatus:Label;
        public var _SupportTooltip_Label1:Label;
        public var _SupportTooltip_Label2:Label;
        public var _SupportTooltip_Label3:Label;
        public var _SupportTooltip_Label4:Label;
        public var _SupportTooltip_Label5:Label;
        public var _SupportTooltip_Label6:Label;
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
                                                "id":"_SupportTooltip_Label1",
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
                                        return ({"source":"controls/Public/line2.png"});
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
                                                                        "id":"_SupportTooltip_Label2",
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
                                                                        "id":"_SupportTooltip_Label3",
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
                                                                return ({"source":"controls/Public/line2.png"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_SupportTooltip_Label4",
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
                                                                        "id":"_SupportTooltip_Label5",
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
                                                                return ({"source":"controls/Public/line2.png"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_SupportTooltip_Label6",
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
                                                                        "id":"peopleStatus",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.fontSize = 12;
                                                                        },
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
                                                                return ({"source":"controls/Public/line2.png"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function SupportTooltip()
        {
            mx_internal::_document = this;
            this.styleName = "tooltips";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            SupportTooltip._watcherSetupUtil = _arg_1;
        }


        public function set peopleStatus(_arg_1:Label):void
        {
            var _local_2:Object = this._734168929peopleStatus;
            if (_local_2 !== _arg_1)
            {
                this._734168929peopleStatus = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "peopleStatus", _local_2, _arg_1));
            };
        }

        private function _SupportTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("民心");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SupportTooltip_Label1.text = _arg_1;
            }, "_SupportTooltip_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("当前民心") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SupportTooltip_Label2.text = _arg_1;
            }, "_SupportTooltip_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = int(this.bean.support);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SupportTooltip_Label3.text = _arg_1;
            }, "_SupportTooltip_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("当前民怨") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SupportTooltip_Label4.text = _arg_1;
            }, "_SupportTooltip_Label4.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = int(this.bean.complaint);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SupportTooltip_Label5.text = _arg_1;
            }, "_SupportTooltip_Label5.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("民心变化") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SupportTooltip_Label6.text = _arg_1;
            }, "_SupportTooltip_Label6.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.status;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                peopleStatus.text = _arg_1;
            }, "peopleStatus.text");
            result[6] = binding;
            binding = new Binding(this, function ():Object
            {
                return (statusStyle);
            }, function (_arg_1:Object):void
            {
                peopleStatus.styleName = _arg_1;
            }, "peopleStatus.styleName");
            result[7] = binding;
            return (result);
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

        override public function initialize():void
        {
            var target:SupportTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _SupportTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_SupportTooltipWatcherSetupUtil");
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

        override public function refresh():void
        {
            this.bean = Context.getInstance().getCurCastle().resource;
            var _local_1:int = (((100 - bean.texRate) - bean.complaint) - bean.support);
            if (_local_1 < 0)
            {
                this.status = statusDown;
                statusStyle = "tooltipsValue3";
            }
            else
            {
                if (_local_1 > 0)
                {
                    this.status = statusUp;
                    statusStyle = "tooltipsValue2";
                }
                else
                {
                    this.status = statusNormal;
                    statusStyle = "tooltipsValue1";
                };
            };
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

        private function _SupportTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("民心");
            _local_1 = (Lang.msg("当前民心") + ": ");
            _local_1 = int(this.bean.support);
            _local_1 = (Lang.msg("当前民怨") + ": ");
            _local_1 = int(this.bean.complaint);
            _local_1 = (Lang.msg("民心变化") + ": ");
            _local_1 = this.status;
            _local_1 = statusStyle;
        }

        [Bindable(event="propertyChange")]
        private function get statusStyle():String
        {
            return (this._902265633statusStyle);
        }

        [Bindable(event="propertyChange")]
        public function get peopleStatus():Label
        {
            return (this._734168929peopleStatus);
        }

        [Bindable(event="propertyChange")]
        private function get status():String
        {
            return (this._892481550status);
        }

        [Bindable(event="propertyChange")]
        private function get bean():CastleResourceBean
        {
            return (this._3019696bean);
        }


    }
}//package view.module.playerInfo

