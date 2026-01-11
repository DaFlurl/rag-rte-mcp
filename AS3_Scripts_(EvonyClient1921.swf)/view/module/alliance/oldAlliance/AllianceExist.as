// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.AllianceExist

package view.module.alliance.oldAlliance
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.Label;
    import mx.controls.DataGrid;
    import mx.containers.ViewStack;
    import com.evony.common.beans.IndexAllianceInfoBean;
    import mx.controls.TextArea;
    import mx.controls.ToggleButtonBar;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.binding.BindingManager;
    import com.evony.client.response.ResponseDispatcher;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import mx.core.ClassFactory;
    import mx.events.ItemClickEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.module.CommandResponse;
    import com.evony.MsgDispacther;
    import com.evony.events.WindowChangeEvent;
    import view.module.alliance.AllianceWin;
    import com.evony.common.module.alliance.HasAllianceResponse;
    import mx.events.FlexEvent;
    import com.evony.client.action.ActionFactory;
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

    public class AllianceExist extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1927885713middleList_view:Canvas;
        public var _AllianceExist_DataGridColumn8:DataGridColumn;
        public var _AllianceExist_DataGridColumn1:DataGridColumn;
        public var _AllianceExist_Label1:Label;
        public var _AllianceExist_Label2:Label;
        public var _AllianceExist_DataGrid1:DataGrid;
        public var _AllianceExist_DataGrid2:DataGrid;
        public var _AllianceExist_DataGrid3:DataGrid;
        public var _AllianceExist_DataGrid4:DataGrid;
        private var _730456920friendList_view:Canvas;
        public var _AllianceExist_Array1:Array;
        private var _1401471234enemyList_view:Canvas;
        private var _946505330viewstack1:ViewStack;
        private var _1672186937indexAllianceInfoBean:IndexAllianceInfoBean;
        private var _1467419989allianceInfoTxt:TextArea;
        private var _108156002togButton:ToggleButtonBar;
        private var _1283608345allianceNoteTxt:TextArea;
        public var _AllianceExist_DataGridColumn10:DataGridColumn;
        public var _AllianceExist_DataGridColumn11:DataGridColumn;
        public var _AllianceExist_DataGridColumn13:DataGridColumn;
        public var _AllianceExist_DataGridColumn14:DataGridColumn;
        public var _AllianceExist_DataGridColumn2:DataGridColumn;
        public var _AllianceExist_DataGridColumn3:DataGridColumn;
        public var _AllianceExist_DataGridColumn4:DataGridColumn;
        public var _AllianceExist_DataGridColumn5:DataGridColumn;
        public var _AllianceExist_DataGridColumn7:DataGridColumn;
        public var _AllianceExist_DataGridColumn9:DataGridColumn;
        public var _AllianceExist_DataGridColumn6:DataGridColumn;
        public var _AllianceExist_DataGridColumn12:DataGridColumn;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":408,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":ToggleButtonBar,
                        "id":"togButton",
                        "events":{"itemClick":"__togButton_itemClick"},
                        "stylesFactory":function ():void
                        {
                            this.top = "102";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "width":320,
                                "height":29,
                                "dataProvider":_AllianceExist_Array1_i()
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"viewstack1",
                        "stylesFactory":function ():void
                        {
                            this.top = "134";
                            this.bottom = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":320,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"friendList_view",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"_AllianceExist_DataGrid1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"style2",
                                                        "rowHeight":25,
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "resizableColumns":false,
                                                        "draggableColumns":false,
                                                        "sortableColumns":false,
                                                        "selectable":false,
                                                        "columns":[_AllianceExist_DataGridColumn1_i(), _AllianceExist_DataGridColumn2_i(), _AllianceExist_DataGridColumn3_i()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"middleList_view",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"_AllianceExist_DataGrid2",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"style2",
                                                        "rowHeight":25,
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "resizableColumns":false,
                                                        "draggableColumns":false,
                                                        "sortableColumns":false,
                                                        "selectable":false,
                                                        "columns":[_AllianceExist_DataGridColumn4_i(), _AllianceExist_DataGridColumn5_i(), _AllianceExist_DataGridColumn6_i()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"enemyList_view",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"_AllianceExist_DataGrid3",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"style2",
                                                        "rowHeight":25,
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "y":0,
                                                        "resizableColumns":false,
                                                        "draggableColumns":false,
                                                        "sortableColumns":false,
                                                        "selectable":false,
                                                        "columns":[_AllianceExist_DataGridColumn7_i(), _AllianceExist_DataGridColumn8_i(), _AllianceExist_DataGridColumn9_i()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 0;
                            this.top = "102";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":121,
                                "width":423,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "x":324,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AllianceExist_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":21
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"allianceInfoTxt",
                                    "stylesFactory":function ():void
                                    {
                                        this.backgroundAlpha = 0;
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":98,
                                            "editable":false
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.top = "232";
                            this.bottom = "10";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":324,
                                "width":423,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AllianceExist_Label2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":21
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"allianceNoteTxt",
                                    "stylesFactory":function ():void
                                    {
                                        this.backgroundAlpha = 0;
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":81,
                                            "editable":false
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"_AllianceExist_DataGrid4",
                        "stylesFactory":function ():void
                        {
                            this.top = "32";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "width":748,
                                "height":53,
                                "rowHeight":25,
                                "styleName":"style2",
                                "variableRowHeight":true,
                                "allowMultipleSelection":true,
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_AllianceExist_DataGridColumn10_i(), _AllianceExist_DataGridColumn11_i(), _AllianceExist_DataGridColumn12_i(), _AllianceExist_DataGridColumn13_i(), _AllianceExist_DataGridColumn14_i()]
                            });
                        }
                    })]
                });
            }
        });
        private var _2145012720friendlyListArray:ArrayCollection = new ArrayCollection();
        private var _1900069446middleListArray:ArrayCollection = new ArrayCollection();
        private var _1429287501enemyListArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllianceExist()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.backgroundAlpha = 0;
            };
            this.percentWidth = 100;
            this.height = 408;
            this.styleName = "myfont";
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___AllianceExist_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllianceExist._watcherSetupUtil = _arg_1;
        }


        private function _AllianceExist_DataGridColumn10_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceExist_DataGridColumn10 = _local_1;
            _local_1.dataField = "allianceName";
            _local_1.itemRenderer = _AllianceExist_ClassFactory1_c();
            BindingManager.executeBindings(this, "_AllianceExist_DataGridColumn10", _AllianceExist_DataGridColumn10);
            return (_local_1);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_IS_HAS_ALLIANCE, onHasAlliance, false, 0, true);
            if (this.initialized)
            {
                this.refresh();
            };
        }

        private function _AllianceExist_DataGridColumn14_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceExist_DataGridColumn14 = _local_1;
            _local_1.dataField = "prestige";
            BindingManager.executeBindings(this, "_AllianceExist_DataGridColumn14", _AllianceExist_DataGridColumn14);
            return (_local_1);
        }

        public function set enemyList_view(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1401471234enemyList_view;
            if (_local_2 !== _arg_1)
            {
                this._1401471234enemyList_view = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "enemyList_view", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get enemyList_view():Canvas
        {
            return (this._1401471234enemyList_view);
        }

        private function _AllianceExist_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceExist_DataGridColumn3 = _local_1;
            _local_1.dataField = "memberCount";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_AllianceExist_DataGridColumn3", _AllianceExist_DataGridColumn3);
            return (_local_1);
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

        private function _AllianceExist_DataGridColumn7_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceExist_DataGridColumn7 = _local_1;
            _local_1.dataField = "allianceName";
            BindingManager.executeBindings(this, "_AllianceExist_DataGridColumn7", _AllianceExist_DataGridColumn7);
            return (_local_1);
        }

        public function set middleList_view(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1927885713middleList_view;
            if (_local_2 !== _arg_1)
            {
                this._1927885713middleList_view = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "middleList_view", _local_2, _arg_1));
            };
        }

        private function set friendlyListArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2145012720friendlyListArray;
            if (_local_2 !== _arg_1)
            {
                this._2145012720friendlyListArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendlyListArray", _local_2, _arg_1));
            };
        }

        private function _AllianceExist_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("友好联盟");
            _local_1 = Lang.msg("中立联盟");
            _local_1 = Lang.msg("敌对联盟");
            _local_1 = friendlyListArray;
            _local_1 = Lang.msg("联盟名称");
            _local_1 = Lang.msg("排名");
            _local_1 = Lang.msg("成员");
            _local_1 = middleListArray;
            _local_1 = Lang.msg("联盟名称");
            _local_1 = Lang.msg("排名");
            _local_1 = Lang.msg("成员");
            _local_1 = enemyListArray;
            _local_1 = Lang.msg("联盟名称");
            _local_1 = Lang.msg("排名");
            _local_1 = Lang.msg("成员");
            _local_1 = Lang.msg("联盟介绍");
            _local_1 = indexAllianceInfoBean.allianceInfo;
            _local_1 = Lang.msg("联盟公告");
            _local_1 = indexAllianceInfoBean.allianceNote;
            _local_1 = indexAllianceInfoBean;
            _local_1 = Lang.msg("联盟名称");
            _local_1 = Lang.msg("创始人");
            _local_1 = Lang.msg("人数");
            _local_1 = Lang.msg("排名");
            _local_1 = Lang.msg("声望");
        }

        public function set togButton(_arg_1:ToggleButtonBar):void
        {
            var _local_2:Object = this._108156002togButton;
            if (_local_2 !== _arg_1)
            {
                this._108156002togButton = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "togButton", _local_2, _arg_1));
            };
        }

        private function _AllianceExist_DataGridColumn13_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceExist_DataGridColumn13 = _local_1;
            _local_1.dataField = "rank";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_AllianceExist_DataGridColumn13", _AllianceExist_DataGridColumn13);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get middleListArray():ArrayCollection
        {
            return (this._1900069446middleListArray);
        }

        public function set allianceInfoTxt(_arg_1:TextArea):void
        {
            var _local_2:Object = this._1467419989allianceInfoTxt;
            if (_local_2 !== _arg_1)
            {
                this._1467419989allianceInfoTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceInfoTxt", _local_2, _arg_1));
            };
        }

        public function set friendList_view(_arg_1:Canvas):void
        {
            var _local_2:Object = this._730456920friendList_view;
            if (_local_2 !== _arg_1)
            {
                this._730456920friendList_view = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendList_view", _local_2, _arg_1));
            };
        }

        private function _AllianceExist_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceExist_DataGridColumn2 = _local_1;
            _local_1.dataField = "rank";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_AllianceExist_DataGridColumn2", _AllianceExist_DataGridColumn2);
            return (_local_1);
        }

        private function _AllianceExist_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceExist_DataGridColumn6 = _local_1;
            _local_1.dataField = "memberCount";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_AllianceExist_DataGridColumn6", _AllianceExist_DataGridColumn6);
            return (_local_1);
        }

        private function _AllianceExist_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = AllianceExist_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function set enemyListArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1429287501enemyListArray;
            if (_local_2 !== _arg_1)
            {
                this._1429287501enemyListArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "enemyListArray", _local_2, _arg_1));
            };
        }

        private function TogBarClickHandler(_arg_1:ItemClickEvent):void
        {
            switch (_arg_1.index)
            {
                case 0:
                    viewstack1.selectedChild = friendList_view;
                    return;
                case 1:
                    viewstack1.selectedChild = middleList_view;
                    return;
                case 2:
                    viewstack1.selectedChild = enemyList_view;
                    return;
            };
        }

        [Bindable(event="propertyChange")]
        public function get viewstack1():ViewStack
        {
            return (this._946505330viewstack1);
        }

        private function _AllianceExist_DataGridColumn12_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceExist_DataGridColumn12 = _local_1;
            _local_1.dataField = "memberCount";
            _local_1.width = 80;
            _local_1.itemRenderer = _AllianceExist_ClassFactory2_c();
            BindingManager.executeBindings(this, "_AllianceExist_DataGridColumn12", _AllianceExist_DataGridColumn12);
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:AllianceExist;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AllianceExist_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_oldAlliance_AllianceExistWatcherSetupUtil");
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
        public function get middleList_view():Canvas
        {
            return (this._1927885713middleList_view);
        }

        public function onHasAlliance(_arg_1:HasAllianceResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                friendlyListArray = _arg_1.friendlyListArray;
                middleListArray = _arg_1.middleListArray;
                enemyListArray = _arg_1.enemyListArray;
                indexAllianceInfoBean = _arg_1.indexAllianceInfoBean;
            }
            else
            {
                if (_arg_1.ok < 0)
                {
                    MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.CALL_OTHER_VIEW, {"id":"allianceBegin"}));
                };
            };
        }

        private function set middleListArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1900069446middleListArray;
            if (_local_2 !== _arg_1)
            {
                this._1900069446middleListArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "middleListArray", _local_2, _arg_1));
            };
        }

        private function set indexAllianceInfoBean(_arg_1:IndexAllianceInfoBean):void
        {
            var _local_2:Object = this._1672186937indexAllianceInfoBean;
            if (_local_2 !== _arg_1)
            {
                this._1672186937indexAllianceInfoBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "indexAllianceInfoBean", _local_2, _arg_1));
            };
        }

        private function _AllianceExist_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceExist_DataGridColumn5 = _local_1;
            _local_1.dataField = "rank";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_AllianceExist_DataGridColumn5", _AllianceExist_DataGridColumn5);
            return (_local_1);
        }

        private function _AllianceExist_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceExist_DataGridColumn1 = _local_1;
            _local_1.dataField = "allianceName";
            BindingManager.executeBindings(this, "_AllianceExist_DataGridColumn1", _AllianceExist_DataGridColumn1);
            return (_local_1);
        }

        private function _AllianceExist_DataGridColumn9_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceExist_DataGridColumn9 = _local_1;
            _local_1.dataField = "memberCount";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_AllianceExist_DataGridColumn9", _AllianceExist_DataGridColumn9);
            return (_local_1);
        }

        private function _AllianceExist_Array1_i():Array
        {
            var _local_1:Array = [null, null, null];
            _AllianceExist_Array1 = _local_1;
            BindingManager.executeBindings(this, "_AllianceExist_Array1", _AllianceExist_Array1);
            return (_local_1);
        }

        private function _AllianceExist_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = AllianceExist_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get friendList_view():Canvas
        {
            return (this._730456920friendList_view);
        }

        [Bindable(event="propertyChange")]
        public function get allianceInfoTxt():TextArea
        {
            return (this._1467419989allianceInfoTxt);
        }

        [Bindable(event="propertyChange")]
        public function get togButton():ToggleButtonBar
        {
            return (this._108156002togButton);
        }

        private function _AllianceExist_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("友好联盟"));
            }, function (_arg_1:*):void
            {
                _AllianceExist_Array1[0] = _arg_1;
            }, "_AllianceExist_Array1[0]");
            result[0] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("中立联盟"));
            }, function (_arg_1:*):void
            {
                _AllianceExist_Array1[1] = _arg_1;
            }, "_AllianceExist_Array1[1]");
            result[1] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("敌对联盟"));
            }, function (_arg_1:*):void
            {
                _AllianceExist_Array1[2] = _arg_1;
            }, "_AllianceExist_Array1[2]");
            result[2] = binding;
            binding = new Binding(this, function ():Object
            {
                return (friendlyListArray);
            }, function (_arg_1:Object):void
            {
                _AllianceExist_DataGrid1.dataProvider = _arg_1;
            }, "_AllianceExist_DataGrid1.dataProvider");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceExist_DataGridColumn1.headerText = _arg_1;
            }, "_AllianceExist_DataGridColumn1.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("排名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceExist_DataGridColumn2.headerText = _arg_1;
            }, "_AllianceExist_DataGridColumn2.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("成员");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceExist_DataGridColumn3.headerText = _arg_1;
            }, "_AllianceExist_DataGridColumn3.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():Object
            {
                return (middleListArray);
            }, function (_arg_1:Object):void
            {
                _AllianceExist_DataGrid2.dataProvider = _arg_1;
            }, "_AllianceExist_DataGrid2.dataProvider");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceExist_DataGridColumn4.headerText = _arg_1;
            }, "_AllianceExist_DataGridColumn4.headerText");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("排名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceExist_DataGridColumn5.headerText = _arg_1;
            }, "_AllianceExist_DataGridColumn5.headerText");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("成员");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceExist_DataGridColumn6.headerText = _arg_1;
            }, "_AllianceExist_DataGridColumn6.headerText");
            result[10] = binding;
            binding = new Binding(this, function ():Object
            {
                return (enemyListArray);
            }, function (_arg_1:Object):void
            {
                _AllianceExist_DataGrid3.dataProvider = _arg_1;
            }, "_AllianceExist_DataGrid3.dataProvider");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceExist_DataGridColumn7.headerText = _arg_1;
            }, "_AllianceExist_DataGridColumn7.headerText");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("排名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceExist_DataGridColumn8.headerText = _arg_1;
            }, "_AllianceExist_DataGridColumn8.headerText");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("成员");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceExist_DataGridColumn9.headerText = _arg_1;
            }, "_AllianceExist_DataGridColumn9.headerText");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟介绍");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceExist_Label1.text = _arg_1;
            }, "_AllianceExist_Label1.text");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = indexAllianceInfoBean.allianceInfo;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                allianceInfoTxt.text = _arg_1;
            }, "allianceInfoTxt.text");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟公告");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceExist_Label2.text = _arg_1;
            }, "_AllianceExist_Label2.text");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = indexAllianceInfoBean.allianceNote;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                allianceNoteTxt.text = _arg_1;
            }, "allianceNoteTxt.text");
            result[18] = binding;
            binding = new Binding(this, function ():Object
            {
                return (indexAllianceInfoBean);
            }, function (_arg_1:Object):void
            {
                _AllianceExist_DataGrid4.dataProvider = _arg_1;
            }, "_AllianceExist_DataGrid4.dataProvider");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceExist_DataGridColumn10.headerText = _arg_1;
            }, "_AllianceExist_DataGridColumn10.headerText");
            result[20] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("创始人");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceExist_DataGridColumn11.headerText = _arg_1;
            }, "_AllianceExist_DataGridColumn11.headerText");
            result[21] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("人数");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceExist_DataGridColumn12.headerText = _arg_1;
            }, "_AllianceExist_DataGridColumn12.headerText");
            result[22] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("排名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceExist_DataGridColumn13.headerText = _arg_1;
            }, "_AllianceExist_DataGridColumn13.headerText");
            result[23] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("声望");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceExist_DataGridColumn14.headerText = _arg_1;
            }, "_AllianceExist_DataGridColumn14.headerText");
            result[24] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get enemyListArray():ArrayCollection
        {
            return (this._1429287501enemyListArray);
        }

        public function ___AllianceExist_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        private function get indexAllianceInfoBean():IndexAllianceInfoBean
        {
            return (this._1672186937indexAllianceInfoBean);
        }

        private function _AllianceExist_DataGridColumn11_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceExist_DataGridColumn11 = _local_1;
            _local_1.dataField = "creatorName";
            BindingManager.executeBindings(this, "_AllianceExist_DataGridColumn11", _AllianceExist_DataGridColumn11);
            return (_local_1);
        }

        private function _AllianceExist_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceExist_DataGridColumn4 = _local_1;
            _local_1.dataField = "allianceName";
            BindingManager.executeBindings(this, "_AllianceExist_DataGridColumn4", _AllianceExist_DataGridColumn4);
            return (_local_1);
        }

        public function refresh():void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().isHasAlliance();
        }

        public function set allianceNoteTxt(_arg_1:TextArea):void
        {
            var _local_2:Object = this._1283608345allianceNoteTxt;
            if (_local_2 !== _arg_1)
            {
                this._1283608345allianceNoteTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceNoteTxt", _local_2, _arg_1));
            };
        }

        private function _AllianceExist_DataGridColumn8_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceExist_DataGridColumn8 = _local_1;
            _local_1.dataField = "rank";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_AllianceExist_DataGridColumn8", _AllianceExist_DataGridColumn8);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get friendlyListArray():ArrayCollection
        {
            return (this._2145012720friendlyListArray);
        }

        public function destroy():void
        {
        }

        public function __togButton_itemClick(_arg_1:ItemClickEvent):void
        {
            this.TogBarClickHandler(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get allianceNoteTxt():TextArea
        {
            return (this._1283608345allianceNoteTxt);
        }


    }
}//package view.module.alliance.oldAlliance

