// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.HistoricalHeroes

package autoevony.gui.info
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextArea;
    import mx.controls.DataGrid;
    import mx.controls.TextInput;
    import com.evony.common.beans.SimpleNpcHeroBean;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import com.evony.client.action.ActionFactory;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.events.ListEvent;
    import com.evony.common.module.quest.QuestListResponse;
    import autoevony.common.Utils;
    import com.evony.common.module.rank.RankPlayerResponse;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import autoevony.gui.MainScreen;
    import com.evony.common.module.rank.RankHeroResponse;
    import mx.events.FlexEvent;
    import com.evony.common.module.npchero.NpcHeroListResponse;
    import autoevony.scripts.CityState;
    import com.evony.common.constants.BuildingConstants;
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

    public class HistoricalHeroes extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _619242552heroInfo:TextArea;
        private var playerStatsPageNumber:int = 1;
        private var _1439439020_HistoricalHeroes_DataGrid2:DataGrid;
        private var _480636075keyInput:TextInput;
        private var pendingItem:SimpleNpcHeroBean = null;
        private var selectedItem:SimpleNpcHeroBean = null;
        private var key:String = "";
        private var _838846263update:Button;
        private var _1439439021_HistoricalHeroes_DataGrid1:DataGrid;

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
                                                "id":"keyInput",
                                                "events":{"enter":"__keyInput_enter"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "maxChars":30,
                                                        "width":100
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
                                                        "label":"Search"
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
                                                "events":{"click":"___HistoricalHeroes_Button2_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Hearsay"
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
                                                "events":{"click":"___HistoricalHeroes_Button3_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Buy Details"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___HistoricalHeroes_Button4_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Accept Task"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "bottom";
                                        this.verticalGap = 0;
                                        this.horizontalGap = 2;
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
                                                        "width":200,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":DataGrid,
                                                            "id":"_HistoricalHeroes_DataGrid1",
                                                            "events":{"change":"___HistoricalHeroes_DataGrid1_change"},
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
                                                                    "selectable":true,
                                                                    "showHeaders":true,
                                                                    "sortableColumns":true,
                                                                    "variableRowHeight":true,
                                                                    "visible":true,
                                                                    "wordWrap":false,
                                                                    "columns":[_HistoricalHeroes_DataGridColumn1_c()]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":DataGrid,
                                                            "id":"_HistoricalHeroes_DataGrid2",
                                                            "events":{"change":"___HistoricalHeroes_DataGrid2_change"},
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
                                                                    "selectable":true,
                                                                    "showHeaders":true,
                                                                    "sortableColumns":true,
                                                                    "variableRowHeight":true,
                                                                    "visible":true,
                                                                    "wordWrap":false,
                                                                    "columns":[_HistoricalHeroes_DataGridColumn2_c()]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":TextArea,
                                                            "id":"heroInfo",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontFamily = "DejaVu Sans";
                                                                this.fontSize = 12;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "editable":false,
                                                                    "styleName":"txtAreaStyle"
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
        private var _566991471searchArray:ArrayCollection = new ArrayCollection();
        private var _61177572hearsayArray:ArrayCollection = new ArrayCollection();
        private var heroCached:Object = new Object();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function HistoricalHeroes()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", this.___HistoricalHeroes_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            HistoricalHeroes._watcherSetupUtil = _arg_1;
        }


        public function ownerInfo(_arg_1:SimpleNpcHeroBean):String
        {
            if (this.heroCached[("hero" + _arg_1.npcid)] != undefined)
            {
                return (this.heroCached[("hero" + _arg_1.npcid)]);
            };
            this.pendingItem = _arg_1;
            ActionFactory.getInstance().getRankCommands().getHeroRank(_arg_1.name, 1, 10, 1, this.fncGetHeroStatsInfo);
            return (null);
        }

        private function _HistoricalHeroes_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Search";
            _local_1.dataField = "name";
            return (_local_1);
        }

        public function ___HistoricalHeroes_DataGrid1_change(_arg_1:ListEvent):void
        {
            this._ia1257(_arg_1);
        }

        private function _en1274(_arg_1:QuestListResponse):void
        {
            if (_arg_1.ok != 1)
            {
                this._jm820(((("Capture historical hero quest failed: " + _arg_1.msg) + "\n\n") + this.heroInfo.text), this.selectedItem);
            }
            else
            {
                this._jm820((("Capture historical hero quest created" + "\n\n") + this.heroInfo.text), this.selectedItem);
            };
        }

        private function _HistoricalHeroes_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.hearsayArray;
            _local_1 = this.searchArray;
        }

        private function _en178():void
        {
            var _local_1:Number = (Utils.getServerTime() - (3600 * 1000));
            var _local_2:String;
            for (_local_2 in this.heroCached)
            {
                if (_local_2.indexOf("hero") != 0)
                {
                    if ((this.heroCached[_local_2] < _local_1))
                    {
                        delete this.heroCached[_local_2];
                        delete this.heroCached[("hero" + _local_2)];
                    };
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get _HistoricalHeroes_DataGrid2():DataGrid
        {
            return (this._1439439020_HistoricalHeroes_DataGrid2);
        }

        [Bindable(event="propertyChange")]
        public function get searchArray():ArrayCollection
        {
            return (this._566991471searchArray);
        }

        private function fncGetOwnerStatsInfo(_arg_1:RankPlayerResponse):void
        {
            if (_arg_1.ok != 1)
            {
                this.playerStatsPageNumber = 1;
                return;
            };
            if (this.pendingItem == null)
            {
                this.playerStatsPageNumber = 1;
                return;
            };
            var _local_2:* = null;
            var _local_3:* = "\n";
            var _local_4:String = this.heroCached[("hero" + this.pendingItem.npcid)];
            var _local_5:String = _local_4.substring((_local_4.indexOf("Owner: ") + 7), _local_4.indexOf(",  Level: "));
            var _local_6:Array = ["Civilian", "Knight", "Baronet", "Baron", "Viscount", "Earl", "Marquis", "Duke", "Furstin", "Prinzessin"];
            if (Version.isTraceOn())
            {
                trace(_local_5);
            };
            for each (_local_2 in _arg_1.beansArray)
            {
                if (Version.isTraceOn())
                {
                    trace(_local_2.toString());
                };
                if (_local_2.userName == _local_5)
                {
                    _local_3 = (((((((((((((((((((((_local_3 + "\nAlliance: ") + _local_2.alliance) + ",  Rank: ") + _local_2.ranking) + ",  Prestige: ") + _local_2.prestige) + ",  Honor: ") + _local_2.honor) + ",  \nStarSet: ") + _local_2.starlv) + ",  Cities: ") + _local_2.castleCount) + ",  Population: ") + _local_2.population) + ",  Title: ") + _local_6[_local_2.titleId]) + ",  \nOffice: ") + _local_2.office) + ",  Flag: ") + _local_2.flag) + "\n");
                    break;
                };
            };
            if (_local_3 == "")
            {
                this.playerStatsPageNumber = (this.playerStatsPageNumber + 1);
                ActionFactory.getInstance().getRankCommands().getPlayerRank(_local_5, this.playerStatsPageNumber, 10, 2, this.fncGetOwnerStatsInfo);
                return;
            };
            this.playerStatsPageNumber = 1;
            this._en178();
            this.heroCached[this.pendingItem.npcid] = Utils.getServerTime();
            this.heroCached[("hero" + this.pendingItem.npcid)] = (_local_4 + _local_3);
            if (this.pendingItem == this.selectedItem)
            {
                this.displayHero(this.selectedItem);
            };
        }

        override public function initialize():void
        {
            var target:HistoricalHeroes;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._HistoricalHeroes_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_HistoricalHeroesWatcherSetupUtil");
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

        public function set update(_arg_1:Button):void
        {
            var _local_2:Object = this._838846263update;
            if (_local_2 !== _arg_1)
            {
                this._838846263update = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "update", _local_2, _arg_1));
            };
        }

        public function ___HistoricalHeroes_Button2_click(_arg_1:MouseEvent):void
        {
            this.hearsay();
        }

        public function ___HistoricalHeroes_Button4_click(_arg_1:MouseEvent):void
        {
            this.acceptTask();
        }

        private function _dy970():void
        {
            if (MainScreen.getPlayer() == null)
            {
                return;
            };
            this.key = Utils.trim(this.keyInput.text);
            this.keyInput.text = this.key;
            this.keyInput.setSelection(0, this.key.length);
            this.keyInput.setFocus();
            var _local_1:* = this.getCastleIdWithValidInn();
            if (_local_1 == -1)
            {
                this._jm820("You need an inn level 5 or higher!");
                return;
            };
            ActionFactory.getInstance().getNpcHeroCommand().getNpcHerosListByFilter(this.key, _local_1, this._qn461);
        }

        private function fncGetHeroStatsInfo(_arg_1:RankHeroResponse):void
        {
            var _local_4:*;
            if (_arg_1.ok != 1)
            {
                return;
            };
            if (this.pendingItem == null)
            {
                return;
            };
            var _local_2:String;
            var _local_3:* = "";
            for each (_local_4 in _arg_1.beansArray)
            {
                if (_local_4.name == this.pendingItem.name)
                {
                    _local_2 = ((((((((("Owner: " + _local_4.kind) + ",  Level: ") + _local_4.grade) + ",  Stats(Pol/Att/Int):") + _local_4.management) + "/") + _local_4.power) + "/") + _local_4.stratagem);
                    if (_local_4.grade > 100)
                    {
                        _local_3 = _local_2;
                        break;
                    };
                    if (_local_3 != "")
                    {
                        _local_3 = (_local_3 + "\n");
                    };
                    _local_3 = (_local_3 + _local_2);
                };
            };
            if (_local_3 == "")
            {
                _local_3 = "none";
            };
            this._en178();
            this.heroCached[this.pendingItem.npcid] = Utils.getServerTime();
            this.heroCached[("hero" + this.pendingItem.npcid)] = _local_3;
            if (this.pendingItem == this.selectedItem)
            {
                this.displayHero(this.selectedItem);
            };
            this.playerStatsPageNumber = 1;
            ActionFactory.getInstance().getRankCommands().getPlayerRank(_local_4.kind, this.playerStatsPageNumber, 10, 2, this.fncGetOwnerStatsInfo);
        }

        public function set searchArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._566991471searchArray;
            if (_local_2 !== _arg_1)
            {
                this._566991471searchArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "searchArray", _local_2, _arg_1));
            };
        }

        public function __keyInput_enter(_arg_1:FlexEvent):void
        {
            this._dy970();
        }

        public function set _HistoricalHeroes_DataGrid1(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1439439021_HistoricalHeroes_DataGrid1;
            if (_local_2 !== _arg_1)
            {
                this._1439439021_HistoricalHeroes_DataGrid1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_HistoricalHeroes_DataGrid1", _local_2, _arg_1));
            };
        }

        public function search(_arg_1:String=""):void
        {
            this.keyInput.text = _arg_1;
            this._dy970();
        }

        [Bindable(event="propertyChange")]
        public function get keyInput():TextInput
        {
            return (this._480636075keyInput);
        }

        public function set _HistoricalHeroes_DataGrid2(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1439439020_HistoricalHeroes_DataGrid2;
            if (_local_2 !== _arg_1)
            {
                this._1439439020_HistoricalHeroes_DataGrid2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_HistoricalHeroes_DataGrid2", _local_2, _arg_1));
            };
        }

        public function freeHearsay(_arg_1:Object=null):void
        {
            removeEventListener(FlexEvent.SHOW, this.freeHearsay);
            var _local_2:int = this.getCastleIdWithValidInn();
            if (_local_2 == -1)
            {
                this._jm820("You need an inn level 5 or higher!");
                return;
            };
            ActionFactory.getInstance().getNpcHeroCommand().getNpcHerosList(_local_2, this._nr1016);
        }

        private function init():void
        {
            addEventListener(FlexEvent.SHOW, this.freeHearsay);
        }

        public function acceptTask():void
        {
            var _local_1:int = this.getCastleIdWithValidInn();
            if (_local_1 == -1)
            {
                this._jm820("You need an inn level 5 or higher!");
                return;
            };
            if (this.selectedItem == null)
            {
                return;
            };
            ActionFactory.getInstance().getQuestCommands().accept(this.selectedItem.npcid, _local_1, this._en1274);
        }

        private function _ia1257(_arg_1:ListEvent):void
        {
            this.displayHero(_arg_1.currentTarget.dataProvider[_arg_1.rowIndex]);
        }

        public function hearsay():void
        {
            var _local_1:int = this.getCastleIdWithValidInn();
            if (_local_1 == -1)
            {
                this._jm820("You need an inn level 5 or higher!");
                return;
            };
            ActionFactory.getInstance().getNpcHeroCommand().getNpcHerosListByMoney(_local_1, this._nr1016);
        }

        private function _wk155(_arg_1:NpcHeroListResponse):void
        {
            var _local_4:SimpleNpcHeroBean;
            var _local_5:SimpleNpcHeroBean;
            if (_arg_1.ok != 1)
            {
                this._jm820(("Error: " + _arg_1.msg));
                return;
            };
            var _local_2:Boolean;
            var _local_3:Boolean = true;
            for each (_local_4 in _arg_1.simpleNpcHerosArray)
            {
                _local_2 = false;
                for each (_local_5 in this.searchArray)
                {
                    if (_local_2) break;
                    if (_local_5.npcid == _local_4.npcid)
                    {
                        _local_2 = true;
                        _local_5.introduce = _local_4.introduce;
                        _local_5.introduce2 = _local_4.introduce2;
                    };
                };
                for each (_local_5 in this.hearsayArray)
                {
                    if (_local_2) break;
                    if (_local_5.npcid == _local_4.npcid)
                    {
                        _local_2 = true;
                        _local_5.introduce = _local_4.introduce;
                        _local_5.introduce2 = _local_4.introduce2;
                    };
                };
                if (!_local_2)
                {
                    this.searchArray.addItem(_local_4);
                };
                if (_local_3)
                {
                    this.displayHero(_local_4);
                };
                _local_3 = false;
            };
        }

        public function set hearsayArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._61177572hearsayArray;
            if (_local_2 !== _arg_1)
            {
                this._61177572hearsayArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hearsayArray", _local_2, _arg_1));
            };
        }

        private function _HistoricalHeroes_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Hearsay";
            _local_1.dataField = "name";
            return (_local_1);
        }

        private function _qn461(_arg_1:NpcHeroListResponse):void
        {
            var _local_2:*;
            if (_arg_1.ok != 1)
            {
                this._jm820(("Error: " + _arg_1.msg));
                return;
            };
            this.searchArray.removeAll();
            for each (_local_2 in _arg_1.simpleNpcHerosArray)
            {
                this.searchArray.addItem(_local_2);
            };
        }

        [Bindable(event="propertyChange")]
        public function get heroInfo():TextArea
        {
            return (this._619242552heroInfo);
        }

        public function toDebugString():String
        {
            return ("field: searchArray, hearsayArray, method: search([String]), hearsay(), freeHearsay(), displayHero(SimpleNpcHeroBean), buyDetails([int]), acceptTask(), ownerInfo(SimpleNpcHeroBean)");
        }

        public function ___HistoricalHeroes_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        [Bindable(event="propertyChange")]
        public function get update():Button
        {
            return (this._838846263update);
        }

        private function _jm820(_arg_1:String, _arg_2:SimpleNpcHeroBean=null):void
        {
            this.heroInfo.text = _arg_1;
            this.selectedItem = _arg_2;
        }

        public function set heroInfo(_arg_1:TextArea):void
        {
            var _local_2:Object = this._619242552heroInfo;
            if (_local_2 !== _arg_1)
            {
                this._619242552heroInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroInfo", _local_2, _arg_1));
            };
        }

        public function ___HistoricalHeroes_DataGrid2_change(_arg_1:ListEvent):void
        {
            this._ia1257(_arg_1);
        }

        public function buyDetails(_arg_1:int=-1):void
        {
            var _local_2:int = this.getCastleIdWithValidInn();
            if (_local_2 == -1)
            {
                this._jm820("You need an inn level 5 or higher!");
                return;
            };
            if (((_arg_1 == -1) && (!(this.selectedItem == null))))
            {
                _arg_1 = this.selectedItem.npcid;
            };
            if (_arg_1 == -1)
            {
                return;
            };
            ActionFactory.getInstance().getNpcHeroCommand().getNpcHeroInfroByID(_arg_1, _local_2, this._wk155);
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

        private function _HistoricalHeroes_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (hearsayArray);
            }, function (_arg_1:Object):void
            {
                _HistoricalHeroes_DataGrid1.dataProvider = _arg_1;
            }, "_HistoricalHeroes_DataGrid1.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (searchArray);
            }, function (_arg_1:Object):void
            {
                _HistoricalHeroes_DataGrid2.dataProvider = _arg_1;
            }, "_HistoricalHeroes_DataGrid2.dataProvider");
            result[1] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get _HistoricalHeroes_DataGrid1():DataGrid
        {
            return (this._1439439021_HistoricalHeroes_DataGrid1);
        }

        private function _nr1016(_arg_1:NpcHeroListResponse):void
        {
            var _local_2:*;
            if (_arg_1.ok != 1)
            {
                this._jm820(("Error: " + _arg_1.msg));
                return;
            };
            this.hearsayArray.removeAll();
            for each (_local_2 in _arg_1.simpleNpcHerosArray)
            {
                this.hearsayArray.addItem(_local_2);
            };
        }

        public function displayHero(_arg_1:SimpleNpcHeroBean):void
        {
            var _local_2:String = ((("\n" + _arg_1.name) + ", id: ") + _arg_1.npcid);
            if (this.heroCached[("hero" + _arg_1.npcid)] == undefined)
            {
                this.pendingItem = _arg_1;
                ActionFactory.getInstance().getRankCommands().getHeroRank(_arg_1.name, 1, 10, 1, this.fncGetHeroStatsInfo);
            }
            else
            {
                _local_2 = (_local_2 + ("\n\n[OWNERSHIP]  (from Statistics)\n" + this.heroCached[("hero" + _arg_1.npcid)]));
            };
            _local_2 = (_local_2 + ((("\n\n[INN KEEPER]\n" + _arg_1.introduce2) + "\n\n[HISTORY]\n") + _arg_1.introduce));
            this._jm820(_local_2, _arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get hearsayArray():ArrayCollection
        {
            return (this._61177572hearsayArray);
        }

        public function __update_click(_arg_1:MouseEvent):void
        {
            this._dy970();
        }

        public function ___HistoricalHeroes_Button3_click(_arg_1:MouseEvent):void
        {
            this.buyDetails();
        }

        private function getCastleIdWithValidInn():int
        {
            var _local_4:CityState;
            var _local_1:int;
            var _local_2:int = -1;
            var _local_3:int;
            for each (_local_4 in MainScreen.getCities())
            {
                _local_1 = _local_4.cityManager.getBuildingLevel(BuildingConstants.TYPE_TAVERN);
                if (_local_1 >= 5)
                {
                    if (_local_1 == 10)
                    {
                        return (_local_4.castle.id);
                    };
                    if ((_local_3 < _local_1))
                    {
                        _local_3 = _local_1;
                        _local_2 = _local_4.castle.id;
                    };
                };
            };
            return (_local_2);
        }


    }
}//package autoevony.gui.info

