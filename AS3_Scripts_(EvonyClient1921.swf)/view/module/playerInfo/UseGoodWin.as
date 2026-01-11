// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.UseGoodWin

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Button;
    import view.ui.NumberInput;
    import com.evony.eum.ItemEum;
    import mx.controls.Image;
    import view.module.guide.GuideArrow;
    import mx.controls.TextArea;
    import mx.controls.TextInput;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.VRule;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import com.evony.common.beans.ItemBean;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import com.evony.eum.ItemEumDefine;
    import flash.events.Event;
    import com.evony.common.module.CommandResponse;
    import flash.external.ExternalInterface;
    import view.ui.AddFundWin;
    import mx.binding.Binding;
    import view.module.guide.GuideStep;
    import view.ui.DescribeTooltip;
    import flash.utils.getDefinitionByName;
    import view.module.shop.Turntable;
    import com.evony.util.ImageSmooth;
    import view.AllWindows;
    import view.module.friendList.DisappearHeroList;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.constants.BuildingConstants;
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

    public class UseGoodWin extends Canvas implements IBindingClient 
    {

        private static var instance:UseGoodWin = new (UseGoodWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1180085800isTrue:Boolean;
        public var _UseGoodWin_Label2:Label;
        public var _UseGoodWin_Label4:Label;
        public var _UseGoodWin_Label5:Label;
        public var _UseGoodWin_Label6:Label;
        public var _UseGoodWin_Label7:Label;
        private var _888567041myPanelHeight:int;
        public var turnAmount:int;
        private var _1157441892CloseBtn:Button;
        private var _488962728wareName:Label;
        private var _113425861xText:NumberInput;
        private var _2116180394itemEum:ItemEum;
        private var _114349382yText:NumberInput;
        private var _770586659isNameVisible:Boolean;
        private var _100358090input:NumberInput;
        private var _3560248tips:String;
        private var _984906006isLoveVisible:Boolean;
        private var _1328457436myAmount:int;
        private var _738344555iconFile:Image;
        private var _1877255560useGoodGuide:GuideArrow;
        private var _447444180descriptionTxt:TextArea;
        private var _1180489451isGate:Boolean = false;
        private var _348630820submitBtn:Button;
        private var _1524533386itemCanUse:Boolean = false;
        private var _1957956080dstName:TextInput;
        private var _1948316758initNum:String = "1";
        private var _401431442OpenBtn:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":450,
                    "height":280,
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
                        "type":Button,
                        "id":"submitBtn",
                        "events":{"click":"__submitBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "17";
                            this.right = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"b75"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"OpenBtn",
                        "events":{"click":"__OpenBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "35";
                            this.right = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"Open",
                                "styleName":"b75"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"CloseBtn",
                        "events":{"click":"__CloseBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "10";
                            this.right = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"Close",
                                "styleName":"b75"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "8";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":4,
                                            "text":"VIEW",
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"descriptionTxt",
                        "stylesFactory":function ():void
                        {
                            this.backgroundAlpha = 0;
                            this.left = "20";
                            this.right = "20";
                            this.top = "103";
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":120,
                                "styleName":"ParamgraphText1",
                                "editable":false,
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"iconFile",
                        "events":{
                            "mouseOver":"__iconFile_mouseOver",
                            "mouseOut":"__iconFile_mouseOut",
                            "mouseMove":"__iconFile_mouseMove",
                            "complete":"__iconFile_complete"
                        },
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.top = "33";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":64,
                                "height":64
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "89";
                            this.top = "43";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":57,
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "top";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":0,
                                            "percentWidth":100,
                                            "height":23,
                                            "x":2,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "height":23,
                                                        "styleName":"textBackGroundFillColor",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_UseGoodWin_Label2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                                this.horizontalCenter = "0";
                                                                this.verticalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({"type":VRule})]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":2,
                                            "y":31,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"wareName",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "height":20,
                                                        "styleName":"tableContent1"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.bottom = "17";
                            this.horizontalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_UseGoodWin_Label4",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 12;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText1",
                                            "width":264
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":NumberInput,
                                    "id":"input",
                                    "events":{"change":"__input_change"},
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":50,
                                            "maxChars":3
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.bottom = "17";
                            this.horizontalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_UseGoodWin_Label5",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 12;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText1",
                                            "text":"Please input player name:",
                                            "width":220
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"dstName",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":60});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.bottom = "17";
                            this.horizontalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_UseGoodWin_Label6",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 12;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText1",
                                            "text":"Please input target coordinates: X",
                                            "width":220
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":NumberInput,
                                    "id":"xText",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":30,
                                            "maxChars":3
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_UseGoodWin_Label7",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 12;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText1",
                                            "text":" Y",
                                            "width":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":NumberInput,
                                    "id":"yText",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":30,
                                            "maxChars":3
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___UseGoodWin_Button4_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":0,
                                "styleName":"close"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"useGoodGuide",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "31";
                            this.right = "31";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"arrowLGuide"});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function UseGoodWin()
        {
            mx_internal::_document = this;
            this.width = 450;
            this.height = 280;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            UseGoodWin._watcherSetupUtil = _arg_1;
        }

        public static function getInstance():UseGoodWin
        {
            if (instance == null)
            {
                instance = new (UseGoodWin)();
            };
            return (instance);
        }

        public static function show(_arg_1:String, _arg_2:int):void
        {
            instance.myAmount = _arg_2;
            instance._itemEum = _arg_1;
            instance.isTrue = instance.isLuckyCharm(_arg_1);
            instance.isLoveVisible = instance.isDevil(_arg_1);
            instance.isNameVisible = instance.isAngel(_arg_1);
            instance.initNum = "1";
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                PopUpManager.addPopUp(instance, MainFrame.instance, true);
                if ((Application.application.width - instance.width) > 0)
                {
                    instance.x = (((Application.application.width - instance.width) / 2) - 150);
                    instance.y = (((Application.application.height - instance.height) / 2) - 30);
                    PopUpManager.bringToFront(instance);
                }
                else
                {
                    PopUpManager.centerPopUp(instance);
                };
            };
            instance.isGate = instance.isGateControl(_arg_1);
        }


        private function set myPanelHeight(_arg_1:int):void
        {
            var _local_2:Object = this._888567041myPanelHeight;
            if (_local_2 !== _arg_1)
            {
                this._888567041myPanelHeight = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myPanelHeight", _local_2, _arg_1));
            };
        }

        private function addFund(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
            };
        }

        [Bindable(event="propertyChange")]
        private function get isGate():Boolean
        {
            return (this._1180489451isGate);
        }

        [Bindable(event="propertyChange")]
        private function get myPanelHeight():int
        {
            return (this._888567041myPanelHeight);
        }

        private function set itemCanUse(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1524533386itemCanUse;
            if (_local_2 !== _arg_1)
            {
                this._1524533386itemCanUse = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemCanUse", _local_2, _arg_1));
            };
        }

        public function set useGoodGuide(_arg_1:GuideArrow):void
        {
            var _local_2:Object = this._1877255560useGoodGuide;
            if (_local_2 !== _arg_1)
            {
                this._1877255560useGoodGuide = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "useGoodGuide", _local_2, _arg_1));
            };
        }

        public function ___UseGoodWin_Button4_click(_arg_1:MouseEvent):void
        {
            closeMe();
        }

        public function set OpenBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._401431442OpenBtn;
            if (_local_2 !== _arg_1)
            {
                this._401431442OpenBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "OpenBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get isLoveVisible():Boolean
        {
            return (this._984906006isLoveVisible);
        }

        private function doUseSilver(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                ActionFactory.getInstance().getShopCommands().useGoods(Context.getInstance().getCurCastle().id, this.itemEum.id, 1);
            };
        }

        public function set iconFile(_arg_1:Image):void
        {
            var _local_2:Object = this._738344555iconFile;
            if (_local_2 !== _arg_1)
            {
                this._738344555iconFile = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iconFile", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get submitBtn():Button
        {
            return (this._348630820submitBtn);
        }

        private function checkOut(_arg_1:String, _arg_2:String=null):void
        {
            var _local_5:ItemBean;
            var _local_3:Boolean;
            PopUpManager.removePopUp(this);
            var _local_4:int;
            while (_local_4 < Context.getInstance().getPlayerBean().itemsArray.length)
            {
                _local_5 = Context.getInstance().getPlayerBean().getItems(_local_4);
                if (((_local_5.id == _arg_1) && (_local_5.count >= 1)))
                {
                    _local_3 = true;
                    if (_arg_2 == null)
                    {
                        ActionFactory.getInstance().getShopCommands().useGoods(Context.getInstance().getCurCastle().id, _arg_1, 1);
                    }
                    else
                    {
                        ActionFactory.getInstance().getShopCommands().useGoods(Context.getInstance().getCurCastle().id, _arg_2, 1);
                    };
                };
                _local_4++;
            };
            if (_local_3 != true)
            {
                AlertWin.show(((Lang.msg("没有") + ItemEumDefine.getItemEum(_arg_1).name) + Lang.msg("使用")));
            };
        }

        private function setValue(_arg_1:Event):void
        {
            this.openAddMoneyUrl();
            if (int(this.input.text) < 1)
            {
                AlertWin.show(Lang.msg("请至少输入一个"));
                input.text = "1";
            };
        }

        private function set isGate(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1180489451isGate;
            if (_local_2 !== _arg_1)
            {
                this._1180489451isGate = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isGate", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get tips():String
        {
            return (this._3560248tips);
        }

        private function set isLoveVisible(_arg_1:Boolean):void
        {
            var _local_2:Object = this._984906006isLoveVisible;
            if (_local_2 !== _arg_1)
            {
                this._984906006isLoveVisible = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isLoveVisible", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get myAmount():int
        {
            return (this._1328457436myAmount);
        }

        private function moveCityResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("迁城成功"), null);
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        public function get yText():NumberInput
        {
            return (this._114349382yText);
        }

        public function set submitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._348630820submitBtn;
            if (_local_2 !== _arg_1)
            {
                this._348630820submitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "submitBtn", _local_2, _arg_1));
            };
        }

        private function set myAmount(_arg_1:int):void
        {
            var _local_2:Object = this._1328457436myAmount;
            if (_local_2 !== _arg_1)
            {
                this._1328457436myAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myAmount", _local_2, _arg_1));
            };
        }

        public function set wareName(_arg_1:Label):void
        {
            var _local_2:Object = this._488962728wareName;
            if (_local_2 !== _arg_1)
            {
                this._488962728wareName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wareName", _local_2, _arg_1));
            };
        }

        private function useGoodResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("callByIngameUse", this.itemEum.id, this.itemEum.name, this.itemEum.itemType, this.itemEum.price);
                };
                AlertWin.show(Lang.msg("成功使用物品"), null);
                MyTreasure.instance.refresh();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get initNum():String
        {
            return (this._1948316758initNum);
        }

        public function set itemEum(_arg_1:ItemEum):void
        {
            var _local_2:Object = this._2116180394itemEum;
            if (_local_2 !== _arg_1)
            {
                this._2116180394itemEum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemEum", _local_2, _arg_1));
            };
        }

        private function doAddCents(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                AddFundWin.gotoPurchasePage();
            };
        }

        [Bindable(event="propertyChange")]
        public function get CloseBtn():Button
        {
            return (this._1157441892CloseBtn);
        }

        private function _UseGoodWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("使用物品");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                submitBtn.label = _arg_1;
            }, "submitBtn.label");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.itemCanUse);
            }, function (_arg_1:Boolean):void
            {
                submitBtn.visible = _arg_1;
            }, "submitBtn.visible");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isGate);
            }, function (_arg_1:Boolean):void
            {
                OpenBtn.visible = _arg_1;
            }, "OpenBtn.visible");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isGate);
            }, function (_arg_1:Boolean):void
            {
                CloseBtn.visible = _arg_1;
            }, "CloseBtn.visible");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.itemEum.desc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                descriptionTxt.text = _arg_1;
            }, "descriptionTxt.text");
            result[4] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.itemEum.iconUrl);
            }, function (_arg_1:Object):void
            {
                iconFile.source = _arg_1;
            }, "iconFile.source");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("宝物");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UseGoodWin_Label2.text = _arg_1;
            }, "_UseGoodWin_Label2.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.itemEum.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                wareName.text = _arg_1;
            }, "wareName.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("请输入使用数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UseGoodWin_Label4.text = _arg_1;
            }, "_UseGoodWin_Label4.text");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isTrue);
            }, function (_arg_1:Boolean):void
            {
                _UseGoodWin_Label4.visible = _arg_1;
            }, "_UseGoodWin_Label4.visible");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isTrue);
            }, function (_arg_1:Boolean):void
            {
                input.visible = _arg_1;
            }, "input.visible");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.initNum;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                input.text = _arg_1;
            }, "input.text");
            result[11] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isNameVisible);
            }, function (_arg_1:Boolean):void
            {
                _UseGoodWin_Label5.visible = _arg_1;
            }, "_UseGoodWin_Label5.visible");
            result[12] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isNameVisible);
            }, function (_arg_1:Boolean):void
            {
                dstName.visible = _arg_1;
            }, "dstName.visible");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isLoveVisible);
            }, function (_arg_1:Boolean):void
            {
                _UseGoodWin_Label6.visible = _arg_1;
            }, "_UseGoodWin_Label6.visible");
            result[14] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isLoveVisible);
            }, function (_arg_1:Boolean):void
            {
                xText.visible = _arg_1;
            }, "xText.visible");
            result[15] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isLoveVisible);
            }, function (_arg_1:Boolean):void
            {
                _UseGoodWin_Label7.visible = _arg_1;
            }, "_UseGoodWin_Label7.visible");
            result[16] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isLoveVisible);
            }, function (_arg_1:Boolean):void
            {
                yText.visible = _arg_1;
            }, "yText.visible");
            result[17] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 14);
            }, function (_arg_1:Boolean):void
            {
                useGoodGuide.includeInLayout = _arg_1;
            }, "useGoodGuide.includeInLayout");
            result[18] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 14);
            }, function (_arg_1:Boolean):void
            {
                useGoodGuide.visible = _arg_1;
            }, "useGoodGuide.visible");
            result[19] = binding;
            return (result);
        }

        private function onMouseOut():void
        {
            DescribeTooltip.hide();
        }

        public function get _itemEum():String
        {
            return (this.itemEum.id);
        }

        private function set tips(_arg_1:String):void
        {
            var _local_2:Object = this._3560248tips;
            if (_local_2 !== _arg_1)
            {
                this._3560248tips = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tips", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get useGoodGuide():GuideArrow
        {
            return (this._1877255560useGoodGuide);
        }

        private function checkAmount():void
        {
            var _local_2:ItemBean;
            var _local_1:int;
            while (_local_1 < Context.getInstance().getPlayerBean().itemsArray.length)
            {
                _local_2 = Context.getInstance().getPlayerBean().getItems(_local_1);
                if (((this.itemEum.id == _local_2.id) && (_local_2.count > 0)))
                {
                    this.myAmount = _local_2.count;
                    return;
                };
                _local_1++;
            };
        }

        private function itemCanUseOrNot():void
        {
            if ((((((((((((((((((this.itemEum.id == "consume.key.3") || (this.itemEum.id == "consume.key.2")) || (this.itemEum.id == "consume.key.1")) || (this.itemEum.id == "consume.move.1")) || (this.itemEum.id == "player.more.castle.1.a")) || (this.itemEum.id == "player.heart.1.a ")) || (this.itemEum.id == "player.pop.1.a")) || (this.itemEum.id.indexOf("equipment.box.") == 0)) || (this.itemEum.id == "alliance.ritual_of_pact.advanced")) || (this.itemEum.id == "alliance.ritual_of_pact.premium")) || (this.itemEum.id == "alliance.ritual_of_pact.ultimate")) || (this.itemEum.id == "player.speak.bronze_publicity_ambassador.permanent")) || (this.itemEum.id == "player.speak.bronze_publicity_ambassador.permanent.15")) || (this.itemEum.id == "player.speak.gold_publicity_ambassador.15")) || (this.itemEum.id == "player.speak.gold_publicity_ambassador.permanent")) || (this.itemEum.id == "player.speak.silver_publicity_ambassador.15")) || (this.itemEum.id == "player.speak.silver_publicity_ambassador.permanent")))
            {
                itemCanUse = true;
                return;
            };
            if (((isAngel(this.itemEum.id)) || (isDevil(this.itemEum.id))))
            {
                itemCanUse = true;
                return;
            };
            if (((((((((((((((((((((((((((((((((((((((((((((((((((((((this.itemEum.playerItem) && (!(this.itemEum.id == "player.troop.1.a"))) && (!(this.itemEum.id == "player.key.evony_easter_package"))) && (!(this.itemEum.id == "player.item.candy"))) && (!(this.itemEum.id == "player.item.turkeyhunt"))) && (!(this.itemEum.id == "player.item.snowball"))) && (!(this.itemEum.id == "player.item.pieceofrainbow"))) && (!(this.itemEum.id == "player.item.wolfpaw"))) && (!(this.itemEum.id == "player.bone.key"))) && (!(this.itemEum.id == "player.item.gildedhorn"))) && (!(this.itemEum.id == "player.item.candy.2013"))) && (!(this.itemEum.id == "player.item.harvesttoken"))) && (!(this.itemEum.id == "player.item.huntersstones"))) && (!(this.itemEum.id == "player.item.relicofthekrampus"))) && (!(this.itemEum.id == "player.item.quest.shakespear"))) && (!(this.itemEum.id == "player.key.keyofcrossing"))) && (!(this.itemEum.id == "player.key.birthdaykey"))) && (!(this.itemEum.id == "player.key.malebolgian"))) && (!(this.itemEum.id == "player.key.keyofdonar"))) && (!(this.itemEum.id == "player.item.candy.2014"))) && (!(this.itemEum.id == "player.item.harvesttoken.2014"))) && (!(this.itemEum.id == "player.key.jakekeyoftheharvest"))) && (!(this.itemEum.id == "player.key.starcrossedkey"))) && (!(this.itemEum.id == "player.key.faeryringkey"))) && (!(this.itemEum.id == "player.key.easterkey2015"))) && (!(this.itemEum.id == "player.key.birthdaykey.2015"))) && (!(this.itemEum.id == "player.key.thesquirrelskey"))) && (!(this.itemEum.id == "player.item.stygandrsbannerofthehorde"))) && (!(this.itemEum.id == "player.key.wheatsheafkey"))) && (!(this.itemEum.id == "player.key.thewitcheskey"))) && (!(this.itemEum.id == "player.key.goldhollykey"))) && (!(this.itemEum.id == "player.key.thehornedkey"))) && (!(this.itemEum.id == "player.key.thehallmarkkey"))) && (!(this.itemEum.id == "player.key.thesquirrelskey2"))) && (!(this.itemEum.id == "player.key.easterkey2017"))) && (!(this.itemEum.id == "player.key.birthdaykey2017"))) && (!(this.itemEum.id == "player.key.themoonsshard"))) && (!(this.itemEum.id == "player.key.bonekey"))) && (!(this.itemEum.id == "player.key.wheatsheafkey.2017"))) && (!(this.itemEum.id == "player.key.goldhollykey2017"))) && (!(this.itemEum.id == "player.key.thehallmarkkey2018"))) && (!(this.itemEum.id == "player.key.thesquirrelskey2018"))) && (!(this.itemEum.id == "player.key.easterkey2018"))) && (!(this.itemEum.id == "player.key.birthdaykey2018"))) && (!(this.itemEum.id == "player.key.wheatsheafkey2018"))) && (!(this.itemEum.id == "player.key.thewitcheskey2018"))) && (!(this.itemEum.id == "player.key.goldenkeyoftheharvest2018"))) && (!(this.itemEum.id == "player.key.goldhollykey2018"))) && (!(this.itemEum.id == "player.key.shadowshornkey2019"))) && (!(this.itemEum.id == "player.key.10thbirthdaykey"))) && (!(this.itemEum.id == "player.key.goldenkeyoftheharvest2019"))) && (!(this.itemEum.id == "player.item.harvesttoken2019"))) && (!(this.itemEum.id == "player.key.goldhollykey2019"))) && (this.itemEum.id.indexOf(".quest.") == -1)))
            {
                itemCanUse = true;
                return;
            };
            if (this.itemEum.id == "player.item.stoneoffinding")
            {
                itemCanUse = true;
                return;
            };
            itemCanUse = false;
        }

        private function isGateControl(_arg_1:String):Boolean
        {
            if (_arg_1 == "player.box.present.money.77")
            {
                submitBtn.visible = false;
                return (true);
            };
            return (false);
        }

        public function set yText(_arg_1:NumberInput):void
        {
            var _local_2:Object = this._114349382yText;
            if (_local_2 !== _arg_1)
            {
                this._114349382yText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "yText", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:UseGoodWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _UseGoodWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_UseGoodWinWatcherSetupUtil");
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
        public function get iconFile():Image
        {
            return (this._738344555iconFile);
        }

        private function isLuckyCharm(_arg_1:String):Boolean
        {
            return ((_arg_1.length <= 22) && (_arg_1.substr(0, 20) == "player.box.gambling."));
        }

        public function set input(_arg_1:NumberInput):void
        {
            var _local_2:Object = this._100358090input;
            if (_local_2 !== _arg_1)
            {
                this._100358090input = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input", _local_2, _arg_1));
            };
        }

        private function isSpecialPacket(_arg_1:String):Boolean
        {
            var _local_3:ItemEum;
            var _local_2:Array = ItemEumDefine.getPacketItemEumArray();
            for each (_local_3 in _local_2)
            {
                if (_arg_1.indexOf(_local_3.id) >= 0)
                {
                    return (true);
                };
            };
            return (false);
        }

        [Bindable(event="propertyChange")]
        public function get OpenBtn():Button
        {
            return (this._401431442OpenBtn);
        }

        public function set xText(_arg_1:NumberInput):void
        {
            var _local_2:Object = this._113425861xText;
            if (_local_2 !== _arg_1)
            {
                this._113425861xText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "xText", _local_2, _arg_1));
            };
        }

        public function __input_change(_arg_1:Event):void
        {
            setValue(_arg_1);
        }

        private function openAddMoneyUrl():void
        {
            var _local_1:int = Context.getInstance().getPlayerBean().playerInfo.medal;
            if ((this.myAmount + int((_local_1 / 5))) <= 0)
            {
                PopUpManager.removePopUp(this);
                Turntable.instance.onClose();
                AddFundWin.show();
                return;
            };
            if (int(this.input.text) > (this.myAmount + int((_local_1 / 5))))
            {
                this.input.text = String((this.myAmount + int((_local_1 / 5))));
            };
        }

        public function set descriptionTxt(_arg_1:TextArea):void
        {
            var _local_2:Object = this._447444180descriptionTxt;
            if (_local_2 !== _arg_1)
            {
                this._447444180descriptionTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "descriptionTxt", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get wareName():Label
        {
            return (this._488962728wareName);
        }

        private function closeMe():void
        {
            PopUpManager.removePopUp(this);
        }

        [Bindable(event="propertyChange")]
        public function get itemEum():ItemEum
        {
            return (this._2116180394itemEum);
        }

        private function ClosebtnClickHandle(_arg_1:MouseEvent):void
        {
            PopUpManager.removePopUp(this);
            ActionFactory.getInstance().getShopCommands().useDevilItem(int(xText.text), int(yText.text), this.itemEum.id, "0", useGoodResponse);
        }

        private function set isTrue(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1180085800isTrue;
            if (_local_2 !== _arg_1)
            {
                this._1180085800isTrue = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isTrue", _local_2, _arg_1));
            };
        }

        private function setTips():void
        {
            if (this.itemEum.playerItem)
            {
                this.tips = ((Lang.msg("是否使用一个") + this.itemEum.name) + "?");
            };
        }

        private function OpenbtnClickHandle(_arg_1:MouseEvent):void
        {
            PopUpManager.removePopUp(this);
            ActionFactory.getInstance().getShopCommands().useDevilItem(int(xText.text), int(yText.text), this.itemEum.id, "1", useGoodResponse);
        }

        public function __OpenBtn_click(_arg_1:MouseEvent):void
        {
            OpenbtnClickHandle(_arg_1);
        }

        public function __iconFile_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get xText():NumberInput
        {
            return (this._113425861xText);
        }

        private function _UseGoodWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("使用物品");
            _local_1 = this.itemCanUse;
            _local_1 = this.isGate;
            _local_1 = this.isGate;
            _local_1 = this.itemEum.desc;
            _local_1 = this.itemEum.iconUrl;
            _local_1 = Lang.msg("宝物");
            _local_1 = this.itemEum.name;
            _local_1 = Lang.msg("请输入使用数量");
            _local_1 = this.isTrue;
            _local_1 = this.isTrue;
            _local_1 = this.initNum;
            _local_1 = this.isNameVisible;
            _local_1 = this.isNameVisible;
            _local_1 = this.isLoveVisible;
            _local_1 = this.isLoveVisible;
            _local_1 = this.isLoveVisible;
            _local_1 = this.isLoveVisible;
            _local_1 = (GuideStep.getInstance().currentStep == 14);
            _local_1 = (GuideStep.getInstance().currentStep == 14);
        }

        [Bindable(event="propertyChange")]
        public function get input():NumberInput
        {
            return (this._100358090input);
        }

        public function __iconFile_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        public function __CloseBtn_click(_arg_1:MouseEvent):void
        {
            ClosebtnClickHandle(_arg_1);
        }

        private function set initNum(_arg_1:String):void
        {
            var _local_2:Object = this._1948316758initNum;
            if (_local_2 !== _arg_1)
            {
                this._1948316758initNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "initNum", _local_2, _arg_1));
            };
        }

        public function __iconFile_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get itemCanUse():Boolean
        {
            return (this._1524533386itemCanUse);
        }

        private function btnClickHandle(_arg_1:MouseEvent):void
        {
            PopUpManager.removePopUp(this);
            if (this.itemEum.id == "player.item.stoneoffinding")
            {
                AllWindows.switchToFuncWindow(DisappearHeroList.EVENT_SHOW);
                return;
            };
            if (this.itemEum.id == "player.peace.1")
            {
                AlertWin.show(Lang.msg("外交书是在玩家信息中更改状态时使用"), null);
                return;
            };
            if (this.itemEum.id == "player.truce.dream")
            {
                StopWar.show(this.itemEum.id);
                PopUpManager.removePopUp(this);
                return;
            };
            if (this.itemEum.id == "player.box.present.4")
            {
                if (checkOffice())
                {
                    ActionFactory.getInstance().getShopCommands().useGoods(Context.getInstance().getCurCastle().id, this.itemEum.id, 1);
                }
                else
                {
                    AlertWin.show(this.itemEum.itemDesc, null);
                };
                return;
            };
            if ((((this.itemEum.id == "player.box.3") || (this.itemEum.id == "player.box.2")) || (this.itemEum.id == "player.box.1")))
            {
                if (this.itemEum.id == "player.box.3")
                {
                    checkOut("consume.key.3", "player.box.3");
                };
                if (this.itemEum.id == "player.box.2")
                {
                    checkOut("consume.key.2", "player.box.2");
                };
                if (this.itemEum.id == "player.box.1")
                {
                    checkOut("consume.key.1", "player.box.1");
                };
            }
            else
            {
                if (this.itemEum.id == "consume.move.1")
                {
                    if (canUseGood("consume.move.1"))
                    {
                        MoveCityWin.show(_arg_1);
                        PopUpManager.removePopUp(this);
                    }
                    else
                    {
                        AlertWin.show(Lang.msg("您没有迁城令"), null);
                    };
                }
                else
                {
                    if (this.itemEum.id == "player.more.castle.1.a")
                    {
                        if (canUseGood("player.more.castle.1.a"))
                        {
                            DesignatedMoveCityWin.show(_arg_1, 0);
                            PopUpManager.removePopUp(this);
                        }
                        else
                        {
                            AlertWin.show(Lang.msg("您没有高级迁城令"), null);
                        };
                    }
                    else
                    {
                        if (this.itemEum.id == "player.more.castle.1.c")
                        {
                            if (canUseGood("player.more.castle.1.c"))
                            {
                                DesignatedMoveCityWin2.show(_arg_1);
                                PopUpManager.removePopUp(this);
                            }
                            else
                            {
                                AlertWin.show(Lang.msg("您没有高级迁城令"), null);
                            };
                        }
                        else
                        {
                            if (this.itemEum.id == "consume.key.3")
                            {
                                checkOut("player.box.3");
                            }
                            else
                            {
                                if (this.itemEum.id == "consume.key.2")
                                {
                                    checkOut("player.box.2");
                                }
                                else
                                {
                                    if (this.itemEum.id == "consume.key.1")
                                    {
                                        checkOut("player.box.1");
                                    }
                                    else
                                    {
                                        if (((((((this.itemEum.id == "player.heart.1.a") || (this.itemEum.id == "player.pop.1.a")) || (this.itemEum.id == "player.haunted.castle")) || (this.itemEum.id == "player.haunted.castle.adv")) || (this.itemEum.id == "player.halloween.castle")) || (this.itemEum.id == "player.halloween.castle.adv")))
                                        {
                                            ActionFactory.getInstance().getShopCommands().useCastleGoods(Context.getInstance().getCurCastle().id, this.itemEum.id, useGoodResponse);
                                            return;
                                        };
                                        if (this.itemEum.id == "player.box.hero.npc")
                                        {
                                            ActionFactory.getInstance().getShopCommands().useGoods(Context.getInstance().getCurCastle().id, this.itemEum.id, 1);
                                        }
                                        else
                                        {
                                            if (this.itemEum.id == "player.box.gambling.3")
                                            {
                                                this.openAddMoneyUrl();
                                                if (this.isTrue)
                                                {
                                                    this.turnAmount = int(this.input.text);
                                                };
                                                ActionFactory.getInstance().getShopCommands().useGoods(Context.getInstance().getCurCastle().id, this.itemEum.id, 1);
                                            }
                                            else
                                            {
                                                if (this.itemEum.id == "player.box.hero.npc")
                                                {
                                                    ActionFactory.getInstance().getShopCommands().useGoods(Context.getInstance().getCurCastle().id, this.itemEum.id, 1);
                                                }
                                                else
                                                {
                                                    if (isAngel(this.itemEum.id))
                                                    {
                                                        ActionFactory.getInstance().getShopCommands().useAngelItem(dstName.text.toString(), this.itemEum.id, useGoodResponse);
                                                    }
                                                    else
                                                    {
                                                        if (isDevil(this.itemEum.id))
                                                        {
                                                            ActionFactory.getInstance().getShopCommands().useDevilItem(int(xText.text), int(yText.text), this.itemEum.id, "", useGoodResponse);
                                                        }
                                                        else
                                                        {
                                                            if (this.itemEum.id == "player.box.hero.e")
                                                            {
                                                                AlertWin.show("You have got a great hero! Please find him/her in your feasting hall.");
                                                            };
                                                            if (this.itemEum.id == "player.box.hero.f")
                                                            {
                                                                AlertWin.show("You have got a great hero! Please find him/her in your feasting hall.");
                                                            };
                                                            if (this.itemEum.id == "player.move.castle.1.b")
                                                            {
                                                                DesignatedMoveCityWin.show(_arg_1, 1);
                                                                PopUpManager.removePopUp(this);
                                                            };
                                                            if (this.itemEum.id != "player.more.castle.1.b")
                                                            {
                                                                ActionFactory.getInstance().getShopCommands().useGoods(Context.getInstance().getCurCastle().id, this.itemEum.id, 1);
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (Context.getInstance().needUserGuide)
            {
                if (GuideStep.getInstance().currentStep == 14)
                {
                    GuideStep.getInstance().step14();
                };
            };
        }

        public function set _itemEum(_arg_1:String):void
        {
            this.itemEum = ItemEumDefine.getItemEum(_arg_1);
            myPanelHeight = (Math.ceil(this.itemEum.desc.length) + 80);
            setTips();
            itemCanUseOrNot();
        }

        public function set CloseBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1157441892CloseBtn;
            if (_local_2 !== _arg_1)
            {
                this._1157441892CloseBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "CloseBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get isTrue():Boolean
        {
            return (this._1180085800isTrue);
        }

        [Bindable(event="propertyChange")]
        public function get descriptionTxt():TextArea
        {
            return (this._447444180descriptionTxt);
        }

        public function __submitBtn_click(_arg_1:MouseEvent):void
        {
            btnClickHandle(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get isNameVisible():Boolean
        {
            return (this._770586659isNameVisible);
        }

        public function set dstName(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1957956080dstName;
            if (_local_2 !== _arg_1)
            {
                this._1957956080dstName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dstName", _local_2, _arg_1));
            };
        }

        private function checkOffice():Boolean
        {
            var _local_3:BuildingBean;
            var _local_1:Boolean;
            var _local_2:int;
            while (_local_2 < Context.getInstance().getCurCastle().buildingsArray.length)
            {
                _local_3 = Context.getInstance().getCurCastle().getBuildings(_local_2);
                if (((_local_3.typeId == BuildingConstants.TYPE_TOWN_HALL) && (_local_3.level > 2)))
                {
                    _local_1 = true;
                    break;
                };
                _local_2++;
            };
            return (_local_1);
        }

        private function set isNameVisible(_arg_1:Boolean):void
        {
            var _local_2:Object = this._770586659isNameVisible;
            if (_local_2 !== _arg_1)
            {
                this._770586659isNameVisible = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isNameVisible", _local_2, _arg_1));
            };
        }

        private function doBuySilver(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                ActionFactory.getInstance().getShopCommands().buy("player.key.silver", 1);
                ActionFactory.getInstance().getShopCommands().useGoods(Context.getInstance().getCurCastle().id, this.itemEum.id, 1);
            }
            else
            {
                AlertWin.show("1 Special Chest Key is required. Click Get Key for detail.", doAddCents, "Get Key", Lang.msg("取消"));
            };
        }

        private function isDevil(_arg_1:String):Boolean
        {
            if (((((_arg_1 == "player.box.present.money.75") || (_arg_1 == "player.box.present.money.76")) || (_arg_1 == "player.box.present.money.77")) || (_arg_1 == "player.box.present.money.74")))
            {
                return (true);
            };
            return (false);
        }

        [Bindable(event="propertyChange")]
        public function get dstName():TextInput
        {
            return (this._1957956080dstName);
        }

        public function __iconFile_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        private function isAngel(_arg_1:String):Boolean
        {
            if ((((_arg_1 == "player.box.present.money.70") || (_arg_1 == "player.box.present.money.71")) || (_arg_1 == "player.box.present.money.72")))
            {
                return (true);
            };
            return (false);
        }

        private function onMouseOver(_arg_1:MouseEvent):void
        {
            DescribeTooltip.show(this.itemEum.name, this.itemEum.itemDesc, _arg_1);
        }

        private function canUseGood(_arg_1:String):Boolean
        {
            var _local_4:ItemBean;
            var _local_2:Boolean;
            var _local_3:int;
            while (_local_3 < Context.getInstance().getPlayerBean().itemsArray.length)
            {
                _local_4 = Context.getInstance().getPlayerBean().getItems(_local_3);
                if (((_local_4.id == _arg_1) && (_local_4.count >= 1)))
                {
                    _local_2 = true;
                    break;
                };
                _local_3++;
            };
            return (_local_2);
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            DescribeTooltip.move2Mouse(_arg_1);
        }


    }
}//package view.module.playerInfo

