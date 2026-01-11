// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Alliance.Diplomacy

package autoevony.gui.info.Alliance
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.ViewStack;
    import mx.core.ClassFactory;
    import mx.controls.DataGrid;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.binding.BindingManager;
    import mx.binding.Binding;
    import autoevony.gui.info.FormatRank_inlineComponent0;
    import autoevony.gui.info.FormatPrestige_inlineComponent0;
    import autoevony.gui.info.FormatHonor_inlineComponent0;
    import mx.events.PropertyChangeEvent;
    import autoevony.gui.MainScreen;
    import com.evony.client.action.ActionFactory;
    import flash.utils.getDefinitionByName;
    import com.evony.common.beans.UnitAlliance;
    import mx.utils.ObjectProxy;
    import com.evony.common.constants.AllianceConstants;
    import com.evony.common.module.alliance.AllianceFriendshipResponse;
    import com.evony.common.module.CommandResponse;
    import autoevony.event.popUpWinShowEvent;
    import com.evony.client.response.ResponseDispatcher;
    import mx.events.FlexEvent;
    import flash.events.Event;
    import mx.controls.dataGridClasses.DataGridColumn;
    import flash.events.MouseEvent;
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

    public class Diplomacy extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1366077706memberLevel:int = 0;
        private var _1191572447selector:ViewStack;
        private var _208958744_AllianceDiplo_ClassFactory1:ClassFactory;
        private var _208958745_AllianceDiplo_ClassFactory2:ClassFactory;
        private var _208958743_AllianceDiplo_ClassFactory0:ClassFactory;
        private var _1412433860_MyAlliance_DataGrid1:DataGrid;
        private var _838846263update:Button;
        public var _Diplomacy_ClassFactory4:ClassFactory;

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
                            return ({"childDescriptors":[new UIComponentDescriptor({
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
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":10});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"update",
                                                "events":{"click":"__update_click"},
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
                                }), new UIComponentDescriptor({
                                    "type":ViewStack,
                                    "id":"selector",
                                    "stylesFactory":function ():void
                                    {
                                        this.borderStyle = "none";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentHeight":100,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":DataGrid,
                                                            "id":"_MyAlliance_DataGrid1",
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
                                                                    "sortableColumns":false,
                                                                    "variableRowHeight":true,
                                                                    "visible":true,
                                                                    "wordWrap":false,
                                                                    "columns":[_Diplomacy_DataGridColumn1_c(), _Diplomacy_DataGridColumn2_c(), _Diplomacy_DataGridColumn3_c(), _Diplomacy_DataGridColumn4_c(), _Diplomacy_DataGridColumn5_c(), _Diplomacy_DataGridColumn6_c(), _Diplomacy_DataGridColumn7_c(), _Diplomacy_DataGridColumn8_c()]
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
        private var _1452549567relationListArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Diplomacy()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", this.___Diplomacy_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Diplomacy._watcherSetupUtil = _arg_1;
        }


        private function _Diplomacy_ClassFactory1_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._AllianceDiplo_ClassFactory0 = _local_1;
            BindingManager.executeBindings(this, "_AllianceDiplo_ClassFactory0", this._AllianceDiplo_ClassFactory0);
            return (_local_1);
        }

        private function _Diplomacy_ClassFactory3_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._AllianceDiplo_ClassFactory2 = _local_1;
            BindingManager.executeBindings(this, "_AllianceDiplo_ClassFactory2", this._AllianceDiplo_ClassFactory2);
            return (_local_1);
        }

        private function _Diplomacy_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.relationListArray);
            }, function (_arg_1:Object):void
            {
                _MyAlliance_DataGrid1.dataProvider = _arg_1;
            }, "_MyAlliance_DataGrid1.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():Class
            {
                return (FormatRank_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _AllianceDiplo_ClassFactory0.generator = _arg_1;
            }, "_AllianceDiplo_ClassFactory0.generator");
            result[1] = binding;
            binding = new Binding(this, function ():Class
            {
                return (FormatPrestige_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _AllianceDiplo_ClassFactory1.generator = _arg_1;
            }, "_AllianceDiplo_ClassFactory1.generator");
            result[2] = binding;
            binding = new Binding(this, function ():Class
            {
                return (FormatHonor_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _AllianceDiplo_ClassFactory2.generator = _arg_1;
            }, "_AllianceDiplo_ClassFactory2.generator");
            result[3] = binding;
            binding = new Binding(this, function ():Class
            {
                return (CancelDiploBtn_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _Diplomacy_ClassFactory4.generator = _arg_1;
            }, "_Diplomacy_ClassFactory4.generator");
            result[4] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get memberLevel():int
        {
            return (this._1366077706memberLevel);
        }

        public function set relationListArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1452549567relationListArray;
            if (_local_2 !== _arg_1)
            {
                this._1452549567relationListArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "relationListArray", _local_2, _arg_1));
            };
        }

        public function set _MyAlliance_DataGrid1(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1412433860_MyAlliance_DataGrid1;
            if (_local_2 !== _arg_1)
            {
                this._1412433860_MyAlliance_DataGrid1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_MyAlliance_DataGrid1", _local_2, _arg_1));
            };
        }

        public function set update(_arg_1:Button):void
        {
            var _local_2:Object = this._838846263update;
            if (_local_2 !== _arg_1)
            {
                this._838846263update = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "update", _local_2, _arg_1));
            };
        }

        private function updateData(_arg_1:Object=null):void
        {
            if (MainScreen.getPlayer() == null)
            {
                return;
            };
            if (MainScreen.getPlayer().playerInfo.alliance != null)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().getAllianceFriendshipList();
            }
            else
            {
                this.relationListArray.removeAll();
            };
        }

        public function cancelRelation(_arg_1:Object):void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().dropAllianceFriendshipRelation(_arg_1["allianceName"]);
        }

        override public function initialize():void
        {
            var target:Diplomacy;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._Diplomacy_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_DiplomacyWatcherSetupUtil");
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
        public function get _AllianceDiplo_ClassFactory2():ClassFactory
        {
            return (this._208958745_AllianceDiplo_ClassFactory2);
        }

        private function handleAllianceFriendshipResponse(_arg_1:AllianceFriendshipResponse):void
        {
            var _local_3:UnitAlliance;
            if (_arg_1.ok != 1)
            {
                return;
            };
            var _local_2:ObjectProxy;
            this.relationListArray.removeAll();
            for each (_local_3 in _arg_1.friendlyListArray)
            {
                _local_2 = new ObjectProxy(_local_3.toObject());
                _local_2.relation = "Friendly";
                _local_2.prestige = _local_3.aPrestigeCount;
                _local_2.showCancelBtn = ((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE));
                this.relationListArray.addItem(_local_2);
            };
            for each (_local_3 in _arg_1.middleListArray)
            {
                _local_2 = new ObjectProxy(_local_3.toObject());
                _local_2.relation = "Neutral";
                _local_2.prestige = _local_3.aPrestigeCount;
                _local_2.showCancelBtn = ((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE));
                this.relationListArray.addItem(_local_2);
            };
            for each (_local_3 in _arg_1.enemyListArray)
            {
                _local_2 = new ObjectProxy(_local_3.toObject());
                _local_2.relation = "Hostile";
                _local_2.prestige = _local_3.aPrestigeCount;
                _local_2.showCancelBtn = ((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE));
                this.relationListArray.addItem(_local_2);
            };
        }

        private function onDropAllianceFriendshipRelation(_arg_1:AllianceFriendshipResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _arg_1.errorMsg));
            }
            else
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "Diplomatic relationship is cancelled successfully."));
                ActionFactory.getInstance().getAllianceManagementCommands().getAllianceFriendshipList();
            };
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceDiplo_ClassFactory0():ClassFactory
        {
            return (this._208958743_AllianceDiplo_ClassFactory0);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_GET_ALLIANCE_FRIENDSHIP_LIST, this.handleAllianceFriendshipResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_DROP_ALLIANCE_FRIENDSHIP_RELATION, this.onDropAllianceFriendshipRelation);
            if (((!(MainScreen.getPlayer() == null)) && (!(MainScreen.getPlayer().playerInfo.alliance == null))))
            {
                this.setMemberLevel(MainScreen.getPlayer().playerInfo.levelId);
            };
            addEventListener(FlexEvent.SHOW, this.updateData);
            addEventListener(Event.RENDER, this._bc516);
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

        [Bindable(event="propertyChange")]
        public function get _AllianceDiplo_ClassFactory1():ClassFactory
        {
            return (this._208958744_AllianceDiplo_ClassFactory1);
        }

        private function _Diplomacy_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Relation";
            _local_1.dataField = "relation";
            _local_1.width = 0.18;
            return (_local_1);
        }

        private function _Diplomacy_DataGridColumn4_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Members";
            _local_1.dataField = "memberCount";
            _local_1.width = 0.15;
            return (_local_1);
        }

        public function set _AllianceDiplo_ClassFactory2(_arg_1:ClassFactory):void
        {
            var _local_2:Object = this._208958745_AllianceDiplo_ClassFactory2;
            if (_local_2 !== _arg_1)
            {
                this._208958745_AllianceDiplo_ClassFactory2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceDiplo_ClassFactory2", _local_2, _arg_1));
            };
        }

        private function _Diplomacy_DataGridColumn6_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Prestige";
            _local_1.dataField = "prestige";
            _local_1.width = 0.25;
            _local_1.itemRenderer = this._Diplomacy_ClassFactory2_i();
            return (_local_1);
        }

        private function _Diplomacy_DataGridColumn8_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = " ";
            _local_1.dataField = "allianceName";
            _local_1.width = 0.2;
            _local_1.itemRenderer = this._Diplomacy_ClassFactory4_i();
            return (_local_1);
        }

        private function _bc516(_arg_1:Object):void
        {
            if (MainScreen.getPlayer() == null)
            {
                return;
            };
            removeEventListener(Event.RENDER, this._bc516);
            this.updateData();
        }

        public function set _AllianceDiplo_ClassFactory0(_arg_1:ClassFactory):void
        {
            var _local_2:Object = this._208958743_AllianceDiplo_ClassFactory0;
            if (_local_2 !== _arg_1)
            {
                this._208958743_AllianceDiplo_ClassFactory0 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceDiplo_ClassFactory0", _local_2, _arg_1));
            };
        }

        public function set selector(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._1191572447selector;
            if (_local_2 !== _arg_1)
            {
                this._1191572447selector = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selector", _local_2, _arg_1));
            };
        }

        private function _Diplomacy_ClassFactory2_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._AllianceDiplo_ClassFactory1 = _local_1;
            BindingManager.executeBindings(this, "_AllianceDiplo_ClassFactory1", this._AllianceDiplo_ClassFactory1);
            return (_local_1);
        }

        public function setMemberLevel(_arg_1:int):void
        {
            this.memberLevel = _arg_1;
            this.updateData();
        }

        public function toDebugString():String
        {
            return ("fields: relationListArray allianceAddPlayerbyLeaderInfoBeanListArray allianceWanted, method: fetchPage(), columns: allianceName relation rank memberCount leaderName prestige honor rawData");
        }

        [Bindable(event="propertyChange")]
        public function get _MyAlliance_DataGrid1():DataGrid
        {
            return (this._1412433860_MyAlliance_DataGrid1);
        }

        private function _Diplomacy_ClassFactory4_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._Diplomacy_ClassFactory4 = _local_1;
            BindingManager.executeBindings(this, "_Diplomacy_ClassFactory4", this._Diplomacy_ClassFactory4);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get relationListArray():ArrayCollection
        {
            return (this._1452549567relationListArray);
        }

        [Bindable(event="propertyChange")]
        public function get update():Button
        {
            return (this._838846263update);
        }

        public function set _AllianceDiplo_ClassFactory1(_arg_1:ClassFactory):void
        {
            var _local_2:Object = this._208958744_AllianceDiplo_ClassFactory1;
            if (_local_2 !== _arg_1)
            {
                this._208958744_AllianceDiplo_ClassFactory1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceDiplo_ClassFactory1", _local_2, _arg_1));
            };
        }

        private function _Diplomacy_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.relationListArray;
            _local_1 = FormatRank_inlineComponent0;
            _local_1 = FormatPrestige_inlineComponent0;
            _local_1 = FormatHonor_inlineComponent0;
            _local_1 = CancelDiploBtn_inlineComponent0;
        }

        public function ___Diplomacy_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        [Bindable(event="propertyChange")]
        public function get selector():ViewStack
        {
            return (this._1191572447selector);
        }

        private function _Diplomacy_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Alliance";
            _local_1.dataField = "allianceName";
            _local_1.width = 0.22;
            return (_local_1);
        }

        private function _Diplomacy_DataGridColumn3_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Rank";
            _local_1.dataField = "rank";
            _local_1.width = 0.15;
            _local_1.itemRenderer = this._Diplomacy_ClassFactory1_i();
            return (_local_1);
        }

        private function _Diplomacy_DataGridColumn5_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Host";
            _local_1.dataField = "leaderName";
            _local_1.width = 0.25;
            return (_local_1);
        }

        private function _Diplomacy_DataGridColumn7_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Honor";
            _local_1.dataField = "honor";
            _local_1.width = 0.25;
            _local_1.itemRenderer = this._Diplomacy_ClassFactory3_i();
            return (_local_1);
        }

        public function fetchPage():void
        {
            this.updateData();
        }

        public function __update_click(_arg_1:MouseEvent):void
        {
            this.updateData();
        }


    }
}//package autoevony.gui.info.Alliance

