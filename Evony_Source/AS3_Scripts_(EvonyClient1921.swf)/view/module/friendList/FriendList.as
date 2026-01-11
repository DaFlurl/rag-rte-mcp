// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.friendList.FriendList

package view.module.friendList
{
    import view.ui.BaseFunctionWindowEx;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.HBox;
    import mx.controls.Button;
    import mx.controls.ToggleButtonBar;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.containers.ViewStack;
    import mx.controls.DataGrid;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Canvas;
    import com.evony.Lang;
    import mx.collections.ArrayCollection;
    import com.evony.Context;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import mx.binding.BindingManager;
    import mx.events.ItemClickEvent;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.friend.FriendResponse;
    import mx.core.ClassFactory;
    import mx.events.ListEvent;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import view.module.rank.PlayerInfo;
    import com.evony.common.beans.PlayerInfoBean;
    import mx.events.FlexEvent;
    import com.evony.common.beans.PlayerBean;
    import mx.collections.Sort;
    import mx.collections.SortField;
    import com.evony.client.response.ResponseDispatcher;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import mx.collections.*;
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

    public class FriendList extends BaseFunctionWindowEx implements IBindingClient 
    {

        public static var instance:FriendList;
        public static const EVENT_SHOW:String = "FriendList.open";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _FriendList_HBox1:HBox;
        public var _FriendList_Button2:Button;
        private var _11548545buttonBar:ToggleButtonBar;
        public var _FriendList_DataGridColumn1:DataGridColumn;
        public var _FriendList_DataGridColumn2:DataGridColumn;
        public var _FriendList_DataGridColumn3:DataGridColumn;
        public var _FriendList_DataGridColumn4:DataGridColumn;
        public var _FriendList_DataGridColumn5:DataGridColumn;
        public var _FriendList_DataGridColumn6:DataGridColumn;
        private var _946505330viewstack1:ViewStack;
        private var _1607799334toLeftBtn:Button;
        private var _1165016872friendsDG:DataGrid;
        public var _FriendList_Label1:Label;
        private var _1456175557toRightBtn:Button;
        private var _1436069623selectedIndex:int;
        private var isFlag:Boolean = true;
        public var _FriendList_Array1:Array;
        private var _577409037totalPage:Number = 0;
        private var _1125923055curPage:int = 1;
        public var _FriendList_DataGrid2:DataGrid;
        public var _FriendList_Button1:Button;
        private var userName:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindowEx,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Button,
                        "id":"_FriendList_Button1",
                        "events":{"click":"___FriendList_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "41";
                            this.right = "186";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"y125"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_FriendList_Button2",
                        "events":{"click":"___FriendList_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "41";
                            this.right = "56";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"y125"});
                        }
                    }), new UIComponentDescriptor({
                        "type":ToggleButtonBar,
                        "id":"buttonBar",
                        "events":{"itemClick":"__buttonBar_itemClick"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":59.5,
                                "x":60,
                                "dataProvider":_FriendList_Array1_i()
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "id":"_FriendList_HBox1",
                        "stylesFactory":function ():void
                        {
                            this.top = "38";
                            this.right = "56";
                            this.verticalAlign = "middle";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"toLeftBtn",
                                    "events":{"click":"__toLeftBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"previous"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_FriendList_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"ftp14f"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"toRightBtn",
                                    "events":{"click":"__toRightBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"next"});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"viewstack1",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "85";
                            this.top = "96";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":700,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"friendVs",
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"friendsDG",
                                                "events":{"itemClick":"__friendsDG_itemClick"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.borderStyle = "solid";
                                                    this.borderThickness = 1;
                                                    this.top = "0";
                                                    this.verticalAlign = "middle";
                                                    this.left = "0";
                                                    this.textAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "styleName":"style2",
                                                        "rowHeight":35,
                                                        "rowCount":10,
                                                        "verticalScrollPolicy":"off",
                                                        "resizableColumns":false,
                                                        "draggableColumns":false,
                                                        "sortableColumns":false,
                                                        "percentWidth":100,
                                                        "columns":[_FriendList_DataGridColumn1_i(), _FriendList_DataGridColumn2_i(), _FriendList_DataGridColumn3_i()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"blackVs",
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"_FriendList_DataGrid2",
                                                "events":{"itemClick":"___FriendList_DataGrid2_itemClick"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.borderStyle = "solid";
                                                    this.borderThickness = 1;
                                                    this.left = "0";
                                                    this.top = "0";
                                                    this.verticalAlign = "middle";
                                                    this.textAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "styleName":"style2",
                                                        "rowHeight":35,
                                                        "rowCount":10,
                                                        "verticalScrollPolicy":"off",
                                                        "resizableColumns":false,
                                                        "draggableColumns":false,
                                                        "sortableColumns":false,
                                                        "columns":[_FriendList_DataGridColumn4_i(), _FriendList_DataGridColumn5_i(), _FriendList_DataGridColumn6_i()]
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
        });
        private var _1591135199viewLable:String = Lang.msg("查看");
        private var _2130926892blockPlayerInfoAry:ArrayCollection = Context.getInstance().getPlayerBean().blockBeansArray;
        private var _1481557317friendPlayerInfoAry:ArrayCollection = Context.getInstance().getPlayerBean().friendBeansArray;
        private var _1149398893eachPageFriendArr:ArrayCollection = new ArrayCollection();
        private var _1079747868eachPageBlockArr:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function FriendList()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___FriendList_BaseFunctionWindowEx1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            FriendList._watcherSetupUtil = _arg_1;
        }


        public function __toLeftBtn_click(_arg_1:MouseEvent):void
        {
            this.changePageNo(-1);
        }

        public function set buttonBar(_arg_1:ToggleButtonBar):void
        {
            var _local_2:Object = this._11548545buttonBar;
            if (_local_2 !== _arg_1)
            {
                this._11548545buttonBar = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buttonBar", _local_2, _arg_1));
            };
        }

        private function _FriendList_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _FriendList_DataGridColumn2 = _local_1;
            _local_1.dataField = "alliance";
            _local_1.itemRenderer = _FriendList_ClassFactory1_c();
            BindingManager.executeBindings(this, "_FriendList_DataGridColumn2", _FriendList_DataGridColumn2);
            return (_local_1);
        }

        private function _FriendList_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _FriendList_DataGridColumn6 = _local_1;
            _local_1.dataField = "userName";
            _local_1.width = 80;
            _local_1.itemRenderer = _FriendList_ClassFactory4_c();
            BindingManager.executeBindings(this, "_FriendList_DataGridColumn6", _FriendList_DataGridColumn6);
            return (_local_1);
        }

        public function __buttonBar_itemClick(_arg_1:ItemClickEvent):void
        {
            getPlayInfoList(_arg_1);
        }

        public function deleteHandler(_arg_1:String=null):void
        {
            if (_arg_1 != null)
            {
                this.userName = _arg_1;
            };
            if (this.userName == null)
            {
                return;
            };
            if (this.isFlag)
            {
                ActionFactory.getInstance().getFriendCommands().deleteFriend(this.userName, friendDeleteHandler);
            }
            else
            {
                ActionFactory.getInstance().getFriendCommands().deleteBlock(this.userName, blackDeleteHandler);
            };
        }

        private function friendDeleteHandler(_arg_1:FriendResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            }
            else
            {
                friendPlayerInfoAry = _arg_1.friendArrArray;
                Context.getInstance().getPlayerBean().friendBeansArray = _arg_1.friendArrArray;
                totalPage = Math.ceil((friendPlayerInfoAry.length / 10));
                changePageNo(0);
                AlertWin.show(Lang.msg("删除成功"));
                eachPageFriendArr = new ArrayCollection(friendPlayerInfoAry.toArray().splice(((curPage - 1) * 10), 10));
            };
        }

        private function _FriendList_ClassFactory4_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = FriendList_inlineComponent4;
            _local_1.properties = {"outerDocument":this};
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

        private function set eachPageFriendArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1149398893eachPageFriendArr;
            if (_local_2 !== _arg_1)
            {
                this._1149398893eachPageFriendArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "eachPageFriendArr", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get viewLable():String
        {
            return (this._1591135199viewLable);
        }

        private function init():void
        {
            instance = this;
            this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
        }

        public function ___FriendList_DataGrid2_itemClick(_arg_1:ListEvent):void
        {
            operatePlayerInfo(_arg_1);
        }

        private function getPlayInfoList(_arg_1:ItemClickEvent):void
        {
            switch (_arg_1.index)
            {
                case 0:
                    this.selectedIndex = 0;
                    curPage = 1;
                    friendPlayerInfoAry = Context.getInstance().getPlayerBean().friendBeansArray;
                    totalPage = Math.ceil((friendPlayerInfoAry.length / 10));
                    eachPageFriendArr = new ArrayCollection(friendPlayerInfoAry.toArray().splice(((curPage - 1) * 10), 10));
                    isFlag = true;
                    return;
                case 1:
                    this.selectedIndex = 1;
                    curPage = 1;
                    blockPlayerInfoAry = Context.getInstance().getPlayerBean().blockBeansArray;
                    totalPage = Math.ceil((blockPlayerInfoAry.length / 10));
                    eachPageBlockArr = new ArrayCollection(blockPlayerInfoAry.toArray().splice(((curPage - 1) * 10), 10));
                    isFlag = false;
                    return;
            };
        }

        private function _FriendList_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("好友列表");
            _local_1 = Lang.msg("添加");
            _local_1 = Lang.msg("删除");
            _local_1 = Lang.msg("好友");
            _local_1 = Lang.msg("黑名单");
            _local_1 = (this.totalPage > 1);
            _local_1 = ((this.curPage + "/") + this.totalPage);
            _local_1 = this.selectedIndex;
            _local_1 = this.eachPageFriendArr;
            _local_1 = Lang.msg("玩家名称");
            _local_1 = Lang.msg("所在联盟");
            _local_1 = Lang.msg("查看");
            _local_1 = this.eachPageBlockArr;
            _local_1 = Lang.msg("玩家名称");
            _local_1 = Lang.msg("所在联盟");
            _local_1 = Lang.msg("查看");
        }

        [Bindable(event="propertyChange")]
        public function get toRightBtn():Button
        {
            return (this._1456175557toRightBtn);
        }

        [Bindable(event="propertyChange")]
        private function get blockPlayerInfoAry():ArrayCollection
        {
            return (this._2130926892blockPlayerInfoAry);
        }

        public function set viewLable(_arg_1:String):void
        {
            var _local_2:Object = this._1591135199viewLable;
            if (_local_2 !== _arg_1)
            {
                this._1591135199viewLable = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewLable", _local_2, _arg_1));
            };
        }

        private function _FriendList_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _FriendList_DataGridColumn1 = _local_1;
            _local_1.dataField = "userName";
            BindingManager.executeBindings(this, "_FriendList_DataGridColumn1", _FriendList_DataGridColumn1);
            return (_local_1);
        }

        private function _FriendList_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _FriendList_DataGridColumn5 = _local_1;
            _local_1.dataField = "alliance";
            _local_1.itemRenderer = _FriendList_ClassFactory3_c();
            BindingManager.executeBindings(this, "_FriendList_DataGridColumn5", _FriendList_DataGridColumn5);
            return (_local_1);
        }

        private function set blockPlayerInfoAry(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2130926892blockPlayerInfoAry;
            if (_local_2 !== _arg_1)
            {
                this._2130926892blockPlayerInfoAry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "blockPlayerInfoAry", _local_2, _arg_1));
            };
        }

        private function _FriendList_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = FriendList_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function mouseDownHandler(_arg_1:MouseEvent):void
        {
            FunctionUI.instance.onClose();
        }

        public function __toRightBtn_click(_arg_1:MouseEvent):void
        {
            this.changePageNo(1);
        }

        private function blackDeleteHandler(_arg_1:FriendResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            }
            else
            {
                blockPlayerInfoAry = _arg_1.blockArrArray;
                Context.getInstance().getPlayerBean().blockBeansArray = _arg_1.blockArrArray;
                changePageNo(0);
                totalPage = Math.ceil((blockPlayerInfoAry.length / 10));
                AlertWin.show(Lang.msg("删除成功"));
            };
        }

        private function addHandler():void
        {
            if (this.isFlag)
            {
                UserInputUI.show(UserInputUI.ADD_FRIEND, Lang.msg("加为好友"));
            }
            else
            {
                UserInputUI.show(UserInputUI.ADD_BLACK, Lang.msg("加入黑名单"));
            };
        }

        public function ___FriendList_Button1_click(_arg_1:MouseEvent):void
        {
            addHandler();
        }

        public function set toRightBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1456175557toRightBtn;
            if (_local_2 !== _arg_1)
            {
                this._1456175557toRightBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toRightBtn", _local_2, _arg_1));
            };
        }

        private function _FriendList_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("好友列表");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.title = _arg_1;
            }, "this.title");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("添加");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FriendList_Button1.label = _arg_1;
            }, "_FriendList_Button1.label");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("删除");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FriendList_Button2.label = _arg_1;
            }, "_FriendList_Button2.label");
            result[2] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("好友"));
            }, function (_arg_1:*):void
            {
                _FriendList_Array1[0] = _arg_1;
            }, "_FriendList_Array1[0]");
            result[3] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("黑名单"));
            }, function (_arg_1:*):void
            {
                _FriendList_Array1[1] = _arg_1;
            }, "_FriendList_Array1[1]");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.totalPage > 1);
            }, function (_arg_1:Boolean):void
            {
                _FriendList_HBox1.visible = _arg_1;
            }, "_FriendList_HBox1.visible");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.curPage + "/") + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FriendList_Label1.text = _arg_1;
            }, "_FriendList_Label1.text");
            result[6] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.selectedIndex);
            }, function (_arg_1:int):void
            {
                viewstack1.selectedIndex = _arg_1;
            }, "viewstack1.selectedIndex");
            result[7] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.eachPageFriendArr);
            }, function (_arg_1:Object):void
            {
                friendsDG.dataProvider = _arg_1;
            }, "friendsDG.dataProvider");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("玩家名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FriendList_DataGridColumn1.headerText = _arg_1;
            }, "_FriendList_DataGridColumn1.headerText");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("所在联盟");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FriendList_DataGridColumn2.headerText = _arg_1;
            }, "_FriendList_DataGridColumn2.headerText");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查看");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FriendList_DataGridColumn3.headerText = _arg_1;
            }, "_FriendList_DataGridColumn3.headerText");
            result[11] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.eachPageBlockArr);
            }, function (_arg_1:Object):void
            {
                _FriendList_DataGrid2.dataProvider = _arg_1;
            }, "_FriendList_DataGrid2.dataProvider");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("玩家名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FriendList_DataGridColumn4.headerText = _arg_1;
            }, "_FriendList_DataGridColumn4.headerText");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("所在联盟");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FriendList_DataGridColumn5.headerText = _arg_1;
            }, "_FriendList_DataGridColumn5.headerText");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查看");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FriendList_DataGridColumn6.headerText = _arg_1;
            }, "_FriendList_DataGridColumn6.headerText");
            result[15] = binding;
            return (result);
        }

        private function set friendPlayerInfoAry(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1481557317friendPlayerInfoAry;
            if (_local_2 !== _arg_1)
            {
                this._1481557317friendPlayerInfoAry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendPlayerInfoAry", _local_2, _arg_1));
            };
        }

        private function changePageNo(_arg_1:int):void
        {
            var _local_2:int = (this.curPage + _arg_1);
            if (_local_2 > this.totalPage)
            {
                _local_2 = totalPage;
            };
            if (((_local_2 > 0) && (_local_2 <= this.totalPage)))
            {
                this.curPage = _local_2;
                if (buttonBar.selectedIndex == 0)
                {
                    eachPageFriendArr = new ArrayCollection(friendPlayerInfoAry.toArray().splice(((curPage - 1) * 10), 10));
                }
                else
                {
                    if (buttonBar.selectedIndex == 1)
                    {
                        eachPageBlockArr = new ArrayCollection(blockPlayerInfoAry.toArray().splice(((curPage - 1) * 10), 10));
                    };
                };
            };
        }

        override public function initialize():void
        {
            var target:FriendList;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _FriendList_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_friendList_FriendListWatcherSetupUtil");
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
        private function get eachPageFriendArr():ArrayCollection
        {
            return (this._1149398893eachPageFriendArr);
        }

        private function _FriendList_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _FriendList_DataGridColumn4 = _local_1;
            _local_1.dataField = "userName";
            BindingManager.executeBindings(this, "_FriendList_DataGridColumn4", _FriendList_DataGridColumn4);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get viewstack1():ViewStack
        {
            return (this._946505330viewstack1);
        }

        [Bindable(event="propertyChange")]
        public function get buttonBar():ToggleButtonBar
        {
            return (this._11548545buttonBar);
        }

        private function _FriendList_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = FriendList_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___FriendList_Button2_click(_arg_1:MouseEvent):void
        {
            deleteHandler();
        }

        private function _FriendList_Array1_i():Array
        {
            var _local_1:Array = [null, null];
            _FriendList_Array1 = _local_1;
            BindingManager.executeBindings(this, "_FriendList_Array1", _FriendList_Array1);
            return (_local_1);
        }

        public function set friendsDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1165016872friendsDG;
            if (_local_2 !== _arg_1)
            {
                this._1165016872friendsDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendsDG", _local_2, _arg_1));
            };
        }

        public function set toLeftBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1607799334toLeftBtn;
            if (_local_2 !== _arg_1)
            {
                this._1607799334toLeftBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toLeftBtn", _local_2, _arg_1));
            };
        }

        public function __friendsDG_itemClick(_arg_1:ListEvent):void
        {
            operatePlayerInfo(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get friendPlayerInfoAry():ArrayCollection
        {
            return (this._1481557317friendPlayerInfoAry);
        }

        private function set eachPageBlockArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1079747868eachPageBlockArr;
            if (_local_2 !== _arg_1)
            {
                this._1079747868eachPageBlockArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "eachPageBlockArr", _local_2, _arg_1));
            };
        }

        private function onAddBlockResponse(_arg_1:FriendResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            }
            else
            {
                blockPlayerInfoAry = _arg_1.blockArrArray;
                Context.getInstance().getPlayerBean().blockBeansArray = _arg_1.blockArrArray;
                changePageNo(0);
                totalPage = Math.ceil((blockPlayerInfoAry.length / 10));
                AlertWin.show(Lang.msg("添加成功"));
                eachPageBlockArr = new ArrayCollection(blockPlayerInfoAry.toArray().splice(((curPage - 1) * 10), 10));
            };
        }

        public function operatePlayerInfo(_arg_1:ListEvent):void
        {
            if (((!(PlayerInfo.instance == null)) && (PlayerInfo.instance.isPopUp)))
            {
                return;
            };
            var _local_2:Object = (_arg_1.itemRenderer.data as PlayerInfoBean);
            this.userName = _local_2.userName;
            if (_arg_1.target == friendsDG)
            {
                FunctionUI.show(_local_2);
            };
        }

        public function ___FriendList_BaseFunctionWindowEx1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        public function get friendsDG():DataGrid
        {
            return (this._1165016872friendsDG);
        }

        private function _FriendList_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = FriendList_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function onAddFriendResponse(_arg_1:FriendResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            }
            else
            {
                friendPlayerInfoAry = _arg_1.friendArrArray;
                Context.getInstance().getPlayerBean().friendBeansArray = _arg_1.friendArrArray;
                changePageNo(0);
                totalPage = Math.ceil((friendPlayerInfoAry.length / 10));
                AlertWin.show(Lang.msg("添加成功"));
                eachPageFriendArr = new ArrayCollection(friendPlayerInfoAry.toArray().splice(((curPage - 1) * 10), 10));
            };
        }

        private function _FriendList_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _FriendList_DataGridColumn3 = _local_1;
            _local_1.dataField = "userName";
            _local_1.width = 80;
            _local_1.itemRenderer = _FriendList_ClassFactory2_c();
            BindingManager.executeBindings(this, "_FriendList_DataGridColumn3", _FriendList_DataGridColumn3);
            return (_local_1);
        }

        private function set curPage(_arg_1:int):void
        {
            var _local_2:Object = this._1125923055curPage;
            if (_local_2 !== _arg_1)
            {
                this._1125923055curPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curPage", _local_2, _arg_1));
            };
        }

        private function set totalPage(_arg_1:Number):void
        {
            var _local_2:Object = this._577409037totalPage;
            if (_local_2 !== _arg_1)
            {
                this._577409037totalPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "totalPage", _local_2, _arg_1));
            };
        }

        public function seePlayerInfo(_arg_1:Object):void
        {
            if (_arg_1 != null)
            {
                PlayerInfo.show(PlayerInfoBean(_arg_1));
            };
        }

        override public function refresh():void
        {
            buttonBar.selectedIndex = 0;
            isFlag = true;
            var _local_1:PlayerBean = Context.getInstance().getPlayerBean();
            blockPlayerInfoAry = _local_1.blockBeansArray;
            friendPlayerInfoAry = _local_1.friendBeansArray;
            var _local_2:Sort = new Sort();
            _local_2.fields = [new SortField("userName")];
            friendPlayerInfoAry.sort = _local_2;
            friendPlayerInfoAry.refresh();
            if (buttonBar.selectedIndex == 0)
            {
                totalPage = Math.ceil((friendPlayerInfoAry.length / 10));
                eachPageFriendArr = new ArrayCollection(friendPlayerInfoAry.toArray().splice(((curPage - 1) * 10), 10));
            }
            else
            {
                if (buttonBar.selectedIndex == 1)
                {
                    totalPage = Math.ceil((blockPlayerInfoAry.length / 10));
                    eachPageBlockArr = new ArrayCollection(blockPlayerInfoAry.toArray().splice(((curPage - 1) * 10), 10));
                };
            };
            if (!ResponseDispatcher.getInstance().hasEventListener(ResponseDispatcher.FRIEND_ADD_FRIEND))
            {
                ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FRIEND_ADD_FRIEND, onAddFriendResponse, false, 0, true);
            };
            if (!ResponseDispatcher.getInstance().hasEventListener(ResponseDispatcher.FRIEND_ADD_BLOCK))
            {
                ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FRIEND_ADD_BLOCK, onAddBlockResponse, false, 0, true);
            };
        }

        [Bindable(event="propertyChange")]
        private function get eachPageBlockArr():ArrayCollection
        {
            return (this._1079747868eachPageBlockArr);
        }

        [Bindable(event="propertyChange")]
        private function get curPage():int
        {
            return (this._1125923055curPage);
        }

        [Bindable(event="propertyChange")]
        public function get toLeftBtn():Button
        {
            return (this._1607799334toLeftBtn);
        }

        private function set selectedIndex(_arg_1:int):void
        {
            var _local_2:Object = this._1436069623selectedIndex;
            if (_local_2 !== _arg_1)
            {
                this._1436069623selectedIndex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selectedIndex", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get selectedIndex():int
        {
            return (this._1436069623selectedIndex);
        }

        [Bindable(event="propertyChange")]
        private function get totalPage():Number
        {
            return (this._577409037totalPage);
        }


    }
}//package view.module.friendList

