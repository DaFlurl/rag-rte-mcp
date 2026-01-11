// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.ArmyDetailsWin

package autoevony.gui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.collections.ArrayCollection;
    import mx.controls.DataGrid;
    import mx.controls.ComboBox;
    import autoevony.gui.controls.popup.PopUpWinBase;
    import mx.controls.Label;
    import com.evony.common.beans.ArmyBean;
    import flash.utils.Timer;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import com.evony.common.constants.ArmyConstants;
    import autoevony.common.Utils;
    import autoevony.scripts.CityState;
    import com.evony.client.response.ResponseDispatcher;
    import autoevony.common.Items;
    import flash.events.TimerEvent;
    import mx.events.PropertyChangeEvent;
    import mx.controls.dataGridClasses.DataGridColumn;
    import flash.events.MouseEvent;
    import com.evony.common.beans.ItemBean;
    import mx.binding.Binding;
    import autoevony.player.Map;
    import com.evony.common.constants.TFConstants;
    import com.evony.common.beans.TroopBean;
    import mx.events.ListEvent;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.beans.FieldBean;
    import com.evony.common.beans.ColonyBean;
    import flash.utils.getDefinitionByName;
    import autoevony.event.popUpWinShowEvent;
    import com.evony.common.server.events.ItemUpdate;
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

    public class ArmyDetailsWin extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _ArmyDetailsWin_Text6:Text;
        public var _ArmyDetailsWin_Text7:Text;
        public var _ArmyDetailsWin_Text9:Text;
        public var _ArmyDetailsWin_Text8:Text;
        public var _ArmyDetailsWin_Text1:Text;
        private var _971377469itemSelectInfo:ArrayCollection = null;
        public var _ArmyDetailsWin_Text4:Text;
        public var _ArmyDetailsWin_DataGrid1:DataGrid;
        private var _617648668troopData:ArrayCollection = null;
        private var _342540263resoData:ArrayCollection = null;
        private var _1220405362_itemSelect:ComboBox;
        private var castleId:int;
        public var _ArmyDetailsWin_PopUpWinBase1:PopUpWinBase;
        public var _ArmyDetailsWin_Label9:Label;
        private var _3002781army:ArmyBean = null;
        private var _838170928armyLandsIn:String = "--:--:--";
        private var lastTime:Number = 0;
        public var _ArmyDetailsWin_Text10:Text;
        public var _ArmyDetailsWin_Text11:Text;
        private var armyId:int;
        private var updateTimeTimer:Timer = null;
        private var _1414939017armyType:String = null;
        public var _ArmyDetailsWin_Button2:Button;
        private var closeFunc:Function = null;
        private var _2127813052itemCount:int = 0;
        private var useFunc:Function = null;
        public var _ArmyDetailsWin_DataGrid2:DataGrid;
        public var _ArmyDetailsWin_Text2:Text;
        public var _ArmyDetailsWin_Text3:Text;
        public var _ArmyDetailsWin_Text5:Text;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":495,
                    "height":484,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":PopUpWinBase,
                        "id":"_ArmyDetailsWin_PopUpWinBase1",
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":Text,
                        "id":"_ArmyDetailsWin_Text1",
                        "stylesFactory":function ():void
                        {
                            this.left = "16";
                            this.top = "12";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":114,
                                "height":22,
                                "styleName":"newArmyTroop"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "15";
                            this.top = "50";
                            this.bottom = "15";
                            this.right = "15";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "0";
                                        this.top = "0";
                                        this.right = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":58,
                                            "styleName":"textBackground",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "3";
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "height":22,
                                                        "text":"From:",
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_ArmyDetailsWin_Text2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "50";
                                                    this.top = "3";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":250,
                                                        "height":22,
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "305";
                                                    this.top = "3";
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "height":22,
                                                        "text":"ETA:",
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_ArmyDetailsWin_Text3",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "350";
                                                    this.top = "3";
                                                    this.right = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":22,
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "28";
                                                    this.right = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":2,
                                                        "styleName":"horizontalSeparator2pxLine"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "33";
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "height":22,
                                                        "text":"To:",
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_ArmyDetailsWin_Text4",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "50";
                                                    this.top = "33";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":250,
                                                        "height":22,
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "305";
                                                    this.top = "33";
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "height":22,
                                                        "text":"In:",
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_ArmyDetailsWin_Text5",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "350";
                                                    this.top = "33";
                                                    this.right = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":22,
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "0";
                                        this.top = "65";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":230,
                                            "height":314,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"_ArmyDetailsWin_DataGrid1",
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
                                                        "minHeight":50,
                                                        "percentHeight":100,
                                                        "percentWidth":100,
                                                        "resizableColumns":true,
                                                        "rowHeight":24,
                                                        "variableRowHeight":true,
                                                        "selectable":false,
                                                        "showHeaders":true,
                                                        "sortableColumns":false,
                                                        "visible":true,
                                                        "wordWrap":false,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "columns":[_ArmyDetailsWin_DataGridColumn1_c(), _ArmyDetailsWin_DataGridColumn2_c()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "65";
                                        this.right = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":230,
                                            "height":163,
                                            "styleName":"textBackground",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "3";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":60,
                                                        "height":22,
                                                        "text":"Mission:",
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_ArmyDetailsWin_Text6",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "70";
                                                    this.top = "3";
                                                    this.right = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":22,
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "28";
                                                    this.right = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":2,
                                                        "styleName":"horizontalSeparator2pxLine"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "33";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":60,
                                                        "height":22,
                                                        "text":"Status:",
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_ArmyDetailsWin_Text7",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "70";
                                                    this.top = "33";
                                                    this.right = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":22,
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "58";
                                                    this.right = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":2,
                                                        "styleName":"horizontalSeparator2pxLine"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "63";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":60,
                                                        "height":22,
                                                        "text":"Lord:",
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_ArmyDetailsWin_Text8",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "70";
                                                    this.top = "63";
                                                    this.right = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":22,
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "88";
                                                    this.right = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":2,
                                                        "styleName":"horizontalSeparator2pxLine"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "93";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":60,
                                                        "height":22,
                                                        "text":"Alliance:",
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_ArmyDetailsWin_Text9",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "70";
                                                    this.top = "93";
                                                    this.right = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":22,
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "118";
                                                    this.right = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":2,
                                                        "styleName":"horizontalSeparator2pxLine"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ArmyDetailsWin_Label9",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "123";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":60,
                                                        "height":22,
                                                        "text":"Hero:",
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_ArmyDetailsWin_Text10",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "70";
                                                    this.top = "123";
                                                    this.right = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":22,
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "233";
                                        this.right = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":230,
                                            "height":146,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"_ArmyDetailsWin_DataGrid2",
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
                                                        "minHeight":50,
                                                        "percentHeight":100,
                                                        "percentWidth":100,
                                                        "resizableColumns":true,
                                                        "rowHeight":24,
                                                        "variableRowHeight":true,
                                                        "selectable":false,
                                                        "showHeaders":true,
                                                        "sortableColumns":false,
                                                        "visible":true,
                                                        "wordWrap":false,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "columns":[_ArmyDetailsWin_DataGridColumn3_c(), _ArmyDetailsWin_DataGridColumn4_c()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "0";
                                        this.right = "0";
                                        this.bottom = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":35,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":ComboBox,
                                                "id":"_itemSelect",
                                                "events":{"change":"___itemSelect_change"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "8";
                                                    this.left = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":230,
                                                        "height":22,
                                                        "styleName":"ComboBox"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___ArmyDetailsWin_Button1_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "8";
                                                    this.left = "240";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Use Stratagem",
                                                        "styleName":"REwinBtn"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_ArmyDetailsWin_Text11",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "350";
                                                    this.top = "10";
                                                    this.textAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":22,
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_ArmyDetailsWin_Button2",
                                                "events":{"click":"___ArmyDetailsWin_Button2_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "8";
                                                    this.right = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Recall",
                                                        "styleName":"REwinBtn"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___ArmyDetailsWin_Button3_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "7";
                            this.right = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ArmyDetailsWin()
        {
            mx_internal::_document = this;
            this.width = 495;
            this.height = 484;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ArmyDetailsWin._watcherSetupUtil = _arg_1;
        }


        private function canRecall(_arg_1:int):Boolean
        {
            if ((((this.armyType == "self") || (this.armyType == "local")) && ((_arg_1 == ArmyConstants.ARMY_FORWARD) || (_arg_1 == ArmyConstants.ARMY_STAY))))
            {
                return (true);
            };
            if (((this.armyType == "friendly") && (_arg_1 == ArmyConstants.ARMY_STAY)))
            {
                return (true);
            };
            return (false);
        }

        private function onArmyUpdates(_arg_1:Object=null):void
        {
            Utils.callLater(100, this.updateArmy);
        }

        private function updateResoData():void
        {
            if (this.resoData == null)
            {
                this.resoData = new ArrayCollection();
            }
            else
            {
                this.resoData.removeAll();
            };
            if (this.army.resource == null)
            {
                return;
            };
            if (this.army.resource.gold)
            {
                this.resoData.addItem({
                    "type":"Gold",
                    "amount":Utils.formatNum(this.army.resource.gold, 0)
                });
            };
            if (this.army.resource.food)
            {
                this.resoData.addItem({
                    "type":"Food",
                    "amount":Utils.formatNum(this.army.resource.food, 0)
                });
            };
            if (this.army.resource.wood)
            {
                this.resoData.addItem({
                    "type":"Lumber",
                    "amount":Utils.formatNum(this.army.resource.wood, 0)
                });
            };
            if (this.army.resource.stone)
            {
                this.resoData.addItem({
                    "type":"Stone",
                    "amount":Utils.formatNum(this.army.resource.stone, 0)
                });
            };
            if (this.army.resource.iron)
            {
                this.resoData.addItem({
                    "type":"Iron",
                    "amount":Utils.formatNum(this.army.resource.iron, 0)
                });
            };
        }

        private function getArmy(_arg_1:int, _arg_2:String):ArmyBean
        {
            var _local_4:ArmyBean;
            var _local_3:CityState = MainScreen.getCityFromCastleId(this.castleId);
            if (_local_3 == null)
            {
                return (null);
            };
            for each (_local_4 in _local_3.cityManager[(_arg_2 + "Armies")])
            {
                if (_local_4.armyId == _arg_1)
                {
                    return (_local_4);
                };
            };
            if (_arg_2 == "enemy")
            {
                for each (_local_4 in _local_3.cityManager.enemyValleyArmies)
                {
                    if (_local_4.armyId == _arg_1)
                    {
                        return (_local_4);
                    };
                };
                for each (_local_4 in _local_3.cityManager.enemyColonyArmies)
                {
                    if (_local_4.armyId == _arg_1)
                    {
                        return (_local_4);
                    };
                };
            };
            return (null);
        }

        public function updateInfo(_arg_1:Array, _arg_2:Function=null):void
        {
            this.castleId = _arg_1[0];
            this.armyId = _arg_1[1];
            this.armyType = _arg_1[2];
            this.useFunc = _arg_1[3];
            this.closeFunc = _arg_2;
            this.updateArmy();
            if (this.army == null)
            {
                return;
            };
            if (((this.armyType == "self") || (this.armyType == "local")))
            {
                ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE, this.onArmyUpdates);
            }
            else
            {
                if (this.armyType == "friendly")
                {
                    ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_FRIEND_ARMYS_UPDATE, this.onArmyUpdates);
                }
                else
                {
                    if (this.armyType == "enemy")
                    {
                        ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_ENEMY_ARMYS_UPDATE, this.onArmyUpdates);
                    };
                };
            };
            this.updateTroopData();
            this.updateResoData();
            if (((this.armyType == "enemy") || (this.armyType == "friendly")))
            {
                this.itemSelectInfo = new ArrayCollection([{
                    "label":Items.getItemName("player.trick.bmjs").split("_").join(" "),
                    "data":"player.trick.bmjs"
                }, {
                    "label":Items.getItemName("player.trick.gmdg").split("_").join(" "),
                    "data":"player.trick.gmdg"
                }, {
                    "label":Items.getItemName("player.trick.ydsr").split("_").join(" "),
                    "data":"player.trick.ydsr"
                }]);
            }
            else
            {
                if (((this.armyType == "self") || (this.armyType == "local")))
                {
                    this.itemSelectInfo = new ArrayCollection([{
                        "label":Items.getItemName("player.trick.jctq").split("_").join(" "),
                        "data":"player.trick.jctq"
                    }, {
                        "label":Items.getItemName("player.trick.qlbx").split("_").join(" "),
                        "data":"player.trick.qlbx"
                    }, {
                        "label":Items.getItemName("player.trick.xzxs").split("_").join(" "),
                        "data":"player.trick.xzxs"
                    }, {
                        "label":Items.getItemName("player.trick.yqxg").split("_").join(" "),
                        "data":"player.trick.yqxg"
                    }]);
                };
            };
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE, this.onItemUpdate);
            Utils.callLater(50, this.updateItemCount);
            this.updateTimeTimer = new Timer(1000);
            this.updateTimeTimer.addEventListener(TimerEvent.TIMER, this.updateReachTime);
            this.updateTimeTimer.start();
        }

        [Bindable(event="propertyChange")]
        private function get resoData():ArrayCollection
        {
            return (this._342540263resoData);
        }

        public function set _itemSelect(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._1220405362_itemSelect;
            if (_local_2 !== _arg_1)
            {
                this._1220405362_itemSelect = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_itemSelect", _local_2, _arg_1));
            };
        }

        private function updateReachTime(_arg_1:TimerEvent=null):void
        {
            this.armyLandsIn = ((this.army.reachTime > 0) ? Utils.formatEndTime(this.army.reachTime) : "--:--:--");
        }

        [Bindable(event="propertyChange")]
        private function get troopData():ArrayCollection
        {
            return (this._617648668troopData);
        }

        private function _ArmyDetailsWin_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Amount";
            _local_1.dataField = "amount";
            _local_1.showDataTips = true;
            return (_local_1);
        }

        private function updateArmy():void
        {
            if (this.armyType == null)
            {
                return;
            };
            this.army = this.getArmy(this.armyId, this.armyType);
            if (this.army == null)
            {
                this.close();
            };
        }

        private function set resoData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._342540263resoData;
            if (_local_2 !== _arg_1)
            {
                this._342540263resoData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resoData", _local_2, _arg_1));
            };
        }

        public function ___ArmyDetailsWin_Button1_click(_arg_1:MouseEvent):void
        {
            this.onApplyStratBtn();
        }

        [Bindable(event="propertyChange")]
        private function get itemSelectInfo():ArrayCollection
        {
            return (this._971377469itemSelectInfo);
        }

        private function getItemCount(_arg_1:String):int
        {
            var _local_2:ItemBean;
            for each (_local_2 in MainScreen.getPlayer().itemsArray)
            {
                if (((!(_local_2.id == null)) && (_local_2.id == _arg_1)))
                {
                    return (Math.max(_local_2.count, 0));
                };
            };
            return (0);
        }

        public function ___ArmyDetailsWin_Button2_click(_arg_1:MouseEvent):void
        {
            this.onRecallBtn();
        }

        private function set army(_arg_1:ArmyBean):void
        {
            var _local_2:Object = this._3002781army;
            if (_local_2 !== _arg_1)
            {
                this._3002781army = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "army", _local_2, _arg_1));
            };
        }

        private function _ArmyDetailsWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((((!(this.armyType == null)) && (!(this.armyType == ""))) ? (this.armyType.charAt(0).toUpperCase() + this.armyType.substr(1)) : "") + "Army Details");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_PopUpWinBase1.windowTitle = _arg_1;
            }, "_ArmyDetailsWin_PopUpWinBase1.windowTitle");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (("[   " + this.army.armyId) + "   ]");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Text1.text = _arg_1;
            }, "_ArmyDetailsWin_Text1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((((this.army.startFieldId < 0) ? "(unknown)" : Map.fieldIdToString(this.army.startFieldId)) + " ") + ((this.army.startPosName == null) ? "(unknown)" : this.army.startPosName));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Text2.text = _arg_1;
            }, "_ArmyDetailsWin_Text2.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.army.reachTime > 0) ? Utils.getTimeStr(this.army.reachTime) : "--:--:--");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Text3.text = _arg_1;
            }, "_ArmyDetailsWin_Text3.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Map.fieldIdToString(this.army.targetFieldId) + " ") + (((!(this.army.targetPosName == null)) && (!(this.army.targetPosName == ""))) ? this.army.targetPosName : this.getTarget(this.army.targetFieldId)));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Text4.text = _arg_1;
            }, "_ArmyDetailsWin_Text4.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.armyLandsIn;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Text5.text = _arg_1;
            }, "_ArmyDetailsWin_Text5.text");
            result[5] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.troopData);
            }, function (_arg_1:Object):void
            {
                _ArmyDetailsWin_DataGrid1.dataProvider = _arg_1;
            }, "_ArmyDetailsWin_DataGrid1.dataProvider");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (((this.armyType == "local") ? "" : (this.armyType.charAt(0) + "-")) + (((this.army.missionType > 0) && (this.army.missionType < Utils.MISSION_NAMES.length)) ? this.getMission(this.army.missionType) : "(unknown"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Text6.text = _arg_1;
            }, "_ArmyDetailsWin_Text6.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.army.direction == ArmyConstants.ARMY_FORWARD) ? "marching" : ((this.army.direction == ArmyConstants.ARMY_BACKWARD) ? "returning" : ((this.army.direction == ArmyConstants.ARMY_STAY) ? "camped" : "")));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Text7.text = _arg_1;
            }, "_ArmyDetailsWin_Text7.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.army.king == null) ? "(unknown)" : this.army.king);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Text8.text = _arg_1;
            }, "_ArmyDetailsWin_Text8.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.army.alliance;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Text9.text = _arg_1;
            }, "_ArmyDetailsWin_Text9.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("HeroId: " + this.army.heroid);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Label9.toolTip = _arg_1;
            }, "_ArmyDetailsWin_Label9.toolTip");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (((this.army.heroLevel < 1) && (this.army.hero == null)) ? "(none)" : ((("(" + ((this.army.heroLevel > 0) ? this.army.heroLevel : "unknown")) + ") ") + (((this.army.hero == null) || (this.army.hero == "")) ? "(unknown)" : this.army.hero)));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Text10.text = _arg_1;
            }, "_ArmyDetailsWin_Text10.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("HeroId: " + this.army.heroid);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Text10.toolTip = _arg_1;
            }, "_ArmyDetailsWin_Text10.toolTip");
            result[13] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.resoData);
            }, function (_arg_1:Object):void
            {
                _ArmyDetailsWin_DataGrid2.dataProvider = _arg_1;
            }, "_ArmyDetailsWin_DataGrid2.dataProvider");
            result[14] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.itemSelectInfo);
            }, function (_arg_1:Object):void
            {
                _itemSelect.dataProvider = _arg_1;
            }, "_itemSelect.dataProvider");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("x" + this.itemCount);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Text11.text = _arg_1;
            }, "_ArmyDetailsWin_Text11.text");
            result[16] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.canRecall(this.army.direction));
            }, function (_arg_1:Boolean):void
            {
                _ArmyDetailsWin_Button2.visible = _arg_1;
            }, "_ArmyDetailsWin_Button2.visible");
            result[17] = binding;
            return (result);
        }

        private function set troopData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._617648668troopData;
            if (_local_2 !== _arg_1)
            {
                this._617648668troopData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopData", _local_2, _arg_1));
            };
        }

        private function _ArmyDetailsWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((((!(this.armyType == null)) && (!(this.armyType == ""))) ? (this.armyType.charAt(0).toUpperCase() + this.armyType.substr(1)) : "") + "Army Details");
            _local_1 = (("[   " + this.army.armyId) + "   ]");
            _local_1 = ((((this.army.startFieldId < 0) ? "(unknown)" : Map.fieldIdToString(this.army.startFieldId)) + " ") + ((this.army.startPosName == null) ? "(unknown)" : this.army.startPosName));
            _local_1 = ((this.army.reachTime > 0) ? Utils.getTimeStr(this.army.reachTime) : "--:--:--");
            _local_1 = ((Map.fieldIdToString(this.army.targetFieldId) + " ") + (((!(this.army.targetPosName == null)) && (!(this.army.targetPosName == ""))) ? this.army.targetPosName : this.getTarget(this.army.targetFieldId)));
            _local_1 = this.armyLandsIn;
            _local_1 = this.troopData;
            _local_1 = (((this.armyType == "local") ? "" : (this.armyType.charAt(0) + "-")) + (((this.army.missionType > 0) && (this.army.missionType < Utils.MISSION_NAMES.length)) ? this.getMission(this.army.missionType) : "(unknown"));
            _local_1 = ((this.army.direction == ArmyConstants.ARMY_FORWARD) ? "marching" : ((this.army.direction == ArmyConstants.ARMY_BACKWARD) ? "returning" : ((this.army.direction == ArmyConstants.ARMY_STAY) ? "camped" : "")));
            _local_1 = ((this.army.king == null) ? "(unknown)" : this.army.king);
            _local_1 = this.army.alliance;
            _local_1 = ("HeroId: " + this.army.heroid);
            _local_1 = (((this.army.heroLevel < 1) && (this.army.hero == null)) ? "(none)" : ((("(" + ((this.army.heroLevel > 0) ? this.army.heroLevel : "unknown")) + ") ") + (((this.army.hero == null) || (this.army.hero == "")) ? "(unknown)" : this.army.hero)));
            _local_1 = ("HeroId: " + this.army.heroid);
            _local_1 = this.resoData;
            _local_1 = this.itemSelectInfo;
            _local_1 = ("x" + this.itemCount);
            _local_1 = this.canRecall(this.army.direction);
        }

        private function updateTroopData():void
        {
            var _local_3:int;
            var _local_1:Array = new Array(TFConstants.T_PEASANTS, TFConstants.T_MILITIA, TFConstants.T_SCOUTER, TFConstants.T_PIKEMAN, TFConstants.T_SWORDSMEN, TFConstants.T_ARCHER, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY, TFConstants.T_CARRIAGE, TFConstants.T_BALLISTA, TFConstants.T_BATTERINGRAM, TFConstants.T_CATAPULT);
            var _local_2:TroopBean = Utils.getTroopBeanFromTroopStrBean(this.army.troop);
            if (this.troopData == null)
            {
                this.troopData = new ArrayCollection();
            }
            else
            {
                this.troopData.removeAll();
            };
            for each (_local_3 in _local_1)
            {
                if (int(_local_2[Utils.troopIntNames[_local_3]]) > 0)
                {
                    this.troopData.addItem({
                        "type":String(Utils.troopExtNames[_local_3]),
                        "amount":Utils.formatInt(_local_2[Utils.troopIntNames[_local_3]])
                    });
                };
            };
        }

        private function getMission(_arg_1:int):String
        {
            return ((Utils.MISSION_NAMES[_arg_1] as String).charAt(0).toUpperCase() + (Utils.MISSION_NAMES[_arg_1] as String).substr(1));
        }

        public function ___itemSelect_change(_arg_1:ListEvent):void
        {
            this.updateItemCount();
        }

        private function _ArmyDetailsWin_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Troop Type";
            _local_1.dataField = "type";
            _local_1.width = 105;
            return (_local_1);
        }

        private function onRecallBtn():void
        {
            var _local_1:Date = new Date();
            if (_local_1.getTime() < (this.lastTime + 2000))
            {
                return;
            };
            this.lastTime = _local_1.getTime();
            MainScreen.getCityFromCastleId(this.castleId).cityManager.logMsg(("Recall self army with armyId: " + this.armyId));
            ActionFactory.getInstance().getArmyCommands().callBackArmy(this.castleId, this.armyId);
        }

        [Bindable(event="propertyChange")]
        private function get armyType():String
        {
            return (this._1414939017armyType);
        }

        private function set itemCount(_arg_1:int):void
        {
            var _local_2:Object = this._2127813052itemCount;
            if (_local_2 !== _arg_1)
            {
                this._2127813052itemCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemCount", _local_2, _arg_1));
            };
        }

        private function set itemSelectInfo(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._971377469itemSelectInfo;
            if (_local_2 !== _arg_1)
            {
                this._971377469itemSelectInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemSelectInfo", _local_2, _arg_1));
            };
        }

        public function ___ArmyDetailsWin_Button3_click(_arg_1:MouseEvent):void
        {
            this.close();
        }

        private function getTarget(_arg_1:int):String
        {
            var _local_3:FieldBean;
            var _local_4:String;
            var _local_5:ColonyBean;
            if (_arg_1 < 0)
            {
                return ("");
            };
            var _local_2:CityState;
            if ((_local_2 = MainScreen.getCityFromFieldId(_arg_1)) != null)
            {
                return (_local_2.castle.name);
            };
            if ((_local_2 = MainScreen.getCityFromValleyFieldId(_arg_1)) != null)
            {
                for each (_local_3 in _local_2.cm.fields)
                {
                    if (_local_3.id == _arg_1)
                    {
                        return ((_local_3.type + _local_3.name) + _local_3.level);
                    };
                };
                return ("");
            };
            if ((_local_2 = MainScreen.getCityFromColonyFieldId(_arg_1)) != null)
            {
                _local_4 = ((Map.getX(_arg_1) + ".") + Map.getY(_arg_1));
                for each (_local_5 in _local_2.cm.colonies)
                {
                    if (_local_5.position == _local_4)
                    {
                        return (_local_5.cityName);
                    };
                };
                return ("");
            };
            return ("");
        }

        override public function initialize():void
        {
            var target:ArmyDetailsWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._ArmyDetailsWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_ArmyDetailsWinWatcherSetupUtil");
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

        private function onApplyStratBtn():void
        {
            var _local_1:int;
            if (this.army.startFieldId < 0)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "You cannot use an army item if the source castle is unknown. Try creating or upgrading the Beacon Tower first."));
                return;
            };
            if (this.getItemCount(this._itemSelect.selectedItem.data) <= 0)
            {
                _local_1 = Items.getItemEumById(this._itemSelect.selectedItem.data).price;
                if ((MainScreen.getPlayer().playerInfo.medal - _local_1) >= 0)
                {
                    dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, (("You do not have any more of this item. Do you want to purchase and automatically use one for " + _local_1) + " cents?"), this.onConfirmBuyAndApplyStrat, "Yes", "No"));
                }
                else
                {
                    dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "You do not have any more of this item, and not enough Cents (coins) to buy this item from the Game Shop."));
                };
            }
            else
            {
                this.onConfirmBuyAndApplyStrat(true);
            };
        }

        private function set armyLandsIn(_arg_1:String):void
        {
            var _local_2:Object = this._838170928armyLandsIn;
            if (_local_2 !== _arg_1)
            {
                this._838170928armyLandsIn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyLandsIn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get army():ArmyBean
        {
            return (this._3002781army);
        }

        [Bindable(event="propertyChange")]
        public function get _itemSelect():ComboBox
        {
            return (this._1220405362_itemSelect);
        }

        private function onConfirmBuyAndApplyStrat(_arg_1:Boolean):void
        {
            if (!_arg_1)
            {
                return;
            };
            this.useFunc.apply(null, [this.army.startFieldId, this.army.armyId, this._itemSelect.selectedItem.data]);
        }

        private function _ArmyDetailsWin_DataGridColumn4_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Amount";
            _local_1.dataField = "amount";
            _local_1.showDataTips = true;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get itemCount():int
        {
            return (this._2127813052itemCount);
        }

        [Bindable(event="propertyChange")]
        private function get armyLandsIn():String
        {
            return (this._838170928armyLandsIn);
        }

        private function _ArmyDetailsWin_DataGridColumn3_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Reso Type";
            _local_1.dataField = "type";
            _local_1.width = 100;
            return (_local_1);
        }

        private function set armyType(_arg_1:String):void
        {
            var _local_2:Object = this._1414939017armyType;
            if (_local_2 !== _arg_1)
            {
                this._1414939017armyType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyType", _local_2, _arg_1));
            };
        }

        private function updateItemCount():void
        {
            this.itemCount = this.getItemCount(this._itemSelect.selectedItem.data);
        }

        private function close():void
        {
            if (((this.armyType == "self") || (this.armyType == "local")))
            {
                ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE, this.onArmyUpdates);
            }
            else
            {
                if (this.armyType == "friendly")
                {
                    ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_FRIEND_ARMYS_UPDATE, this.onArmyUpdates);
                }
                else
                {
                    if (this.armyType == "enemy")
                    {
                        ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_ENEMY_ARMYS_UPDATE, this.onArmyUpdates);
                    };
                };
            };
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE, this.onItemUpdate);
            if (this.updateTimeTimer != null)
            {
                this.updateTimeTimer.stop();
                this.updateTimeTimer.removeEventListener(TimerEvent.TIMER, this.updateReachTime);
                this.updateTimeTimer = null;
            };
            if (this.itemSelectInfo != null)
            {
                this.itemSelectInfo.removeAll();
                this.itemSelectInfo = null;
            };
            if (this.troopData != null)
            {
                this.troopData.removeAll();
                this.troopData = null;
            };
            if (this.resoData != null)
            {
                this.resoData.removeAll();
                this.resoData = null;
            };
            this.useFunc = null;
            this.army = null;
            this.armyType = null;
            this.closeFunc.apply(null, [this]);
        }

        private function onItemUpdate(_arg_1:ItemUpdate):void
        {
            var _local_2:ItemBean;
            for each (_local_2 in _arg_1.itemsArray)
            {
                if (_local_2.id == this._itemSelect.selectedItem.data)
                {
                    Utils.callLater(50, this.updateItemCount);
                    break;
                };
            };
        }


    }
}//package autoevony.gui

