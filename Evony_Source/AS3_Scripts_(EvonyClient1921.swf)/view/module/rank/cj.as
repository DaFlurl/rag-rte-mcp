// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.rank.cj

package view.module.rank
{
    import view.ui.BaseWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.ViewStack;
    import mx.controls.DataGrid;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.EffortListBean;
    import mx.containers.VBox;
    import mx.containers.Canvas;
    import mx.controls.Label;
    import view.ui.WinTitle;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.MainWin;
    import mx.events.FlexEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.Lang;
    import mx.binding.Binding;
    import com.evony.common.module.quest.QuestListResponse;
    import mx.events.ListEvent;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.events.DataGridEvent;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import flash.events.Event;
    import view.ui.AccomplishBuffItem;
    import flash.utils.ByteArray;
    import mx.core.ClassFactory;
    import flash.utils.getDefinitionByName;
    import com.evony.common.module.quest.EffortListResponse;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import com.evony.common.beans.*;
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

    public class cj extends BaseWindow implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "cj.open";
        public static var instance:cj = new (cj)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var scrollIndex:int = 0;
        private var _892024219strArg:String = "";
        private var pageSize:int = 100;
        private var _1398734388rightStack:ViewStack;
        private var _655126789questDg:DataGrid;
        private var isBuffLink:Boolean = false;
        private var _425636739questTypeArray:ArrayCollection;
        private var isFirstLogin:Boolean = true;
        private var _873325055effortTypeId:int;
        private var _1359545350cjitem:DataGrid;
        private var curSelectQuestTypeIndex:int = 0;
        private var _1783104352questList:ArrayCollection;
        public var callTimes:int = 1;
        private var isScroll:Boolean = false;
        private var _995752784pageNo:int = 1;
        private var bean:EffortListBean;
        private var showItem:Object;
        private var _1436105645rightDg2:VBox;
        private var sendMax:int;
        private var _1436105646rightDg1:Canvas;
        private var _577409037totalPage:int = 0;
        private var allEffortType:ArrayCollection;
        private var _74932463right_label:Label;
        private var _776676342curSelectRankIndex:int = 0;
        private var winTitle:WinTitle;
        private var detailsBuffName:String;
        private var _1841160004left_label:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseWindow,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":819,
                    "height":505,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":MyWindow,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "79";
                            this.bottom = "44";
                            this.right = "25";
                            this.left = "295";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"tabwk",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "1";
                                        this.top = "1";
                                        this.bottom = "1";
                                        this.right = "1";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"textBackground"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"rightStack",
                        "stylesFactory":function ():void
                        {
                            this.top = "80";
                            this.bottom = "47";
                            this.right = "26";
                            this.left = "296";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"rightDg1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"questDg",
                                                "events":{
                                                    "updateComplete":"__questDg_updateComplete",
                                                    "itemClick":"__questDg_itemClick"
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "styleName":"style2",
                                                        "showHeaders":false,
                                                        "resizableColumns":false,
                                                        "draggableColumns":false,
                                                        "sortableColumns":false,
                                                        "variableRowHeight":true,
                                                        "columns":[_cj_DataGridColumn1_c()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"rightDg2",
                                    "events":{"creationComplete":"__rightDg2_creationComplete"},
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalGap = 10;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"left_label",
                        "stylesFactory":function ():void
                        {
                            this.top = "42";
                            this.left = "34";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":235,
                                "styleName":"contentheader1"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"right_label",
                        "stylesFactory":function ():void
                        {
                            this.top = "42";
                            this.right = "24";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":235,
                                "styleName":"PropertyName1"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "79";
                            this.bottom = "44";
                            this.left = "23";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"tabwk",
                                "width":268,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"cjitem",
                                    "events":{"itemClick":"__cjitem_itemClick"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "rowHeight":27,
                                            "styleName":"style2",
                                            "horizontalScrollPolicy":"off",
                                            "showHeaders":false,
                                            "resizableColumns":false,
                                            "draggableColumns":false,
                                            "sortableColumns":false,
                                            "x":0,
                                            "columns":[_cj_DataGridColumn2_c()]
                                        });
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        private var idArr:Array = new Array();
        private var itemArr:Array = new Array();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function cj()
        {
            mx_internal::_document = this;
            this.width = 819;
            this.height = 505;
            this.addEventListener("creationComplete", ___cj_BaseWindow1_creationComplete);
            this.addEventListener("removedFromStage", ___cj_BaseWindow1_removedFromStage);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            cj._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object=null):void
        {
            UIUtil.setPopopHelpWindowStye(instance);
            if (!instance.isPopUp)
            {
                MinePopupManager.instance.addPopup(instance, MainWin.instance, true);
            };
            MinePopupManager.instance.centerPopUp();
            MinePopupManager.instance.bringToFront();
            instance.refresh();
        }


        public function ___cj_BaseWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        override public function destroy():void
        {
        }

        public function set effortTypeId(_arg_1:int):void
        {
            var _local_2:Object = this._873325055effortTypeId;
            if (_local_2 !== _arg_1)
            {
                this._873325055effortTypeId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "effortTypeId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get effortTypeId():int
        {
            return (this._873325055effortTypeId);
        }

        private function loadDg():void
        {
            if (this.isFirstLogin)
            {
                this.isFirstLogin = false;
                setItemCurValue();
            };
        }

        [Bindable(event="propertyChange")]
        public function get questDg():DataGrid
        {
            return (this._655126789questDg);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.QUEST_GET_EFFORT_LIST, onRank);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.QUEST_GET_EFFORT_LIST_BY_TARGE_TYPEID, onList);
            winTitle = new WinTitle();
            winTitle.title = Lang.msg("成就");
            winTitle.addEventListener("onClose", onClose);
            this.addChild(winTitle);
            this.refresh();
            rightStack.selectedChild = this.rightDg2;
            createBuff();
        }

        private function set questTypeArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._425636739questTypeArray;
            if (_local_2 !== _arg_1)
            {
                this._425636739questTypeArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questTypeArray", _local_2, _arg_1));
            };
        }

        public function set curSelectRankIndex(_arg_1:int):void
        {
            var _local_2:Object = this._776676342curSelectRankIndex;
            if (_local_2 !== _arg_1)
            {
                this._776676342curSelectRankIndex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curSelectRankIndex", _local_2, _arg_1));
            };
        }

        private function _cj_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.questList);
            }, function (_arg_1:Object):void
            {
                questDg.dataProvider = _arg_1;
            }, "questDg.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.questTypeArray);
            }, function (_arg_1:Object):void
            {
                cjitem.dataProvider = _arg_1;
            }, "cjitem.dataProvider");
            result[1] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get right_label():Label
        {
            return (this._74932463right_label);
        }

        public function set questDg(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._655126789questDg;
            if (_local_2 !== _arg_1)
            {
                this._655126789questDg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questDg", _local_2, _arg_1));
            };
        }

        private function onList(_arg_1:QuestListResponse):void
        {
            var _local_2:Boolean;
            var _local_3:ArrayCollection;
            var _local_4:int;
            var _local_5:int;
            var _local_6:String;
            if (!isBuffLink)
            {
                this.questList = _arg_1.questsArray;
                cjitem.selectedIndex = curSelectQuestTypeIndex;
            }
            else
            {
                _local_2 = false;
                _local_3 = _arg_1.questsArray;
                _local_4 = _local_3.length;
                _local_5 = 0;
                while (_local_5 < _local_4)
                {
                    _local_6 = _local_3.getItemAt(_local_5).description;
                    if (_local_6.search(this.detailsBuffName) != -1)
                    {
                        _local_2 = true;
                        isScroll = true;
                        this.questList = _local_3;
                        isBuffLink = false;
                        scrollIndex = _local_5;
                        break;
                    };
                    _local_5++;
                };
                if (!_local_2)
                {
                    callTimes++;
                    sendMessage();
                };
            };
        }

        public function set right_label(_arg_1:Label):void
        {
            var _local_2:Object = this._74932463right_label;
            if (_local_2 !== _arg_1)
            {
                this._74932463right_label = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "right_label", _local_2, _arg_1));
            };
        }

        public function __cjitem_itemClick(_arg_1:ListEvent):void
        {
            onChange(_arg_1);
        }

        private function _cj_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.questList;
            _local_1 = this.questTypeArray;
        }

        private function _cj_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.itemRenderer = _cj_ClassFactory2_c();
            return (_local_1);
        }

        private function scrollIndexFun():void
        {
            if (isScroll)
            {
                questDg.scrollToIndex(scrollIndex);
                scrollIndex = 0;
                isScroll = false;
            };
        }

        private function selectEffortItem(_arg_1:ListEvent):void
        {
        }

        private function set questList(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1783104352questList;
            if (_local_2 !== _arg_1)
            {
                this._1783104352questList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questList", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get curSelectRankIndex():int
        {
            return (this._776676342curSelectRankIndex);
        }

        private function onFocusIn(_arg_1:DataGridEvent):void
        {
        }

        [Bindable(event="propertyChange")]
        public function get rightDg1():Canvas
        {
            return (this._1436105646rightDg1);
        }

        [Bindable(event="propertyChange")]
        public function get rightDg2():VBox
        {
            return (this._1436105645rightDg2);
        }

        private function sendMessage():void
        {
            var _local_1:Object;
            if (callTimes < sendMax)
            {
                _local_1 = allEffortType.getItemAt(callTimes);
                this.effortTypeId = _local_1.effortTypeid;
                ActionFactory.getInstance().getQuestCommands().getEffortListByTargeTypeid(Context.getInstance().getCurCastle().id, _local_1.effortTypeid);
            };
        }

        [Bindable(event="propertyChange")]
        public function get strArg():String
        {
            return (this._892024219strArg);
        }

        public function onClose(_arg_1:Event):void
        {
            MinePopupManager.instance.removePopup();
        }

        private function onChange(_arg_1:ListEvent):void
        {
            if (_arg_1.rowIndex != 0)
            {
                rightStack.selectedChild = this.rightDg1;
                this.bean = (_arg_1.itemRenderer.data as EffortListBean);
                this.effortTypeId = bean.effortTypeid;
                ActionFactory.getInstance().getQuestCommands().getEffortListByTargeTypeid(Context.getInstance().getCurCastle().id, this.bean.effortTypeid);
                this.curSelectQuestTypeIndex = _arg_1.rowIndex;
            }
            else
            {
                rightStack.selectedChild = this.rightDg2;
                createBuff();
            };
        }

        private function _cj_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.itemRenderer = _cj_ClassFactory1_c();
            return (_local_1);
        }

        public function set left_label(_arg_1:Label):void
        {
            var _local_2:Object = this._1841160004left_label;
            if (_local_2 !== _arg_1)
            {
                this._1841160004left_label = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "left_label", _local_2, _arg_1));
            };
        }

        public function __questDg_updateComplete(_arg_1:FlexEvent):void
        {
            scrollIndexFun();
        }

        [Bindable(event="propertyChange")]
        private function get questTypeArray():ArrayCollection
        {
            return (this._425636739questTypeArray);
        }

        private function createBuff():void
        {
            var _local_6:AccomplishBuffItem;
            rightDg2.removeAllChildren();
            var _local_1:Class = cj_xmlClass;
            var _local_2:ByteArray = (new (_local_1)() as ByteArray);
            var _local_3:XML = XML(_local_2);
            var _local_4:int = _local_3.children().length();
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                _local_6 = new AccomplishBuffItem();
                idArr.push(_local_3.child(_local_5).@id);
                _local_6.maxLev = _local_3.child(_local_5).@maxLev;
                _local_6.dec = _local_3.child(_local_5).@desc;
                _local_6.per = _local_3.child(_local_5).@per;
                _local_6.tooltips = _local_3.child(_local_5).@tooltip;
                _local_6.path = _local_3.child(_local_5).@img;
                _local_6.buffType = _local_3.child(_local_5).@id;
                _local_6.buffname = _local_3.child(_local_5).@name;
                _local_6.point = _local_3.child(_local_5).@point;
                itemArr.push(_local_6);
                rightDg2.addChildAt(_local_6, _local_5);
                _local_6.setParent(this);
                _local_5++;
            };
            if (!this.isFirstLogin)
            {
                setItemCurValue();
            };
        }

        private function _cj_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = cj_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function set pageNo(_arg_1:int):void
        {
            var _local_2:Object = this._995752784pageNo;
            if (_local_2 !== _arg_1)
            {
                this._995752784pageNo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pageNo", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:cj;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _cj_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_rank_cjWatcherSetupUtil");
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

        public function __questDg_itemClick(_arg_1:ListEvent):void
        {
            selectEffortItem(_arg_1);
        }

        public function set rightStack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._1398734388rightStack;
            if (_local_2 !== _arg_1)
            {
                this._1398734388rightStack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rightStack", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get questList():ArrayCollection
        {
            return (this._1783104352questList);
        }

        public function set rightDg1(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1436105646rightDg1;
            if (_local_2 !== _arg_1)
            {
                this._1436105646rightDg1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rightDg1", _local_2, _arg_1));
            };
        }

        public function set rightDg2(_arg_1:VBox):void
        {
            var _local_2:Object = this._1436105645rightDg2;
            if (_local_2 !== _arg_1)
            {
                this._1436105645rightDg2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rightDg2", _local_2, _arg_1));
            };
        }

        private function onRank(_arg_1:EffortListResponse):void
        {
            var _local_2:Object = new Object();
            _local_2.effortListInfo = "Summary";
            this.questTypeArray = _arg_1.effortlistbeanArray;
            this.allEffortType = _arg_1.effortlistbeanArray;
            this.questTypeArray.addItemAt(_local_2, 0);
            left_label.text = _arg_1.effortcomplete.toString();
            right_label.text = _arg_1.effortpoint.toString();
        }

        public function ___cj_BaseWindow1_removedFromStage(_arg_1:Event):void
        {
            destroy();
        }

        public function __rightDg2_creationComplete(_arg_1:FlexEvent):void
        {
            loadDg();
        }

        [Bindable(event="propertyChange")]
        private function get pageNo():int
        {
            return (this._995752784pageNo);
        }

        private function _cj_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = cj_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get left_label():Label
        {
            return (this._1841160004left_label);
        }

        public function set strArg(_arg_1:String):void
        {
            var _local_2:Object = this._892024219strArg;
            if (_local_2 !== _arg_1)
            {
                this._892024219strArg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strArg", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get rightStack():ViewStack
        {
            return (this._1398734388rightStack);
        }

        private function setItemCurValue():void
        {
            var _local_3:Boolean;
            var _local_5:int;
            var _local_1:int = idArr.length;
            var _local_2:int = Context.getInstance().getPlayerBean().buffsArray.length;
            var _local_4:int;
            while (_local_4 < _local_1)
            {
                _local_3 = false;
                _local_5 = 0;
                while (_local_5 < _local_2)
                {
                    if (idArr[_local_4] == Context.getInstance().getPlayerBean().buffsArray.getItemAt(_local_5).typeId)
                    {
                        _local_3 = true;
                        itemArr[_local_4].curLev = Context.getInstance().getPlayerBean().buffsArray[_local_5].descName;
                    };
                    _local_5++;
                };
                if (!_local_3)
                {
                    itemArr[_local_4].curLev = "0";
                };
                _local_4++;
            };
        }

        override public function refresh():void
        {
            ActionFactory.getInstance().getQuestCommands().getEffortList(Context.getInstance().getCurCastle().id);
        }

        private function set totalPage(_arg_1:int):void
        {
            var _local_2:Object = this._577409037totalPage;
            if (_local_2 !== _arg_1)
            {
                this._577409037totalPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "totalPage", _local_2, _arg_1));
            };
        }

        public function BuffLinkToCj(_arg_1:String):void
        {
            this.questList = null;
            rightStack.selectedChild = this.rightDg1;
            isBuffLink = true;
            detailsBuffName = _arg_1;
            sendMax = allEffortType.length;
            sendMessage();
        }

        [Bindable(event="propertyChange")]
        private function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        public function set cjitem(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1359545350cjitem;
            if (_local_2 !== _arg_1)
            {
                this._1359545350cjitem = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cjitem", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get cjitem():DataGrid
        {
            return (this._1359545350cjitem);
        }


    }
}//package view.module.rank

