// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleList.ArmyInColonie

package view.castleList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.module.office.ColonizeTroopItem;
    import mx.controls.Label;
    import flash.utils.Timer;
    import mx.controls.Button;
    import com.evony.common.beans.CastleBean;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.controls.Image;
    import view.ui.MyHRule;
    import mx.controls.VRule;
    import mx.containers.VBox;
    import mx.controls.Text;
    import com.evony.common.beans.TroopBean;
    import mx.core.mx_internal;
    import com.evony.Lang;
    import mx.events.PropertyChangeEvent;
    import flash.events.TimerEvent;
    import mx.events.FlexEvent;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import mx.managers.PopUpManager;
    import flash.events.MouseEvent;
    import com.evony.client.action.ActionFactory;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.beans.ColonyBean;
    import flash.events.Event;
    import com.evony.common.module.colony.ColonialDeployResponse;
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

    public class ArmyInColonie extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1671895235heavyCavalry:ColonizeTroopItem;
        public var _ArmyInColonie_Label1:Label;
        public var _ArmyInColonie_Label2:Label;
        private var _339147856showItem:Boolean = false;
        private var _678927291percent:Number = 0.001;
        private var _982634288tooltips:String;
        private var timer:Timer;
        private var endTime:Number;
        private var _1409605757archer:ColonizeTroopItem;
        private var _1062697427militia:ColonizeTroopItem;
        private var _1914804330ballista:ColonizeTroopItem;
        private var _5304340carriage:ColonizeTroopItem;
        private var _2135247928batteringRam:ColonizeTroopItem;
        public var _ArmyInColonie_Button2:Button;
        private var _570808349pikemen:ColonizeTroopItem;
        private var _500112759reduceEnable:Boolean = false;
        private var _47090712catapult:ColonizeTroopItem;
        private var _1767743441currentCastle:CastleBean;
        private var _953891597spaceTime:Number;
        private var _331737559addHandle:Boolean;
        private var nowTime:Number;
        private var _1821715860lightCavalry:ColonizeTroopItem;
        private var _1924105259scouter:ColonizeTroopItem;
        private var targetCastleId:int;
        private var _1495860549btnEnabled:Boolean = false;
        private var _43947821peasants:ColonizeTroopItem;
        private var _1669530624swordsmen:ColonizeTroopItem;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "2";
                            this.left = "0";
                            this.right = "0";
                            this.verticalAlign = "middle";
                            this.horizontalAlign = "center";
                            this.horizontalGap = 10;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___ArmyInColonie_Button1_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"y125",
                                            "label":"Cancel",
                                            "x":40,
                                            "width":125,
                                            "y":472
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_ArmyInColonie_Button2",
                                    "events":{"click":"___ArmyInColonie_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"y125",
                                            "x":310,
                                            "width":125,
                                            "label":"Save Changes",
                                            "y":472
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.left = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"doubleLineBlue",
                                "height":290,
                                "width":320
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.left = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":22,
                                "styleName":"textBackGroundFillColor",
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "width":190,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ArmyInColonie_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.fontSize = 13;
                                        this.left = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"focusColor",
                                            "y":2
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.left = "190";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":22,
                                "styleName":"textBackGroundFillColor",
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "width":130,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ArmyInColonie_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.fontSize = 13;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"focusColor",
                                            "y":2
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "stylesFactory":function ():void
                        {
                            this.left = "190";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":22,
                                "source":"controls/DataGrid/separators.png"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":264,
                                "width":315
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":242,
                                "width":315
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":220,
                                "width":315
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":198,
                                "width":315
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":176,
                                "width":315
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":154,
                                "width":315
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":132,
                                "width":315
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":110,
                                "width":315
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":88,
                                "width":315
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":66,
                                "width":315
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":44,
                                "width":315
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":22,
                                "width":315
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "190";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineVrule",
                                "width":1,
                                "height":260,
                                "y":22
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 0;
                            this.left = "0";
                            this.right = "450";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":22,
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":ColonizeTroopItem,
                                    "id":"peasants",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ColonizeTroopItem,
                                    "id":"militia",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ColonizeTroopItem,
                                    "id":"scouter",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ColonizeTroopItem,
                                    "id":"pikemen",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ColonizeTroopItem,
                                    "id":"swordsmen",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ColonizeTroopItem,
                                    "id":"archer",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ColonizeTroopItem,
                                    "id":"lightCavalry",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ColonizeTroopItem,
                                    "id":"heavyCavalry",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ColonizeTroopItem,
                                    "id":"carriage",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ColonizeTroopItem,
                                    "id":"ballista",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ColonizeTroopItem,
                                    "id":"batteringRam",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ColonizeTroopItem,
                                    "id":"catapult",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":22});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.left = "330";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":290,
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "60";
                                        this.left = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "htmlText":"You can set a percentage of the troops in your Suzerain city, as the suppression Army.  Suppression Army will fight for you against any Uprise Army.",
                                            "styleName":"ParamgraphText1",
                                            "selectable":false,
                                            "height":110,
                                            "width":250
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "150";
                                        this.left = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "htmlText":"You need to click Button 'Save Changes' to save changes.  There's a 5-hour cool down for every troops setting modification. ",
                                            "styleName":"ParamgraphText1",
                                            "selectable":false,
                                            "width":250
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var timeCount:Timer = new Timer(1000);
        private var _110634834troop:TroopBean = new TroopBean();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ArmyInColonie()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.styleName = "baseBackGround";
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___ArmyInColonie_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ArmyInColonie._watcherSetupUtil = _arg_1;
        }


        private function secondToString(_arg_1:Number):String
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_2:* = "";
            if (_arg_1 >= 0)
            {
                _local_3 = int((_arg_1 / (60 * 60)));
                if (_local_3 > 0)
                {
                    _local_2 = (_local_2 + ((_local_3 + Lang.msg("时")) + " "));
                };
                _local_4 = int(((_arg_1 / 60) % 60));
                if (((_local_2.length > 0) || (_local_4 > 0)))
                {
                    _local_2 = (_local_2 + ((_local_4 + Lang.msg("分")) + " "));
                };
                if (_local_3 == 0)
                {
                    _local_5 = (_arg_1 % 60);
                    if (_local_5 < 10)
                    {
                        _local_2 = (_local_2 + "0");
                    };
                    _local_2 = (_local_2 + (_local_5 + Lang.msg("秒")));
                };
            };
            return (_local_2);
        }

        [Bindable(event="propertyChange")]
        private function get spaceTime():Number
        {
            return (this._953891597spaceTime);
        }

        public function set archer(_arg_1:ColonizeTroopItem):void
        {
            var _local_2:Object = this._1409605757archer;
            if (_local_2 !== _arg_1)
            {
                this._1409605757archer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "archer", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get swordsmen():ColonizeTroopItem
        {
            return (this._1669530624swordsmen);
        }

        private function set spaceTime(_arg_1:Number):void
        {
            var _local_2:Object = this._953891597spaceTime;
            if (_local_2 !== _arg_1)
            {
                this._953891597spaceTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "spaceTime", _local_2, _arg_1));
            };
        }

        private function showToolTips():String
        {
            var _local_1:* = "";
            if (!reduceEnable)
            {
                _local_1 = (("You can modify your deploying troops again in " + secondToString((endTime / 1000))) + " .");
            };
            return (_local_1);
        }

        public function set swordsmen(_arg_1:ColonizeTroopItem):void
        {
            var _local_2:Object = this._1669530624swordsmen;
            if (_local_2 !== _arg_1)
            {
                this._1669530624swordsmen = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "swordsmen", _local_2, _arg_1));
            };
        }

        private function set reduceEnable(_arg_1:Boolean):void
        {
            var _local_2:Object = this._500112759reduceEnable;
            if (_local_2 !== _arg_1)
            {
                this._500112759reduceEnable = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "reduceEnable", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get carriage():ColonizeTroopItem
        {
            return (this._5304340carriage);
        }

        public function init():void
        {
            refresh();
        }

        [Bindable(event="propertyChange")]
        public function get catapult():ColonizeTroopItem
        {
            return (this._47090712catapult);
        }

        private function _ArmyInColonie_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = reduceEnable;
            _local_1 = this.tooltips;
            _local_1 = Lang.msg("兵种");
            _local_1 = Lang.msg("数量");
            _local_1 = Lang.msg("民夫");
            _local_1 = this.troop.peasants;
            _local_1 = this.showItem;
            _local_1 = addHandle;
            _local_1 = Lang.msg("义兵");
            _local_1 = this.troop.militia;
            _local_1 = this.showItem;
            _local_1 = addHandle;
            _local_1 = Lang.msg("斥候");
            _local_1 = this.troop.scouter;
            _local_1 = this.showItem;
            _local_1 = addHandle;
            _local_1 = Lang.msg("枪兵");
            _local_1 = this.troop.pikemen;
            _local_1 = this.showItem;
            _local_1 = addHandle;
            _local_1 = Lang.msg("刀盾兵");
            _local_1 = this.troop.swordsmen;
            _local_1 = this.showItem;
            _local_1 = addHandle;
            _local_1 = Lang.msg("弓箭手");
            _local_1 = this.troop.archer;
            _local_1 = this.showItem;
            _local_1 = addHandle;
            _local_1 = Lang.msg("轻骑兵");
            _local_1 = this.troop.lightCavalry;
            _local_1 = this.showItem;
            _local_1 = addHandle;
            _local_1 = Lang.msg("铁骑兵");
            _local_1 = this.troop.heavyCavalry;
            _local_1 = this.showItem;
            _local_1 = addHandle;
            _local_1 = Lang.msg("辎重车");
            _local_1 = this.troop.carriage;
            _local_1 = this.showItem;
            _local_1 = addHandle;
            _local_1 = Lang.msg("车弩");
            _local_1 = this.troop.ballista;
            _local_1 = this.showItem;
            _local_1 = addHandle;
            _local_1 = Lang.msg("冲车");
            _local_1 = this.troop.batteringRam;
            _local_1 = this.showItem;
            _local_1 = addHandle;
            _local_1 = Lang.msg("投石车");
            _local_1 = this.troop.catapult;
            _local_1 = this.showItem;
            _local_1 = addHandle;
        }

        public function set carriage(_arg_1:ColonizeTroopItem):void
        {
            var _local_2:Object = this._5304340carriage;
            if (_local_2 !== _arg_1)
            {
                this._5304340carriage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "carriage", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get addHandle():Boolean
        {
            return (this._331737559addHandle);
        }

        private function onTimeCount(_arg_1:TimerEvent):void
        {
            endTime = (endTime - 1000);
            if (endTime <= 0)
            {
                this.reduceEnable = true;
                this.timeCount.stop();
                this.timeCount.removeEventListener(TimerEvent.TIMER, onTimeCount);
                this.tooltips = "";
            }
            else
            {
                this.tooltips = showToolTips();
            };
        }

        [Bindable(event="propertyChange")]
        public function get scouter():ColonizeTroopItem
        {
            return (this._1924105259scouter);
        }

        public function ___ArmyInColonie_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set catapult(_arg_1:ColonizeTroopItem):void
        {
            var _local_2:Object = this._47090712catapult;
            if (_local_2 !== _arg_1)
            {
                this._47090712catapult = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "catapult", _local_2, _arg_1));
            };
        }

        public function set ballista(_arg_1:ColonizeTroopItem):void
        {
            var _local_2:Object = this._1914804330ballista;
            if (_local_2 !== _arg_1)
            {
                this._1914804330ballista = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ballista", _local_2, _arg_1));
            };
        }

        public function set lightCavalry(_arg_1:ColonizeTroopItem):void
        {
            var _local_2:Object = this._1821715860lightCavalry;
            if (_local_2 !== _arg_1)
            {
                this._1821715860lightCavalry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lightCavalry", _local_2, _arg_1));
            };
        }

        private function troopAddResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                refresh();
                AlertWin.show(Lang.msg("保存成功"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get troop():TroopBean
        {
            return (this._110634834troop);
        }

        public function onClose():void
        {
            if (timeCount != null)
            {
                this.timeCount.stop();
                this.timeCount.removeEventListener(TimerEvent.TIMER, onTimeCount);
                this.timeCount = null;
            };
            PopUpManager.removePopUp(this);
        }

        public function set scouter(_arg_1:ColonizeTroopItem):void
        {
            var _local_2:Object = this._1924105259scouter;
            if (_local_2 !== _arg_1)
            {
                this._1924105259scouter = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scouter", _local_2, _arg_1));
            };
        }

        private function set addHandle(_arg_1:Boolean):void
        {
            var _local_2:Object = this._331737559addHandle;
            if (_local_2 !== _arg_1)
            {
                this._331737559addHandle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "addHandle", _local_2, _arg_1));
            };
        }

        public function ___ArmyInColonie_Button1_click(_arg_1:MouseEvent):void
        {
            refresh();
        }

        [Bindable(event="propertyChange")]
        private function get percent():Number
        {
            return (this._678927291percent);
        }

        private function set showItem(_arg_1:Boolean):void
        {
            var _local_2:Object = this._339147856showItem;
            if (_local_2 !== _arg_1)
            {
                this._339147856showItem = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showItem", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get archer():ColonizeTroopItem
        {
            return (this._1409605757archer);
        }

        [Bindable(event="propertyChange")]
        private function get reduceEnable():Boolean
        {
            return (this._500112759reduceEnable);
        }

        [Bindable(event="propertyChange")]
        private function get btnEnabled():Boolean
        {
            return (this._1495860549btnEnabled);
        }

        public function set heavyCavalry(_arg_1:ColonizeTroopItem):void
        {
            var _local_2:Object = this._1671895235heavyCavalry;
            if (_local_2 !== _arg_1)
            {
                this._1671895235heavyCavalry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heavyCavalry", _local_2, _arg_1));
            };
        }

        private function send():void
        {
            var _local_1:TroopBean = new TroopBean();
            _local_1.peasants = Math.abs(int(peasants.txtInput.text));
            _local_1.militia = Math.abs(int(militia.txtInput.text));
            _local_1.scouter = Math.abs(int(scouter.txtInput.text));
            _local_1.pikemen = Math.abs(int(pikemen.txtInput.text));
            _local_1.swordsmen = Math.abs(int(swordsmen.txtInput.text));
            _local_1.archer = Math.abs(int(archer.txtInput.text));
            _local_1.lightCavalry = Math.abs(int(lightCavalry.txtInput.text));
            _local_1.heavyCavalry = Math.abs(int(heavyCavalry.txtInput.text));
            _local_1.carriage = Math.abs(int(carriage.txtInput.text));
            _local_1.ballista = Math.abs(int(ballista.txtInput.text));
            _local_1.batteringRam = Math.abs(int(batteringRam.txtInput.text));
            _local_1.catapult = Math.abs(int(catapult.txtInput.text));
            ActionFactory.getInstance().getColonyCommands().setDeployTroops(currentCastle.id, targetCastleId, _local_1, troopAddResponse);
        }

        private function set percent(_arg_1:Number):void
        {
            var _local_2:Object = this._678927291percent;
            if (_local_2 !== _arg_1)
            {
                this._678927291percent = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "percent", _local_2, _arg_1));
            };
        }

        public function set setCastleBean(_arg_1:CastleBean):void
        {
            this.currentCastle = _arg_1;
        }

        override public function initialize():void
        {
            var target:ArmyInColonie;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ArmyInColonie_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleList_ArmyInColonieWatcherSetupUtil");
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

        private function set btnEnabled(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1495860549btnEnabled;
            if (_local_2 !== _arg_1)
            {
                this._1495860549btnEnabled = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnEnabled", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get ballista():ColonizeTroopItem
        {
            return (this._1914804330ballista);
        }

        private function set currentCastle(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._1767743441currentCastle;
            if (_local_2 !== _arg_1)
            {
                this._1767743441currentCastle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentCastle", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get lightCavalry():ColonizeTroopItem
        {
            return (this._1821715860lightCavalry);
        }

        public function ___ArmyInColonie_Button2_click(_arg_1:MouseEvent):void
        {
            send();
        }

        public function set militia(_arg_1:ColonizeTroopItem):void
        {
            var _local_2:Object = this._1062697427militia;
            if (_local_2 !== _arg_1)
            {
                this._1062697427militia = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "militia", _local_2, _arg_1));
            };
        }

        public function set batteringRam(_arg_1:ColonizeTroopItem):void
        {
            var _local_2:Object = this._2135247928batteringRam;
            if (_local_2 !== _arg_1)
            {
                this._2135247928batteringRam = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "batteringRam", _local_2, _arg_1));
            };
        }

        private function _ArmyInColonie_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (reduceEnable);
            }, function (_arg_1:Boolean):void
            {
                _ArmyInColonie_Button2.enabled = _arg_1;
            }, "_ArmyInColonie_Button2.enabled");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.tooltips;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInColonie_Button2.toolTip = _arg_1;
            }, "_ArmyInColonie_Button2.toolTip");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("兵种");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInColonie_Label1.text = _arg_1;
            }, "_ArmyInColonie_Label1.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInColonie_Label2.text = _arg_1;
            }, "_ArmyInColonie_Label2.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("民夫");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                peasants.itemName = _arg_1;
            }, "peasants.itemName");
            result[4] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troop.peasants);
            }, function (_arg_1:int):void
            {
                peasants.baseNum = _arg_1;
            }, "peasants.baseNum");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showItem);
            }, function (_arg_1:Boolean):void
            {
                peasants.showItem = _arg_1;
            }, "peasants.showItem");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (addHandle);
            }, function (_arg_1:Boolean):void
            {
                peasants.addHandle = _arg_1;
            }, "peasants.addHandle");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("义兵");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                militia.itemName = _arg_1;
            }, "militia.itemName");
            result[8] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troop.militia);
            }, function (_arg_1:int):void
            {
                militia.baseNum = _arg_1;
            }, "militia.baseNum");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showItem);
            }, function (_arg_1:Boolean):void
            {
                militia.showItem = _arg_1;
            }, "militia.showItem");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (addHandle);
            }, function (_arg_1:Boolean):void
            {
                militia.addHandle = _arg_1;
            }, "militia.addHandle");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("斥候");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                scouter.itemName = _arg_1;
            }, "scouter.itemName");
            result[12] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troop.scouter);
            }, function (_arg_1:int):void
            {
                scouter.baseNum = _arg_1;
            }, "scouter.baseNum");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showItem);
            }, function (_arg_1:Boolean):void
            {
                scouter.showItem = _arg_1;
            }, "scouter.showItem");
            result[14] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (addHandle);
            }, function (_arg_1:Boolean):void
            {
                scouter.addHandle = _arg_1;
            }, "scouter.addHandle");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("枪兵");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                pikemen.itemName = _arg_1;
            }, "pikemen.itemName");
            result[16] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troop.pikemen);
            }, function (_arg_1:int):void
            {
                pikemen.baseNum = _arg_1;
            }, "pikemen.baseNum");
            result[17] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showItem);
            }, function (_arg_1:Boolean):void
            {
                pikemen.showItem = _arg_1;
            }, "pikemen.showItem");
            result[18] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (addHandle);
            }, function (_arg_1:Boolean):void
            {
                pikemen.addHandle = _arg_1;
            }, "pikemen.addHandle");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("刀盾兵");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                swordsmen.itemName = _arg_1;
            }, "swordsmen.itemName");
            result[20] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troop.swordsmen);
            }, function (_arg_1:int):void
            {
                swordsmen.baseNum = _arg_1;
            }, "swordsmen.baseNum");
            result[21] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showItem);
            }, function (_arg_1:Boolean):void
            {
                swordsmen.showItem = _arg_1;
            }, "swordsmen.showItem");
            result[22] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (addHandle);
            }, function (_arg_1:Boolean):void
            {
                swordsmen.addHandle = _arg_1;
            }, "swordsmen.addHandle");
            result[23] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("弓箭手");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                archer.itemName = _arg_1;
            }, "archer.itemName");
            result[24] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troop.archer);
            }, function (_arg_1:int):void
            {
                archer.baseNum = _arg_1;
            }, "archer.baseNum");
            result[25] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showItem);
            }, function (_arg_1:Boolean):void
            {
                archer.showItem = _arg_1;
            }, "archer.showItem");
            result[26] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (addHandle);
            }, function (_arg_1:Boolean):void
            {
                archer.addHandle = _arg_1;
            }, "archer.addHandle");
            result[27] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("轻骑兵");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                lightCavalry.itemName = _arg_1;
            }, "lightCavalry.itemName");
            result[28] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troop.lightCavalry);
            }, function (_arg_1:int):void
            {
                lightCavalry.baseNum = _arg_1;
            }, "lightCavalry.baseNum");
            result[29] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showItem);
            }, function (_arg_1:Boolean):void
            {
                lightCavalry.showItem = _arg_1;
            }, "lightCavalry.showItem");
            result[30] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (addHandle);
            }, function (_arg_1:Boolean):void
            {
                lightCavalry.addHandle = _arg_1;
            }, "lightCavalry.addHandle");
            result[31] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("铁骑兵");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heavyCavalry.itemName = _arg_1;
            }, "heavyCavalry.itemName");
            result[32] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troop.heavyCavalry);
            }, function (_arg_1:int):void
            {
                heavyCavalry.baseNum = _arg_1;
            }, "heavyCavalry.baseNum");
            result[33] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showItem);
            }, function (_arg_1:Boolean):void
            {
                heavyCavalry.showItem = _arg_1;
            }, "heavyCavalry.showItem");
            result[34] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (addHandle);
            }, function (_arg_1:Boolean):void
            {
                heavyCavalry.addHandle = _arg_1;
            }, "heavyCavalry.addHandle");
            result[35] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("辎重车");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                carriage.itemName = _arg_1;
            }, "carriage.itemName");
            result[36] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troop.carriage);
            }, function (_arg_1:int):void
            {
                carriage.baseNum = _arg_1;
            }, "carriage.baseNum");
            result[37] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showItem);
            }, function (_arg_1:Boolean):void
            {
                carriage.showItem = _arg_1;
            }, "carriage.showItem");
            result[38] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (addHandle);
            }, function (_arg_1:Boolean):void
            {
                carriage.addHandle = _arg_1;
            }, "carriage.addHandle");
            result[39] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("车弩");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                ballista.itemName = _arg_1;
            }, "ballista.itemName");
            result[40] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troop.ballista);
            }, function (_arg_1:int):void
            {
                ballista.baseNum = _arg_1;
            }, "ballista.baseNum");
            result[41] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showItem);
            }, function (_arg_1:Boolean):void
            {
                ballista.showItem = _arg_1;
            }, "ballista.showItem");
            result[42] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (addHandle);
            }, function (_arg_1:Boolean):void
            {
                ballista.addHandle = _arg_1;
            }, "ballista.addHandle");
            result[43] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("冲车");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                batteringRam.itemName = _arg_1;
            }, "batteringRam.itemName");
            result[44] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troop.batteringRam);
            }, function (_arg_1:int):void
            {
                batteringRam.baseNum = _arg_1;
            }, "batteringRam.baseNum");
            result[45] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showItem);
            }, function (_arg_1:Boolean):void
            {
                batteringRam.showItem = _arg_1;
            }, "batteringRam.showItem");
            result[46] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (addHandle);
            }, function (_arg_1:Boolean):void
            {
                batteringRam.addHandle = _arg_1;
            }, "batteringRam.addHandle");
            result[47] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("投石车");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                catapult.itemName = _arg_1;
            }, "catapult.itemName");
            result[48] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troop.catapult);
            }, function (_arg_1:int):void
            {
                catapult.baseNum = _arg_1;
            }, "catapult.baseNum");
            result[49] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showItem);
            }, function (_arg_1:Boolean):void
            {
                catapult.showItem = _arg_1;
            }, "catapult.showItem");
            result[50] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (addHandle);
            }, function (_arg_1:Boolean):void
            {
                catapult.addHandle = _arg_1;
            }, "catapult.addHandle");
            result[51] = binding;
            return (result);
        }

        public function set peasants(_arg_1:ColonizeTroopItem):void
        {
            var _local_2:Object = this._43947821peasants;
            if (_local_2 !== _arg_1)
            {
                this._43947821peasants = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "peasants", _local_2, _arg_1));
            };
        }

        public function set showArmyInColony(_arg_1:ColonyBean):void
        {
            this.targetCastleId = _arg_1.castleId;
        }

        private function set troop(_arg_1:TroopBean):void
        {
            var _local_2:Object = this._110634834troop;
            if (_local_2 !== _arg_1)
            {
                this._110634834troop = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troop", _local_2, _arg_1));
            };
        }

        private function troopReduceResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                refresh();
                AlertWin.show(Lang.msg("保存成功"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get showItem():Boolean
        {
            return (this._339147856showItem);
        }

        private function set tooltips(_arg_1:String):void
        {
            var _local_2:Object = this._982634288tooltips;
            if (_local_2 !== _arg_1)
            {
                this._982634288tooltips = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tooltips", _local_2, _arg_1));
            };
        }

        public function set pikemen(_arg_1:ColonizeTroopItem):void
        {
            var _local_2:Object = this._570808349pikemen;
            if (_local_2 !== _arg_1)
            {
                this._570808349pikemen = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pikemen", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heavyCavalry():ColonizeTroopItem
        {
            return (this._1671895235heavyCavalry);
        }

        [Bindable(event="propertyChange")]
        public function get batteringRam():ColonizeTroopItem
        {
            return (this._2135247928batteringRam);
        }

        [Bindable(event="propertyChange")]
        private function get currentCastle():CastleBean
        {
            return (this._1767743441currentCastle);
        }

        [Bindable(event="propertyChange")]
        public function get militia():ColonizeTroopItem
        {
            return (this._1062697427militia);
        }

        private function clickHandle(_arg_1:Event):void
        {
            if (_arg_1.target.label == "add")
            {
                addHandle = true;
            }
            else
            {
                addHandle = false;
            };
            showItem = true;
        }

        private function refresh():void
        {
            showItem = false;
            reduceEnable = false;
            ActionFactory.getInstance().getColonyCommands().getDeployTroopsInfo(currentCastle.id, targetCastleId, getDeployTroopsResponse);
        }

        [Bindable(event="propertyChange")]
        private function get tooltips():String
        {
            return (this._982634288tooltips);
        }

        private function endHandle(_arg_1:TimerEvent=null):void
        {
            reduceEnable = true;
            timer.stop();
            timer.removeEventListener(TimerEvent.TIMER, endHandle);
            timer = null;
        }

        [Bindable(event="propertyChange")]
        public function get pikemen():ColonizeTroopItem
        {
            return (this._570808349pikemen);
        }

        [Bindable(event="propertyChange")]
        public function get peasants():ColonizeTroopItem
        {
            return (this._43947821peasants);
        }

        private function getDeployTroopsResponse(_arg_1:ColonialDeployResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.troop = _arg_1.troopBean;
                endTime = _arg_1.reduceCoolDown;
                timeCount.addEventListener(TimerEvent.TIMER, onTimeCount);
                timeCount.start();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }


    }
}//package view.castleList

