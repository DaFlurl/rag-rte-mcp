// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.newAlliance.BeginAlliance

package view.module.alliance.newAlliance
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.DataGrid;
    import mx.controls.Button;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import com.evony.client.action.ActionFactory;
    import com.evony.MsgDispacther;
    import com.evony.events.WindowChangeEvent;
    import view.module.alliance.AllianceWin;
    import com.evony.Context;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import mx.binding.BindingManager;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.alliance.WantedAllianceResponse;
    import com.evony.client.response.ResponseDispatcher;
    import mx.core.ClassFactory;
    import com.evony.common.module.alliance.AllianceInviteOnClientBeanResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.alliance.AllianceUserAddResponse;
    import flash.events.MouseEvent;
    import mx.events.FlexEvent;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.MainWin;
    import com.evony.common.module.alliance.AllianceManagementResponse;
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

    public class BeginAlliance extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _BeginAlliance_Label2:Label;
        public var _BeginAlliance_Label4:Label;
        public var _BeginAlliance_Label3:Label;
        private var _1179968483applyStr:String;
        public var _BeginAlliance_DataGrid1:DataGrid;
        public var _BeginAlliance_Button1:Button;
        public var _BeginAlliance_Button2:Button;
        public var _BeginAlliance_Button3:Button;
        public var _BeginAlliance_DataGridColumn1:DataGridColumn;
        public var _BeginAlliance_DataGridColumn2:DataGridColumn;
        public var _BeginAlliance_DataGridColumn3:DataGridColumn;
        public var _BeginAlliance_DataGridColumn5:DataGridColumn;
        public var _BeginAlliance_DataGridColumn4:DataGridColumn;
        public var _BeginAlliance_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"_BeginAlliance_DataGrid1",
                        "stylesFactory":function ():void
                        {
                            this.borderStyle = "solid";
                            this.borderThickness = 1;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "y":168,
                                "width":745,
                                "height":245,
                                "styleName":"style2",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_BeginAlliance_DataGridColumn1_i(), _BeginAlliance_DataGridColumn2_i(), _BeginAlliance_DataGridColumn3_i(), _BeginAlliance_DataGridColumn4_i(), _BeginAlliance_DataGridColumn5_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 3;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "y":6,
                                "width":363,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_BeginAlliance_Button1",
                                    "events":{"click":"___BeginAlliance_Button1_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b95"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_BeginAlliance_Button2",
                                    "events":{"click":"___BeginAlliance_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b95"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "y":105,
                                "width":745,
                                "height":25,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.left = "5";
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_BeginAlliance_Label1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "10";
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyName1",
                                                        "x":10,
                                                        "width":230
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_BeginAlliance_Button3",
                                                "events":{"click":"___BeginAlliance_Button3_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":283,
                                                        "height":20,
                                                        "width":70,
                                                        "styleName":"b75",
                                                        "y":3
                                                    });
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "y":138,
                                "width":745,
                                "height":25,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_BeginAlliance_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"PropertyName1",
                                            "y":5,
                                            "width":130
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_BeginAlliance_Label3",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":9,
                                "y":43,
                                "styleName":"ParamgraphText1",
                                "width":758
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_BeginAlliance_Label4",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":9,
                                "y":64,
                                "styleName":"ParamgraphText1",
                                "width":758
                            });
                        }
                    })]});
            }
        });
        private var createWin:CreateWin = new CreateWin();
        private var _269012959allianceInviteArr:ArrayCollection = new ArrayCollection();
        private var _2117790711acceptStr:String = Lang.msg("接受");
        private var _1683539438rejectStr:String = Lang.msg("拒绝");
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function BeginAlliance()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___BeginAlliance_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            BeginAlliance._watcherSetupUtil = _arg_1;
        }


        private function cancleApply():void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().cancelUserWantInAlliance(applyStr);
        }

        private function onGetAllianceList():void
        {
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.CALL_OTHER_VIEW, {"id":"allianceList"}));
        }

        public function isAgreeClick(_arg_1:Object, _arg_2:Boolean):void
        {
            if (_arg_2)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceByUser(Context.getInstance().getCurCastle().id, _arg_1["allianceName"]);
            }
            else
            {
                ActionFactory.getInstance().getAllianceManagementCommands().rejectComeinAlliance(_arg_1["allianceName"]);
            };
        }

        override public function initialize():void
        {
            var target:BeginAlliance;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _BeginAlliance_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_newAlliance_BeginAllianceWatcherSetupUtil");
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

        public function set acceptStr(_arg_1:String):void
        {
            var _local_2:Object = this._2117790711acceptStr;
            if (_local_2 !== _arg_1)
            {
                this._2117790711acceptStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "acceptStr", _local_2, _arg_1));
            };
        }

        private function _BeginAlliance_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _BeginAlliance_DataGridColumn3 = _local_1;
            _local_1.dataField = "memberCount";
            _local_1.width = 90;
            BindingManager.executeBindings(this, "_BeginAlliance_DataGridColumn3", _BeginAlliance_DataGridColumn3);
            return (_local_1);
        }

        private function _BeginAlliance_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _BeginAlliance_DataGridColumn5 = _local_1;
            _local_1.dataField = "allianceName";
            _local_1.itemRenderer = _BeginAlliance_ClassFactory1_c();
            BindingManager.executeBindings(this, "_BeginAlliance_DataGridColumn5", _BeginAlliance_DataGridColumn5);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get applyStr():String
        {
            return (this._1179968483applyStr);
        }

        private function onGetAllianceWanted(_arg_1:WantedAllianceResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (((_arg_1.allianceName == null) || (_arg_1.allianceName == "")))
                {
                    applyStr = null;
                }
                else
                {
                    applyStr = _arg_1.allianceName;
                };
            };
        }

        private function _BeginAlliance_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _BeginAlliance_DataGridColumn1 = _local_1;
            _local_1.dataField = "allianceName";
            _local_1.width = 200;
            BindingManager.executeBindings(this, "_BeginAlliance_DataGridColumn1", _BeginAlliance_DataGridColumn1);
            return (_local_1);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_GET_ALLIANCE_WANTED, onGetAllianceWanted);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_LEADER_WANT_USER_IN_ALLIANCE_LIST, onLeaderWantUserInList);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_CANCEL_USER_WANT_IN_ALLIANCE, onCancelUserWantInAlliance);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_AGREE_COMEIN_ALLIANCE_BY_USER, onAgreeComeInByUser);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_REJECT_COMEIN_ALLIANCE, onRejectComeInByUser);
            if (this.initialized)
            {
                this.refresh();
            };
        }

        [Bindable(event="propertyChange")]
        private function get allianceInviteArr():ArrayCollection
        {
            return (this._269012959allianceInviteArr);
        }

        public function set rejectStr(_arg_1:String):void
        {
            var _local_2:Object = this._1683539438rejectStr;
            if (_local_2 !== _arg_1)
            {
                this._1683539438rejectStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rejectStr", _local_2, _arg_1));
            };
        }

        private function _BeginAlliance_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = BeginAlliance_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function onLeaderWantUserInList(_arg_1:AllianceInviteOnClientBeanResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                allianceInviteArr = _arg_1.allianceAddPlayerByLeaderInfoBeanListArray;
            };
        }

        private function onAgreeComeInByUser(_arg_1:AllianceUserAddResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.CALL_OTHER_VIEW, {"id":" "}));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function ___BeginAlliance_Button2_click(_arg_1:MouseEvent):void
        {
            onGetAllianceList();
        }

        private function _BeginAlliance_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (allianceInviteArr);
            }, function (_arg_1:Object):void
            {
                _BeginAlliance_DataGrid1.dataProvider = _arg_1;
            }, "_BeginAlliance_DataGrid1.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BeginAlliance_DataGridColumn1.headerText = _arg_1;
            }, "_BeginAlliance_DataGridColumn1.headerText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("排名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BeginAlliance_DataGridColumn2.headerText = _arg_1;
            }, "_BeginAlliance_DataGridColumn2.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("人数");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BeginAlliance_DataGridColumn3.headerText = _arg_1;
            }, "_BeginAlliance_DataGridColumn3.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("声望");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BeginAlliance_DataGridColumn4.headerText = _arg_1;
            }, "_BeginAlliance_DataGridColumn4.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("行为");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BeginAlliance_DataGridColumn5.headerText = _arg_1;
            }, "_BeginAlliance_DataGridColumn5.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("创建联盟");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BeginAlliance_Button1.label = _arg_1;
            }, "_BeginAlliance_Button1.label");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟列表");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BeginAlliance_Button2.label = _arg_1;
            }, "_BeginAlliance_Button2.label");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Lang.msg("发送申请") + ": ") + ((applyStr == null) ? "" : applyStr));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BeginAlliance_Label1.text = _arg_1;
            }, "_BeginAlliance_Label1.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("取消");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BeginAlliance_Button3.label = _arg_1;
            }, "_BeginAlliance_Button3.label");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(applyStr == null));
            }, function (_arg_1:Boolean):void
            {
                _BeginAlliance_Button3.visible = _arg_1;
            }, "_BeginAlliance_Button3.visible");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("收到邀请");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BeginAlliance_Label2.text = _arg_1;
            }, "_BeginAlliance_Label2.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("创建或加入联盟的前提条件");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BeginAlliance_Label3.text = _arg_1;
            }, "_BeginAlliance_Label3.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("申请加入联盟的方式");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BeginAlliance_Label4.text = _arg_1;
            }, "_BeginAlliance_Label4.text");
            result[13] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get rejectStr():String
        {
            return (this._1683539438rejectStr);
        }

        [Bindable(event="propertyChange")]
        public function get acceptStr():String
        {
            return (this._2117790711acceptStr);
        }

        private function _BeginAlliance_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = allianceInviteArr;
            _local_1 = Lang.msg("联盟");
            _local_1 = Lang.msg("排名");
            _local_1 = Lang.msg("人数");
            _local_1 = Lang.msg("声望");
            _local_1 = Lang.msg("行为");
            _local_1 = Lang.msg("创建联盟");
            _local_1 = Lang.msg("联盟列表");
            _local_1 = ((Lang.msg("发送申请") + ": ") + ((applyStr == null) ? "" : applyStr));
            _local_1 = Lang.msg("取消");
            _local_1 = (!(applyStr == null));
            _local_1 = Lang.msg("收到邀请");
            _local_1 = Lang.msg("创建或加入联盟的前提条件");
            _local_1 = Lang.msg("申请加入联盟的方式");
        }

        public function ___BeginAlliance_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set allianceInviteArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._269012959allianceInviteArr;
            if (_local_2 !== _arg_1)
            {
                this._269012959allianceInviteArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceInviteArr", _local_2, _arg_1));
            };
        }

        private function set applyStr(_arg_1:String):void
        {
            var _local_2:Object = this._1179968483applyStr;
            if (_local_2 !== _arg_1)
            {
                this._1179968483applyStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "applyStr", _local_2, _arg_1));
            };
        }

        private function _BeginAlliance_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _BeginAlliance_DataGridColumn2 = _local_1;
            _local_1.dataField = "rank";
            _local_1.width = 90;
            BindingManager.executeBindings(this, "_BeginAlliance_DataGridColumn2", _BeginAlliance_DataGridColumn2);
            return (_local_1);
        }

        public function refresh():void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().getAllianceWanted();
            ActionFactory.getInstance().getAllianceManagementCommands().leaderWantUserInAllianceList();
        }

        private function _BeginAlliance_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _BeginAlliance_DataGridColumn4 = _local_1;
            _local_1.dataField = "prestige";
            _local_1.width = 120;
            BindingManager.executeBindings(this, "_BeginAlliance_DataGridColumn4", _BeginAlliance_DataGridColumn4);
            return (_local_1);
        }

        private function onRejectComeInByUser(_arg_1:AllianceUserAddResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().leaderWantUserInAllianceList();
            };
        }

        private function createNewAlliance():void
        {
            UIUtil.setPopopHelpWindowStye(createWin);
            MinePopupManager.instance.addPopup(createWin, MainWin.instance, false);
        }

        private function onCancelUserWantInAlliance(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().getAllianceWanted();
                ActionFactory.getInstance().getAllianceManagementCommands().leaderWantUserInAllianceList();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function ___BeginAlliance_Button3_click(_arg_1:MouseEvent):void
        {
            cancleApply();
        }

        public function ___BeginAlliance_Button1_click(_arg_1:MouseEvent):void
        {
            createNewAlliance();
        }

        public function destroy():void
        {
        }


    }
}//package view.module.alliance.newAlliance

