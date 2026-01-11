// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.rank.AllianceInfo

package view.module.rank
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.controls.TextArea;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import com.evony.Lang;
    import com.evony.Context;
    import com.evony.common.constants.AllianceConstants;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.alliance.AllianceInfoResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.alliance.AllianceManagementResponse;
    import com.evony.client.action.ActionFactory;
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

    public class AllianceInfo extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _908188233_creater:String;
        public var _AllianceInfo_Label4:Label;
        public var _AllianceInfo_Label5:Label;
        public var _AllianceInfo_Label6:Label;
        public var _AllianceInfo_Label8:Label;
        public var _AllianceInfo_Label9:Label;
        private var _1601716776_leader:String;
        private var _1125982860curRank:int;
        private var _701364083_prestigeCount:int;
        public var _AllianceInfo_Label10:Label;
        public var _AllianceInfo_Label11:Label;
        private var _958631177_ranking:int;
        private var _736019670_memberCount:int;
        public var _AllianceInfo_Button1:Button;
        private var _497477788_allianceInfo:String;
        private var _1770461058AllianceName:String;
        public var _AllianceInfo_Label1:Label;
        public var _AllianceInfo_Label2:Label;
        public var _AllianceInfo_Label3:Label;
        public var _AllianceInfo_TextArea1:TextArea;
        public var _AllianceInfo_Label7:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":294,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":MyWindow,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_AllianceInfo_Button1",
                        "events":{"click":"___AllianceInfo_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "20";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"b95"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_AllianceInfo_Label1",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.top = "6";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":121,
                                "width":194,
                                "styleName":"funtionWindowTitle"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"_AllianceInfo_TextArea1",
                        "stylesFactory":function ():void
                        {
                            this.backgroundAlpha = 0;
                            this.top = "125";
                            this.left = "20";
                            this.right = "20";
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"ParamgraphText1",
                                "height":125,
                                "editable":false,
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "53";
                            this.left = "20";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":88,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "5";
                                        this.left = "5";
                                        this.right = "5";
                                        this.bottom = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
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
                                                            "type":Label,
                                                            "id":"_AllianceInfo_Label2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":90,
                                                                    "styleName":"PropertyName1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_AllianceInfo_Label3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "width":90,
                                                                    "styleName":"PropertyValue1",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_AllianceInfo_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":90,
                                                                    "styleName":"PropertyName1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_AllianceInfo_Label5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "width":90,
                                                                    "styleName":"PropertyValue1",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
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
                                                            "type":Label,
                                                            "id":"_AllianceInfo_Label6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":90,
                                                                    "styleName":"PropertyName1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_AllianceInfo_Label7",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "width":90,
                                                                    "styleName":"PropertyValue1",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_AllianceInfo_Label8",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":90,
                                                                    "styleName":"PropertyName1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_AllianceInfo_Label9",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "width":90,
                                                                    "styleName":"PropertyValue1",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
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
                                                            "type":Label,
                                                            "id":"_AllianceInfo_Label10",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":90,
                                                                    "styleName":"PropertyName1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_AllianceInfo_Label11",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "width":90,
                                                                    "styleName":"PropertyValue1",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___AllianceInfo_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":341,
                                "y":2,
                                "styleName":"close"
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

        public function AllianceInfo()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 294;
            this.addEventListener("creationComplete", ___AllianceInfo_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllianceInfo._watcherSetupUtil = _arg_1;
        }


        private function closeWindow():void
        {
            PopUpManager.removePopUp(this);
        }

        private function _AllianceInfo_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("申请加入");
            _local_1 = (Context.getInstance().getPlayerBean().playerInfo.levelId == AllianceConstants.SAME_ALLIANCE);
            _local_1 = this.AllianceName;
            _local_1 = this._allianceInfo;
            _local_1 = (Lang.msg("盟主") + ": ");
            _local_1 = this._leader;
            _local_1 = (Lang.msg("创始人") + ": ");
            _local_1 = this._creater;
            _local_1 = (Lang.msg("人数") + ": ");
            _local_1 = this._memberCount;
            _local_1 = (Lang.msg("排名") + ": ");
            _local_1 = this.curRank;
            _local_1 = (Lang.msg("声望") + ": ");
            _local_1 = this._prestigeCount;
        }

        public function ___AllianceInfo_Button1_click(_arg_1:MouseEvent):void
        {
            joinUnion(AllianceName);
        }

        [Bindable(event="propertyChange")]
        private function get _ranking():int
        {
            return (this._958631177_ranking);
        }

        override public function initialize():void
        {
            var target:AllianceInfo;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AllianceInfo_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_rank_AllianceInfoWatcherSetupUtil");
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
        private function get AllianceName():String
        {
            return (this._1770461058AllianceName);
        }

        private function set AllianceName(_arg_1:String):void
        {
            var _local_2:Object = this._1770461058AllianceName;
            if (_local_2 !== _arg_1)
            {
                this._1770461058AllianceName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "AllianceName", _local_2, _arg_1));
            };
        }

        private function _AllianceInfo_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("申请加入");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Button1.label = _arg_1;
            }, "_AllianceInfo_Button1.label");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (Context.getInstance().getPlayerBean().playerInfo.levelId == AllianceConstants.SAME_ALLIANCE);
            }, function (_arg_1:Boolean):void
            {
                _AllianceInfo_Button1.visible = _arg_1;
            }, "_AllianceInfo_Button1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.AllianceName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label1.htmlText = _arg_1;
            }, "_AllianceInfo_Label1.htmlText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._allianceInfo;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_TextArea1.htmlText = _arg_1;
            }, "_AllianceInfo_TextArea1.htmlText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("盟主") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label2.text = _arg_1;
            }, "_AllianceInfo_Label2.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._leader;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label3.text = _arg_1;
            }, "_AllianceInfo_Label3.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("创始人") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label4.text = _arg_1;
            }, "_AllianceInfo_Label4.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._creater;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label5.text = _arg_1;
            }, "_AllianceInfo_Label5.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("人数") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label6.text = _arg_1;
            }, "_AllianceInfo_Label6.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._memberCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label7.text = _arg_1;
            }, "_AllianceInfo_Label7.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("排名") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label8.text = _arg_1;
            }, "_AllianceInfo_Label8.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curRank;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label9.text = _arg_1;
            }, "_AllianceInfo_Label9.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("声望") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label10.text = _arg_1;
            }, "_AllianceInfo_Label10.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._prestigeCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label11.text = _arg_1;
            }, "_AllianceInfo_Label11.text");
            result[13] = binding;
            return (result);
        }

        private function onGetAllianceInfo(_arg_1:AllianceInfoResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this._leader = _arg_1.leader;
                this._creater = _arg_1.creator;
                this._allianceInfo = ((_arg_1.allinaceInfo != null) ? ((("<b>" + Lang.msg("联盟介绍")) + "</b>\n\n") + _arg_1.allinaceInfo) : _arg_1.allinaceInfo);
                this._memberCount = _arg_1.memberCount;
                this._ranking = _arg_1.ranking;
                this._prestigeCount = _arg_1.prestigeCount;
            };
        }

        private function onUserWantInAlliance(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("申请成功{0}", AllianceName));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function init():void
        {
            PopUpManager.centerPopUp(this);
        }

        private function set _prestigeCount(_arg_1:int):void
        {
            var _local_2:Object = this._701364083_prestigeCount;
            if (_local_2 !== _arg_1)
            {
                this._701364083_prestigeCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_prestigeCount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get curRank():int
        {
            return (this._1125982860curRank);
        }

        [Bindable(event="propertyChange")]
        private function get _leader():String
        {
            return (this._1601716776_leader);
        }

        [Bindable(event="propertyChange")]
        private function get _allianceInfo():String
        {
            return (this._497477788_allianceInfo);
        }

        [Bindable(event="propertyChange")]
        private function get _prestigeCount():int
        {
            return (this._701364083_prestigeCount);
        }

        private function set curRank(_arg_1:int):void
        {
            var _local_2:Object = this._1125982860curRank;
            if (_local_2 !== _arg_1)
            {
                this._1125982860curRank = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curRank", _local_2, _arg_1));
            };
        }

        private function set _ranking(_arg_1:int):void
        {
            var _local_2:Object = this._958631177_ranking;
            if (_local_2 !== _arg_1)
            {
                this._958631177_ranking = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_ranking", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get _creater():String
        {
            return (this._908188233_creater);
        }

        private function set _memberCount(_arg_1:int):void
        {
            var _local_2:Object = this._736019670_memberCount;
            if (_local_2 !== _arg_1)
            {
                this._736019670_memberCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_memberCount", _local_2, _arg_1));
            };
        }

        private function joinUnion(_arg_1:String):void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().userWantInAlliance(_arg_1, onUserWantInAlliance);
        }

        public function ___AllianceInfo_Button2_click(_arg_1:MouseEvent):void
        {
            closeWindow();
        }

        [Bindable(event="propertyChange")]
        private function get _memberCount():int
        {
            return (this._736019670_memberCount);
        }

        private function set _leader(_arg_1:String):void
        {
            var _local_2:Object = this._1601716776_leader;
            if (_local_2 !== _arg_1)
            {
                this._1601716776_leader = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_leader", _local_2, _arg_1));
            };
        }

        public function ___AllianceInfo_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set _allianceInfo(_arg_1:String):void
        {
            var _local_2:Object = this._497477788_allianceInfo;
            if (_local_2 !== _arg_1)
            {
                this._497477788_allianceInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_allianceInfo", _local_2, _arg_1));
            };
        }

        public function setAllianceName(_arg_1:String):void
        {
            this.AllianceName = _arg_1;
            ActionFactory.getInstance().getAllianceCommands().getAllianceInfo(this.AllianceName, onGetAllianceInfo);
        }

        public function setcurRank(_arg_1:int):void
        {
            curRank = _arg_1;
        }

        private function set _creater(_arg_1:String):void
        {
            var _local_2:Object = this._908188233_creater;
            if (_local_2 !== _arg_1)
            {
                this._908188233_creater = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_creater", _local_2, _arg_1));
            };
        }


    }
}//package view.module.rank

