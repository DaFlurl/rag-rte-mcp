// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Alliance.AllianceInviteMemberWin

package autoevony.gui.info.Alliance
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.DataGrid;
    import mx.formatters.DateFormatter;
    import mx.core.ClassFactory;
    import mx.controls.TextInput;
    import mx.core.UIComponentDescriptor;
    import autoevony.gui.controls.popup.PopUpWinBase;
    import mx.controls.Button;
    import mx.containers.HBox;
    import mx.controls.Label;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import com.evony.client.action.ActionFactory;
    import mx.binding.BindingManager;
    import autoevony.event.popUpWinShowEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.MouseEvent;
    import com.evony.client.response.ResponseDispatcher;
    import mx.events.FlexEvent;
    import com.evony.common.beans.AllianceAddPlayerInfoBean;
    import com.evony.common.module.CommandResponse;
    import autoevony.common.Utils;
    import com.evony.common.module.alliance.AllianceInviteBeanResponse;
    import mx.events.PropertyChangeEvent;
    import mx.controls.dataGridClasses.DataGridColumn;
    import com.evony.common.module.alliance.AllianceManagementResponse;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.styles.*;
    import flash.text.*;
    import flash.media.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.system.*;
    import flash.net.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.filters.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class AllianceInviteMemberWin extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _AllianceInviteMemberWin_DataGrid1:DataGrid;
        private var _1765123250formatDateTime:DateFormatter;
        private var closeFunc:Function = null;
        public var _AllianceInviteMemberWin_ClassFactory1:ClassFactory;
        public var _AllianceInviteMemberWin_ClassFactory2:ClassFactory;
        private var _1519929921inviteNames:TextInput;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":410,
                    "width":790,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":PopUpWinBase,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"windowTitle":"Manage Invitations"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "30";
                            this.top = "55";
                            this.bottom = "5";
                            this.right = "30";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"_AllianceInviteMemberWin_DataGrid1",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "33";
                                        this.bottom = "36";
                                        this.left = "1";
                                        this.right = "1";
                                        this.headerStyleName = "columnHeaderSyle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"REdataGrid",
                                            "draggableColumns":false,
                                            "resizableColumns":false,
                                            "selectable":false,
                                            "sortableColumns":false,
                                            "columns":[_AllianceInviteMemberWin_DataGridColumn1_c(), _AllianceInviteMemberWin_DataGridColumn2_c(), _AllianceInviteMemberWin_DataGridColumn3_c(), _AllianceInviteMemberWin_DataGridColumn4_c(), _AllianceInviteMemberWin_DataGridColumn5_c(), _AllianceInviteMemberWin_DataGridColumn6_c(), _AllianceInviteMemberWin_DataGridColumn7_c()]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___AllianceInviteMemberWin_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "7";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Return",
                                            "styleName":"REwinBtn",
                                            "width":75,
                                            "x":616.5
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "5";
                                        this.left = "5";
                                        this.verticalAlign = "top";
                                        this.horizontalGap = 5;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Enter Player Name:",
                                                        "styleName":"PropertyName1"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"inviteNames",
                                                "events":{"enter":"__inviteNames_enter"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"textInput"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___AllianceInviteMemberWin_Button2_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Invite",
                                                        "styleName":"REwinBtn",
                                                        "width":75
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___AllianceInviteMemberWin_Button3_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "7";
                            this.right = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        private var _1515842358unionArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllianceInviteMemberWin()
        {
            mx_internal::_document = this;
            this.height = 410;
            this.width = 790;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this._AllianceInviteMemberWin_DateFormatter1_i();
            this.addEventListener("creationComplete", this.___AllianceInviteMemberWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllianceInviteMemberWin._watcherSetupUtil = _arg_1;
        }


        public function showMembersMsg(_arg_1:Object):void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().canceladdUsertoAlliance(_arg_1.userName);
        }

        private function _AllianceInviteMemberWin_ClassFactory1_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._AllianceInviteMemberWin_ClassFactory1 = _local_1;
            BindingManager.executeBindings(this, "_AllianceInviteMemberWin_ClassFactory1", this._AllianceInviteMemberWin_ClassFactory1);
            return (_local_1);
        }

        private function inviteIn():void
        {
            if (((this.inviteNames.text == null) || (this.inviteNames.text == "")))
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "You must enter a valid player name."));
                return;
            };
            ActionFactory.getInstance().getAllianceManagementCommands().addUsertoAlliance(this.inviteNames.text);
        }

        override public function initialize():void
        {
            var target:AllianceInviteMemberWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._AllianceInviteMemberWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_AllianceInviteMemberWinWatcherSetupUtil");
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

        private function _AllianceInviteMemberWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.unionArray);
            }, function (_arg_1:Object):void
            {
                _AllianceInviteMemberWin_DataGrid1.dataProvider = _arg_1;
            }, "_AllianceInviteMemberWin_DataGrid1.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():Class
            {
                return (InviteMember_inlineComponent1);
            }, function (_arg_1:Class):void
            {
                _AllianceInviteMemberWin_ClassFactory1.generator = _arg_1;
            }, "_AllianceInviteMemberWin_ClassFactory1.generator");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.propertiesObj);
            }, function (_arg_1:Object):void
            {
                _AllianceInviteMemberWin_ClassFactory1.properties = _arg_1;
            }, "_AllianceInviteMemberWin_ClassFactory1.properties");
            result[2] = binding;
            binding = new Binding(this, function ():Class
            {
                return (CancelInviteMember_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _AllianceInviteMemberWin_ClassFactory2.generator = _arg_1;
            }, "_AllianceInviteMemberWin_ClassFactory2.generator");
            result[3] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.propertiesObj);
            }, function (_arg_1:Object):void
            {
                _AllianceInviteMemberWin_ClassFactory2.properties = _arg_1;
            }, "_AllianceInviteMemberWin_ClassFactory2.properties");
            result[4] = binding;
            return (result);
        }

        public function ___AllianceInviteMemberWin_Button2_click(_arg_1:MouseEvent):void
        {
            this.inviteIn();
        }

        private function _AllianceInviteMemberWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.unionArray;
            _local_1 = InviteMember_inlineComponent1;
            _local_1 = this.propertiesObj;
            _local_1 = CancelInviteMember_inlineComponent0;
            _local_1 = this.propertiesObj;
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_CANCELADD_USERTO_ALLIANCE, this.onCancleAddUserToAlliance);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_ADD_USERTO_ALLIANCE, this.onAddUserToAlliance);
            if (this.initialized)
            {
                this.refresh();
            };
            this.inviteNames.setFocus();
        }

        public function ___AllianceInviteMemberWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        private function onAddUserToAllianceList(_arg_1:AllianceInviteBeanResponse):void
        {
            var _local_2:Object;
            var _local_3:AllianceAddPlayerInfoBean;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, (_arg_1.errorMsg + "\nPlayer list isn't refreshed")));
            }
            else
            {
                _local_2 = new Object();
                this.unionArray.removeAll();
                for each (_local_3 in _arg_1.allianceAddPlayerInfoBeanListArray)
                {
                    _local_2 = _local_3.toObject();
                    _local_2.inviteTimeStr = this.formatDateTime.format(new Date(_local_3.inviteTime).toString());
                    _local_2.prestige_formatted = Utils.formatInt(_local_3.prestige);
                    _local_2.rank_formatted = Utils.formatInt(_local_3.rank);
                    this.unionArray.addItem(_local_2);
                };
            };
        }

        public function updateInfo(_arg_1:Function=null):void
        {
            this.closeFunc = _arg_1;
        }

        private function set unionArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1515842358unionArray;
            if (_local_2 !== _arg_1)
            {
                this._1515842358unionArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "unionArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get formatDateTime():DateFormatter
        {
            return (this._1765123250formatDateTime);
        }

        private function _AllianceInviteMemberWin_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Ranking";
            _local_1.dataField = "rank_formatted";
            _local_1.width = 80;
            return (_local_1);
        }

        private function _AllianceInviteMemberWin_DataGridColumn4_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "State";
            _local_1.width = 120;
            _local_1.itemRenderer = this._AllianceInviteMemberWin_ClassFactory1_i();
            return (_local_1);
        }

        private function _AllianceInviteMemberWin_DataGridColumn6_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Invite Time";
            _local_1.dataField = "inviteTimeStr";
            return (_local_1);
        }

        private function onCancleAddUserToAlliance(_arg_1:AllianceInviteBeanResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _arg_1.errorMsg));
            }
            else
            {
                ActionFactory.getInstance().getAllianceManagementCommands().addUsertoAllianceList(this.onAddUserToAllianceList);
            };
        }

        private function _AllianceInviteMemberWin_DateFormatter1_i():DateFormatter
        {
            var _local_1:DateFormatter = new DateFormatter();
            this.formatDateTime = _local_1;
            _local_1.formatString = "MM/DD/YY JJ:NN";
            return (_local_1);
        }

        private function get propertiesObj():Object
        {
            return ({"outerDocument":this});
        }

        public function ___AllianceInviteMemberWin_Button1_click(_arg_1:MouseEvent):void
        {
            this.close();
        }

        private function _AllianceInviteMemberWin_ClassFactory2_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._AllianceInviteMemberWin_ClassFactory2 = _local_1;
            BindingManager.executeBindings(this, "_AllianceInviteMemberWin_ClassFactory2", this._AllianceInviteMemberWin_ClassFactory2);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get unionArray():ArrayCollection
        {
            return (this._1515842358unionArray);
        }

        public function ___AllianceInviteMemberWin_Button3_click(_arg_1:MouseEvent):void
        {
            this.close();
        }

        [Bindable(event="propertyChange")]
        public function get inviteNames():TextInput
        {
            return (this._1519929921inviteNames);
        }

        public function refresh():void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().addUsertoAllianceList(this.onAddUserToAllianceList);
        }

        private function onAddUserToAlliance(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _arg_1.errorMsg));
            }
            else
            {
                (this.inviteNames.text == "");
                ActionFactory.getInstance().getAllianceManagementCommands().addUsertoAllianceList(this.onAddUserToAllianceList);
            };
        }

        public function set formatDateTime(_arg_1:DateFormatter):void
        {
            var _local_2:Object = this._1765123250formatDateTime;
            if (_local_2 !== _arg_1)
            {
                this._1765123250formatDateTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "formatDateTime", _local_2, _arg_1));
            };
        }

        private function _AllianceInviteMemberWin_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Player";
            _local_1.dataField = "userName";
            _local_1.width = 100;
            return (_local_1);
        }

        private function _AllianceInviteMemberWin_DataGridColumn3_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Prestige";
            _local_1.dataField = "prestige_formatted";
            _local_1.width = 80;
            return (_local_1);
        }

        private function _AllianceInviteMemberWin_DataGridColumn5_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Inviter";
            _local_1.dataField = "invitePerson";
            _local_1.width = 100;
            return (_local_1);
        }

        private function close():void
        {
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_CANCELADD_USERTO_ALLIANCE, this.onCancleAddUserToAlliance);
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_ADD_USERTO_ALLIANCE, this.onAddUserToAlliance);
            this.closeFunc.apply(null, [this]);
        }

        private function _AllianceInviteMemberWin_DataGridColumn7_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Cancel";
            _local_1.dataField = "userName";
            _local_1.width = 100;
            _local_1.itemRenderer = this._AllianceInviteMemberWin_ClassFactory2_i();
            return (_local_1);
        }

        public function set inviteNames(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1519929921inviteNames;
            if (_local_2 !== _arg_1)
            {
                this._1519929921inviteNames = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inviteNames", _local_2, _arg_1));
            };
        }

        public function __inviteNames_enter(_arg_1:FlexEvent):void
        {
            this.inviteIn();
        }


    }
}//package autoevony.gui.info.Alliance

