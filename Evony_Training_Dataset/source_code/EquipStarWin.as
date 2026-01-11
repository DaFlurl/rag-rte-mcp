// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.workshop.EquipStarWin

package view.module.workshop
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.controls.CheckBox;
    import com.evony.eum.EquipTechEum;
    import com.evony.common.beans.AvailableResearchListBean;
    import mx.controls.Image;
    import mx.controls.Text;
    import mx.controls.ComboBox;
    import mx.controls.TextArea;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import view.ui.MyHRule;
    import mx.collections.ArrayCollection;
    import flash.utils.Timer;
    import view.module.forge.StoneTooltip;
    import mx.core.mx_internal;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.gemstone.GemstoneRespone;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import com.evony.common.beans.ItemBean;
    import com.evony.Context;
    import mx.events.ListEvent;
    import com.evony.eum.EquipTechEumDefine;
    import com.evony.Lang;
    import com.evony.client.action.ActionFactory;
    import view.ui.AddFundWin;
    import com.evony.util.MinePopupManager;
    import mx.managers.PopUpManager;
    import mx.events.FlexEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.eum.ItemEumDefine;
    import flash.events.TimerEvent;
    import com.evony.util.ImageSmooth;
    import com.evony.eum.ItemEum;
    import com.evony.util.UIUtil;
    import view.castle.MainFrame;
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

    public class EquipStarWin extends Canvas implements IBindingClient 
    {

        private static var instance:EquipStarWin;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _EquipStarWin_Label2:Label;
        public var _EquipStarWin_Label3:Label;
        public var _EquipStarWin_Label4:Label;
        private var starNeed:Object;
        private var _1211945787handStarBtn:Button;
        private var _148527153useCent:CheckBox;
        private var _588876147equipImg:String;
        private var _575054799flawlessNum:Label;
        private var _1212720905equipTechEum:EquipTechEum;
        private var _646343123autoBtn:Button;
        private var _1884363014stopBtn:Button;
        private var _1060252598equipTechBean:AvailableResearchListBean;
        public var _EquipStarWin_Image6:Image;
        private var targetStar:int;
        private var stopFlag:Boolean;
        private var itemId:String;
        public var _EquipStarWin_Text1:Text;
        public var _EquipStarWin_Text3:Text;
        public var _EquipStarWin_Text4:Text;
        public var _EquipStarWin_Text5:Text;
        public var _EquipStarWin_Text6:Text;
        public var _EquipStarWin_Text7:Text;
        private var _743804359delicateNum:Label;
        private var _1249826449addPoint:String;
        private var _1722425888handStarRateCom:ComboBox;
        private var _2008313381autoStarLevCom:ComboBox;
        private var _1556407391desText:TextArea;
        private var _1006653728autoStarCom:ComboBox;
        private var delicateRateAdd:int = 10;
        private var _1092797764closeBtn:Button;
        private var _563947171handStarStoneCom:ComboBox;
        private var _1106143469levTxt:Text;
        private var autoLev:int;
        private var flawlessRateAdd:int = 15;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":850,
                    "height":528,
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
                        "type":Label,
                        "stylesFactory":function ():void
                        {
                            this.top = "10";
                            this.left = "30";
                            this.right = "30";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":27,
                                "text":"Stars",
                                "styleName":"funtionWindowTitle"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"closeBtn",
                        "events":{"click":"__closeBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "42";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":0,
                                "styleName":"close"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "55";
                            this.left = "10";
                            this.right = "10";
                            this.bottom = "10";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_EquipStarWin_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFFFFFF;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "selectable":false,
                                            "x":140,
                                            "y":7,
                                            "width":330
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_EquipStarWin_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFFFFFF;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":140,
                                            "y":39
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"levTxt",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFF0000;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":292,
                                            "y":40
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_EquipStarWin_Text3",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFFFFFF;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":40,
                                            "text":"."
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_EquipStarWin_Text4",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFFFFFF;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "selectable":false,
                                            "text":"Your item's attribute will be increased by",
                                            "x":140,
                                            "y":57,
                                            "width":290
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_EquipStarWin_Text5",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFF0000;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":390,
                                            "y":57
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_EquipStarWin_Text6",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFFFFFF;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "selectable":false,
                                            "text":"after the upgrade of star's level is succeed.",
                                            "x":140,
                                            "y":75,
                                            "width":290
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_EquipStarWin_Text7",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFFFFFF;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "selectable":false,
                                            "x":140,
                                            "y":57,
                                            "width":330
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_EquipStarWin_Label3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"PropertyName1",
                                            "x":29,
                                            "y":243
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"handStarStoneCom",
                                    "events":{"change":"__handStarStoneCom_change"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":188,
                                            "x":22,
                                            "y":269
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"handStarRateCom",
                                    "events":{"change":"__handStarRateCom_change"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":162,
                                            "x":217,
                                            "y":269
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"handStarBtn",
                                    "events":{"click":"__handStarBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Manual",
                                            "styleName":"b75",
                                            "y":269,
                                            "width":75,
                                            "x":390
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_EquipStarWin_Label4",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"PropertyName1",
                                            "x":29,
                                            "y":323
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"autoStarLevCom",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":188,
                                            "x":22,
                                            "y":349
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"autoStarCom",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":162,
                                            "x":217,
                                            "y":349
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"autoBtn",
                                    "events":{"click":"__autoBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Auto",
                                            "styleName":"b75",
                                            "y":349,
                                            "width":75,
                                            "x":390
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"stopBtn",
                                    "events":{"click":"__stopBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "visible":false,
                                            "label":"stop",
                                            "styleName":"b75",
                                            "y":349,
                                            "width":75,
                                            "x":390
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":CheckBox,
                                    "id":"useCent",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFFFFFF;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":407,
                                            "x":32
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "events":{
                                        "rollOver":"___EquipStarWin_Image1_rollOver",
                                        "mouseMove":"___EquipStarWin_Image1_mouseMove",
                                        "rollOut":"___EquipStarWin_Image1_rollOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":39,
                                            "y":122,
                                            "width":90,
                                            "height":90,
                                            "source":"images/items/enhacedstar1.png"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "events":{
                                        "rollOver":"___EquipStarWin_Image2_rollOver",
                                        "mouseMove":"___EquipStarWin_Image2_mouseMove",
                                        "rollOut":"___EquipStarWin_Image2_rollOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":141,
                                            "y":122,
                                            "width":90,
                                            "height":90,
                                            "source":"images/items/enhacedstar2.png"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":39,
                                            "y":0,
                                            "width":96,
                                            "height":96,
                                            "source":"images/equipBg.png"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":11,
                                            "y":233,
                                            "width":443
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "mouseEnabled":false,
                                            "mouseChildren":false,
                                            "x":102,
                                            "y":182,
                                            "width":36,
                                            "height":36,
                                            "source":"images/numberbg.png"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "mouseEnabled":false,
                                            "mouseChildren":false,
                                            "x":204,
                                            "y":182,
                                            "width":36,
                                            "height":36,
                                            "source":"images/numberbg.png"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_EquipStarWin_Image6",
                                    "events":{"updateComplete":"___EquipStarWin_Image6_updateComplete"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":90,
                                            "height":90,
                                            "x":42,
                                            "y":3
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"doubleLineBlue",
                                            "x":478,
                                            "y":0,
                                            "width":317,
                                            "height":408,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "3";
                                                    this.top = "5";
                                                    this.right = "3";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":26,
                                                        "styleName":"textBackGroundFillColor",
                                                        "verticalScrollPolicy":"off",
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
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
                                                                    "text":"Description",
                                                                    "y":3
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextArea,
                                                "id":"desText",
                                                "stylesFactory":function ():void
                                                {
                                                    this.borderStyle = "none";
                                                    this.backgroundAlpha = 0;
                                                    this.left = "15";
                                                    this.right = "10";
                                                    this.bottom = "10";
                                                    this.top = "33";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "selectable":false,
                                                        "editable":false
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"delicateNum",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFFFFFF;
                                        this.textAlign = "center";
                                        this.horizontalCenter = "-295";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "mouseEnabled":false,
                                            "mouseChildren":false,
                                            "y":192
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"flawlessNum",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFFFFFF;
                                        this.textAlign = "center";
                                        this.horizontalCenter = "-193";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "mouseEnabled":false,
                                            "mouseChildren":false,
                                            "y":192
                                        });
                                    }
                                })]});
                        }
                    })]
                });
            }
        });
        private var addPointArr:Array = ["0.40", "0.75", "1.00", "1.32", "1.74", "2.30", "3.04", "4.01", "5.29", "6.98", "9.22", "12.17", "16.06", "21.20", "27.98"];
        private var baseRateArr:Array = [55, 50, 45, 40, 35, 30, 25, 20, 10, 0, -5, -10, -15, -15, -15];
        private var _2128642777autoStarLevShow:ArrayCollection = new ArrayCollection();
        private var _1141964606autoStarShow:ArrayCollection = new ArrayCollection();
        private var _759468420handStarStone:ArrayCollection = new ArrayCollection([{
            "label":"Use 1 delicate gem",
            "data":1
        }, {
            "label":"Use 2 delicate gems",
            "data":2
        }, {
            "label":"Use 3 delicate gems",
            "data":3
        }, {
            "label":"Use 4 delicate gems",
            "data":4
        }, {
            "label":"Use 1 flawless gem",
            "data":1
        }, {
            "label":"Use 2 flawless gems",
            "data":2
        }, {
            "label":"Use 3 flawless gems",
            "data":3
        }, {
            "label":"Use 4 flawless gems",
            "data":4
        }]);
        private var _1083927583handStarRate:ArrayCollection = new ArrayCollection([{
            "label":"Success rate 21%",
            "data":0
        }, {
            "label":"Success rate 31%",
            "data":1
        }, {
            "label":"Success rate 41%",
            "data":2
        }, {
            "label":"Success rate 51%",
            "data":3
        }, {
            "label":"Success rate 26%",
            "data":4
        }, {
            "label":"Success rate 41%",
            "data":5
        }, {
            "label":"Success rate 56%",
            "data":6
        }, {
            "label":"Success rate 71%",
            "data":7
        }]);
        private var _1006662076autoStarLev:ArrayCollection = new ArrayCollection([{
            "label":"Delicate gems only",
            "data":0
        }, {
            "label":"Use flawless from Lv 1",
            "data":1
        }, {
            "label":"Use flawless from Lv 2",
            "data":2
        }, {
            "label":"Use flawless from Lv 3",
            "data":3
        }, {
            "label":"Use flawless from Lv 4",
            "data":4
        }, {
            "label":"Use flawless from Lv 5",
            "data":5
        }, {
            "label":"Use flawless from Lv 6",
            "data":6
        }, {
            "label":"Use flawless from Lv 7",
            "data":7
        }, {
            "label":"Use flawless from Lv 8",
            "data":8
        }, {
            "label":"Use flawless from Lv 9",
            "data":9
        }, {
            "label":"Use flawless from Lv 10",
            "data":10
        }, {
            "label":"Use flawless from Lv 11",
            "data":11
        }, {
            "label":"Use flawless from Lv 12",
            "data":12
        }, {
            "label":"Use flawless from Lv 13",
            "data":13
        }, {
            "label":"Use flawless from Lv 14",
            "data":14
        }, {
            "label":"Use flawless from Lv 15",
            "data":15
        }]);
        private var _1438705825autoStar:ArrayCollection = new ArrayCollection([{
            "label":"Upgrade to level 1",
            "data":1
        }, {
            "label":"Upgrade to level 2",
            "data":2
        }, {
            "label":"Upgrade to level 3",
            "data":3
        }, {
            "label":"Upgrade to level 4",
            "data":4
        }, {
            "label":"Upgrade to level 5",
            "data":5
        }, {
            "label":"Upgrade to level 6",
            "data":6
        }, {
            "label":"Upgrade to level 7",
            "data":7
        }, {
            "label":"Upgrade to level 8",
            "data":8
        }, {
            "label":"Upgrade to level 9",
            "data":9
        }, {
            "label":"Upgrade to level 10",
            "data":10
        }, {
            "label":"Upgrade to level 11",
            "data":11
        }, {
            "label":"Upgrade to level 12",
            "data":12
        }, {
            "label":"Upgrade to level 13",
            "data":13
        }, {
            "label":"Upgrade to level 14",
            "data":14
        }, {
            "label":"Upgrade to level 15",
            "data":15
        }]);
        private var _timer:Timer = new Timer(1000);
        private var _1653984749starNumArr:ArrayCollection = new ArrayCollection();
        private var _1576125777starRateArr:ArrayCollection = new ArrayCollection();
        private var tips:StoneTooltip = StoneTooltip.getInstance();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function EquipStarWin()
        {
            mx_internal::_document = this;
            this.width = 850;
            this.height = 528;
            this.addEventListener("creationComplete", ___EquipStarWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            EquipStarWin._watcherSetupUtil = _arg_1;
        }

        public static function getInstance():EquipStarWin
        {
            if (instance == null)
            {
                instance = new (EquipStarWin)();
            };
            return (instance);
        }


        private function onAutoStarResponse(_arg_1:GemstoneRespone):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.refreshItemNum();
                equipTechBean.enhancedstarlv = _arg_1.enhancedstarlv;
                _timer.start();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function set starNumArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1653984749starNumArr;
            if (_local_2 !== _arg_1)
            {
                this._1653984749starNumArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "starNumArr", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get stopBtn():Button
        {
            return (this._1884363014stopBtn);
        }

        public function ___EquipStarWin_Image1_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        private function init():void
        {
            desText.htmlText = "<b><font color='#ff0000'>Star levels:</font></b> There are fifteen levels of stars, the higher the star level is, the more powerful the item will be. The upgrade of star level requires delicate gems or flawless gems. The star level of the item will be downgraded if the upgrade fails.\n<b><font color='#ff0000'>Requirements:</font></b> The weapon's gear level must be higher than lv0. The maximum star level is the weapon' gear level plus six. The current star level will be downgraded by one when gear technology is upgraded, while the maximum star level will be increased by one.\n<b><font color='#ff0000'>There are two ways to upgrade star level, auto and manual.\nAuto upgrade\n</font></b>1. Select the gem type and amount, or select the success rate that you seek.\n2. Click on the 'Auto' button, and the upgrade will be completed.\n<b><font color='#ff0000'>Manual upgrade\n</font></b>1. Select the star level that you want to start using flawless gems to upgrade from the first drop-down menu, the system will use delicate gems by default.\n2. Select the star level that you want the upgrade to stop from the second drop-down menu.\n3. Make sure that you have  relevant amount of gems for the upgrade that you have set up, click the 'Manual' button to start the upgrade.\n<b><font color='#ff0000'>Warning:</font></b> There is a certain success rate of the upgrade of star level, the more gems you use, the higher the success rate is. You may use up to four gems for the upgrade. \n<b><font color='#ff0000'>Failure:</font></b> If the upgrade of star level fails, the gems that you use for the upgrade will be consumed, and the current star level of your item will be downgraded, down to zero star level.\nUpgrading star level from 1 to 2, the level will be downgraded to zero if the upgrade fails.\nUpgrading star level from 2 to 3, the level will be downgraded to zero if the upgrade fails.\nUpgrading star level from 3 to 4, the level will be downgraded to one if the upgrade fails.\nUpgrading star level from 4 to 5, the level will be downgraded to two if the upgrade fails.\nUpgrading star level from 5 to 6, the level will be downgraded to three if the upgrade fails.\nUpgrading star level from 6 to 7, the level will be downgraded to four if the upgrade fails.\nUpgrading star level from 7 to 8, the level will be downgraded to five if the upgrade fails.\nUpgrading star level from 8 to 9, the level will be downgraded to zero if the upgrade fails.\nUpgrading star level from 9 to 10, the level will be downgraded to zero if the upgrade fails.\nUpgrading star level from 10 to 11, the level will be downgraded to zero if the upgrade fails.\nUpgrading star level from 11 to 12, the level will be downgraded to zero if the upgrade fails.\nUpgrading star level from 12 to 13, the level will be downgraded to zero if the upgrade fails.\nUpgrading star level from 13 to 14, the level will be downgraded to zero if the upgrade fails.\nUpgrading star level from 14 to 15, the level will be downgraded to zero if the upgrade fails.";
        }

        [Bindable(event="propertyChange")]
        public function get levTxt():Text
        {
            return (this._1106143469levTxt);
        }

        public function __autoBtn_click(_arg_1:MouseEvent):void
        {
            onAutoStar();
        }

        [Bindable(event="propertyChange")]
        private function get equipTechEum():EquipTechEum
        {
            return (this._1212720905equipTechEum);
        }

        [Bindable(event="propertyChange")]
        private function get starNumArr():ArrayCollection
        {
            return (this._1653984749starNumArr);
        }

        [Bindable(event="propertyChange")]
        public function get autoStarCom():ComboBox
        {
            return (this._1006653728autoStarCom);
        }

        [Bindable(event="propertyChange")]
        public function get autoStarLevCom():ComboBox
        {
            return (this._2008313381autoStarLevCom);
        }

        private function refreshItemNum():void
        {
            var _local_1:ItemBean;
            delicateNum.text = "0";
            flawlessNum.text = "0";
            for each (_local_1 in Context.getInstance().getPlayerBean().itemsArray)
            {
                if (_local_1.id == "enhanced.star.1")
                {
                    delicateNum.text = _local_1.count.toString();
                };
                if (_local_1.id == "enhanced.star.2")
                {
                    flawlessNum.text = _local_1.count.toString();
                };
            };
        }

        public function __stopBtn_click(_arg_1:MouseEvent):void
        {
            onStop();
        }

        public function __handStarStoneCom_change(_arg_1:ListEvent):void
        {
            onHandStarChange();
        }

        [Bindable(event="propertyChange")]
        public function get autoBtn():Button
        {
            return (this._646343123autoBtn);
        }

        private function onHandStarChange():void
        {
            handStarRateCom.selectedIndex = handStarStoneCom.selectedIndex;
        }

        [Bindable(event="propertyChange")]
        public function get flawlessNum():Label
        {
            return (this._575054799flawlessNum);
        }

        private function setBean(_arg_1:AvailableResearchListBean):void
        {
            equipTechBean = _arg_1;
            autoStarLevShow.removeAll();
            autoStarShow.removeAll();
            var _local_2:int = (((equipTechBean.level + 6) >= 15) ? 15 : (equipTechBean.level + 6));
            var _local_3:int;
            while (_local_3 <= _local_2)
            {
                autoStarLevShow.addItem(autoStarLev.getItemAt(_local_3));
                _local_3++;
            };
            var _local_4:int;
            while (_local_4 < _local_2)
            {
                autoStarShow.addItem(autoStar.getItemAt(_local_4));
                _local_4++;
            };
            autoStarLevCom.selectedIndex = 0;
            autoStarCom.selectedIndex = 0;
            this.equipTechEum = EquipTechEumDefine.getEquipTechEum(((_arg_1.typeId + "_") + _arg_1.level));
            equipImg = equipTechEum.iconURL;
            setStarRate();
        }

        private function onHandStarRateChange():void
        {
            handStarStoneCom.selectedIndex = handStarRateCom.selectedIndex;
        }

        [Bindable(event="propertyChange")]
        public function get delicateNum():Label
        {
            return (this._743804359delicateNum);
        }

        private function set equipImg(_arg_1:String):void
        {
            var _local_2:Object = this._588876147equipImg;
            if (_local_2 !== _arg_1)
            {
                this._588876147equipImg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "equipImg", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get handStarBtn():Button
        {
            return (this._1211945787handStarBtn);
        }

        private function _EquipStarWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("最多可冲星", equipTechBean.level, (((equipTechBean.level + 6) >= 15) ? 15 : (equipTechBean.level + 6)));
            _local_1 = Lang.msg("当前星");
            _local_1 = equipTechBean.enhancedstarlv;
            _local_1 = ((this.levTxt.x + this.levTxt.width) - 3);
            _local_1 = (!(equipTechBean.enhancedstarlv == 15));
            _local_1 = (!(equipTechBean.enhancedstarlv == 15));
            _local_1 = getPoint(equipTechBean.enhancedstarlv);
            _local_1 = (!(equipTechBean.enhancedstarlv == 15));
            _local_1 = (!(equipTechBean.enhancedstarlv == 15));
            _local_1 = (equipTechBean.enhancedstarlv == 15);
            _local_1 = (equipTechBean.enhancedstarlv == 15);
            _local_1 = Lang.msg("打星收益最高级");
            _local_1 = Lang.msg("手动冲星");
            _local_1 = starNumArr;
            _local_1 = starRateArr;
            _local_1 = Lang.msg("手动冲星");
            _local_1 = Lang.msg("自动冲星");
            _local_1 = autoStarLevShow;
            _local_1 = autoStarShow;
            _local_1 = Lang.msg("自动冲星");
            _local_1 = Lang.msg("打星自动购买");
            _local_1 = equipImg;
        }

        [Bindable(event="propertyChange")]
        private function get autoStarShow():ArrayCollection
        {
            return (this._1141964606autoStarShow);
        }

        public function set autoStarCom(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._1006653728autoStarCom;
            if (_local_2 !== _arg_1)
            {
                this._1006653728autoStarCom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autoStarCom", _local_2, _arg_1));
            };
        }

        private function set autoStar(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1438705825autoStar;
            if (_local_2 !== _arg_1)
            {
                this._1438705825autoStar = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autoStar", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get closeBtn():Button
        {
            return (this._1092797764closeBtn);
        }

        public function set autoStarLevCom(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._2008313381autoStarLevCom;
            if (_local_2 !== _arg_1)
            {
                this._2008313381autoStarLevCom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autoStarLevCom", _local_2, _arg_1));
            };
        }

        private function onSureBuy(_arg_1:Boolean):void
        {
            if (!stopFlag)
            {
                if (_arg_1)
                {
                    if (Context.getInstance().getPlayerBean().playerInfo.medal >= starNeed.totalCent)
                    {
                        ActionFactory.getInstance().getShopCommands().buy(starNeed.id, starNeed.needNum, onAutoBuyItem);
                    }
                    else
                    {
                        AddFundWin.show();
                    };
                }
                else
                {
                    autoStatusChange(false);
                };
                return;
            };
            if (_arg_1)
            {
                if (Context.getInstance().getPlayerBean().playerInfo.medal >= starNeed.totalCent)
                {
                    ActionFactory.getInstance().getShopCommands().buy(starNeed.id, starNeed.needNum, onBuyItem);
                }
                else
                {
                    AddFundWin.show();
                };
            };
        }

        public function set levTxt(_arg_1:Text):void
        {
            var _local_2:Object = this._1106143469levTxt;
            if (_local_2 !== _arg_1)
            {
                this._1106143469levTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "levTxt", _local_2, _arg_1));
            };
        }

        private function onClose():void
        {
            MinePopupManager.instance.removePopup();
        }

        public function set autoBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._646343123autoBtn;
            if (_local_2 !== _arg_1)
            {
                this._646343123autoBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autoBtn", _local_2, _arg_1));
            };
        }

        private function set handStarStone(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._759468420handStarStone;
            if (_local_2 !== _arg_1)
            {
                this._759468420handStarStone = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "handStarStone", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get handStarStoneCom():ComboBox
        {
            return (this._563947171handStarStoneCom);
        }

        private function set starRateArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1576125777starRateArr;
            if (_local_2 !== _arg_1)
            {
                this._1576125777starRateArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "starRateArr", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get desText():TextArea
        {
            return (this._1556407391desText);
        }

        private function onHandStar():void
        {
            var _local_1:String;
            var _local_2:int;
            if (((handStarStoneCom.selectedIndex < 4) && (handStarStoneCom.selectedIndex >= 0)))
            {
                _local_1 = "enhanced.star.1";
                _local_2 = handStarStoneCom.selectedItem.data;
            }
            else
            {
                _local_1 = "enhanced.star.2";
                _local_2 = handStarStoneCom.selectedItem.data;
            };
            if (showBuyItem(_local_1, _local_2))
            {
                return;
            };
            ActionFactory.getInstance().getEquipmentCommands().EnhancedStarByGemStone(_local_1, _local_2, equipTechBean.typeId, onHandStarResponse);
        }

        private function onMouseOut():void
        {
            PopUpManager.removePopUp(tips);
        }

        public function set flawlessNum(_arg_1:Label):void
        {
            var _local_2:Object = this._575054799flawlessNum;
            if (_local_2 !== _arg_1)
            {
                this._575054799flawlessNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "flawlessNum", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get addPoint():String
        {
            return (this._1249826449addPoint);
        }

        private function set equipTechBean(_arg_1:AvailableResearchListBean):void
        {
            var _local_2:Object = this._1060252598equipTechBean;
            if (_local_2 !== _arg_1)
            {
                this._1060252598equipTechBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "equipTechBean", _local_2, _arg_1));
            };
        }

        private function set autoStarLev(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1006662076autoStarLev;
            if (_local_2 !== _arg_1)
            {
                this._1006662076autoStarLev = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autoStarLev", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get equipImg():String
        {
            return (this._588876147equipImg);
        }

        private function set autoStarShow(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1141964606autoStarShow;
            if (_local_2 !== _arg_1)
            {
                this._1141964606autoStarShow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autoStarShow", _local_2, _arg_1));
            };
        }

        public function set handStarBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1211945787handStarBtn;
            if (_local_2 !== _arg_1)
            {
                this._1211945787handStarBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "handStarBtn", _local_2, _arg_1));
            };
        }

        private function getItemId():String
        {
            if (targetStar == equipTechBean.enhancedstarlv)
            {
                return ("");
            };
            if (autoLev == 0)
            {
                return ("enhanced.star.1");
            };
            if (equipTechBean.enhancedstarlv >= (autoLev - 1))
            {
                return ("enhanced.star.2");
            };
            return ("enhanced.star.1");
        }

        private function onStop():void
        {
            autoStatusChange(false);
        }

        private function checkAutoItem(_arg_1:String):int
        {
            var _local_3:ItemBean;
            var _local_2:int;
            for each (_local_3 in Context.getInstance().getPlayerBean().itemsArray)
            {
                if (_local_3.id == _arg_1)
                {
                    _local_2 = _local_3.count;
                };
            };
            return (((_local_2 - 4) >= 0) ? 0 : (4 - _local_2));
        }

        public function ___EquipStarWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set closeBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1092797764closeBtn;
            if (_local_2 !== _arg_1)
            {
                this._1092797764closeBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "closeBtn", _local_2, _arg_1));
            };
        }

        private function autoStatusChange(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                autoBtn.visible = false;
                autoStarCom.enabled = false;
                autoStarLevCom.enabled = false;
                useCent.enabled = false;
                stopFlag = false;
                closeBtn.enabled = false;
                handStarBtn.enabled = false;
                stopBtn.visible = true;
            }
            else
            {
                autoBtn.visible = true;
                autoStarCom.enabled = true;
                autoStarLevCom.enabled = true;
                useCent.enabled = true;
                stopFlag = true;
                closeBtn.enabled = true;
                handStarBtn.enabled = true;
                stopBtn.visible = false;
                setStarRate();
            };
        }

        public function ___EquipStarWin_Image2_rollOver(_arg_1:MouseEvent):void
        {
            onMouseOver("enhanced.star.2");
        }

        override public function initialize():void
        {
            var target:EquipStarWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _EquipStarWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_workshop_EquipStarWinWatcherSetupUtil");
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
        private function get handStarStone():ArrayCollection
        {
            return (this._759468420handStarStone);
        }

        public function set useCent(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._148527153useCent;
            if (_local_2 !== _arg_1)
            {
                this._148527153useCent = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "useCent", _local_2, _arg_1));
            };
        }

        private function _EquipStarWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("最多可冲星", equipTechBean.level, (((equipTechBean.level + 6) >= 15) ? 15 : (equipTechBean.level + 6)));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EquipStarWin_Text1.text = _arg_1;
            }, "_EquipStarWin_Text1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当前星");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EquipStarWin_Label2.text = _arg_1;
            }, "_EquipStarWin_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = equipTechBean.enhancedstarlv;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                levTxt.text = _arg_1;
            }, "levTxt.text");
            result[2] = binding;
            binding = new Binding(this, function ():Number
            {
                return ((this.levTxt.x + this.levTxt.width) - 3);
            }, function (_arg_1:Number):void
            {
                _EquipStarWin_Text3.x = _arg_1;
            }, "_EquipStarWin_Text3.x");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(equipTechBean.enhancedstarlv == 15));
            }, function (_arg_1:Boolean):void
            {
                _EquipStarWin_Text4.includeInLayout = _arg_1;
            }, "_EquipStarWin_Text4.includeInLayout");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(equipTechBean.enhancedstarlv == 15));
            }, function (_arg_1:Boolean):void
            {
                _EquipStarWin_Text4.visible = _arg_1;
            }, "_EquipStarWin_Text4.visible");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = getPoint(equipTechBean.enhancedstarlv);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EquipStarWin_Text5.text = _arg_1;
            }, "_EquipStarWin_Text5.text");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(equipTechBean.enhancedstarlv == 15));
            }, function (_arg_1:Boolean):void
            {
                _EquipStarWin_Text6.includeInLayout = _arg_1;
            }, "_EquipStarWin_Text6.includeInLayout");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(equipTechBean.enhancedstarlv == 15));
            }, function (_arg_1:Boolean):void
            {
                _EquipStarWin_Text6.visible = _arg_1;
            }, "_EquipStarWin_Text6.visible");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (equipTechBean.enhancedstarlv == 15);
            }, function (_arg_1:Boolean):void
            {
                _EquipStarWin_Text7.includeInLayout = _arg_1;
            }, "_EquipStarWin_Text7.includeInLayout");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (equipTechBean.enhancedstarlv == 15);
            }, function (_arg_1:Boolean):void
            {
                _EquipStarWin_Text7.visible = _arg_1;
            }, "_EquipStarWin_Text7.visible");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("打星收益最高级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EquipStarWin_Text7.text = _arg_1;
            }, "_EquipStarWin_Text7.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("手动冲星");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EquipStarWin_Label3.text = _arg_1;
            }, "_EquipStarWin_Label3.text");
            result[12] = binding;
            binding = new Binding(this, function ():Object
            {
                return (starNumArr);
            }, function (_arg_1:Object):void
            {
                handStarStoneCom.dataProvider = _arg_1;
            }, "handStarStoneCom.dataProvider");
            result[13] = binding;
            binding = new Binding(this, function ():Object
            {
                return (starRateArr);
            }, function (_arg_1:Object):void
            {
                handStarRateCom.dataProvider = _arg_1;
            }, "handStarRateCom.dataProvider");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("手动冲星");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                handStarBtn.toolTip = _arg_1;
            }, "handStarBtn.toolTip");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("自动冲星");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EquipStarWin_Label4.text = _arg_1;
            }, "_EquipStarWin_Label4.text");
            result[16] = binding;
            binding = new Binding(this, function ():Object
            {
                return (autoStarLevShow);
            }, function (_arg_1:Object):void
            {
                autoStarLevCom.dataProvider = _arg_1;
            }, "autoStarLevCom.dataProvider");
            result[17] = binding;
            binding = new Binding(this, function ():Object
            {
                return (autoStarShow);
            }, function (_arg_1:Object):void
            {
                autoStarCom.dataProvider = _arg_1;
            }, "autoStarCom.dataProvider");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("自动冲星");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                autoBtn.toolTip = _arg_1;
            }, "autoBtn.toolTip");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("打星自动购买");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                useCent.label = _arg_1;
            }, "useCent.label");
            result[20] = binding;
            binding = new Binding(this, function ():Object
            {
                return (equipImg);
            }, function (_arg_1:Object):void
            {
                _EquipStarWin_Image6.source = _arg_1;
            }, "_EquipStarWin_Image6.source");
            result[21] = binding;
            return (result);
        }

        private function onAutoBuyItem(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                ActionFactory.getInstance().getEquipmentCommands().EnhancedStarByGemStone(itemId, 4, equipTechBean.typeId, onAutoStarResponse);
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function onTimer(_arg_1:TimerEvent):void
        {
            _timer.stop();
            if (stopFlag)
            {
                return;
            };
            itemId = getItemId();
            if (itemId == "")
            {
                AlertWin.show("Automatically upgrade the star's level stop,you have reach the level!");
                autoStatusChange(false);
                return;
            };
            if (checkAutoItem(itemId) != 0)
            {
                if (!useCent.selected)
                {
                    showBuyItem(itemId, 4);
                    return;
                };
                if (Context.getInstance().getPlayerBean().playerInfo.medal > (ItemEumDefine.getItemEum(itemId).price * 4))
                {
                    ActionFactory.getInstance().getShopCommands().buy(itemId, checkAutoItem(itemId), onAutoBuyItem);
                }
                else
                {
                    AlertWin.show("Automatically upgrade the star's level stop,your cents not enough.");
                    autoStatusChange(false);
                };
                return;
            };
            if (!stopFlag)
            {
                ActionFactory.getInstance().getEquipmentCommands().EnhancedStarByGemStone(itemId, 4, equipTechBean.typeId, onAutoStarResponse);
            };
        }

        public function ___EquipStarWin_Image1_rollOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        public function __handStarBtn_click(_arg_1:MouseEvent):void
        {
            onHandStar();
        }

        public function __closeBtn_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        private function onAutoStar():void
        {
            autoLev = autoStarLevCom.selectedItem.data;
            targetStar = autoStarCom.selectedItem.data;
            if (targetStar <= equipTechBean.enhancedstarlv)
            {
                AlertWin.show(Lang.msg("选择星级小"));
                return;
            };
            autoStatusChange(true);
            _timer.start();
            _timer.addEventListener(TimerEvent.TIMER, onTimer);
        }

        private function set autoStarLevShow(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2128642777autoStarLevShow;
            if (_local_2 !== _arg_1)
            {
                this._2128642777autoStarLevShow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autoStarLevShow", _local_2, _arg_1));
            };
        }

        public function ___EquipStarWin_Image2_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get autoStarLev():ArrayCollection
        {
            return (this._1006662076autoStarLev);
        }

        [Bindable(event="propertyChange")]
        private function get equipTechBean():AvailableResearchListBean
        {
            return (this._1060252598equipTechBean);
        }

        public function ___EquipStarWin_Image6_updateComplete(_arg_1:FlexEvent):void
        {
            ImageSmooth.onCreationComplete(_arg_1);
        }

        private function set handStarRate(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1083927583handStarRate;
            if (_local_2 !== _arg_1)
            {
                this._1083927583handStarRate = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "handStarRate", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get autoStar():ArrayCollection
        {
            return (this._1438705825autoStar);
        }

        public function set delicateNum(_arg_1:Label):void
        {
            var _local_2:Object = this._743804359delicateNum;
            if (_local_2 !== _arg_1)
            {
                this._743804359delicateNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "delicateNum", _local_2, _arg_1));
            };
        }

        public function ___EquipStarWin_Image2_rollOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        private function onHandStarResponse(_arg_1:GemstoneRespone):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.refreshItemNum();
                equipTechBean.enhancedstarlv = _arg_1.enhancedstarlv;
                setStarRate();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set handStarStoneCom(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._563947171handStarStoneCom;
            if (_local_2 !== _arg_1)
            {
                this._563947171handStarStoneCom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "handStarStoneCom", _local_2, _arg_1));
            };
        }

        public function __handStarRateCom_change(_arg_1:ListEvent):void
        {
            onHandStarRateChange();
        }

        [Bindable(event="propertyChange")]
        private function get starRateArr():ArrayCollection
        {
            return (this._1576125777starRateArr);
        }

        public function set desText(_arg_1:TextArea):void
        {
            var _local_2:Object = this._1556407391desText;
            if (_local_2 !== _arg_1)
            {
                this._1556407391desText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "desText", _local_2, _arg_1));
            };
        }

        public function ___EquipStarWin_Image1_rollOver(_arg_1:MouseEvent):void
        {
            onMouseOver("enhanced.star.1");
        }

        [Bindable(event="propertyChange")]
        private function get autoStarLevShow():ArrayCollection
        {
            return (this._2128642777autoStarLevShow);
        }

        private function onBuyItem(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                ActionFactory.getInstance().getEquipmentCommands().EnhancedStarByGemStone(starNeed.id, starNeed.num, equipTechBean.typeId, onHandStarResponse);
            };
        }

        [Bindable(event="propertyChange")]
        public function get useCent():CheckBox
        {
            return (this._148527153useCent);
        }

        [Bindable(event="propertyChange")]
        public function get handStarRateCom():ComboBox
        {
            return (this._1722425888handStarRateCom);
        }

        private function getPoint(_arg_1:int):String
        {
            return (addPointArr[_arg_1]);
        }

        public function set handStarRateCom(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._1722425888handStarRateCom;
            if (_local_2 !== _arg_1)
            {
                this._1722425888handStarRateCom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "handStarRateCom", _local_2, _arg_1));
            };
        }

        private function setStarRate():void
        {
            var _local_5:Object;
            var _local_6:Object;
            if (equipTechBean.enhancedstarlv == 15)
            {
                return;
            };
            var _local_1:int = baseRateArr[equipTechBean.enhancedstarlv];
            starNumArr.removeAll();
            starRateArr.removeAll();
            var _local_2:int;
            var _local_3:int = 1;
            while (_local_3 <= 4)
            {
                _local_2 = ((_local_3 * delicateRateAdd) + _local_1);
                _local_2 = ((_local_2 > 100) ? 100 : _local_2);
                if (_local_2 >= 0)
                {
                    starNumArr.addItem(handStarStone.getItemAt((_local_3 - 1)));
                    _local_5 = handStarRate.getItemAt((_local_3 - 1));
                    _local_5.label = (("Success rate " + _local_2) + "%");
                    starRateArr.addItem(_local_5);
                };
                _local_3++;
            };
            var _local_4:int = 1;
            while (_local_4 <= 4)
            {
                _local_2 = ((_local_4 * flawlessRateAdd) + _local_1);
                _local_2 = ((_local_2 > 100) ? 100 : _local_2);
                if (_local_2 >= 0)
                {
                    starNumArr.addItem(handStarStone.getItemAt((_local_4 + 3)));
                    _local_6 = handStarRate.getItemAt((_local_4 + 3));
                    _local_6.label = (("Success rate " + _local_2) + "%");
                    starRateArr.addItem(_local_6);
                };
                _local_4++;
            };
            handStarStoneCom.selectedIndex = 0;
            handStarRateCom.selectedIndex = 0;
        }

        private function set addPoint(_arg_1:String):void
        {
            var _local_2:Object = this._1249826449addPoint;
            if (_local_2 !== _arg_1)
            {
                this._1249826449addPoint = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "addPoint", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get handStarRate():ArrayCollection
        {
            return (this._1083927583handStarRate);
        }

        public function set stopBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1884363014stopBtn;
            if (_local_2 !== _arg_1)
            {
                this._1884363014stopBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stopBtn", _local_2, _arg_1));
            };
        }

        private function set equipTechEum(_arg_1:EquipTechEum):void
        {
            var _local_2:Object = this._1212720905equipTechEum;
            if (_local_2 !== _arg_1)
            {
                this._1212720905equipTechEum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "equipTechEum", _local_2, _arg_1));
            };
        }

        private function onMouseOver(_arg_1:String):void
        {
            tips.itemEum = ItemEumDefine.getItemEum(_arg_1);
            PopUpManager.addPopUp(this.tips, this);
        }

        private function showBuyItem(_arg_1:String, _arg_2:int):Boolean
        {
            var _local_5:ItemBean;
            var _local_6:ItemEum;
            var _local_7:String;
            var _local_3:Boolean;
            var _local_4:int;
            for each (_local_5 in Context.getInstance().getPlayerBean().itemsArray)
            {
                if (_local_5.id == _arg_1)
                {
                    _local_4 = _local_5.count;
                    break;
                };
            };
            if (_local_4 < _arg_2)
            {
                starNeed = new Object();
                starNeed.needNum = (_arg_2 - _local_4);
                starNeed.id = _arg_1;
                starNeed.num = _arg_2;
                _local_6 = ItemEumDefine.getItemEum(_arg_1);
                starNeed.name = _local_6.name;
                starNeed.totalCent = (_local_6.price * starNeed.needNum);
                _local_7 = Lang.msg("购买打星物品提示", starNeed.name, starNeed.name, starNeed.needNum, starNeed.totalCent);
                AlertWin.show(_local_7, onSureBuy);
                _local_3 = true;
            };
            return (_local_3);
        }

        public function show(_arg_1:AvailableResearchListBean):void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
            setBean(_arg_1);
            refreshItemNum();
            stopFlag = true;
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            tips.moveToMouse(_arg_1);
        }


    }
}//package view.module.workshop

