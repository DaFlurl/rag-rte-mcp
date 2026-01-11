// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Alliance.AllianceMembers

package autoevony.gui.info.Alliance
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.formatters.DateFormatter;
    import mx.core.ClassFactory;
    import mx.controls.DataGrid;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import mx.controls.dataGridClasses.DataGridColumn;
    import autoevony.event.popUpWinShowEvent;
    import flash.events.MouseEvent;
    import autoevony.gui.MainScreen;
    import com.evony.client.action.ActionFactory;
    import mx.events.FlexEvent;
    import mx.binding.BindingManager;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.constants.AllianceConstants;
    import autoevony.gui.info.FormatRanking_inlineComponent0;
    import autoevony.gui.info.FormatPrestige_inlineComponent0;
    import autoevony.gui.info.FormatPopulation_inlineComponent0;
    import com.evony.common.beans.PlayerInfoBean;
    import mx.utils.ObjectProxy;
    import autoevony.player.Map;
    import com.evony.common.module.alliance.AllianceMembersResponse;
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

    public class AllianceMembers extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1765123250formatDateTime:DateFormatter;
        private var _1809330466_AllianceMembers_ClassFactory0:ClassFactory;
        private var _1809330468_AllianceMembers_ClassFactory2:ClassFactory;
        public var _AllianceMembers_DataGrid1:DataGrid;
        private var _1809330467_AllianceMembers_ClassFactory1:ClassFactory;
        private var _1809330469_AllianceMembers_ClassFactory3:ClassFactory;
        private var _1366077706memberLevel:int = 0;
        public var _AllianceMembers_Button2:Button;
        public var _AllianceMembers_Button3:Button;
        public var _AllianceMembers_Button4:Button;
        public var _AllianceMembers_Button5:Button;
        public var _AllianceMembers_Button6:Button;
        public var _AllianceMembers_Button7:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalGap = 0;
                            this.left = "3";
                            this.right = "3";
                            this.top = "0";
                            this.bottom = "3";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.verticalGap = 0;
                                        this.horizontalGap = 2;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":32,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":10});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___AllianceMembers_Button1_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"refreshBtn",
                                                        "toolTip":"Refresh"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":25});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_AllianceMembers_Button2",
                                                "events":{"click":"___AllianceMembers_Button2_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Invite"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":10});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_AllianceMembers_Button3",
                                                "events":{"click":"___AllianceMembers_Button3_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Pending Apps"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_AllianceMembers_Button4",
                                                "events":{"click":"___AllianceMembers_Button4_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinCancelBtn",
                                                        "label":"Expel Member"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":5});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"_AllianceMembers_DataGrid1",
                                    "stylesFactory":function ():void
                                    {
                                        this.headerStyleName = "columnHeaderSyle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"REdataGrid",
                                            "allowDragSelection":false,
                                            "allowMultipleSelection":false,
                                            "doubleClickEnabled":false,
                                            "dragEnabled":false,
                                            "draggableColumns":false,
                                            "editable":false,
                                            "enabled":true,
                                            "horizontalScrollPolicy":"off",
                                            "minHeight":50,
                                            "percentHeight":100,
                                            "percentWidth":100,
                                            "resizableColumns":true,
                                            "rowHeight":23,
                                            "selectable":false,
                                            "showHeaders":true,
                                            "sortableColumns":true,
                                            "variableRowHeight":true,
                                            "visible":true,
                                            "wordWrap":false,
                                            "columns":[_AllianceMembers_DataGridColumn1_c(), _AllianceMembers_DataGridColumn2_c(), _AllianceMembers_DataGridColumn3_c(), _AllianceMembers_DataGridColumn4_c(), _AllianceMembers_DataGridColumn5_c(), _AllianceMembers_DataGridColumn6_c(), _AllianceMembers_DataGridColumn7_c(), _AllianceMembers_DataGridColumn8_c()]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.verticalGap = 0;
                                        this.horizontalGap = 2;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":32,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":10});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_AllianceMembers_Button5",
                                                "events":{"click":"___AllianceMembers_Button5_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinCancelBtn",
                                                        "label":"Quit Alliance"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":15});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_AllianceMembers_Button6",
                                                "events":{"click":"___AllianceMembers_Button6_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Resignation"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":30});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_AllianceMembers_Button7",
                                                "events":{"click":"___AllianceMembers_Button7_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Relinquish Host"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":5});
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
        private var _481919168membersArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllianceMembers()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this._AllianceMembers_DateFormatter1_i();
            this.addEventListener("creationComplete", this.___AllianceMembers_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllianceMembers._watcherSetupUtil = _arg_1;
        }


        public function set membersArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._481919168membersArray;
            if (_local_2 !== _arg_1)
            {
                this._481919168membersArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "membersArray", _local_2, _arg_1));
            };
        }

        private function _AllianceMembers_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Position";
            _local_1.dataField = "allianceLevel";
            _local_1.width = 0.15;
            return (_local_1);
        }

        public function showMembersMsg(_arg_1:Object):void
        {
            var _local_2:popUpWinShowEvent = new popUpWinShowEvent(popUpWinShowEvent.ALLIANCE_MEMBER_INFO);
            _local_2.objParam = _arg_1;
            dispatchEvent(_local_2);
        }

        public function ___AllianceMembers_Button1_click(_arg_1:MouseEvent):void
        {
            this.updateData();
        }

        public function ___AllianceMembers_Button3_click(_arg_1:MouseEvent):void
        {
            this.onPendingAppsBtn();
        }

        public function ___AllianceMembers_Button7_click(_arg_1:MouseEvent):void
        {
            this.onRelinquishHost();
        }

        private function updateData(_arg_1:Object=null):void
        {
            if (MainScreen.getPlayer() == null)
            {
                return;
            };
            if (MainScreen.getPlayer().playerInfo.alliance != null)
            {
                ActionFactory.getInstance().getAllianceCommands().getAllianceMembers(this._wn1051);
            }
            else
            {
                this.membersArray = new ArrayCollection();
            };
        }

        private function init():void
        {
            addEventListener(FlexEvent.SHOW, this.updateData);
            if (((!(MainScreen.getPlayer() == null)) && (!(MainScreen.getPlayer().playerInfo.alliance == null))))
            {
                this.setMemberLevel(MainScreen.getPlayer().playerInfo.levelId);
            };
        }

        private function _AllianceMembers_DataGridColumn4_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Prestige";
            _local_1.dataField = "prestige";
            _local_1.width = 0.2;
            _local_1.itemRenderer = this._AllianceMembers_ClassFactory2_i();
            return (_local_1);
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

        private function retireMember():void
        {
            var _local_1:popUpWinShowEvent = new popUpWinShowEvent(popUpWinShowEvent.ALLIANCE_EXPEL_MEMBER);
            _local_1.membersArray = this.membersArray;
            dispatchEvent(_local_1);
        }

        private function _AllianceMembers_ClassFactory2_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._AllianceMembers_ClassFactory1 = _local_1;
            BindingManager.executeBindings(this, "_AllianceMembers_ClassFactory1", this._AllianceMembers_ClassFactory1);
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:AllianceMembers;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._AllianceMembers_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_AllianceMembersWatcherSetupUtil");
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

        private function onRelinquishHost():void
        {
            if (this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALLIANCE_CHANGE_HOST));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceMembers_ClassFactory2():ClassFactory
        {
            return (this._1809330468_AllianceMembers_ClassFactory2);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceMembers_ClassFactory3():ClassFactory
        {
            return (this._1809330469_AllianceMembers_ClassFactory3);
        }

        private function _AllianceMembers_ClassFactory4_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._AllianceMembers_ClassFactory3 = _local_1;
            BindingManager.executeBindings(this, "_AllianceMembers_ClassFactory3", this._AllianceMembers_ClassFactory3);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceMembers_ClassFactory0():ClassFactory
        {
            return (this._1809330466_AllianceMembers_ClassFactory0);
        }

        private function _AllianceMembers_DataGridColumn3_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Ranking";
            _local_1.dataField = "ranking";
            _local_1.width = 0.1;
            _local_1.itemRenderer = this._AllianceMembers_ClassFactory1_i();
            return (_local_1);
        }

        private function _AllianceMembers_DataGridColumn5_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Cities";
            _local_1.dataField = "castleCount";
            _local_1.width = 0.08;
            return (_local_1);
        }

        private function onPendingAppsBtn():void
        {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALLIANCE_PENDING_APPLICATIONS));
        }

        private function _AllianceMembers_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Player";
            _local_1.dataField = "userName";
            _local_1.width = 0.21;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceMembers_ClassFactory1():ClassFactory
        {
            return (this._1809330467_AllianceMembers_ClassFactory1);
        }

        public function ___AllianceMembers_Button5_click(_arg_1:MouseEvent):void
        {
            this.onQuitAllianceBtn();
        }

        [Bindable(event="propertyChange")]
        public function get formatDateTime():DateFormatter
        {
            return (this._1765123250formatDateTime);
        }

        [Bindable(event="propertyChange")]
        private function get memberLevel():int
        {
            return (this._1366077706memberLevel);
        }

        public function set _AllianceMembers_ClassFactory0(_arg_1:ClassFactory):void
        {
            var _local_2:Object = this._1809330466_AllianceMembers_ClassFactory0;
            if (_local_2 !== _arg_1)
            {
                this._1809330466_AllianceMembers_ClassFactory0 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceMembers_ClassFactory0", _local_2, _arg_1));
            };
        }

        public function set _AllianceMembers_ClassFactory1(_arg_1:ClassFactory):void
        {
            var _local_2:Object = this._1809330467_AllianceMembers_ClassFactory1;
            if (_local_2 !== _arg_1)
            {
                this._1809330467_AllianceMembers_ClassFactory1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceMembers_ClassFactory1", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get membersArray():ArrayCollection
        {
            return (this._481919168membersArray);
        }

        public function toDebugString():String
        {
            return ("fields: membersArray, method: fetchPage(), columns: userName allianceLevel ranking prestige castleCount population lastLoginTimeStr");
        }

        public function ___AllianceMembers_Button2_click(_arg_1:MouseEvent):void
        {
            this.onInviteBtn();
        }

        public function setMemberLevel(_arg_1:int):void
        {
            this.memberLevel = _arg_1;
        }

        private function _AllianceMembers_DataGridColumn7_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Last On";
            _local_1.dataField = "lastLoginTimeStr";
            _local_1.width = 0.2;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        private function _AllianceMembers_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return ((((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE)) || (this.memberLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE));
            }, function (_arg_1:Boolean):void
            {
                _AllianceMembers_Button2.enabled = _arg_1;
            }, "_AllianceMembers_Button2.enabled");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE)) || (this.memberLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE));
            }, function (_arg_1:Boolean):void
            {
                _AllianceMembers_Button3.enabled = _arg_1;
            }, "_AllianceMembers_Button3.enabled");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE));
            }, function (_arg_1:Boolean):void
            {
                _AllianceMembers_Button4.visible = _arg_1;
            }, "_AllianceMembers_Button4.visible");
            result[2] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.membersArray);
            }, function (_arg_1:Object):void
            {
                _AllianceMembers_DataGrid1.dataProvider = _arg_1;
            }, "_AllianceMembers_DataGrid1.dataProvider");
            result[3] = binding;
            binding = new Binding(this, function ():Class
            {
                return (FormatRanking_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _AllianceMembers_ClassFactory0.generator = _arg_1;
            }, "_AllianceMembers_ClassFactory0.generator");
            result[4] = binding;
            binding = new Binding(this, function ():Class
            {
                return (FormatPrestige_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _AllianceMembers_ClassFactory1.generator = _arg_1;
            }, "_AllianceMembers_ClassFactory1.generator");
            result[5] = binding;
            binding = new Binding(this, function ():Class
            {
                return (FormatPopulation_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _AllianceMembers_ClassFactory2.generator = _arg_1;
            }, "_AllianceMembers_ClassFactory2.generator");
            result[6] = binding;
            binding = new Binding(this, function ():Class
            {
                return (ViewMemberBtn_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _AllianceMembers_ClassFactory3.generator = _arg_1;
            }, "_AllianceMembers_ClassFactory3.generator");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.memberLevel == AllianceConstants.LAST_POWER_FOR_ALLIANCE) || ((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) && (this.membersArray.length == 1)));
            }, function (_arg_1:Boolean):void
            {
                _AllianceMembers_Button5.enabled = _arg_1;
            }, "_AllianceMembers_Button5.enabled");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE) || (this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE)) || (this.memberLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE));
            }, function (_arg_1:Boolean):void
            {
                _AllianceMembers_Button6.enabled = _arg_1;
            }, "_AllianceMembers_Button6.enabled");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) && (!(this.membersArray.length == 1)));
            }, function (_arg_1:Boolean):void
            {
                _AllianceMembers_Button7.enabled = _arg_1;
            }, "_AllianceMembers_Button7.enabled");
            result[10] = binding;
            return (result);
        }

        private function _AllianceMembers_ClassFactory1_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._AllianceMembers_ClassFactory0 = _local_1;
            BindingManager.executeBindings(this, "_AllianceMembers_ClassFactory0", this._AllianceMembers_ClassFactory0);
            return (_local_1);
        }

        private function _AllianceMembers_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE)) || (this.memberLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE));
            _local_1 = ((((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE)) || (this.memberLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE));
            _local_1 = (((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE));
            _local_1 = this.membersArray;
            _local_1 = FormatRanking_inlineComponent0;
            _local_1 = FormatPrestige_inlineComponent0;
            _local_1 = FormatPopulation_inlineComponent0;
            _local_1 = ViewMemberBtn_inlineComponent0;
            _local_1 = ((this.memberLevel == AllianceConstants.LAST_POWER_FOR_ALLIANCE) || ((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) && (this.membersArray.length == 1)));
            _local_1 = (((this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE) || (this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE)) || (this.memberLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE));
            _local_1 = ((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) && (!(this.membersArray.length == 1)));
        }

        private function onResignationBtn():void
        {
            if ((((this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE) || (this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE)) || (this.memberLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE)))
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, (("Are you sure you want to resign from your position as " + MainScreen.getPlayer().playerInfo.allianceLevel) + "?"), this.onClickOk_resignForAlliance, "Yes", "Cancel"));
            };
        }

        public function ___AllianceMembers_Button6_click(_arg_1:MouseEvent):void
        {
            this.onResignationBtn();
        }

        public function ___AllianceMembers_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        public function ___AllianceMembers_Button4_click(_arg_1:MouseEvent):void
        {
            this.retireMember();
        }

        public function set _AllianceMembers_ClassFactory2(_arg_1:ClassFactory):void
        {
            var _local_2:Object = this._1809330468_AllianceMembers_ClassFactory2;
            if (_local_2 !== _arg_1)
            {
                this._1809330468_AllianceMembers_ClassFactory2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceMembers_ClassFactory2", _local_2, _arg_1));
            };
        }

        public function set _AllianceMembers_ClassFactory3(_arg_1:ClassFactory):void
        {
            var _local_2:Object = this._1809330469_AllianceMembers_ClassFactory3;
            if (_local_2 !== _arg_1)
            {
                this._1809330469_AllianceMembers_ClassFactory3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceMembers_ClassFactory3", _local_2, _arg_1));
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

        private function onClickOk_sayByetoAlliance(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().sayByetoAlliance();
            };
        }

        public function fetchPage(_arg_1:Object=null):void
        {
            this.updateData();
        }

        private function _wn1051(_arg_1:AllianceMembersResponse):void
        {
            var _local_3:PlayerInfoBean;
            var _local_2:ObjectProxy;
            this.membersArray.removeAll();
            if (_arg_1.ok != 1)
            {
                return;
            };
            for each (_local_3 in _arg_1.membersArray)
            {
                _local_2 = new ObjectProxy(_local_3.toObject());
                _local_2.lastLoginTimeStr = this.formatDateTime.format(new Date(_local_3.lastLoginTime).toString());
                _local_2.titleStr = Map.TITLES.getItemAt(_local_3.titleId);
                _local_2.label = (((((((((((((((((("Office: " + _local_3.office) + "\n") + "Title: ") + _local_2.titleStr) + " ") + _local_3.castleCount) + "/") + (1 + _local_3.titleId)) + "\n") + "Flag: ") + _local_3.flag) + "\n") + "Sex: ") + ((_local_3.sex == 0) ? "M" : "F")) + "\n") + "Honor ") + _local_3.honor) + "\n");
                this.membersArray.addItem(_local_2);
            };
        }

        private function onInviteBtn():void
        {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALLIANCE_INVITE_MEMBER));
        }

        private function onClickOk_resignForAlliance(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().resignForAlliance();
            };
        }

        private function onQuitAllianceBtn():void
        {
            if (this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "If you quit, this alliance will be deleted. Are you sure you want to quit?", this.onClickOk_sayByetoAlliance, "Yes", "Cancel"));
            }
            else
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "If you quit this alliance, you will have to wait 24 hours before you can rejoin. Are you sure you want to quit?", this.onClickOk_sayByetoAlliance, "Yes", "Cancel"));
            };
        }

        private function _AllianceMembers_DataGridColumn6_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Population";
            _local_1.dataField = "population";
            _local_1.width = 0.14;
            _local_1.itemRenderer = this._AllianceMembers_ClassFactory3_i();
            return (_local_1);
        }

        private function _AllianceMembers_DataGridColumn8_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "View";
            _local_1.dataField = "userName";
            _local_1.width = 0.1;
            _local_1.itemRenderer = this._AllianceMembers_ClassFactory4_i();
            return (_local_1);
        }

        private function _AllianceMembers_DateFormatter1_i():DateFormatter
        {
            var _local_1:DateFormatter = new DateFormatter();
            this.formatDateTime = _local_1;
            _local_1.formatString = "MM/DD/YY JJ:NN";
            return (_local_1);
        }

        private function _AllianceMembers_ClassFactory3_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._AllianceMembers_ClassFactory2 = _local_1;
            BindingManager.executeBindings(this, "_AllianceMembers_ClassFactory2", this._AllianceMembers_ClassFactory2);
            return (_local_1);
        }


    }
}//package autoevony.gui.info.Alliance

