// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.Map

package view.castle
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.Tile;
    import mx.controls.TextInput;
    import mx.core.Repeater;
    import com.evony.common.beans.CastleBean;
    import mx.controls.Button;
    import mx.collections.ArrayCollection;
    import mx.controls.Label;
    import view.castle.world.WorldMap;
    import mx.core.UIComponentDescriptor;
    import view.ui.CoordinatesUI;
    import mx.core.UIComponent;
    import view.castle.world.ArrowSign;
    import mx.core.mx_internal;
    import flash.events.TimerEvent;
    import flash.events.MouseEvent;
    import com.evony.util.EvonyImage;
    import com.evony.Lang;
    import com.evony.common.server.events.CastleFieldUpdate;
    import mx.events.PropertyChangeEvent;
    import mx.events.FlexEvent;
    import flash.events.Event;
    import mx.binding.Binding;
    import mx.binding.RepeatableBinding;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.server.events.CastleUpdate;
    import com.evony.events.MapResetPointEvent;
    import view.MainWin;
    import view.castle.world.WorldEvent;
    import com.evony.Context;
    import com.evony.common.module.castle.CastleSignResponse;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import flash.utils.getDefinitionByName;
    import flash.utils.Timer;
    import com.evony.Coordinate;
    import view.newUI.MapPos;
    import com.evony.MsgDispacther;
    import com.evony.client.response.ResponseDispatcher;
    import flash.events.KeyboardEvent;
    import com.evony.common.MouseManager;
    import flash.ui.Keyboard;
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

    public class Map extends Canvas implements IBindingClient 
    {

        public static var instance:Map;
        private static var singleinstance:Map = null;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1741668577_Map_Tile1:Tile;
        private var _3313gx:TextInput;
        private var MCIsoperate:Boolean = false;
        private var type:String = "";
        private var _3646rp:Repeater;
        private var curCastle:CastleBean;
        public var _Map_CoordinatesUI1:Array;
        private var _3304go:Button;
        private var level:String = "";
        private var _1180125369isShow:Boolean = false;
        private var _3314gy:TextInput;
        private var _14669033castleSign_Cmbox:Tile;
        private var _501536414CoordinateData:ArrayCollection;
        public var _Map_Label1:Label;
        private var _114190243castleName:String;
        private var _36212842worldMap:WorldMap;
        private var CoordinateIsShow:Boolean = false;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":WorldMap,
                        "id":"worldMap",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "percentHeight":100
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":161,
                                "height":49,
                                "visible":false,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___Map_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "5";
                                        this.bottom = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"reFreshBtn"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"go",
                                    "events":{"click":"__go_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "3";
                                        this.top = "3";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"b40",
                                            "width":40,
                                            "height":20
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"gy",
                                    "events":{"enter":"__gy_enter"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "text":"0",
                                            "width":35,
                                            "styleName":"textInput",
                                            "height":20,
                                            "maxChars":3,
                                            "restrict":"0-9",
                                            "x":72,
                                            "y":4
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_Map_Label1",
                                    "events":{"click":"___Map_Label1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "11";
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":20,
                                            "width":130,
                                            "height":20,
                                            "styleName":"commonNormalColor"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"gx",
                                    "events":{"enter":"__gx_enter"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "text":"0",
                                            "width":35,
                                            "styleName":"textInput",
                                            "height":20,
                                            "maxChars":3,
                                            "restrict":"0-9",
                                            "x":22,
                                            "y":4
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Tile,
                        "id":"castleSign_Cmbox",
                        "stylesFactory":function ():void
                        {
                            this.borderStyle = "solid";
                            this.horizontalGap = 0;
                            this.verticalGap = 0;
                            this.borderThickness = 1;
                            this.borderColor = 11760387;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":682,
                                "y":47,
                                "width":156,
                                "direction":"horizontal",
                                "visible":false,
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Repeater,
                                    "id":"rp",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":CoordinatesUI,
                                                "id":"_Map_CoordinatesUI1",
                                                "events":{
                                                    "onDeleteClick":"___Map_CoordinatesUI1_onDeleteClick",
                                                    "onChangeClick":"___Map_CoordinatesUI1_onChangeClick"
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var arrowSignDisplay:UIComponent = new ArrowSign();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Map()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___Map_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Map._watcherSetupUtil = _arg_1;
        }

        public static function singleton():Map
        {
            if (singleinstance == null)
            {
                singleinstance = new (Map)();
            };
            return (singleinstance);
        }


        private function timerRun(_arg_1:TimerEvent):void
        {
            if (CoordinateIsShow)
            {
                castleSign_Cmbox.height = (castleSign_Cmbox.height + (156 / 20));
            }
            else
            {
                castleSign_Cmbox.height = (castleSign_Cmbox.height - (156 / 20));
            };
        }

        public function ___Map_Button1_click(_arg_1:MouseEvent):void
        {
            resetCityPoint();
        }

        public function init():void
        {
            this.worldMap.bkimg.addEventListener(EvonyImage.LOAD_COMPLETED, onFloorLoaded);
            this.worldMap.bkimg.source = "fla/dynamic/MapViewFloorTile.swf@mapTile.jpg@2";
        }

        [Bindable(event="propertyChange")]
        public function get castleSign_Cmbox():Tile
        {
            return (this._14669033castleSign_Cmbox);
        }

        private function timerCompelete(_arg_1:TimerEvent):void
        {
            MCIsoperate = false;
            castleSign_Cmbox.verticalScrollPolicy = "auto";
            _arg_1.target.stop();
            _arg_1.target.removeEventListener(TimerEvent.TIMER, timerRun);
            _arg_1.target.removeEventListener(TimerEvent.TIMER_COMPLETE, timerCompelete);
        }

        public function changeGotoPoint(_arg_1:uint, _arg_2:uint, _arg_3:String):void
        {
            CoordinateIsShow = false;
            castleSign_Cmbox.visible = false;
            viewPoint(int(_arg_1), int(_arg_2));
            this.castleName = _arg_3;
        }

        private function _Map_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("跳转");
            _local_1 = this.castleName;
            _local_1 = CoordinateData;
            _local_1 = rp.currentItem.name;
            _local_1 = ((rp.currentItem.x + ".") + rp.currentItem.y);
        }

        private function onCastleFieldUpdate(_arg_1:CastleFieldUpdate):void
        {
            if (this.isShow)
            {
                this.refresh();
            };
        }

        public function set castleSign_Cmbox(_arg_1:Tile):void
        {
            var _local_2:Object = this._14669033castleSign_Cmbox;
            if (_local_2 !== _arg_1)
            {
                this._14669033castleSign_Cmbox = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleSign_Cmbox", _local_2, _arg_1));
            };
        }

        public function __gy_enter(_arg_1:FlexEvent):void
        {
            gotoPoint();
        }

        [Bindable(event="propertyChange")]
        public function get rp():Repeater
        {
            return (this._3646rp);
        }

        private function set castleName(_arg_1:String):void
        {
            var _local_2:Object = this._114190243castleName;
            if (_local_2 !== _arg_1)
            {
                this._114190243castleName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get isShow():Boolean
        {
            return (this._1180125369isShow);
        }

        private function onCurCastleChange(_arg_1:Event):void
        {
            trace((this.className + ".onCurCastleChange()"));
            if (this.initialized)
            {
                this.refresh();
            };
        }

        private function _Map_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("跳转");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                go.label = _arg_1;
            }, "go.label");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.castleName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Map_Label1.text = _arg_1;
            }, "_Map_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (CoordinateData);
            }, function (_arg_1:Object):void
            {
                rp.dataProvider = _arg_1;
            }, "rp.dataProvider");
            result[2] = binding;
            binding = new RepeatableBinding(this, function (_arg_1:Array, _arg_2:Array):String
            {
                var _local_3:* = rp.mx_internal::getItemAt(_arg_2[0]).name;
                var _local_4:* = ((_local_3 == undefined) ? null : String(_local_3));
                return (_local_4);
            }, function (_arg_1:String, _arg_2:Array):void
            {
                _Map_CoordinatesUI1[_arg_2[0]].cityname = _arg_1;
            }, "_Map_CoordinatesUI1.cityname");
            result[3] = binding;
            binding = new RepeatableBinding(this, function (_arg_1:Array, _arg_2:Array):String
            {
                var _local_3:* = ((rp.mx_internal::getItemAt(_arg_2[0]).x + ".") + rp.mx_internal::getItemAt(_arg_2[0]).y);
                var _local_4:* = ((_local_3 == undefined) ? null : String(_local_3));
                return (_local_4);
            }, function (_arg_1:String, _arg_2:Array):void
            {
                _Map_CoordinatesUI1[_arg_2[0]].cityXY = _arg_1;
            }, "_Map_CoordinatesUI1.cityXY");
            result[4] = binding;
            return (result);
        }

        public function ___Map_Label1_click(_arg_1:MouseEvent):void
        {
            showCoordinates();
        }

        public function deleteCoordinates(_arg_1:uint):void
        {
            ActionFactory.getInstance().getCastleSignCommand().deleteCastleSign(_arg_1);
        }

        public function __go_click(_arg_1:MouseEvent):void
        {
            gotoPoint();
        }

        private function resetCityPoint():void
        {
            setcity();
        }

        public function restorePlayAll():void
        {
            if (this.worldMap != null)
            {
                this.worldMap.restorePlayAll();
            };
        }

        private function onCastleUpdate(_arg_1:CastleUpdate):void
        {
            if (this.isShow)
            {
                this.refresh();
            };
        }

        [Bindable(event="propertyChange")]
        private function get CoordinateData():ArrayCollection
        {
            return (this._501536414CoordinateData);
        }

        private function setArrowRotation(_arg_1:MapResetPointEvent):void
        {
            var _local_2:Number = Number(_arg_1.getData());
            this.arrowSignDisplay.rotation = _local_2;
        }

        [Bindable(event="propertyChange")]
        public function get worldMap():WorldMap
        {
            return (this._36212842worldMap);
        }

        private function onShowMsg(_arg_1:WorldEvent):void
        {
            if (_arg_1.mapTile)
            {
                if (MainWin.instance != null)
                {
                    MainWin.instance.showNew.visible = true;
                    MainWin.instance.showNew.refresh(_arg_1.mapTile);
                };
            };
        }

        private function castle_deleteCastle(_arg_1:CastleSignResponse):void
        {
            var _local_2:ArrayCollection = _arg_1.castleSignInfoArrArray;
            CoordinateData = _local_2;
            Context.getInstance().getPlayerBean().castleSignBeanArray = _local_2;
        }

        public function stopPlayAll():void
        {
            if (this.worldMap != null)
            {
                this.worldMap.stopPlayAll();
            };
        }

        private function castle_saveCastle(_arg_1:CastleSignResponse):void
        {
            var _local_2:ArrayCollection;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                _local_2 = _arg_1.castleSignInfoArrArray;
                CoordinateData = _local_2;
                Context.getInstance().getPlayerBean().castleSignBeanArray = _local_2;
                AlertWin.show(Lang.msg("收藏成功"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function resetPoint():void
        {
            this.worldMap.resetPoint();
        }

        public function set rp(_arg_1:Repeater):void
        {
            var _local_2:Object = this._3646rp;
            if (_local_2 !== _arg_1)
            {
                this._3646rp = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rp", _local_2, _arg_1));
            };
        }

        public function set isShow(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1180125369isShow;
            if (_local_2 !== _arg_1)
            {
                this._1180125369isShow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isShow", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:Map;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _Map_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castle_MapWatcherSetupUtil");
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
        private function get castleName():String
        {
            return (this._114190243castleName);
        }

        public function ___Map_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function laterRefresh():void
        {
            this.refresh();
        }

        public function ___Map_CoordinatesUI1_onDeleteClick(_arg_1:Event):void
        {
            this.deleteCoordinates(_arg_1.currentTarget.getRepeaterItem().id);
        }

        private function set CoordinateData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._501536414CoordinateData;
            if (_local_2 !== _arg_1)
            {
                this._501536414CoordinateData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "CoordinateData", _local_2, _arg_1));
            };
        }

        private function showCoordinates():void
        {
            var _local_1:Timer;
            if (!MCIsoperate)
            {
                if (!CoordinateIsShow)
                {
                    CoordinateIsShow = true;
                    castleSign_Cmbox.visible = true;
                    castleSign_Cmbox.height = 1;
                }
                else
                {
                    CoordinateIsShow = false;
                };
                MCIsoperate = true;
                castleSign_Cmbox.verticalScrollPolicy = "off";
                _local_1 = new Timer(15, 20);
                _local_1.addEventListener(TimerEvent.TIMER, timerRun);
                _local_1.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompelete);
                _local_1.start();
            };
        }

        public function set _Map_Tile1(_arg_1:Tile):void
        {
            var _local_2:Object = this._1741668577_Map_Tile1;
            if (_local_2 !== _arg_1)
            {
                this._1741668577_Map_Tile1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_Map_Tile1", _local_2, _arg_1));
            };
        }

        private function setcity():void
        {
            this.curCastle = Context.getInstance().getCurCastle();
            this.castleName = curCastle.name;
            var coo:Coordinate = new Coordinate(this.curCastle.fieldId);
            var x:int = coo.x;
            var y:int = coo.y;
            gx.text = String(x);
            gy.text = String(y);
            this.worldMap.setPoint(x, y);
            this.worldMap.setCityPos(x, y);
            try
            {
                if (MapPos.instance != null)
                {
                    MapPos.instance.gx.text = String(x);
                    MapPos.instance.gy.text = String(y);
                };
            }
            catch(e:Error)
            {
            };
        }

        public function set go(_arg_1:Button):void
        {
            var _local_2:Object = this._3304go;
            if (_local_2 !== _arg_1)
            {
                this._3304go = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "go", _local_2, _arg_1));
            };
        }

        public function onFloorLoaded(_arg_1:Event):void
        {
            this.worldMap.onFloorLoaded(_arg_1);
            instance = this;
            MsgDispacther.getInstance().addEventListener(Context.EVENT_CASTLE_CHANGE, onCurCastleChange);
            MsgDispacther.getInstance().addEventListener(Context.EVENT_CASTLE_MOVE, onCurCastleChange);
            worldMap.addEventListener(MapResetPointEvent.MAP_RESET, setArrowRotation);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_CASTLE_FIELD_UPDATE, onCastleFieldUpdate);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_CASTLE_UPDATE, onCastleUpdate);
            worldMap.addEventListener(WorldEvent.EVENT_MSG, onShowMsg);
            this.addEventListener(KeyboardEvent.KEY_DOWN, onMapKeyDown);
            if (MainWin.instance != null)
            {
                MainWin.instance.showNew.visible = false;
            };
            MouseManager.setNormal();
            this.addChild(arrowSignDisplay);
            this.arrowSignDisplay.x = 0;
            this.arrowSignDisplay.y = (this.height / 2);
            var _local_2:ArrayCollection = Context.getInstance().getPlayerBean().castleSignBeanArray;
            CoordinateData = _local_2;
            this.refresh();
            MainFrame.instance.showMapYet();
        }

        public function refresh():void
        {
            if (this.initialized)
            {
                trace((this.className + ".refresh()"));
                setcity();
                if (MainWin.instance != null)
                {
                    MainWin.instance.showNew.visible = false;
                };
            };
        }

        public function ___Map_CoordinatesUI1_onChangeClick(_arg_1:Event):void
        {
            this.changeGotoPoint(_arg_1.currentTarget.getRepeaterItem().x, _arg_1.currentTarget.getRepeaterItem().y, _arg_1.currentTarget.getRepeaterItem().name);
        }

        public function set gx(_arg_1:TextInput):void
        {
            var _local_2:Object = this._3313gx;
            if (_local_2 !== _arg_1)
            {
                this._3313gx = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gx", _local_2, _arg_1));
            };
        }

        public function set worldMap(_arg_1:WorldMap):void
        {
            var _local_2:Object = this._36212842worldMap;
            if (_local_2 !== _arg_1)
            {
                this._36212842worldMap = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "worldMap", _local_2, _arg_1));
            };
        }

        public function set gy(_arg_1:TextInput):void
        {
            var _local_2:Object = this._3314gy;
            if (_local_2 !== _arg_1)
            {
                this._3314gy = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gy", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _Map_Tile1():Tile
        {
            return (this._1741668577_Map_Tile1);
        }

        public function __gx_enter(_arg_1:FlexEvent):void
        {
            gotoPoint();
        }

        public function viewPoint(city_x:int, city_y:int):void
        {
            this.worldMap.setPoint(city_x, city_y);
            this.gx.text = city_x.toString();
            this.gy.text = city_y.toString();
            try
            {
                if (MapPos.instance != null)
                {
                    MapPos.instance.gx.text = city_x.toString();
                    MapPos.instance.gy.text = city_y.toString();
                };
            }
            catch(e:Error)
            {
            };
        }

        [Bindable(event="propertyChange")]
        public function get gx():TextInput
        {
            return (this._3313gx);
        }

        [Bindable(event="propertyChange")]
        public function get gy():TextInput
        {
            return (this._3314gy);
        }

        public function onMapKeyDown(event:KeyboardEvent):void
        {
            var isMapMove:Boolean;
            if (event.keyCode == Keyboard.UP)
            {
                isMapMove = true;
                this.worldMap.setPoint(worldMap.center_x, (worldMap.center_y - 2));
            }
            else
            {
                if (event.keyCode == Keyboard.DOWN)
                {
                    isMapMove = true;
                    this.worldMap.setPoint(worldMap.center_x, (worldMap.center_y + 2));
                }
                else
                {
                    if (event.keyCode == Keyboard.LEFT)
                    {
                        isMapMove = true;
                        this.worldMap.setPoint((worldMap.center_x - 2), worldMap.center_y);
                    }
                    else
                    {
                        if (event.keyCode == Keyboard.RIGHT)
                        {
                            isMapMove = true;
                            this.worldMap.setPoint((worldMap.center_x + 2), worldMap.center_y);
                        };
                    };
                };
            };
            if (isMapMove)
            {
                gx.text = String(worldMap.center_x);
                gy.text = String(worldMap.center_y);
                try
                {
                    if (MapPos.instance != null)
                    {
                        MapPos.instance.gx.text = String(worldMap.center_x);
                        MapPos.instance.gy.text = String(worldMap.center_y);
                    };
                }
                catch(e:Error)
                {
                };
            };
        }

        private function gotoPoint():void
        {
            this.worldMap.setPoint(int(gx.text), int(gy.text));
        }

        [Bindable(event="propertyChange")]
        public function get go():Button
        {
            return (this._3304go);
        }


    }
}//package view.castle

