// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Stats.Cities

package autoevony.gui.info.Stats
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.Label;
    import mx.controls.TextInput;
    import mx.controls.ComboBox;
    import mx.core.ClassFactory;
    import mx.controls.DataGrid;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import autoevony.common.Utils;
    import autoevony.gui.MainScreen;
    import mx.events.FlexEvent;
    import mx.binding.Binding;
    import autoevony.gui.info.FormatRank_inlineComponent0;
    import autoevony.gui.info.FormatPopulation_inlineComponent0;
    import mx.binding.BindingManager;
    import mx.controls.dataGridClasses.DataGridColumn;
    import com.evony.common.beans.RankCastleBean;
    import mx.utils.ObjectProxy;
    import com.evony.common.module.rank.RankCastleResponse;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.action.ActionFactory;
    import flash.utils.getDefinitionByName;
    import mx.events.ListEvent;
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

    public class Cities extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private const PAGESIZE:int = 10;
        private var _554043283_searchRankingBtn:Button;
        private var _1190618133_StatHeroesPageNo:Label;
        private var _1511170927_searchRanking:TextInput;
        private var key:String = "";
        private var _254798002sortTypeInput:ComboBox;
        private var _1223883875_AllianceInfo_ClassFactory0:ClassFactory;
        private var _995752784pageNo:int = 1;
        private var _480636075keyInput:TextInput;
        private var _791587407keyInputBtn:Button;
        private var _1223883878_AllianceInfo_ClassFactory3:ClassFactory;
        private var _577409037totalPage:int = 1;
        private var _1148866775jumpto:TextInput;
        private var _60930046_StatCities_DataGrid1:DataGrid;
        private var sortType:int = 1;

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
                                                "type":TextInput,
                                                "id":"_searchRanking",
                                                "events":{"enter":"___searchRanking_enter"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":60,
                                                        "maxChars":6,
                                                        "restrict":"0-9",
                                                        "toolTip":"Enter ranking value to search for."
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_searchRankingBtn",
                                                "events":{"click":"___searchRankingBtn_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Ranking",
                                                        "styleName":"REwinBtn"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":7});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"keyInput",
                                                "events":{"enter":"__keyInput_enter"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":80,
                                                        "maxChars":10,
                                                        "toolTip":"Enter player name to search for."
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"keyInputBtn",
                                                "events":{"click":"__keyInputBtn_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Name",
                                                        "styleName":"REwinBtn"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":7});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ComboBox,
                                                "id":"sortTypeInput",
                                                "events":{"change":"__sortTypeInput_change"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"ComboBox",
                                                        "height":22
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
                                                "events":{"click":"___Cities_Button3_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"previousBtn"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"jumpto",
                                                "events":{"enter":"__jumpto_enter"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "restrict":"0-9",
                                                        "maxChars":5,
                                                        "width":48,
                                                        "toolTip":"Enter page number to jump to that page."
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_StatHeroesPageNo",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"REmainFormText"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___Cities_Button4_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"nextBtn"});
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
                                    "id":"_StatCities_DataGrid1",
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
                                            "columns":[_Cities_DataGridColumn1_c(), _Cities_DataGridColumn2_c(), _Cities_DataGridColumn3_c(), _Cities_DataGridColumn4_c(), _Cities_DataGridColumn5_c(), _Cities_DataGridColumn6_c()]
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        private const sortKeysArray:ArrayCollection = new ArrayCollection(new Array("Population", "Level"));
        private var _496803498beansArray:ArrayCollection = new ArrayCollection();
        private var lastSortType:int = sortType;
        private var lastKey:String = key;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Cities()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", this.___Cities_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Cities._watcherSetupUtil = _arg_1;
        }


        private function _iy128():void
        {
            this.pageNo = ((Utils.hasValue(this.jumpto.text)) ? int(this.jumpto.text) : 0);
            this.key = Utils.trim(this.keyInput.text);
            if (this.pageNo >= this.totalPage)
            {
                this.pageNo = this.totalPage;
            };
            if (this.pageNo <= 1)
            {
                this.pageNo = 1;
            };
            this.updateData();
        }

        private function updateData(_arg_1:Object=null):void
        {
            if (MainScreen.getPlayer() == null)
            {
                return;
            };
            this.sortType = (this.sortTypeInput.selectedIndex + 1);
            if (((!(this.lastKey == this.key)) || (!(this.lastSortType == this.sortType))))
            {
                this.pageNo = 1;
            };
            if (_arg_1 != null)
            {
                this.pageNo = 1;
            };
            this.keyInput.setFocus();
            this.fetchPage(this.pageNo, this.sortType, this.key);
            this.lastKey = this.key;
            this.lastSortType = this.sortType;
        }

        private function init():void
        {
            addEventListener(FlexEvent.SHOW, this.updateData);
        }

        private function _Cities_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.sortKeysArray);
            }, function (_arg_1:Object):void
            {
                sortTypeInput.dataProvider = _arg_1;
            }, "sortTypeInput.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("/" + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _StatHeroesPageNo.text = _arg_1;
            }, "_StatHeroesPageNo.text");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.beansArray);
            }, function (_arg_1:Object):void
            {
                _StatCities_DataGrid1.dataProvider = _arg_1;
            }, "_StatCities_DataGrid1.dataProvider");
            result[2] = binding;
            binding = new Binding(this, function ():Class
            {
                return (FormatRank_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _AllianceInfo_ClassFactory0.generator = _arg_1;
            }, "_AllianceInfo_ClassFactory0.generator");
            result[3] = binding;
            binding = new Binding(this, function ():Class
            {
                return (FormatPopulation_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _AllianceInfo_ClassFactory3.generator = _arg_1;
            }, "_AllianceInfo_ClassFactory3.generator");
            result[4] = binding;
            return (result);
        }

        private function nextPage():void
        {
            if (this.pageNo >= this.totalPage)
            {
                return;
            };
            this.pageNo++;
            this.updateData();
        }

        public function __keyInput_enter(_arg_1:FlexEvent):void
        {
            this._iy128();
        }

        private function previousPage():void
        {
            if (this.pageNo <= 1)
            {
                return;
            };
            this.pageNo--;
            this.updateData();
        }

        public function __jumpto_enter(_arg_1:FlexEvent):void
        {
            this._iy128();
        }

        private function _Cities_ClassFactory2_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._AllianceInfo_ClassFactory3 = _local_1;
            BindingManager.executeBindings(this, "_AllianceInfo_ClassFactory3", this._AllianceInfo_ClassFactory3);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get jumpto():TextInput
        {
            return (this._1148866775jumpto);
        }

        private function _Cities_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Name";
            _local_1.dataField = "name";
            _local_1.width = 0.25;
            return (_local_1);
        }

        private function _ld288(_arg_1:RankCastleResponse):void
        {
            var _local_3:RankCastleBean;
            this.beansArray.removeAll();
            if (_arg_1.ok != 1)
            {
                return;
            };
            this.totalPage = _arg_1.totalPage;
            var _local_2:ObjectProxy;
            for each (_local_3 in _arg_1.beansArray)
            {
                _local_2 = new ObjectProxy(_local_3.toObject());
                _local_2.rawData = _local_3;
                this.beansArray.addItem(_local_2);
            };
        }

        private function _Cities_DataGridColumn6_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Population";
            _local_1.dataField = "population";
            _local_1.width = 0.15;
            _local_1.itemRenderer = this._Cities_ClassFactory2_i();
            return (_local_1);
        }

        private function _Cities_ClassFactory1_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._AllianceInfo_ClassFactory0 = _local_1;
            BindingManager.executeBindings(this, "_AllianceInfo_ClassFactory0", this._AllianceInfo_ClassFactory0);
            return (_local_1);
        }

        public function ___searchRankingBtn_click(_arg_1:MouseEvent):void
        {
            this._iy128();
        }

        public function set jumpto(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1148866775jumpto;
            if (_local_2 !== _arg_1)
            {
                this._1148866775jumpto = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "jumpto", _local_2, _arg_1));
            };
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

        public function set pageNo(_arg_1:int):void
        {
            var _local_2:Object = this._995752784pageNo;
            if (_local_2 !== _arg_1)
            {
                this._995752784pageNo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pageNo", _local_2, _arg_1));
            };
        }

        public function set keyInputBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._791587407keyInputBtn;
            if (_local_2 !== _arg_1)
            {
                this._791587407keyInputBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "keyInputBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_ClassFactory0():ClassFactory
        {
            return (this._1223883875_AllianceInfo_ClassFactory0);
        }

        public function set sortTypeInput(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._254798002sortTypeInput;
            if (_local_2 !== _arg_1)
            {
                this._254798002sortTypeInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sortTypeInput", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get beansArray():ArrayCollection
        {
            return (this._496803498beansArray);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_ClassFactory3():ClassFactory
        {
            return (this._1223883878_AllianceInfo_ClassFactory3);
        }

        public function fetchPage(_arg_1:int, _arg_2:int=1, _arg_3:String=""):void
        {
            ActionFactory.getInstance().getRankCommands().getCastleRank(_arg_3, _arg_1, this.PAGESIZE, _arg_2, this._ld288);
            this.jumpto.text = ("" + _arg_1);
            this.sortTypeInput.selectedIndex = (_arg_2 - 1);
            this.keyInput.text = _arg_3;
            this.keyInput.setSelection(0, _arg_3.length);
        }

        [Bindable(event="propertyChange")]
        public function get _searchRankingBtn():Button
        {
            return (this._554043283_searchRankingBtn);
        }

        [Bindable(event="propertyChange")]
        public function get _searchRanking():TextInput
        {
            return (this._1511170927_searchRanking);
        }

        private function _Cities_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Rank";
            _local_1.dataField = "rank";
            _local_1.width = 0.1;
            _local_1.itemRenderer = this._Cities_ClassFactory1_i();
            return (_local_1);
        }

        private function _Cities_DataGridColumn5_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Alliance";
            _local_1.dataField = "alliance";
            _local_1.width = 0.25;
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:Cities;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._Cities_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Stats_CitiesWatcherSetupUtil");
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

        public function __keyInputBtn_click(_arg_1:MouseEvent):void
        {
            this._iy128();
        }

        public function ___Cities_Button3_click(_arg_1:MouseEvent):void
        {
            this.previousPage();
        }

        [Bindable(event="propertyChange")]
        public function get keyInput():TextInput
        {
            return (this._480636075keyInput);
        }

        public function set beansArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._496803498beansArray;
            if (_local_2 !== _arg_1)
            {
                this._496803498beansArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "beansArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get pageNo():int
        {
            return (this._995752784pageNo);
        }

        [Bindable(event="propertyChange")]
        public function get keyInputBtn():Button
        {
            return (this._791587407keyInputBtn);
        }

        [Bindable(event="propertyChange")]
        public function get sortTypeInput():ComboBox
        {
            return (this._254798002sortTypeInput);
        }

        public function ___Cities_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        private function _Cities_DataGridColumn4_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Lord";
            _local_1.dataField = "kind";
            _local_1.width = 0.25;
            return (_local_1);
        }

        public function __sortTypeInput_change(_arg_1:ListEvent):void
        {
            this._iy128();
        }

        public function set _AllianceInfo_ClassFactory0(_arg_1:ClassFactory):void
        {
            var _local_2:Object = this._1223883875_AllianceInfo_ClassFactory0;
            if (_local_2 !== _arg_1)
            {
                this._1223883875_AllianceInfo_ClassFactory0 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_ClassFactory0", _local_2, _arg_1));
            };
        }

        public function toDebugString():String
        {
            return ("fields: beansArray pageNo totalPage, method: fetchPage(int,[int],[String])" + ", colums: rank name level kind alliance population rawData");
        }

        public function set _AllianceInfo_ClassFactory3(_arg_1:ClassFactory):void
        {
            var _local_2:Object = this._1223883878_AllianceInfo_ClassFactory3;
            if (_local_2 !== _arg_1)
            {
                this._1223883878_AllianceInfo_ClassFactory3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_ClassFactory3", _local_2, _arg_1));
            };
        }

        public function ___Cities_Button4_click(_arg_1:MouseEvent):void
        {
            this.nextPage();
        }

        public function set _StatHeroesPageNo(_arg_1:Label):void
        {
            var _local_2:Object = this._1190618133_StatHeroesPageNo;
            if (_local_2 !== _arg_1)
            {
                this._1190618133_StatHeroesPageNo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_StatHeroesPageNo", _local_2, _arg_1));
            };
        }

        public function set _searchRankingBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._554043283_searchRankingBtn;
            if (_local_2 !== _arg_1)
            {
                this._554043283_searchRankingBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_searchRankingBtn", _local_2, _arg_1));
            };
        }

        public function set _searchRanking(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1511170927_searchRanking;
            if (_local_2 !== _arg_1)
            {
                this._1511170927_searchRanking = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_searchRanking", _local_2, _arg_1));
            };
        }

        public function set totalPage(_arg_1:int):void
        {
            var _local_2:Object = this._577409037totalPage;
            if (_local_2 !== _arg_1)
            {
                this._577409037totalPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "totalPage", _local_2, _arg_1));
            };
        }

        public function ___searchRanking_enter(_arg_1:FlexEvent):void
        {
            this._iy128();
        }

        [Bindable(event="propertyChange")]
        public function get _StatHeroesPageNo():Label
        {
            return (this._1190618133_StatHeroesPageNo);
        }

        private function _Cities_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.sortKeysArray;
            _local_1 = ("/" + this.totalPage);
            _local_1 = this.beansArray;
            _local_1 = FormatRank_inlineComponent0;
            _local_1 = FormatPopulation_inlineComponent0;
        }

        [Bindable(event="propertyChange")]
        public function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        private function _Cities_DataGridColumn3_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Level";
            _local_1.dataField = "level";
            _local_1.width = 0.15;
            return (_local_1);
        }

        public function set _StatCities_DataGrid1(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._60930046_StatCities_DataGrid1;
            if (_local_2 !== _arg_1)
            {
                this._60930046_StatCities_DataGrid1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_StatCities_DataGrid1", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _StatCities_DataGrid1():DataGrid
        {
            return (this._60930046_StatCities_DataGrid1);
        }


    }
}//package autoevony.gui.info.Stats

