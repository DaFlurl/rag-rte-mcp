// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.allianceMember.AllianceMemberMc

package view.module.alliance.oldAlliance.allianceMember
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.Label;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.DataGrid;
    import mx.controls.ComboBox;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.beans.PlayerInfoBean;
    import mx.managers.PopUpManager;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.constants.AllianceConstants;
    import mx.binding.BindingManager;
    import mx.events.DropdownEvent;
    import com.evony.client.response.ResponseDispatcher;
    import mx.core.ClassFactory;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import mx.collections.SortField;
    import mx.collections.Sort;
    import mx.events.FlexEvent;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.alliance.AllianceMembersResponse;
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

    public class AllianceMemberMc extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _AllianceMemberMc_Button1:Button;
        public var _AllianceMemberMc_Label1:Label;
        public var _AllianceMemberMc_DataGridColumn1:DataGridColumn;
        public var _AllianceMemberMc_DataGridColumn3:DataGridColumn;
        public var _AllianceMemberMc_DataGridColumn4:DataGridColumn;
        public var _AllianceMemberMc_DataGridColumn5:DataGridColumn;
        public var _AllianceMemberMc_DataGridColumn6:DataGridColumn;
        public var _AllianceMemberMc_DataGridColumn7:DataGridColumn;
        public var _AllianceMemberMc_DataGridColumn8:DataGridColumn;
        public var _AllianceMemberMc_DataGridColumn2:DataGridColumn;
        private var _1941741961inboxDG:DataGrid;
        private var _1366077706memberLevel:int;
        private var sortType:String = "levelId";
        private var _896594307sortCB:ComboBox;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"inboxDG",
                        "stylesFactory":function ():void
                        {
                            this.top = "30";
                            this.bottom = "36";
                            this.left = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"style2",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_AllianceMemberMc_DataGridColumn1_i(), _AllianceMemberMc_DataGridColumn2_i(), _AllianceMemberMc_DataGridColumn3_i(), _AllianceMemberMc_DataGridColumn4_i(), _AllianceMemberMc_DataGridColumn5_i(), _AllianceMemberMc_DataGridColumn6_i(), _AllianceMemberMc_DataGridColumn7_i(), _AllianceMemberMc_DataGridColumn8_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "5";
                            this.bottom = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":207,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AllianceMemberMc_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "4";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"PropertyName1",
                                            "height":20
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"sortCB",
                                    "events":{"close":"__sortCB_close"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "40";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":50,
                                            "styleName":"PropertyValue2"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.right = "0";
                            this.bottom = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_AllianceMemberMc_Button1",
                                    "events":{"click":"___AllianceMemberMc_Button1_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"y165",
                                            "width":165
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        private var _481919168membersArray:ArrayCollection = new ArrayCollection();
        private var _1120764471lookUpStr:String = Lang.msg("查看");
        private var _1443179717dataPCB:ArrayCollection = new ArrayCollection([{
            "label":Lang.msg("联盟职位"),
            "data":"levelId"
        }, {
            "label":Lang.msg("排名"),
            "data":"ranking"
        }, {
            "label":Lang.msg("人口"),
            "data":"population"
        }, {
            "label":Lang.msg("声望"),
            "data":"prestige"
        }, {
            "label":Lang.msg("城池数"),
            "data":"castleCount"
        }, {
            "label":Lang.msg("最后上线"),
            "data":"lastLoginTime"
        }]);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllianceMemberMc()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___AllianceMemberMc_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllianceMemberMc._watcherSetupUtil = _arg_1;
        }


        private function set membersArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._481919168membersArray;
            if (_local_2 !== _arg_1)
            {
                this._481919168membersArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "membersArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get sortCB():ComboBox
        {
            return (this._896594307sortCB);
        }

        public function showMembersMsg(_arg_1:Object):void
        {
            AllianceMemberInfoShow.show(PlayerInfoBean(_arg_1));
        }

        public function destroy():void
        {
            if (AllianceRetire.instance)
            {
                PopUpManager.removePopUp(AllianceRetire.instance);
            }
            else
            {
                if (AllianceMemberInfoShow.instance)
                {
                    PopUpManager.removePopUp(AllianceMemberInfoShow.instance);
                };
            };
        }

        override public function initialize():void
        {
            var target:AllianceMemberMc;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AllianceMemberMc_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_oldAlliance_allianceMember_AllianceMemberMcWatcherSetupUtil");
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
        private function get memberLevel():int
        {
            return (this._1366077706memberLevel);
        }

        private function _AllianceMemberMc_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = membersArray;
            _local_1 = Lang.msg("成员");
            _local_1 = Lang.msg("联盟职位");
            _local_1 = Lang.msg("排名");
            _local_1 = Lang.msg("声望");
            _local_1 = Lang.msg("城池数");
            _local_1 = Lang.msg("人口");
            _local_1 = Lang.msg("最后上线");
            _local_1 = Lang.msg("查看");
            _local_1 = Lang.msg("排列方式");
            _local_1 = dataPCB;
            _local_1 = Lang.msg("开除成员");
            _local_1 = (((memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE));
        }

        private function retireMember():void
        {
            AllianceRetire.show(membersArray);
        }

        public function set inboxDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1941741961inboxDG;
            if (_local_2 !== _arg_1)
            {
                this._1941741961inboxDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inboxDG", _local_2, _arg_1));
            };
        }

        private function set memberLevel(_arg_1:int):void
        {
            var _local_2:Object = this._1366077706memberLevel;
            if (_local_2 !== _arg_1)
            {
                this._1366077706memberLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "memberLevel", _local_2, _arg_1));
            };
        }

        private function _AllianceMemberMc_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceMemberMc_DataGridColumn1 = _local_1;
            _local_1.dataField = "userName";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_AllianceMemberMc_DataGridColumn1", _AllianceMemberMc_DataGridColumn1);
            return (_local_1);
        }

        public function __sortCB_close(_arg_1:DropdownEvent):void
        {
            onSortByType(_arg_1);
        }

        private function _AllianceMemberMc_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceMemberMc_DataGridColumn3 = _local_1;
            _local_1.dataField = "ranking";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_AllianceMemberMc_DataGridColumn3", _AllianceMemberMc_DataGridColumn3);
            return (_local_1);
        }

        public function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_GET_ALLIANCE_MEMBERS, onGetMembersList);
            if (this.initialized)
            {
                this.refresh();
            };
        }

        [Bindable(event="propertyChange")]
        public function get inboxDG():DataGrid
        {
            return (this._1941741961inboxDG);
        }

        private function _AllianceMemberMc_DataGridColumn7_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceMemberMc_DataGridColumn7 = _local_1;
            _local_1.dataField = "lastLoginTime";
            _local_1.width = 110;
            _local_1.itemRenderer = _AllianceMemberMc_ClassFactory1_c();
            BindingManager.executeBindings(this, "_AllianceMemberMc_DataGridColumn7", _AllianceMemberMc_DataGridColumn7);
            return (_local_1);
        }

        private function _AllianceMemberMc_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceMemberMc_DataGridColumn5 = _local_1;
            _local_1.dataField = "castleCount";
            _local_1.width = 60;
            BindingManager.executeBindings(this, "_AllianceMemberMc_DataGridColumn5", _AllianceMemberMc_DataGridColumn5);
            return (_local_1);
        }

        private function _AllianceMemberMc_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = AllianceMemberMc_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function onSortByType(_arg_1:Event):void
        {
            this.sortType = ComboBox(_arg_1.target).selectedItem.data;
            if (((ComboBox(_arg_1.target).selectedItem.data == "levelId") || (ComboBox(_arg_1.target).selectedItem.data == "ranking")))
            {
                mineSortArray(membersArray, ComboBox(_arg_1.target).selectedItem.data, false);
            }
            else
            {
                mineSortArray(membersArray, ComboBox(_arg_1.target).selectedItem.data);
            };
        }

        public function ___AllianceMemberMc_Button1_click(_arg_1:MouseEvent):void
        {
            retireMember();
        }

        private function _AllianceMemberMc_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (membersArray);
            }, function (_arg_1:Object):void
            {
                inboxDG.dataProvider = _arg_1;
            }, "inboxDG.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("成员");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberMc_DataGridColumn1.headerText = _arg_1;
            }, "_AllianceMemberMc_DataGridColumn1.headerText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟职位");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberMc_DataGridColumn2.headerText = _arg_1;
            }, "_AllianceMemberMc_DataGridColumn2.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("排名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberMc_DataGridColumn3.headerText = _arg_1;
            }, "_AllianceMemberMc_DataGridColumn3.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("声望");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberMc_DataGridColumn4.headerText = _arg_1;
            }, "_AllianceMemberMc_DataGridColumn4.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("城池数");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberMc_DataGridColumn5.headerText = _arg_1;
            }, "_AllianceMemberMc_DataGridColumn5.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("人口");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberMc_DataGridColumn6.headerText = _arg_1;
            }, "_AllianceMemberMc_DataGridColumn6.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("最后上线");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberMc_DataGridColumn7.headerText = _arg_1;
            }, "_AllianceMemberMc_DataGridColumn7.headerText");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查看");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberMc_DataGridColumn8.headerText = _arg_1;
            }, "_AllianceMemberMc_DataGridColumn8.headerText");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("排列方式");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberMc_Label1.text = _arg_1;
            }, "_AllianceMemberMc_Label1.text");
            result[9] = binding;
            binding = new Binding(this, function ():Object
            {
                return (dataPCB);
            }, function (_arg_1:Object):void
            {
                sortCB.dataProvider = _arg_1;
            }, "sortCB.dataProvider");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("开除成员");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberMc_Button1.label = _arg_1;
            }, "_AllianceMemberMc_Button1.label");
            result[11] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE));
            }, function (_arg_1:Boolean):void
            {
                _AllianceMemberMc_Button1.visible = _arg_1;
            }, "_AllianceMemberMc_Button1.visible");
            result[12] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get lookUpStr():String
        {
            return (this._1120764471lookUpStr);
        }

        private function set dataPCB(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1443179717dataPCB;
            if (_local_2 !== _arg_1)
            {
                this._1443179717dataPCB = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataPCB", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get membersArray():ArrayCollection
        {
            return (this._481919168membersArray);
        }

        private function mineSortArray(_arg_1:ArrayCollection, _arg_2:String, _arg_3:Boolean=true):void
        {
            var _local_4:SortField = new SortField();
            _local_4.name = _arg_2;
            _local_4.descending = _arg_3;
            _local_4.numeric = true;
            var _local_5:Sort = new Sort();
            _local_5.fields = [_local_4];
            _arg_1.sort = _local_5;
            _arg_1.refresh();
        }

        public function set sortCB(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._896594307sortCB;
            if (_local_2 !== _arg_1)
            {
                this._896594307sortCB = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sortCB", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get dataPCB():ArrayCollection
        {
            return (this._1443179717dataPCB);
        }

        public function ___AllianceMemberMc_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function refresh():void
        {
            ActionFactory.getInstance().getAllianceCommands().getAllianceMembers();
            memberLevel = Context.getInstance().getPlayerBean().playerInfo.levelId;
        }

        private function _AllianceMemberMc_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceMemberMc_DataGridColumn2 = _local_1;
            _local_1.dataField = "allianceLevel";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_AllianceMemberMc_DataGridColumn2", _AllianceMemberMc_DataGridColumn2);
            return (_local_1);
        }

        private function _AllianceMemberMc_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceMemberMc_DataGridColumn4 = _local_1;
            _local_1.dataField = "prestige";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_AllianceMemberMc_DataGridColumn4", _AllianceMemberMc_DataGridColumn4);
            return (_local_1);
        }

        private function onGetMembersList(_arg_1:AllianceMembersResponse):void
        {
            var _local_2:int;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                membersArray = _arg_1.membersArray;
                if (sortType != null)
                {
                    if (((sortType == "levelId") || (sortType == "ranking")))
                    {
                        mineSortArray(membersArray, sortType, false);
                    }
                    else
                    {
                        mineSortArray(membersArray, sortType);
                    };
                }
                else
                {
                    mineSortArray(membersArray, "levelId");
                };
                _local_2 = 0;
                while (_local_2 < dataPCB.length)
                {
                    if (dataPCB[_local_2].data == sortType)
                    {
                        this.sortCB.selectedIndex = _local_2;
                        break;
                    };
                    _local_2++;
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function _AllianceMemberMc_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceMemberMc_DataGridColumn6 = _local_1;
            _local_1.dataField = "population";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_AllianceMemberMc_DataGridColumn6", _AllianceMemberMc_DataGridColumn6);
            return (_local_1);
        }

        private function _AllianceMemberMc_DataGridColumn8_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceMemberMc_DataGridColumn8 = _local_1;
            _local_1.dataField = "userName";
            _local_1.width = 80;
            _local_1.itemRenderer = _AllianceMemberMc_ClassFactory2_c();
            BindingManager.executeBindings(this, "_AllianceMemberMc_DataGridColumn8", _AllianceMemberMc_DataGridColumn8);
            return (_local_1);
        }

        private function _AllianceMemberMc_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = AllianceMemberMc_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function set lookUpStr(_arg_1:String):void
        {
            var _local_2:Object = this._1120764471lookUpStr;
            if (_local_2 !== _arg_1)
            {
                this._1120764471lookUpStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lookUpStr", _local_2, _arg_1));
            };
        }


    }
}//package view.module.alliance.oldAlliance.allianceMember

