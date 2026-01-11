// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Items.ItemInfo

package autoevony.gui.info.Items
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextInput;
    import mx.controls.DataGrid;
    import mx.controls.ComboBox;
    import mx.core.ClassFactory;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.controls.Label;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import autoevony.event.popUpWinShowEvent;
    import mx.events.FlexEvent;
    import mx.controls.dataGridClasses.DataGridColumn;
    import com.evony.common.beans.ItemBean;
    import autoevony.gui.MainScreen;
    import autoevony.common.Utils;
    import com.evony.eum.ItemEum;
    import autoevony.common.Items;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.binding.BindingManager;
    import mx.events.ListEvent;
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

    public class ItemInfo extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _480636075keyInput:TextInput;
        private var _1174855070_ItemInfo_DataGrid1:DataGrid;
        private var _445142669_selectFilter:ComboBox;
        private var _244722591_Iteminfo_ClassFactory0:ClassFactory;
        private var _838846263update:Button;
        private var key:String = "";
        private var selectedType:String = null;

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
                                                    return ({"width":5});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"keyInput",
                                                "events":{"enter":"__keyInput_enter"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "maxChars":10,
                                                        "width":80
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"update",
                                                "events":{"click":"__update_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Update"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":50});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"View by Type: ",
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ComboBox,
                                                "id":"_selectFilter",
                                                "events":{"change":"___selectFilter_change"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":155,
                                                        "styleName":"ComboBox"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"_ItemInfo_DataGrid1",
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
                                            "columns":[_ItemInfo_DataGridColumn1_c(), _ItemInfo_DataGridColumn2_c(), _ItemInfo_DataGridColumn3_c(), _ItemInfo_DataGridColumn4_c(), _ItemInfo_DataGridColumn5_c()]
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        private var _1948713978filterOptions:ArrayCollection = new ArrayCollection([{
            "label":"All",
            "data":null
        }, {
            "label":"Items",
            "data":"Items"
        }, {
            "label":"Chests",
            "data":"Chest"
        }, {
            "label":"Resources",
            "data":"Resource"
        }, {
            "label":"Angel & Devil Items",
            "data":"Angel/Devil"
        }, {
            "label":"Stratagems",
            "data":"Stratagem"
        }, {
            "label":"Teleporters",
            "data":"Teleporters"
        }, {
            "label":"Troop Packs",
            "data":"Troops"
        }, {
            "label":"Produce",
            "data":"Produce"
        }, {
            "label":"Speed Ups",
            "data":"Speed Up"
        }, {
            "label":"Materials",
            "data":"Materials"
        }, {
            "label":"Medals",
            "data":"Medal"
        }, {
            "label":"HH Quests",
            "data":"Quests"
        }]);
        private var _1425640839itemsArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ItemInfo()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", this.___ItemInfo_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ItemInfo._watcherSetupUtil = _arg_1;
        }


        public function set itemsArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1425640839itemsArray;
            if (_local_2 !== _arg_1)
            {
                this._1425640839itemsArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemsArray", _local_2, _arg_1));
            };
        }

        public function _onViewItemBtn(_arg_1:Object):void
        {
            var _local_2:popUpWinShowEvent = new popUpWinShowEvent(popUpWinShowEvent.VIEW_ITEM_INFO_WIN);
            _local_2.args = [_arg_1];
            dispatchEvent(_local_2);
        }

        private function set filterOptions(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1948713978filterOptions;
            if (_local_2 !== _arg_1)
            {
                this._1948713978filterOptions = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "filterOptions", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get filterOptions():ArrayCollection
        {
            return (this._1948713978filterOptions);
        }

        private function init():void
        {
            addEventListener(FlexEvent.SHOW, this.updateData);
        }

        private function _ItemInfo_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Desc";
            _local_1.dataField = "desc";
            _local_1.width = 0.46;
            _local_1.showDataTips = true;
            return (_local_1);
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
            var _local_8:ItemBean;
            if (MainScreen.getPlayer() == null)
            {
                return;
            };
            this.key = Utils.trim(this.keyInput.text).toLowerCase();
            this.keyInput.text = this.key;
            this.keyInput.setSelection(0, this.key.length);
            this.keyInput.setFocus();
            if (this.key == "")
            {
                this.itemsArray.sort = null;
                this.itemsArray.refresh();
            }
            else
            {
                this._selectFilter.selectedIndex = 0;
                this.selectedType = null;
            };
            this.itemsArray.removeAll();
            var _local_2:Object = new Object();
            var _local_3:Object;
            var _local_4:ItemEum;
            var _local_5:String;
            var _local_6:String;
            var _local_7:Boolean = ((!(this.selectedType == null)) && (((((((this.selectedType == "Angel/Devil") || (this.selectedType == "Materials")) || (this.selectedType == "Medal")) || (this.selectedType == "Troops")) || (this.selectedType == "Produce")) || (this.selectedType == "Resource")) || (this.selectedType == "Teleporters")));
            for each (_local_8 in MainScreen.getPlayer().itemsArray)
            {
                if (_local_8.id != null)
                {
                    if ((_local_4 = Items.getItemEumById(_local_8.id)) != null)
                    {
                        _local_3 = _local_4.toObject();
                    }
                    else
                    {
                        _local_3 = new ItemEum().toObject();
                        _local_3.name = _local_8.id;
                        _local_3.id = _local_8.id;
                        _local_3.desc = "miscellaneous or undefined item";
                        _local_3.itemDesc = "miscellaneous or undefined item";
                    };
                    _local_3.count = _local_8.count;
                    _local_3.maxCount = _local_8.maxCount;
                    _local_3.minCount = _local_8.minCount;
                    _local_3.label = (_local_3.itemDesc as String);
                    _local_5 = (_local_3.name as String).toLowerCase();
                    if (this.selectedType == null)
                    {
                        if (_local_5.indexOf(this.key) == -1) continue;
                    }
                    else
                    {
                        if ((_local_6 = ((_local_7) ? Items.getCommonType(_local_3.itemType, _local_3.id) : Items.getCommonType(_local_3.itemType))) == null) continue;
                        if (this.key != "")
                        {
                            if (((!(_local_5.indexOf(this.key) == -1)) || (!(_local_6 == this.selectedType)))) continue;
                        }
                        else
                        {
                            if (_local_6 != this.selectedType) continue;
                        };
                    };
                    _local_2[_local_5] = 1;
                    this.itemsArray.addItem(_local_3);
                };
            };
            if ((((this.selectedType == null) && (this.itemsArray.length > 0)) && (MainScreen.getPlayer().playerInfo.medal > 0)))
            {
                _local_3 = new ItemEum().toObject();
                _local_3.name = "Cents";
                _local_3.id = "evony.game.coins";
                _local_3.desc = "Game coins used to purchase goods and items from the shop.";
                _local_3.count = MainScreen.getPlayer().playerInfo.medal;
                _local_3.maxCount = 0;
                _local_3.minCount = 0;
                _local_3.label = (_local_3.itemDesc as String);
                _local_3.iconUrl = "images/items/medals.png";
                this.itemsArray.addItem(_local_3);
            };
            if ((((this.key == "") && (this.selectedType == null)) || (Items.externalItemNames == null)))
            {
                return;
            };
            for each (_local_4 in Items.externalItemNames)
            {
                _local_5 = _local_4.name.toLowerCase();
                if (_local_2[_local_5] == undefined)
                {
                    if (this.selectedType == null)
                    {
                        if (_local_5.indexOf(this.key) == -1) continue;
                    }
                    else
                    {
                        if ((_local_6 = ((_local_7) ? Items.getCommonType(_local_4.itemType, _local_4.id) : Items.getCommonType(_local_4.itemType))) == null) continue;
                        if (this.key != "")
                        {
                            if (((!(_local_5.indexOf(this.key) == -1)) || (!(_local_6 == this.selectedType)))) continue;
                        }
                        else
                        {
                            if (_local_6 != this.selectedType) continue;
                        };
                    };
                    _local_2[_local_5] = 1;
                    _local_3 = _local_4.toObject();
                    _local_3.name = _local_4.name;
                    _local_3.count = 0;
                    _local_3.maxCount = 0;
                    _local_3.minCount = 0;
                    _local_3.label = (_local_3.itemDesc as String);
                    this.itemsArray.addItem(_local_3);
                };
            };
        }

        override public function initialize():void
        {
            var target:ItemInfo;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._ItemInfo_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Items_ItemInfoWatcherSetupUtil");
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

        private function _ItemInfo_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.filterOptions;
            _local_1 = this.itemsArray;
            _local_1 = ItemViewBtn_inlineComponent0;
        }

        private function _ItemInfo_DataGridColumn4_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Count";
            _local_1.dataField = "count";
            _local_1.width = 0.09;
            return (_local_1);
        }

        public function __keyInput_enter(_arg_1:FlexEvent):void
        {
            this.updateData();
        }

        private function _ItemInfo_ClassFactory1_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._Iteminfo_ClassFactory0 = _local_1;
            BindingManager.executeBindings(this, "_Iteminfo_ClassFactory0", this._Iteminfo_ClassFactory0);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get keyInput():TextInput
        {
            return (this._480636075keyInput);
        }

        [Bindable(event="propertyChange")]
        public function get _Iteminfo_ClassFactory0():ClassFactory
        {
            return (this._244722591_Iteminfo_ClassFactory0);
        }

        public function set _ItemInfo_DataGrid1(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1174855070_ItemInfo_DataGrid1;
            if (_local_2 !== _arg_1)
            {
                this._1174855070_ItemInfo_DataGrid1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_ItemInfo_DataGrid1", _local_2, _arg_1));
            };
        }

        public function set _Iteminfo_ClassFactory0(_arg_1:ClassFactory):void
        {
            var _local_2:Object = this._244722591_Iteminfo_ClassFactory0;
            if (_local_2 !== _arg_1)
            {
                this._244722591_Iteminfo_ClassFactory0 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_Iteminfo_ClassFactory0", _local_2, _arg_1));
            };
        }

        public function toDebugString():String
        {
            return ("field: itemsArray, method: fetchPage([String]), columns: id name desc itemDesc count price");
        }

        private function _ItemInfo_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Name";
            _local_1.dataField = "name";
            _local_1.width = 0.3;
            return (_local_1);
        }

        private function _ItemInfo_DataGridColumn3_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Price";
            _local_1.dataField = "price";
            _local_1.width = 0.07;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get update():Button
        {
            return (this._838846263update);
        }

        private function _ItemInfo_DataGridColumn5_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Action";
            _local_1.dataField = "name";
            _local_1.width = 0.08;
            _local_1.itemRenderer = this._ItemInfo_ClassFactory1_i();
            return (_local_1);
        }

        public function ___ItemInfo_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        [Bindable(event="propertyChange")]
        public function get _ItemInfo_DataGrid1():DataGrid
        {
            return (this._1174855070_ItemInfo_DataGrid1);
        }

        public function ___selectFilter_change(_arg_1:ListEvent):void
        {
            this.keyInput.text = "";
            this.selectedType = this._selectFilter.selectedItem.data;
            this.updateData(null);
        }

        public function set keyInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._480636075keyInput;
            if (_local_2 !== _arg_1)
            {
                this._480636075keyInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "keyInput", _local_2, _arg_1));
            };
        }

        public function set _selectFilter(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._445142669_selectFilter;
            if (_local_2 !== _arg_1)
            {
                this._445142669_selectFilter = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_selectFilter", _local_2, _arg_1));
            };
        }

        public function fetchPage(_arg_1:String=""):void
        {
            this.keyInput.text = _arg_1;
            this._selectFilter.selectedIndex = 0;
            this.selectedType = null;
            this.updateData();
        }

        private function _ItemInfo_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.filterOptions);
            }, function (_arg_1:Object):void
            {
                _selectFilter.dataProvider = _arg_1;
            }, "_selectFilter.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.itemsArray);
            }, function (_arg_1:Object):void
            {
                _ItemInfo_DataGrid1.dataProvider = _arg_1;
            }, "_ItemInfo_DataGrid1.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():Class
            {
                return (ItemViewBtn_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _Iteminfo_ClassFactory0.generator = _arg_1;
            }, "_Iteminfo_ClassFactory0.generator");
            result[2] = binding;
            return (result);
        }

        public function __update_click(_arg_1:MouseEvent):void
        {
            this.updateData();
        }

        [Bindable(event="propertyChange")]
        public function get _selectFilter():ComboBox
        {
            return (this._445142669_selectFilter);
        }

        [Bindable(event="propertyChange")]
        public function get itemsArray():ArrayCollection
        {
            return (this._1425640839itemsArray);
        }


    }
}//package autoevony.gui.info.Items

