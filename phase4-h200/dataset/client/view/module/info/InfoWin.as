// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.InfoWin

package view.module.info
{
    import view.ui.BaseFunctionWindowEx;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.collections.ArrayCollection;
    import mx.controls.ToggleButtonBar;
    import mx.controls.Label;
    import mx.containers.Canvas;
    import com.evony.util.EvonyImage;
    import mx.containers.ViewStack;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import mx.events.FlexEvent;
    import mx.events.ItemClickEvent;
    import com.evony.Context;
    import com.evony.client.response.ResponseDispatcher;
    import mx.controls.Button;
    import flash.events.Event;
    import mx.binding.Binding;
    import com.evony.Lang;
    import mx.binding.BindingManager;
    import flash.utils.getDefinitionByName;
    import mx.core.Container;
    import com.evony.common.constants.ObjConstants;
    import com.evony.common.server.events.NewReport;
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

    public class InfoWin extends BaseFunctionWindowEx implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "InfoWin.open";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _InfoWin_ArmyInfoDataGrid1:ArmyInfoDataGrid;
        public var _InfoWin_FriendArmyInfoDataGrid1:FriendArmyInfoDataGrid;
        private var _1904160439publicInfo:ArrayCollection;
        private var _11548545buttonBar:ToggleButtonBar;
        private var _1849667083tradeCount:int;
        public var _InfoWin_Label1:Label;
        public var _InfoWin_Label2:Label;
        public var _InfoWin_Label3:Label;
        public var _InfoWin_Label4:Label;
        private var pageSize:int = 10;
        private var _1507677378armyNumIcon:Canvas;
        public var _InfoWin_EvonyImage1:EvonyImage;
        public var _InfoWin_EvonyImage2:EvonyImage;
        public var _InfoWin_EvonyImage3:EvonyImage;
        public var _InfoWin_EvonyImage4:EvonyImage;
        private var _946505330viewstack1:ViewStack;
        private var _208221217otherCount:int;
        private var _1050500010enemyInfo:ArrayCollection;
        public var _InfoWin_Array1:Array;
        private var _140738682publicReportVS:PublicReportCanvas;
        private var _1747355620armyInfoCount:int;
        private var _1235924927scoutNumIcon:Canvas;
        private var _354865329scoutCount:int;
        private var _1196216337otherNumIcon:Canvas;
        private var _1788741223enemyCount:int;
        private var _1360484984friendArmys:ArrayCollection;
        private var _929429134armyCount:int;
        private var _749483803tradeNumIcon:Canvas;
        private var _577409037totalPage:int = 0;
        private var _1125923055curPage:int = 1;
        public var _InfoWin_EnemyInfoDataGrid1:EnemyInfoDataGrid;
        private var _435867532friendArmyCount:int;
        private var _1415277589armyInfo:ArrayCollection;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindowEx,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":22,
                                "y":64,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":ToggleButtonBar,
                                    "id":"buttonBar",
                                    "events":{
                                        "itemClick":"__buttonBar_itemClick",
                                        "creationComplete":"__buttonBar_creationComplete"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":680,
                                            "dataProvider":_InfoWin_Array1_i()
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"viewstack1",
                        "stylesFactory":function ():void
                        {
                            this.left = "22";
                            this.right = "12";
                            this.bottom = "41";
                            this.top = "64";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":EnemyInfoDataGrid,
                                    "id":"_InfoWin_EnemyInfoDataGrid1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"DataGrid",
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":ArmyInfoDataGrid,
                                                "id":"_InfoWin_ArmyInfoDataGrid1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "30";
                                                    this.bottom = "0";
                                                    this.left = "0";
                                                    this.right = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"DataGrid"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":FriendArmyInfoDataGrid,
                                                "id":"_InfoWin_FriendArmyInfoDataGrid1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "30";
                                                    this.left = "0";
                                                    this.right = "0";
                                                    this.bottom = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"DataGrid"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":PublicReportCanvas,
                                    "id":"publicReportVS",
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
                        "type":Canvas,
                        "id":"armyNumIcon",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":409,
                                "y":56,
                                "mouseEnabled":false,
                                "mouseChildren":false,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_InfoWin_EvonyImage1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"fla/dynamic/ui234.swf@greenInfoAmount.png",
                                            "alpha":0.5
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_InfoWin_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "16";
                                        this.top = "8";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":28,
                                            "mouseChildren":false,
                                            "mouseEnabled":false,
                                            "styleName":"LabelWhite13"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"scoutNumIcon",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":495,
                                "y":56,
                                "mouseEnabled":false,
                                "mouseChildren":false,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_InfoWin_EvonyImage2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"fla/dynamic/ui234.swf@greenInfoAmount.png",
                                            "alpha":0.5
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_InfoWin_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "16";
                                        this.top = "8";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":28,
                                            "mouseChildren":false,
                                            "mouseEnabled":false,
                                            "styleName":"LabelWhite13"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"tradeNumIcon",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":581,
                                "y":56,
                                "mouseEnabled":false,
                                "mouseChildren":false,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_InfoWin_EvonyImage3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"fla/dynamic/ui234.swf@greenInfoAmount.png",
                                            "alpha":0.5
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_InfoWin_Label3",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "16";
                                        this.top = "8";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":28,
                                            "mouseChildren":false,
                                            "mouseEnabled":false,
                                            "styleName":"LabelWhite13"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"otherNumIcon",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":667,
                                "y":56,
                                "mouseEnabled":false,
                                "mouseChildren":false,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_InfoWin_EvonyImage4",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"fla/dynamic/ui234.swf@greenInfoAmount.png",
                                            "alpha":0.5
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_InfoWin_Label4",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "16";
                                        this.top = "8";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":28,
                                            "mouseChildren":false,
                                            "mouseEnabled":false,
                                            "styleName":"LabelWhite13"
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function InfoWin()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___InfoWin_BaseFunctionWindowEx1_creationComplete);
            this.addEventListener("removedFromStage", ___InfoWin_BaseFunctionWindowEx1_removedFromStage);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            InfoWin._watcherSetupUtil = _arg_1;
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

        [Bindable(event="propertyChange")]
        private function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        [Bindable(event="propertyChange")]
        private function get tradeCount():int
        {
            return (this._1849667083tradeCount);
        }

        public function __buttonBar_creationComplete(_arg_1:FlexEvent):void
        {
            onBtnBarCreated(_arg_1);
        }

        public function __buttonBar_itemClick(_arg_1:ItemClickEvent):void
        {
            this.clickHandler(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get tradeNumIcon():Canvas
        {
            return (this._749483803tradeNumIcon);
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

        private function set tradeCount(_arg_1:int):void
        {
            var _local_2:Object = this._1849667083tradeCount;
            if (_local_2 !== _arg_1)
            {
                this._1849667083tradeCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tradeCount", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            this.armyCount = Context.getInstance().getPlayerBean().newReportCount_army;
            this.scoutCount = Context.getInstance().getPlayerBean().newReportCount_scout;
            this.tradeCount = Context.getInstance().getPlayerBean().newReportCount_trade;
            this.otherCount = Context.getInstance().getPlayerBean().newReportCount_other;
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_NEW_REPORT, onHasNewReport);
        }

        private function onBtnBarCreated(_arg_1:Event):void
        {
            var _local_2:int;
            var _local_3:Button;
            while (_local_2 < buttonBar.numChildren)
            {
                _local_3 = (buttonBar.getChildAt(_local_2) as Button);
                switch (_local_2)
                {
                    case 0:
                        _local_3.width = 86;
                        break;
                    case 1:
                        _local_3.width = 140;
                        break;
                    case 2:
                        _local_3.width = 110;
                        break;
                    case 3:
                        _local_3.width = 86;
                        break;
                    case 4:
                        _local_3.width = 86;
                        break;
                    case 5:
                        _local_3.width = 86;
                        break;
                    case 5:
                        _local_3.width = 86;
                        break;
                };
                _local_2++;
            };
        }

        public function set tradeNumIcon(_arg_1:Canvas):void
        {
            var _local_2:Object = this._749483803tradeNumIcon;
            if (_local_2 !== _arg_1)
            {
                this._749483803tradeNumIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tradeNumIcon", _local_2, _arg_1));
            };
        }

        private function _InfoWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("情报");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.title = _arg_1;
            }, "this.title");
            result[0] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("敌情警报"));
            }, function (_arg_1:*):void
            {
                _InfoWin_Array1[0] = _arg_1;
            }, "_InfoWin_Array1[0]");
            result[1] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("军队动态"));
            }, function (_arg_1:*):void
            {
                _InfoWin_Array1[1] = _arg_1;
            }, "_InfoWin_Array1[1]");
            result[2] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("盟军动态"));
            }, function (_arg_1:*):void
            {
                _InfoWin_Array1[2] = _arg_1;
            }, "_InfoWin_Array1[2]");
            result[3] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("军情报告"));
            }, function (_arg_1:*):void
            {
                _InfoWin_Array1[3] = _arg_1;
            }, "_InfoWin_Array1[3]");
            result[4] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("侦察"));
            }, function (_arg_1:*):void
            {
                _InfoWin_Array1[4] = _arg_1;
            }, "_InfoWin_Array1[4]");
            result[5] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("交易报告"));
            }, function (_arg_1:*):void
            {
                _InfoWin_Array1[5] = _arg_1;
            }, "_InfoWin_Array1[5]");
            result[6] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("其他报告"));
            }, function (_arg_1:*):void
            {
                _InfoWin_Array1[6] = _arg_1;
            }, "_InfoWin_Array1[6]");
            result[7] = binding;
            binding = new Binding(this, function ():ArrayCollection
            {
                return (Context.getInstance().getPlayerBean().enemyArmysArray);
            }, function (_arg_1:ArrayCollection):void
            {
                _InfoWin_EnemyInfoDataGrid1.dataProvider = _arg_1;
            }, "_InfoWin_EnemyInfoDataGrid1.dataProvider");
            result[8] = binding;
            binding = new Binding(this, function ():ArrayCollection
            {
                return (Context.getInstance().getPlayerBean().selfArmysArray);
            }, function (_arg_1:ArrayCollection):void
            {
                _InfoWin_ArmyInfoDataGrid1.dataProvider = _arg_1;
            }, "_InfoWin_ArmyInfoDataGrid1.dataProvider");
            result[9] = binding;
            binding = new Binding(this, function ():ArrayCollection
            {
                return (Context.getInstance().getPlayerBean().friendArmysArray);
            }, function (_arg_1:ArrayCollection):void
            {
                _InfoWin_FriendArmyInfoDataGrid1.dataProvider = _arg_1;
            }, "_InfoWin_FriendArmyInfoDataGrid1.dataProvider");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((armyCount == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _InfoWin_EvonyImage1.visible = _arg_1;
            }, "_InfoWin_EvonyImage1.visible");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.armyCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _InfoWin_Label1.text = _arg_1;
            }, "_InfoWin_Label1.text");
            result[12] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((armyCount == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _InfoWin_Label1.visible = _arg_1;
            }, "_InfoWin_Label1.visible");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((scoutCount == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _InfoWin_EvonyImage2.visible = _arg_1;
            }, "_InfoWin_EvonyImage2.visible");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.scoutCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _InfoWin_Label2.text = _arg_1;
            }, "_InfoWin_Label2.text");
            result[15] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((scoutCount == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _InfoWin_Label2.visible = _arg_1;
            }, "_InfoWin_Label2.visible");
            result[16] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((tradeCount == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _InfoWin_EvonyImage3.visible = _arg_1;
            }, "_InfoWin_EvonyImage3.visible");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.tradeCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _InfoWin_Label3.text = _arg_1;
            }, "_InfoWin_Label3.text");
            result[18] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((tradeCount == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _InfoWin_Label3.visible = _arg_1;
            }, "_InfoWin_Label3.visible");
            result[19] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((otherCount == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _InfoWin_EvonyImage4.visible = _arg_1;
            }, "_InfoWin_EvonyImage4.visible");
            result[20] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.otherCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _InfoWin_Label4.text = _arg_1;
            }, "_InfoWin_Label4.text");
            result[21] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((otherCount == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _InfoWin_Label4.visible = _arg_1;
            }, "_InfoWin_Label4.visible");
            result[22] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get scoutNumIcon():Canvas
        {
            return (this._1235924927scoutNumIcon);
        }

        private function _InfoWin_Array1_i():Array
        {
            var _local_1:Array = [null, null, null, null, null, null, null];
            _InfoWin_Array1 = _local_1;
            BindingManager.executeBindings(this, "_InfoWin_Array1", _InfoWin_Array1);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get enemyInfo():ArrayCollection
        {
            return (this._1050500010enemyInfo);
        }

        private function set scoutCount(_arg_1:int):void
        {
            var _local_2:Object = this._354865329scoutCount;
            if (_local_2 !== _arg_1)
            {
                this._354865329scoutCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scoutCount", _local_2, _arg_1));
            };
        }

        private function set publicInfo(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1904160439publicInfo;
            if (_local_2 !== _arg_1)
            {
                this._1904160439publicInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "publicInfo", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get armyCount():int
        {
            return (this._929429134armyCount);
        }

        [Bindable(event="propertyChange")]
        private function get enemyCount():int
        {
            return (this._1788741223enemyCount);
        }

        [Bindable(event="propertyChange")]
        private function get friendArmys():ArrayCollection
        {
            return (this._1360484984friendArmys);
        }

        [Bindable(event="propertyChange")]
        public function get publicReportVS():PublicReportCanvas
        {
            return (this._140738682publicReportVS);
        }

        public function ___InfoWin_BaseFunctionWindowEx1_removedFromStage(_arg_1:Event):void
        {
            destroy();
        }

        [Bindable(event="propertyChange")]
        public function get buttonBar():ToggleButtonBar
        {
            return (this._11548545buttonBar);
        }

        [Bindable(event="propertyChange")]
        private function get friendArmyCount():int
        {
            return (this._435867532friendArmyCount);
        }

        public function set armyNumIcon(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1507677378armyNumIcon;
            if (_local_2 !== _arg_1)
            {
                this._1507677378armyNumIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyNumIcon", _local_2, _arg_1));
            };
        }

        public function set scoutNumIcon(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1235924927scoutNumIcon;
            if (_local_2 !== _arg_1)
            {
                this._1235924927scoutNumIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scoutNumIcon", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get viewstack1():ViewStack
        {
            return (this._946505330viewstack1);
        }

        override public function initialize():void
        {
            var target:InfoWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _InfoWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_InfoWinWatcherSetupUtil");
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

        private function gotoView(_arg_1:Container):void
        {
            this.viewstack1.selectedChild = _arg_1;
        }

        private function clickHandler(_arg_1:ItemClickEvent):void
        {
            if (_arg_1.index == 3)
            {
                this.publicReportVS.refresh(ObjConstants.REPORT_TYPE_ARMY);
                viewstack1.selectedIndex = 3;
            }
            else
            {
                if (_arg_1.index == 4)
                {
                    this.publicReportVS.refresh(ObjConstants.REPORT_TYPE_SCOUT);
                    viewstack1.selectedIndex = 3;
                }
                else
                {
                    if (_arg_1.index == 5)
                    {
                        this.publicReportVS.refresh(ObjConstants.REPORT_TYPE_TRADE);
                        viewstack1.selectedIndex = 3;
                    }
                    else
                    {
                        if (_arg_1.index == 6)
                        {
                            this.publicReportVS.refresh(ObjConstants.REPORT_TYPE_OTHER);
                            viewstack1.selectedIndex = 3;
                        }
                        else
                        {
                            viewstack1.selectedIndex = _arg_1.index;
                        };
                    };
                };
            };
        }

        private function set enemyInfo(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1050500010enemyInfo;
            if (_local_2 !== _arg_1)
            {
                this._1050500010enemyInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "enemyInfo", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get scoutCount():int
        {
            return (this._354865329scoutCount);
        }

        private function setSelectedIndex():void
        {
            var _local_1:int;
            var _local_2:Array = [this.armyCount, this.scoutCount, this.tradeCount, this.otherCount];
            var _local_3:int;
            while (_local_3 < _local_2.length)
            {
                if (_local_2[_local_3] > _local_1)
                {
                    _local_1 = _local_2[_local_3];
                };
                _local_3++;
            };
            switch (_local_1)
            {
                case 0:
                    this.viewstack1.selectedIndex = 0;
                    this.buttonBar.selectedIndex = 0;
                    return;
                case this.armyCount:
                    this.publicReportVS.refresh(ObjConstants.REPORT_TYPE_ARMY);
                    this.viewstack1.selectedIndex = 3;
                    this.buttonBar.selectedIndex = 3;
                    return;
                case this.scoutCount:
                    this.publicReportVS.refresh(ObjConstants.REPORT_TYPE_SCOUT);
                    this.viewstack1.selectedIndex = 3;
                    this.buttonBar.selectedIndex = 4;
                    return;
                case this.tradeCount:
                    this.publicReportVS.refresh(ObjConstants.REPORT_TYPE_TRADE);
                    this.viewstack1.selectedIndex = 3;
                    this.buttonBar.selectedIndex = 5;
                    return;
                case this.otherCount:
                    this.publicReportVS.refresh(ObjConstants.REPORT_TYPE_OTHER);
                    this.viewstack1.selectedIndex = 3;
                    this.buttonBar.selectedIndex = 6;
                    return;
            };
        }

        [Bindable(event="propertyChange")]
        private function get publicInfo():ArrayCollection
        {
            return (this._1904160439publicInfo);
        }

        private function set otherCount(_arg_1:int):void
        {
            var _local_2:Object = this._208221217otherCount;
            if (_local_2 !== _arg_1)
            {
                this._208221217otherCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "otherCount", _local_2, _arg_1));
            };
        }

        private function set armyInfoCount(_arg_1:int):void
        {
            var _local_2:Object = this._1747355620armyInfoCount;
            if (_local_2 !== _arg_1)
            {
                this._1747355620armyInfoCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyInfoCount", _local_2, _arg_1));
            };
        }

        public function ___InfoWin_BaseFunctionWindowEx1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set enemyCount(_arg_1:int):void
        {
            var _local_2:Object = this._1788741223enemyCount;
            if (_local_2 !== _arg_1)
            {
                this._1788741223enemyCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "enemyCount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get armyNumIcon():Canvas
        {
            return (this._1507677378armyNumIcon);
        }

        private function set armyInfo(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1415277589armyInfo;
            if (_local_2 !== _arg_1)
            {
                this._1415277589armyInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyInfo", _local_2, _arg_1));
            };
        }

        public function set otherNumIcon(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1196216337otherNumIcon;
            if (_local_2 !== _arg_1)
            {
                this._1196216337otherNumIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "otherNumIcon", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get otherCount():int
        {
            return (this._208221217otherCount);
        }

        [Bindable(event="propertyChange")]
        private function get armyInfoCount():int
        {
            return (this._1747355620armyInfoCount);
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

        private function set totalPage(_arg_1:int):void
        {
            var _local_2:Object = this._577409037totalPage;
            if (_local_2 !== _arg_1)
            {
                this._577409037totalPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "totalPage", _local_2, _arg_1));
            };
        }

        private function set friendArmyCount(_arg_1:int):void
        {
            var _local_2:Object = this._435867532friendArmyCount;
            if (_local_2 !== _arg_1)
            {
                this._435867532friendArmyCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendArmyCount", _local_2, _arg_1));
            };
        }

        private function _InfoWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("情报");
            _local_1 = Lang.msg("敌情警报");
            _local_1 = Lang.msg("军队动态");
            _local_1 = Lang.msg("盟军动态");
            _local_1 = Lang.msg("军情报告");
            _local_1 = Lang.msg("侦察");
            _local_1 = Lang.msg("交易报告");
            _local_1 = Lang.msg("其他报告");
            _local_1 = Context.getInstance().getPlayerBean().enemyArmysArray;
            _local_1 = Context.getInstance().getPlayerBean().selfArmysArray;
            _local_1 = Context.getInstance().getPlayerBean().friendArmysArray;
            _local_1 = ((armyCount == 0) ? false : true);
            _local_1 = this.armyCount;
            _local_1 = ((armyCount == 0) ? false : true);
            _local_1 = ((scoutCount == 0) ? false : true);
            _local_1 = this.scoutCount;
            _local_1 = ((scoutCount == 0) ? false : true);
            _local_1 = ((tradeCount == 0) ? false : true);
            _local_1 = this.tradeCount;
            _local_1 = ((tradeCount == 0) ? false : true);
            _local_1 = ((otherCount == 0) ? false : true);
            _local_1 = this.otherCount;
            _local_1 = ((otherCount == 0) ? false : true);
        }

        [Bindable(event="propertyChange")]
        private function get armyInfo():ArrayCollection
        {
            return (this._1415277589armyInfo);
        }

        [Bindable(event="propertyChange")]
        public function get otherNumIcon():Canvas
        {
            return (this._1196216337otherNumIcon);
        }

        private function set friendArmys(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1360484984friendArmys;
            if (_local_2 !== _arg_1)
            {
                this._1360484984friendArmys = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendArmys", _local_2, _arg_1));
            };
        }

        override public function refresh():void
        {
            setSelectedIndex();
        }

        public function set publicReportVS(_arg_1:PublicReportCanvas):void
        {
            var _local_2:Object = this._140738682publicReportVS;
            if (_local_2 !== _arg_1)
            {
                this._140738682publicReportVS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "publicReportVS", _local_2, _arg_1));
            };
        }

        private function onHasNewReport(_arg_1:NewReport):void
        {
            this.armyCount = Context.getInstance().getPlayerBean().newReportCount_army;
            this.scoutCount = Context.getInstance().getPlayerBean().newReportCount_scout;
            this.tradeCount = Context.getInstance().getPlayerBean().newReportCount_trade;
            this.otherCount = Context.getInstance().getPlayerBean().newReportCount_other;
        }

        override public function destroy():void
        {
        }

        private function set armyCount(_arg_1:int):void
        {
            var _local_2:Object = this._929429134armyCount;
            if (_local_2 !== _arg_1)
            {
                this._929429134armyCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyCount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get curPage():int
        {
            return (this._1125923055curPage);
        }


    }
}//package view.module.info

