// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.allianceManage.allianceExchange.Diplomatic

package view.module.alliance.oldAlliance.allianceManage.allianceExchange
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.DataGrid;
    import mx.controls.TextInput;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.containers.ViewStack;
    import mx.controls.Button;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import mx.controls.ToggleButtonBar;
    import mx.collections.ArrayCollection;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import mx.binding.BindingManager;
    import mx.events.ItemClickEvent;
    import com.evony.client.response.ResponseDispatcher;
    import mx.core.ClassFactory;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.constants.AllianceConstants;
    import com.evony.MsgDispacther;
    import com.evony.events.WindowChangeEvent;
    import view.module.alliance.AllianceWin;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.alliance.AllianceFriendshipResponse;
    import com.evony.common.module.alliance.AllianceManagementResponse;
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

    public class Diplomatic extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1615879686oppositeAlliance_view:Canvas;
        private var _1642265064middleAlliance_view:Canvas;
        public var _Diplomatic_Array1:Array;
        private var _1968405825oppositeAllianceDG:DataGrid;
        private var _1783885162setRelationNames:TextInput;
        private var _572762056friendAllianceDG:DataGrid;
        public var _Diplomatic_DataGridColumn10:DataGridColumn;
        public var _Diplomatic_DataGridColumn11:DataGridColumn;
        public var _Diplomatic_DataGridColumn12:DataGridColumn;
        public var _Diplomatic_DataGridColumn13:DataGridColumn;
        public var _Diplomatic_DataGridColumn14:DataGridColumn;
        public var _Diplomatic_DataGridColumn15:DataGridColumn;
        public var _Diplomatic_DataGridColumn17:DataGridColumn;
        public var _Diplomatic_DataGridColumn18:DataGridColumn;
        public var _Diplomatic_DataGridColumn19:DataGridColumn;
        public var _Diplomatic_DataGridColumn16:DataGridColumn;
        private var _946505330viewstack1:ViewStack;
        public var _Diplomatic_DataGridColumn21:DataGridColumn;
        public var _Diplomatic_DataGridColumn20:DataGridColumn;
        public var _Diplomatic_Button1:Button;
        public var _Diplomatic_Button2:Button;
        public var _Diplomatic_DataGridColumn1:DataGridColumn;
        public var _Diplomatic_DataGridColumn3:DataGridColumn;
        public var _Diplomatic_DataGridColumn4:DataGridColumn;
        public var _Diplomatic_DataGridColumn5:DataGridColumn;
        public var _Diplomatic_DataGridColumn6:DataGridColumn;
        public var _Diplomatic_DataGridColumn7:DataGridColumn;
        public var _Diplomatic_DataGridColumn8:DataGridColumn;
        public var _Diplomatic_DataGridColumn9:DataGridColumn;
        private var _231480943middleAllianceDG:DataGrid;
        public var _Diplomatic_DataGridColumn2:DataGridColumn;
        private var _777096111friendAlliance_view:Canvas;
        public var _Diplomatic_Text1:Text;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":ToggleButtonBar,
                        "events":{"itemClick":"___Diplomatic_ToggleButtonBar1_itemClick"},
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 1;
                            this.top = "7";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "styleName":"titleToggleButtonBar",
                                "height":23,
                                "dataProvider":_Diplomatic_Array1_i()
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"viewstack1",
                        "stylesFactory":function ():void
                        {
                            this.top = "30";
                            this.bottom = "36";
                            this.left = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"friendAlliance_view",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"friendAllianceDG",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "styleName":"style2",
                                                        "y":0,
                                                        "resizableColumns":false,
                                                        "draggableColumns":false,
                                                        "sortableColumns":false,
                                                        "selectable":false,
                                                        "columns":[_Diplomatic_DataGridColumn1_i(), _Diplomatic_DataGridColumn2_i(), _Diplomatic_DataGridColumn3_i(), _Diplomatic_DataGridColumn4_i(), _Diplomatic_DataGridColumn5_i(), _Diplomatic_DataGridColumn6_i(), _Diplomatic_DataGridColumn7_i()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"middleAlliance_view",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"middleAllianceDG",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "styleName":"style2",
                                                        "resizableColumns":false,
                                                        "draggableColumns":false,
                                                        "sortableColumns":false,
                                                        "selectable":false,
                                                        "columns":[_Diplomatic_DataGridColumn8_i(), _Diplomatic_DataGridColumn9_i(), _Diplomatic_DataGridColumn10_i(), _Diplomatic_DataGridColumn11_i(), _Diplomatic_DataGridColumn12_i(), _Diplomatic_DataGridColumn13_i(), _Diplomatic_DataGridColumn14_i()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"oppositeAlliance_view",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"oppositeAllianceDG",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "styleName":"style2",
                                                        "resizableColumns":false,
                                                        "draggableColumns":false,
                                                        "sortableColumns":false,
                                                        "selectable":false,
                                                        "columns":[_Diplomatic_DataGridColumn15_i(), _Diplomatic_DataGridColumn16_i(), _Diplomatic_DataGridColumn17_i(), _Diplomatic_DataGridColumn18_i(), _Diplomatic_DataGridColumn19_i(), _Diplomatic_DataGridColumn20_i(), _Diplomatic_DataGridColumn21_i()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                            this.bottom = "3";
                            this.left = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":413,
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_Diplomatic_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "5";
                                        this.verticalCenter = "0";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":100,
                                            "height":22,
                                            "selectable":false,
                                            "styleName":"PropertyName1"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"setRelationNames",
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"textInput",
                                            "x":105,
                                            "width":129
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_Diplomatic_Button1",
                                    "events":{"click":"___Diplomatic_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "10";
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":25,
                                            "styleName":"b95",
                                            "width":95
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_Diplomatic_Button2",
                        "events":{"click":"___Diplomatic_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                            this.bottom = "7";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b95",
                                "width":95
                            });
                        }
                    })]});
            }
        });
        private var _1165016863friendsDP:ArrayCollection = new ArrayCollection();
        private var _1650011935middleDP:ArrayCollection = new ArrayCollection();
        private var _161799757oppositeDP:ArrayCollection = new ArrayCollection();
        private var _476564823cancelStr:String = Lang.msg("取消");
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Diplomatic()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___Diplomatic_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Diplomatic._watcherSetupUtil = _arg_1;
        }


        public function set setRelationNames(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1783885162setRelationNames;
            if (_local_2 !== _arg_1)
            {
                this._1783885162setRelationNames = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "setRelationNames", _local_2, _arg_1));
            };
        }

        private function _Diplomatic_DataGridColumn10_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn10 = _local_1;
            _local_1.dataField = "memberCount";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn10", _Diplomatic_DataGridColumn10);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get oppositeAlliance_view():Canvas
        {
            return (this._1615879686oppositeAlliance_view);
        }

        private function _Diplomatic_DataGridColumn14_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn14 = _local_1;
            _local_1.dataField = "allianceName";
            _local_1.width = 80;
            _local_1.itemRenderer = _Diplomatic_ClassFactory2_c();
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn14", _Diplomatic_DataGridColumn14);
            return (_local_1);
        }

        public function set oppositeAlliance_view(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1615879686oppositeAlliance_view;
            if (_local_2 !== _arg_1)
            {
                this._1615879686oppositeAlliance_view = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "oppositeAlliance_view", _local_2, _arg_1));
            };
        }

        public function ___Diplomatic_ToggleButtonBar1_itemClick(_arg_1:ItemClickEvent):void
        {
            itemClickHandle(_arg_1);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_GET_ALLIANCE_FRIENDSHIP_LIST, onGetAllianceFriendShipList);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_SET_ALLIANCE_FRIENDSHIP, onSetAllianceFriendship);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_DROP_ALLIANCE_FRIENDSHIP_RELATION, onDropAllianceFriendshipRelation);
            if (this.initialized)
            {
                this.refresh();
            };
        }

        private function _Diplomatic_DataGridColumn18_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn18 = _local_1;
            _local_1.dataField = "rank";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn18", _Diplomatic_DataGridColumn18);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get middleDP():ArrayCollection
        {
            return (this._1650011935middleDP);
        }

        public function set viewstack1(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._946505330viewstack1;
            if (_local_2 !== _arg_1)
            {
                this._946505330viewstack1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewstack1", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get middleAlliance_view():Canvas
        {
            return (this._1642265064middleAlliance_view);
        }

        private function _Diplomatic_DataGridColumn21_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn21 = _local_1;
            _local_1.dataField = "allianceName";
            _local_1.width = 80;
            _local_1.itemRenderer = _Diplomatic_ClassFactory3_c();
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn21", _Diplomatic_DataGridColumn21);
            return (_local_1);
        }

        private function _Diplomatic_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn4 = _local_1;
            _local_1.dataField = "rank";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn4", _Diplomatic_DataGridColumn4);
            return (_local_1);
        }

        private function _Diplomatic_Array1_i():Array
        {
            var _local_1:Array = [null, null, null];
            _Diplomatic_Array1 = _local_1;
            BindingManager.executeBindings(this, "_Diplomatic_Array1", _Diplomatic_Array1);
            return (_local_1);
        }

        private function _Diplomatic_DataGridColumn8_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn8 = _local_1;
            _local_1.dataField = "allianceName";
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn8", _Diplomatic_DataGridColumn8);
            return (_local_1);
        }

        private function _Diplomatic_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Diplomatic_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function submitRelation():void
        {
            switch (viewstack1.selectedChild)
            {
                case friendAlliance_view:
                    ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(setRelationNames.text, AllianceConstants.FRIEND_ALLIANCE);
                    return;
                case middleAlliance_view:
                    ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(setRelationNames.text, AllianceConstants.MIDDLE_ALLIANCE);
                    return;
                case oppositeAlliance_view:
                    ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(setRelationNames.text, AllianceConstants.ENEMY_ALLIANCE);
                    return;
            };
        }

        public function ___Diplomatic_Button2_click(_arg_1:MouseEvent):void
        {
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.SUBWINDOW_CLOSE));
        }

        public function set middleAlliance_view(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1642265064middleAlliance_view;
            if (_local_2 !== _arg_1)
            {
                this._1642265064middleAlliance_view = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "middleAlliance_view", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get friendAllianceDG():DataGrid
        {
            return (this._572762056friendAllianceDG);
        }

        [Bindable(event="propertyChange")]
        public function get oppositeAllianceDG():DataGrid
        {
            return (this._1968405825oppositeAllianceDG);
        }

        private function _Diplomatic_DataGridColumn13_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn13 = _local_1;
            _local_1.dataField = "honor";
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn13", _Diplomatic_DataGridColumn13);
            return (_local_1);
        }

        private function _Diplomatic_DataGridColumn17_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn17 = _local_1;
            _local_1.dataField = "memberCount";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn17", _Diplomatic_DataGridColumn17);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get cancelStr():String
        {
            return (this._476564823cancelStr);
        }

        private function _Diplomatic_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn3 = _local_1;
            _local_1.dataField = "memberCount";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn3", _Diplomatic_DataGridColumn3);
            return (_local_1);
        }

        public function set friendAlliance_view(_arg_1:Canvas):void
        {
            var _local_2:Object = this._777096111friendAlliance_view;
            if (_local_2 !== _arg_1)
            {
                this._777096111friendAlliance_view = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendAlliance_view", _local_2, _arg_1));
            };
        }

        private function _Diplomatic_DataGridColumn7_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn7 = _local_1;
            _local_1.dataField = "allianceName";
            _local_1.width = 80;
            _local_1.itemRenderer = _Diplomatic_ClassFactory1_c();
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn7", _Diplomatic_DataGridColumn7);
            return (_local_1);
        }

        private function _Diplomatic_DataGridColumn20_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn20 = _local_1;
            _local_1.dataField = "honor";
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn20", _Diplomatic_DataGridColumn20);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get setRelationNames():TextInput
        {
            return (this._1783885162setRelationNames);
        }

        private function set oppositeDP(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._161799757oppositeDP;
            if (_local_2 !== _arg_1)
            {
                this._161799757oppositeDP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "oppositeDP", _local_2, _arg_1));
            };
        }

        private function _Diplomatic_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Diplomatic_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function set friendAllianceDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._572762056friendAllianceDG;
            if (_local_2 !== _arg_1)
            {
                this._572762056friendAllianceDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendAllianceDG", _local_2, _arg_1));
            };
        }

        public function set _middleDP(_arg_1:ArrayCollection):void
        {
            middleDP = _arg_1;
        }

        public function set oppositeAllianceDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1968405825oppositeAllianceDG;
            if (_local_2 !== _arg_1)
            {
                this._1968405825oppositeAllianceDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "oppositeAllianceDG", _local_2, _arg_1));
            };
        }

        private function _Diplomatic_DataGridColumn12_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn12 = _local_1;
            _local_1.dataField = "aPrestigeCount";
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn12", _Diplomatic_DataGridColumn12);
            return (_local_1);
        }

        private function _Diplomatic_DataGridColumn16_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn16 = _local_1;
            _local_1.dataField = "leaderName";
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn16", _Diplomatic_DataGridColumn16);
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:Diplomatic;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _Diplomatic_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_oldAlliance_allianceManage_allianceExchange_DiplomaticWatcherSetupUtil");
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
        public function get middleAllianceDG():DataGrid
        {
            return (this._231480943middleAllianceDG);
        }

        [Bindable(event="propertyChange")]
        public function get viewstack1():ViewStack
        {
            return (this._946505330viewstack1);
        }

        public function cancelRelation(_arg_1:Object):void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().dropAllianceFriendshipRelation(_arg_1["allianceName"]);
        }

        private function onDropAllianceFriendshipRelation(_arg_1:AllianceFriendshipResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("联盟关系取消成功"));
                ActionFactory.getInstance().getAllianceManagementCommands().getAllianceFriendshipList();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function _Diplomatic_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn2 = _local_1;
            _local_1.dataField = "leaderName";
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn2", _Diplomatic_DataGridColumn2);
            return (_local_1);
        }

        public function set _oppositeDP(_arg_1:ArrayCollection):void
        {
            oppositeDP = _arg_1;
        }

        private function onGetAllianceFriendShipList(_arg_1:AllianceFriendshipResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                _friendsDP = _arg_1.friendlyListArray;
                _middleDP = _arg_1.middleListArray;
                _oppositeDP = _arg_1.enemyListArray;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function _Diplomatic_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn6 = _local_1;
            _local_1.dataField = "honor";
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn6", _Diplomatic_DataGridColumn6);
            return (_local_1);
        }

        public function set cancelStr(_arg_1:String):void
        {
            var _local_2:Object = this._476564823cancelStr;
            if (_local_2 !== _arg_1)
            {
                this._476564823cancelStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cancelStr", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get friendAlliance_view():Canvas
        {
            return (this._777096111friendAlliance_view);
        }

        [Bindable(event="propertyChange")]
        private function get oppositeDP():ArrayCollection
        {
            return (this._161799757oppositeDP);
        }

        private function _Diplomatic_DataGridColumn15_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn15 = _local_1;
            _local_1.dataField = "allianceName";
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn15", _Diplomatic_DataGridColumn15);
            return (_local_1);
        }

        public function set _friendsDP(_arg_1:ArrayCollection):void
        {
            friendsDP = _arg_1;
        }

        private function _Diplomatic_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("友好");
            _local_1 = Lang.msg("中立");
            _local_1 = Lang.msg("敌对");
            _local_1 = friendsDP;
            _local_1 = Lang.msg("联盟");
            _local_1 = Lang.msg("盟主");
            _local_1 = Lang.msg("人数");
            _local_1 = Lang.msg("排名");
            _local_1 = Lang.msg("声望");
            _local_1 = Lang.msg("荣誉");
            _local_1 = Lang.msg("取消");
            _local_1 = middleDP;
            _local_1 = Lang.msg("联盟");
            _local_1 = Lang.msg("盟主");
            _local_1 = Lang.msg("人数");
            _local_1 = Lang.msg("排名");
            _local_1 = Lang.msg("声望");
            _local_1 = Lang.msg("荣誉");
            _local_1 = Lang.msg("取消");
            _local_1 = oppositeDP;
            _local_1 = Lang.msg("联盟");
            _local_1 = Lang.msg("盟主");
            _local_1 = Lang.msg("人数");
            _local_1 = Lang.msg("排名");
            _local_1 = Lang.msg("声望");
            _local_1 = Lang.msg("荣誉");
            _local_1 = Lang.msg("取消");
            _local_1 = (Lang.msg("输入联盟") + ": ");
            _local_1 = Lang.msg("确定");
            _local_1 = Lang.msg("返回");
        }

        private function set friendsDP(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1165016863friendsDP;
            if (_local_2 !== _arg_1)
            {
                this._1165016863friendsDP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendsDP", _local_2, _arg_1));
            };
        }

        private function _Diplomatic_DataGridColumn11_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn11 = _local_1;
            _local_1.dataField = "rank";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn11", _Diplomatic_DataGridColumn11);
            return (_local_1);
        }

        private function onSetAllianceFriendship(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("联盟设置成功"));
                ActionFactory.getInstance().getAllianceManagementCommands().getAllianceFriendshipList();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function itemClickHandle(_arg_1:ItemClickEvent):void
        {
            switch (_arg_1.index)
            {
                case 0:
                    viewstack1.selectedChild = friendAlliance_view;
                    break;
                case 1:
                    viewstack1.selectedChild = middleAlliance_view;
                    break;
                case 2:
                    viewstack1.selectedChild = oppositeAlliance_view;
                    break;
            };
            ActionFactory.getInstance().getAllianceManagementCommands().getAllianceFriendshipList();
        }

        public function refresh():void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().getAllianceFriendshipList();
        }

        public function set middleAllianceDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._231480943middleAllianceDG;
            if (_local_2 !== _arg_1)
            {
                this._231480943middleAllianceDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "middleAllianceDG", _local_2, _arg_1));
            };
        }

        private function _Diplomatic_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn1 = _local_1;
            _local_1.dataField = "allianceName";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn1", _Diplomatic_DataGridColumn1);
            return (_local_1);
        }

        private function _Diplomatic_DataGridColumn19_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn19 = _local_1;
            _local_1.dataField = "aPrestigeCount";
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn19", _Diplomatic_DataGridColumn19);
            return (_local_1);
        }

        private function _Diplomatic_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn5 = _local_1;
            _local_1.dataField = "aPrestigeCount";
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn5", _Diplomatic_DataGridColumn5);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get friendsDP():ArrayCollection
        {
            return (this._1165016863friendsDP);
        }

        private function _Diplomatic_DataGridColumn9_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Diplomatic_DataGridColumn9 = _local_1;
            _local_1.dataField = "leaderName";
            BindingManager.executeBindings(this, "_Diplomatic_DataGridColumn9", _Diplomatic_DataGridColumn9);
            return (_local_1);
        }

        private function set middleDP(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1650011935middleDP;
            if (_local_2 !== _arg_1)
            {
                this._1650011935middleDP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "middleDP", _local_2, _arg_1));
            };
        }

        private function _Diplomatic_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Diplomatic_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___Diplomatic_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function ___Diplomatic_Button1_click(_arg_1:MouseEvent):void
        {
            submitRelation();
        }

        public function destroy():void
        {
        }

        private function _Diplomatic_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("友好"));
            }, function (_arg_1:*):void
            {
                _Diplomatic_Array1[0] = _arg_1;
            }, "_Diplomatic_Array1[0]");
            result[0] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("中立"));
            }, function (_arg_1:*):void
            {
                _Diplomatic_Array1[1] = _arg_1;
            }, "_Diplomatic_Array1[1]");
            result[1] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("敌对"));
            }, function (_arg_1:*):void
            {
                _Diplomatic_Array1[2] = _arg_1;
            }, "_Diplomatic_Array1[2]");
            result[2] = binding;
            binding = new Binding(this, function ():Object
            {
                return (friendsDP);
            }, function (_arg_1:Object):void
            {
                friendAllianceDG.dataProvider = _arg_1;
            }, "friendAllianceDG.dataProvider");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn1.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn1.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("盟主");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn2.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn2.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("人数");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn3.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn3.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("排名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn4.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn4.headerText");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("声望");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn5.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn5.headerText");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("荣誉");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn6.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn6.headerText");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("取消");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn7.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn7.headerText");
            result[10] = binding;
            binding = new Binding(this, function ():Object
            {
                return (middleDP);
            }, function (_arg_1:Object):void
            {
                middleAllianceDG.dataProvider = _arg_1;
            }, "middleAllianceDG.dataProvider");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn8.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn8.headerText");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("盟主");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn9.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn9.headerText");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("人数");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn10.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn10.headerText");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("排名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn11.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn11.headerText");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("声望");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn12.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn12.headerText");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("荣誉");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn13.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn13.headerText");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("取消");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn14.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn14.headerText");
            result[18] = binding;
            binding = new Binding(this, function ():Object
            {
                return (oppositeDP);
            }, function (_arg_1:Object):void
            {
                oppositeAllianceDG.dataProvider = _arg_1;
            }, "oppositeAllianceDG.dataProvider");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn15.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn15.headerText");
            result[20] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("盟主");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn16.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn16.headerText");
            result[21] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("人数");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn17.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn17.headerText");
            result[22] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("排名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn18.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn18.headerText");
            result[23] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("声望");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn19.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn19.headerText");
            result[24] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("荣誉");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn20.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn20.headerText");
            result[25] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("取消");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_DataGridColumn21.headerText = _arg_1;
            }, "_Diplomatic_DataGridColumn21.headerText");
            result[26] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("输入联盟") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_Text1.text = _arg_1;
            }, "_Diplomatic_Text1.text");
            result[27] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_Button1.label = _arg_1;
            }, "_Diplomatic_Button1.label");
            result[28] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("返回");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Diplomatic_Button2.label = _arg_1;
            }, "_Diplomatic_Button2.label");
            result[29] = binding;
            return (result);
        }


    }
}//package view.module.alliance.oldAlliance.allianceManage.allianceExchange

