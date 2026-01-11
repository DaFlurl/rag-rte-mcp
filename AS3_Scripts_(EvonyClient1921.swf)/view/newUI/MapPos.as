// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.newUI.MapPos

package view.newUI
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.TextInput;
    import mx.core.Repeater;
    import mx.containers.Tile;
    import com.evony.common.beans.CastleBean;
    import mx.collections.ArrayCollection;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import view.ui.CoordinatesUI;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.core.UIComponent;
    import view.castle.world.ArrowSign;
    import mx.core.mx_internal;
    import view.castle.Map;
    import com.evony.common.module.CommandResponse;
    import com.evony.Context;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import com.evony.common.module.castle.CastleSignResponse;
    import flash.events.TimerEvent;
    import mx.events.PropertyChangeEvent;
    import mx.events.FlexEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.MsgDispacther;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.common.MouseManager;
    import flash.events.Event;
    import com.evony.common.server.events.CastleFieldUpdate;
    import flash.events.MouseEvent;
    import flash.utils.Timer;
    import view.castle.MainFrame;
    import com.evony.Coordinate;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.server.events.CastleUpdate;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import view.castle.world.WorldEvent;
    import com.evony.events.MapResetPointEvent;
    import mx.binding.RepeatableBinding;
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

    public class MapPos extends Canvas implements IBindingClient 
    {

        public static var instance:MapPos;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _MapPos_Label1:Label;
        public var _MapPos_CoordinatesUI1:Array;
        private var level:String = "";
        private var _3313gx:TextInput;
        private var MCIsoperate:Boolean = false;
        private var type:String = "";
        private var _1180125369isShow:Boolean = false;
        private var _3646rp:Repeater;
        private var _14669033castleSign_Cmbox:Tile;
        private var _3314gy:TextInput;
        private var curCastle:CastleBean;
        private var _501536414CoordinateData:ArrayCollection;
        private var _114190243castleName:String;
        private var _3304go:Button;
        private var _399074949_MapPos_Tile1:Tile;
        private var CoordinateIsShow:Boolean = false;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":327,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Tile,
                        "id":"castleSign_Cmbox",
                        "stylesFactory":function ():void
                        {
                            this.borderColor = 10339019;
                            this.borderStyle = "solid";
                            this.cornerRadius = 3;
                            this.backgroundColor = 0x191919;
                            this.backgroundAlpha = 0.8;
                            this.right = "20";
                            this.fontSize = 10;
                            this.color = 0xFFFFFF;
                            this.horizontalGap = 0;
                            this.verticalGap = 0;
                            this.borderThickness = 1;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":200,
                                "y":30,
                                "width":200,
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
                                                "id":"_MapPos_CoordinatesUI1",
                                                "events":{
                                                    "onDeleteClick":"___MapPos_CoordinatesUI1_onDeleteClick",
                                                    "onChangeClick":"___MapPos_CoordinatesUI1_onChangeClick"
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.left = "0";
                            this.right = "0";
                            this.paddingLeft = 38;
                            this.paddingTop = 4;
                            this.backgroundSize = "100%";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":327,
                                "height":35,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "styleName":"MapCoordinateBg",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___MapPos_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"reFreshBtn",
                                            "useHandCursor":true,
                                            "buttonMode":true
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_MapPos_Label1",
                                    "events":{"click":"___MapPos_Label1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "11";
                                        this.textAlign = "center";
                                        this.color = 0xFFFFFF;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":110,
                                            "height":20,
                                            "styleName":"commonNormalColor",
                                            "useHandCursor":true,
                                            "buttonMode":true,
                                            "mouseChildren":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "text":"X",
                                            "width":18,
                                            "styleName":"MapCoordinate"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"gx",
                                    "events":{"enter":"__gx_enter"},
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0;
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "text":"0",
                                            "width":35,
                                            "height":20,
                                            "styleName":"MapCoordinateInp",
                                            "maxChars":3,
                                            "restrict":"0-9"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "text":"Y",
                                            "width":18,
                                            "styleName":"MapCoordinate"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"gy",
                                    "events":{"enter":"__gy_enter"},
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                        this.color = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "text":"0",
                                            "width":35,
                                            "height":20,
                                            "styleName":"MapCoordinateInp",
                                            "maxChars":3,
                                            "restrict":"0-9"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":5});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"go",
                                    "events":{"click":"__go_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "-10";
                                        this.right = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"MapCoordinateGo"});
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        private var arrowSignDisplay:UIComponent = new ArrowSign();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function MapPos()
        {
            mx_internal::_document = this;
            this.width = 327;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___MapPos_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            MapPos._watcherSetupUtil = _arg_1;
        }


        private function resetPoint():void
        {
            try
            {
                if (Map.instance != null)
                {
                    Map.instance.worldMap.resetPoint();
                };
            }
            catch(e:Error)
            {
            };
        }

        [Bindable(event="propertyChange")]
        public function get _MapPos_Tile1():Tile
        {
            return (this._399074949_MapPos_Tile1);
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

        private function timerRun(_arg_1:TimerEvent):void
        {
            if (CoordinateIsShow)
            {
                if (castleSign_Cmbox.height < 360)
                {
                    castleSign_Cmbox.height = (castleSign_Cmbox.height + (360 / 20));
                };
            }
            else
            {
                castleSign_Cmbox.height = (castleSign_Cmbox.height - (360 / 20));
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

        public function ___MapPos_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set _MapPos_Tile1(_arg_1:Tile):void
        {
            var _local_2:Object = this._399074949_MapPos_Tile1;
            if (_local_2 !== _arg_1)
            {
                this._399074949_MapPos_Tile1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_MapPos_Tile1", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:MapPos;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _MapPos_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_newUI_MapPosWatcherSetupUtil");
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
        public function get gx():TextInput
        {
            return (this._3313gx);
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

        [Bindable(event="propertyChange")]
        public function get castleSign_Cmbox():Tile
        {
            return (this._14669033castleSign_Cmbox);
        }

        private function init():void
        {
            instance = this;
            MsgDispacther.getInstance().addEventListener(Context.EVENT_CASTLE_CHANGE, onCurCastleChange);
            MsgDispacther.getInstance().addEventListener(Context.EVENT_CASTLE_MOVE, onCurCastleChange);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_CASTLE_FIELD_UPDATE, onCastleFieldUpdate);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_CASTLE_UPDATE, onCastleUpdate);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CASTLE_SAVE_CASTLE_SIGN_LIST, castle_saveCastle);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CASTLE_DELETE_CASTLE_SIGN, castle_deleteCastle);
            MouseManager.setNormal();
            var _local_1:ArrayCollection = Context.getInstance().getPlayerBean().castleSignBeanArray;
            CoordinateData = _local_1;
            this.refresh();
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

        public function ___MapPos_CoordinatesUI1_onDeleteClick(_arg_1:Event):void
        {
            this.deleteCoordinates(_arg_1.currentTarget.getRepeaterItem().id);
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

        private function onCastleFieldUpdate(_arg_1:CastleFieldUpdate):void
        {
            if (this.isShow)
            {
                this.refresh();
            };
        }

        public function ___MapPos_Label1_click(_arg_1:MouseEvent):void
        {
            showCoordinates();
        }

        public function __gy_enter(_arg_1:FlexEvent):void
        {
            gotoPoint();
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

        private function _MapPos_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = CoordinateData;
            _local_1 = rp.currentItem.name;
            _local_1 = ((rp.currentItem.x + ".") + rp.currentItem.y);
            _local_1 = this.castleName;
        }

        public function ___MapPos_CoordinatesUI1_onChangeClick(_arg_1:Event):void
        {
            this.changeGotoPoint(_arg_1.currentTarget.getRepeaterItem().x, _arg_1.currentTarget.getRepeaterItem().y, _arg_1.currentTarget.getRepeaterItem().name);
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

        private function set CoordinateData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._501536414CoordinateData;
            if (_local_2 !== _arg_1)
            {
                this._501536414CoordinateData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "CoordinateData", _local_2, _arg_1));
            };
        }

        private function setcity():void
        {
            if (((Map.instance == null) || (!(MainFrame.instance.currentView == Map.instance))))
            {
                return;
            };
            this.curCastle = Context.getInstance().getCurCastle();
            this.castleName = curCastle.name;
            var coo:Coordinate = new Coordinate(this.curCastle.fieldId);
            var x:int = coo.x;
            var y:int = coo.y;
            gx.text = String(x);
            gy.text = String(y);
            Map.instance.stopPlayAll();
            try
            {
                if (Map.instance != null)
                {
                    Map.instance.worldMap.setPoint(x, y);
                    Map.instance.worldMap.setCityPos(x, y);
                };
            }
            catch(e:Error)
            {
            };
        }

        public function __go_click(_arg_1:MouseEvent):void
        {
            gotoPoint();
        }

        public function deleteCoordinates(_arg_1:uint):void
        {
            ActionFactory.getInstance().getCastleSignCommand().deleteCastleSign(_arg_1);
        }

        public function refresh():void
        {
            if (this.initialized)
            {
                trace((this.className + ".refresh()"));
                setcity();
            };
        }

        [Bindable(event="propertyChange")]
        private function get castleName():String
        {
            return (this._114190243castleName);
        }

        private function resetCityPoint():void
        {
            setcity();
        }

        private function onCastleUpdate(_arg_1:CastleUpdate):void
        {
            if (this.isShow)
            {
                this.refresh();
            };
        }

        private function onCurCastleChange(_arg_1:Event):void
        {
            trace((this.className + ".onCurCastleChange()"));
            if (this.initialized)
            {
                this.refresh();
            };
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

        private function onMapKeyDown(event:KeyboardEvent):void
        {
            var isMapMove:Boolean;
            if (event.keyCode == Keyboard.UP)
            {
                isMapMove = true;
                try
                {
                    if (Map.instance != null)
                    {
                        Map.instance.worldMap.setPoint(Map.instance.worldMap.center_x, (Map.instance.worldMap.center_y - 2));
                    };
                }
                catch(e:Error)
                {
                };
            }
            else
            {
                if (event.keyCode == Keyboard.DOWN)
                {
                    isMapMove = true;
                    try
                    {
                        if (Map.instance != null)
                        {
                            Map.instance.worldMap.setPoint(Map.instance.worldMap.center_x, (Map.instance.worldMap.center_y + 2));
                        };
                    }
                    catch(e:Error)
                    {
                    };
                }
                else
                {
                    if (event.keyCode == Keyboard.LEFT)
                    {
                        isMapMove = true;
                        try
                        {
                            if (Map.instance != null)
                            {
                                Map.instance.worldMap.setPoint((Map.instance.worldMap.center_x - 2), Map.instance.worldMap.center_y);
                            };
                        }
                        catch(e:Error)
                        {
                        };
                    }
                    else
                    {
                        if (event.keyCode == Keyboard.RIGHT)
                        {
                            isMapMove = true;
                            try
                            {
                                if (Map.instance != null)
                                {
                                    Map.instance.worldMap.setPoint((Map.instance.worldMap.center_x + 2), Map.instance.worldMap.center_y);
                                };
                            }
                            catch(e:Error)
                            {
                            };
                        };
                    };
                };
            };
            if (isMapMove)
            {
                try
                {
                    if (Map.instance != null)
                    {
                        gx.text = String(Map.instance.worldMap.center_x);
                        gy.text = String(Map.instance.worldMap.center_y);
                    };
                }
                catch(e:Error)
                {
                };
            };
        }

        private function onShowMsg(_arg_1:WorldEvent):void
        {
            if (_arg_1.mapTile)
            {
            };
        }

        public function ___MapPos_Button1_click(_arg_1:MouseEvent):void
        {
            resetCityPoint();
        }

        [Bindable(event="propertyChange")]
        private function get CoordinateData():ArrayCollection
        {
            return (this._501536414CoordinateData);
        }

        private function castle_deleteCastle(_arg_1:CastleSignResponse):void
        {
            var _local_2:ArrayCollection = _arg_1.castleSignInfoArrArray;
            CoordinateData = _local_2;
            Context.getInstance().getPlayerBean().castleSignBeanArray = _local_2;
        }

        public function viewPoint(city_x:int, city_y:int):void
        {
            try
            {
                if (Map.instance != null)
                {
                    Map.instance.worldMap.setPoint(city_x, city_y);
                };
            }
            catch(e:Error)
            {
            };
            this.gx.text = city_x.toString();
            this.gy.text = city_y.toString();
        }

        private function setArrowRotation(_arg_1:MapResetPointEvent):void
        {
            var _local_2:Number = Number(_arg_1.getData());
        }

        private function gotoPoint():void
        {
            try
            {
                if (Map.instance != null)
                {
                    Map.instance.worldMap.setPoint(int(gx.text), int(gy.text));
                    Map.instance.worldMap.updateVisibleTiles();
                };
            }
            catch(e:Error)
            {
            };
        }

        private function _MapPos_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (CoordinateData);
            }, function (_arg_1:Object):void
            {
                rp.dataProvider = _arg_1;
            }, "rp.dataProvider");
            result[0] = binding;
            binding = new RepeatableBinding(this, function (_arg_1:Array, _arg_2:Array):String
            {
                var _local_3:* = rp.mx_internal::getItemAt(_arg_2[0]).name;
                var _local_4:* = ((_local_3 == undefined) ? null : String(_local_3));
                return (_local_4);
            }, function (_arg_1:String, _arg_2:Array):void
            {
                _MapPos_CoordinatesUI1[_arg_2[0]].cityname = _arg_1;
            }, "_MapPos_CoordinatesUI1.cityname");
            result[1] = binding;
            binding = new RepeatableBinding(this, function (_arg_1:Array, _arg_2:Array):String
            {
                var _local_3:* = ((rp.mx_internal::getItemAt(_arg_2[0]).x + ".") + rp.mx_internal::getItemAt(_arg_2[0]).y);
                var _local_4:* = ((_local_3 == undefined) ? null : String(_local_3));
                return (_local_4);
            }, function (_arg_1:String, _arg_2:Array):void
            {
                _MapPos_CoordinatesUI1[_arg_2[0]].cityXY = _arg_1;
            }, "_MapPos_CoordinatesUI1.cityXY");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.castleName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MapPos_Label1.text = _arg_1;
            }, "_MapPos_Label1.text");
            result[3] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get go():Button
        {
            return (this._3304go);
        }

        public function __gx_enter(_arg_1:FlexEvent):void
        {
            gotoPoint();
        }

        [Bindable(event="propertyChange")]
        public function get gy():TextInput
        {
            return (this._3314gy);
        }


    }
}//package view.newUI

