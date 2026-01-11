// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ZoneInfoTooltip

package view
{
    import view.ui.BaseTooltip;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import com.evony.common.beans.ZoneInfoBean;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Lang;
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

    public class ZoneInfoTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var instance:ZoneInfoTooltip = new (ZoneInfoTooltip)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _94935213crowd:Label;
        private var _1093795510zoneInfoBean:ZoneInfoBean;
        public var _ZoneInfoTooltip_Label3:Label;
        private var _1098677438hostNum:Label;
        private var _785423899cityNum:Label;
        private var _1026093505zhouName:Label;
        public var _ZoneInfoTooltip_Label4:Label;
        public var _ZoneInfoTooltip_Label5:Label;
        public var _ZoneInfoTooltip_Label2:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalAlign = "center";
                            this.verticalGap = 0;
                            this.left = "10";
                            this.right = "10";
                            this.top = "10";
                            this.bottom = "10";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"zhouName",
                                                "stylesFactory":function ():void
                                                {
                                                    this.fontSize = 15;
                                                    this.fontWeight = "bold";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ZoneInfoTooltip_Label2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.fontSize = 15;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 2;
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
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ZoneInfoTooltip_Label3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 13;
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"contentheader1",
                                                                    "percentWidth":100
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ZoneInfoTooltip_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 13;
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"contentheader1",
                                                                    "percentWidth":100
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ZoneInfoTooltip_Label5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 13;
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"contentheader1",
                                                                    "percentWidth":100
                                                                });
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
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"hostNum",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 13;
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyValue1",
                                                                    "percentWidth":100
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"cityNum",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 13;
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyValue1",
                                                                    "percentWidth":100
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"crowd",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 13;
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyValue1",
                                                                    "percentWidth":100
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
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ZoneInfoTooltip()
        {
            mx_internal::_document = this;
            this.styleName = "tooltips";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ZoneInfoTooltip._watcherSetupUtil = _arg_1;
        }

        public static function getInstance():ZoneInfoTooltip
        {
            return (instance);
        }


        public function set cityNum(_arg_1:Label):void
        {
            var _local_2:Object = this._785423899cityNum;
            if (_local_2 !== _arg_1)
            {
                this._785423899cityNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityNum", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get cityNum():Label
        {
            return (this._785423899cityNum);
        }

        public function set hostNum(_arg_1:Label):void
        {
            var _local_2:Object = this._1098677438hostNum;
            if (_local_2 !== _arg_1)
            {
                this._1098677438hostNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hostNum", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get crowd():Label
        {
            return (this._94935213crowd);
        }

        override public function initialize():void
        {
            var target:ZoneInfoTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ZoneInfoTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ZoneInfoTooltipWatcherSetupUtil");
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
        private function get zoneInfoBean():ZoneInfoBean
        {
            return (this._1093795510zoneInfoBean);
        }

        private function _ZoneInfoTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.zoneInfoBean.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                zhouName.text = _arg_1;
            }, "zhouName.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("状况");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ZoneInfoTooltip_Label2.text = _arg_1;
            }, "_ZoneInfoTooltip_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("玩家数") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ZoneInfoTooltip_Label3.text = _arg_1;
            }, "_ZoneInfoTooltip_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("城池数量") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ZoneInfoTooltip_Label4.text = _arg_1;
            }, "_ZoneInfoTooltip_Label4.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("Crowding") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ZoneInfoTooltip_Label5.text = _arg_1;
            }, "_ZoneInfoTooltip_Label5.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.zoneInfoBean.playerCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                hostNum.text = _arg_1;
            }, "hostNum.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.zoneInfoBean.castleCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                cityNum.text = _arg_1;
            }, "cityNum.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (this.zoneInfoBean.rate + "%");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                crowd.text = _arg_1;
            }, "crowd.text");
            result[7] = binding;
            return (result);
        }

        override public function refresh():void
        {
        }

        public function set zhouName(_arg_1:Label):void
        {
            var _local_2:Object = this._1026093505zhouName;
            if (_local_2 !== _arg_1)
            {
                this._1026093505zhouName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "zhouName", _local_2, _arg_1));
            };
        }

        public function set crowd(_arg_1:Label):void
        {
            var _local_2:Object = this._94935213crowd;
            if (_local_2 !== _arg_1)
            {
                this._94935213crowd = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "crowd", _local_2, _arg_1));
            };
        }

        private function _ZoneInfoTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.zoneInfoBean.name;
            _local_1 = Lang.msg("状况");
            _local_1 = (Lang.msg("玩家数") + ":");
            _local_1 = (Lang.msg("城池数量") + ":");
            _local_1 = (Lang.msg("Crowding") + ":");
            _local_1 = this.zoneInfoBean.playerCount;
            _local_1 = this.zoneInfoBean.castleCount;
            _local_1 = (this.zoneInfoBean.rate + "%");
        }

        public function set zoneInfo(_arg_1:ZoneInfoBean):void
        {
            this.zoneInfoBean = _arg_1;
        }

        private function set zoneInfoBean(_arg_1:ZoneInfoBean):void
        {
            var _local_2:Object = this._1093795510zoneInfoBean;
            if (_local_2 !== _arg_1)
            {
                this._1093795510zoneInfoBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "zoneInfoBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get hostNum():Label
        {
            return (this._1098677438hostNum);
        }

        [Bindable(event="propertyChange")]
        public function get zhouName():Label
        {
            return (this._1026093505zhouName);
        }


    }
}//package view

