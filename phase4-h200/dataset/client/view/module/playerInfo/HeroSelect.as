// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.HeroSelect

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.controls.CheckBox;
    import mx.controls.Label;
    import mx.controls.TextInput;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import mx.controls.Button;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import com.evony.client.action.ActionFactory;
    import flash.events.Event;
    import mx.events.FlexEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import com.evony.Context;
    import com.evony.eum.LogoEumDefine;
    import mx.events.ItemClickEvent;
    import view.ui.AlertWinCost;
    import flash.display.Bitmap;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.constants.BuildingConstants;
    import view.AllWindows;
    import view.module.herosMansion.HerosMansion;
    import view.ui.AlertWin;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.beans.RandomHeroBean;
    import com.evony.common.module.hero.RandomHeroResponse;
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

    public class HeroSelect extends Canvas implements IBindingClient 
    {

        public static var instance:HeroSelect = new (HeroSelect)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _HeroSelect_Image1:Image;
        private var _3052621chk3:CheckBox;
        private var _459172079IntelligenceTxt:Label;
        private var _3052620chk2:CheckBox;
        private var _642046766SexFlag:Boolean = true;
        private var _2096610540playername:TextInput;
        private var iResetCount:int = 0;
        private var _1525053160AttackTxt:Label;
        private var sex:int = 0;
        private var _3052619chk1:CheckBox;
        private var _571486424faceSource:String;
        private var faceIndex:int = 0;
        private var _1286766383PoliticsTxt:Label;
        private var _879022499txtCost:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":500,
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
                                            "text":"RECRUIT HERO",
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 10;
                            this.horizontalCenter = "0";
                            this.horizontalAlign = "center";
                            this.top = "160";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 10;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___HeroSelect_Button1_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"previous"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___HeroSelect_Button2_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"next"});
                                                }
                                            })]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 10;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Name: ",
                                                        "styleName":"ParamgraphText1"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"playername",
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                }
                                            })]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 10;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Politics:    ",
                                                        "styleName":"ParamgraphText1"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"PoliticsTxt",
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"50",
                                                        "styleName":"ParamgraphText1"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CheckBox,
                                                "id":"chk1",
                                                "events":{"change":"__chk1_change"}
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Lock",
                                                        "toolTip":"Locked attributes will not change during the reset",
                                                        "styleName":"ParamgraphText1"
                                                    });
                                                }
                                            })]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 10;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Attack:     ",
                                                        "styleName":"ParamgraphText1"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"AttackTxt",
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"50",
                                                        "styleName":"ParamgraphText1"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CheckBox,
                                                "id":"chk2",
                                                "events":{"change":"__chk2_change"}
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Lock",
                                                        "toolTip":"Locked attributes will not change during the reset",
                                                        "styleName":"ParamgraphText1"
                                                    });
                                                }
                                            })]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 10;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Intelligence: ",
                                                        "styleName":"ParamgraphText1"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"IntelligenceTxt",
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"50",
                                                        "styleName":"ParamgraphText1"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CheckBox,
                                                "id":"chk3",
                                                "events":{"change":"__chk3_change"}
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Lock    ",
                                                        "toolTip":"Locked attributes will not change during the reset",
                                                        "styleName":"ParamgraphText1"
                                                    });
                                                }
                                            })]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 10;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"txtCost",
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                    this.color = 0xFF0000;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Free reset of attributes 3 times today ",
                                                        "styleName":"ParamgraphText1"
                                                    });
                                                }
                                            })]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___HeroSelect_Button3_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "50";
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Reset Attributes",
                                            "styleName":"Blue75"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___HeroSelect_Button4_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "50";
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Recruit",
                                            "styleName":"Blue75"
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"_HeroSelect_Image1",
                        "events":{"complete":"___HeroSelect_Image1_complete"},
                        "stylesFactory":function ():void
                        {
                            this.top = "43";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":100,
                                "height":100,
                                "x":170
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___HeroSelect_Button5_click"},
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
                    })]
                });
            }
        });
        private var faceArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function HeroSelect()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 500;
            this.addEventListener("creationComplete", ___HeroSelect_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            HeroSelect._watcherSetupUtil = _arg_1;
        }

        public static function show():void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
                ActionFactory.getInstance().getHeroCommand().GetRandomHero(instance.onHeroResponse);
            };
        }


        public function __chk3_change(_arg_1:Event):void
        {
            onLockChange3();
        }

        public function ___HeroSelect_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        override public function initialize():void
        {
            var target:HeroSelect;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _HeroSelect_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_HeroSelectWatcherSetupUtil");
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
        public function get IntelligenceTxt():Label
        {
            return (this._459172079IntelligenceTxt);
        }

        public function set chk3(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._3052621chk3;
            if (_local_2 !== _arg_1)
            {
                this._3052621chk3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chk3", _local_2, _arg_1));
            };
        }

        public function ___HeroSelect_Button1_click(_arg_1:MouseEvent):void
        {
            changeFace(-1);
        }

        private function init():void
        {
            var _local_2:int;
            this.sex = Context.getInstance().getPlayerBean().playerInfo.sex;
            this.faceArray = LogoEumDefine.getMalePlayerLogoArray();
            var _local_1:ArrayCollection = LogoEumDefine.getFemalePlayerLogoArray();
            _local_2 = 0;
            while (_local_2 < _local_1.length)
            {
                this.faceArray.addItem(_local_1[_local_2]);
                _local_2++;
            };
            _local_2 = 0;
            while (_local_2 < this.faceArray.length)
            {
                if (this.faceArray[_local_2].toString() == Context.getInstance().getPlayerBean().playerInfo.faceUrl)
                {
                    this.faceIndex = _local_2;
                    break;
                };
                _local_2++;
            };
            this.faceSource = this.faceArray[faceIndex];
            this.playername.text = Context.getInstance().getPlayerBean().playerInfo.userName;
        }

        public function ___HeroSelect_Button3_click(_arg_1:MouseEvent):void
        {
            onReset();
        }

        private function onItemSelectedOk(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                ActionFactory.getInstance().getHeroCommand().RetSetHeroAttri(this.chk1.selected, this.chk2.selected, this.chk3.selected, false, onHeroResponse);
            };
        }

        public function __chk2_change(_arg_1:Event):void
        {
            onLockChange2();
        }

        private function handleSex(_arg_1:ItemClickEvent):void
        {
            this.sex = _arg_1.index;
            this.resetFaceArray();
        }

        public function ___HeroSelect_Button5_click(_arg_1:MouseEvent):void
        {
            MinePopupManager.instance.removePopup();
        }

        private function set SexFlag(_arg_1:Boolean):void
        {
            var _local_2:Object = this._642046766SexFlag;
            if (_local_2 !== _arg_1)
            {
                this._642046766SexFlag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "SexFlag", _local_2, _arg_1));
            };
        }

        private function _HeroSelect_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.faceSource);
            }, function (_arg_1:Object):void
            {
                _HeroSelect_Image1.source = _arg_1;
            }, "_HeroSelect_Image1.source");
            result[0] = binding;
            return (result);
        }

        private function changeFace(_arg_1:int):void
        {
            this.faceIndex = (this.faceIndex + _arg_1);
            if (this.faceIndex < 0)
            {
                this.faceIndex = (this.faceArray.length - 1);
            }
            else
            {
                if (this.faceIndex >= this.faceArray.length)
                {
                    this.faceIndex = 0;
                };
            };
            this.faceSource = this.faceArray[this.faceIndex];
        }

        public function set chk1(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._3052619chk1;
            if (_local_2 !== _arg_1)
            {
                this._3052619chk1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chk1", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get PoliticsTxt():Label
        {
            return (this._1286766383PoliticsTxt);
        }

        private function onReset():void
        {
            if (Context.getInstance().bCostSure)
            {
                AlertWinCost.show(txtCost.text, onItemSelectedOk, "Ok", "Cancel");
            }
            else
            {
                onItemSelectedOk(true);
            };
        }

        public function set IntelligenceTxt(_arg_1:Label):void
        {
            var _local_2:Object = this._459172079IntelligenceTxt;
            if (_local_2 !== _arg_1)
            {
                this._459172079IntelligenceTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "IntelligenceTxt", _local_2, _arg_1));
            };
        }

        public function ___HeroSelect_Image1_complete(_arg_1:Event):void
        {
            onLoadComplete(_arg_1);
        }

        public function set chk2(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._3052620chk2;
            if (_local_2 !== _arg_1)
            {
                this._3052620chk2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chk2", _local_2, _arg_1));
            };
        }

        private function calCost():void
        {
            var _local_1:int;
            if (iResetCount == 0)
            {
                _local_1 = 0;
                if (this.chk1.selected)
                {
                    _local_1++;
                };
                if (this.chk2.selected)
                {
                    _local_1++;
                };
                if (this.chk3.selected)
                {
                    _local_1++;
                };
                if (_local_1 == 1)
                {
                    txtCost.text = "This reset costs 20 coins and 20,000 gold";
                }
                else
                {
                    if (_local_1 == 2)
                    {
                        txtCost.text = "This reset costs 40 coins and 40,000 gold";
                    }
                    else
                    {
                        txtCost.text = "This reset costs 10 coins and 10,000 gold";
                    };
                };
            };
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            Bitmap(_arg_1.target.content).smoothing = true;
        }

        private function set faceSource(_arg_1:String):void
        {
            var _local_2:Object = this._571486424faceSource;
            if (_local_2 !== _arg_1)
            {
                this._571486424faceSource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "faceSource", _local_2, _arg_1));
            };
        }

        private function onResponse(_arg_1:CommandResponse):void
        {
            var _local_2:BuildingBean;
            if (_arg_1.ok == 1)
            {
                MinePopupManager.instance.removePopup();
                for each (_local_2 in Context.getInstance().getCurCastle().buildingsArray)
                {
                    if (_local_2.typeId == BuildingConstants.TYPE_HEROS_MANSION)
                    {
                        AllWindows.switchToBuildingWindow(HerosMansion.EVENT_SHOW, _local_2);
                        return;
                    };
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set txtCost(_arg_1:Label):void
        {
            var _local_2:Object = this._879022499txtCost;
            if (_local_2 !== _arg_1)
            {
                this._879022499txtCost = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtCost", _local_2, _arg_1));
            };
        }

        private function _HeroSelect_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.faceSource;
        }

        public function __chk1_change(_arg_1:Event):void
        {
            onLockChange1();
        }

        [Bindable(event="propertyChange")]
        public function get chk3():CheckBox
        {
            return (this._3052621chk3);
        }

        public function set AttackTxt(_arg_1:Label):void
        {
            var _local_2:Object = this._1525053160AttackTxt;
            if (_local_2 !== _arg_1)
            {
                this._1525053160AttackTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "AttackTxt", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get chk1():CheckBox
        {
            return (this._3052619chk1);
        }

        [Bindable(event="propertyChange")]
        private function get SexFlag():Boolean
        {
            return (this._642046766SexFlag);
        }

        private function onHeroResponse(_arg_1:RandomHeroResponse):void
        {
            var _local_2:RandomHeroBean;
            if (_arg_1.ok)
            {
                _local_2 = _arg_1.randomherobean;
                iResetCount = _local_2.resetcount;
                calCost();
                this.PoliticsTxt.text = _local_2.management.toString();
                this.AttackTxt.text = _local_2.power.toString();
                this.IntelligenceTxt.text = _local_2.stratagem.toString();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        public function get chk2():CheckBox
        {
            return (this._3052620chk2);
        }

        [Bindable(event="propertyChange")]
        private function get faceSource():String
        {
            return (this._571486424faceSource);
        }

        [Bindable(event="propertyChange")]
        public function get txtCost():Label
        {
            return (this._879022499txtCost);
        }

        public function set PoliticsTxt(_arg_1:Label):void
        {
            var _local_2:Object = this._1286766383PoliticsTxt;
            if (_local_2 !== _arg_1)
            {
                this._1286766383PoliticsTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "PoliticsTxt", _local_2, _arg_1));
            };
        }

        private function onRecruit():void
        {
            if (this.playername.text.length == 0)
            {
                return;
            };
            ActionFactory.getInstance().getHeroCommand().GenSaveRandomHero(Context.getInstance().getCurCastle().id, this.playername.text, this.faceSource, onResponse);
        }

        public function ___HeroSelect_Button4_click(_arg_1:MouseEvent):void
        {
            onRecruit();
        }

        public function set playername(_arg_1:TextInput):void
        {
            var _local_2:Object = this._2096610540playername;
            if (_local_2 !== _arg_1)
            {
                this._2096610540playername = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playername", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get AttackTxt():Label
        {
            return (this._1525053160AttackTxt);
        }

        private function resetFaceArray():void
        {
            this.faceIndex = 0;
            if (this.sex == 0)
            {
                this.faceArray = LogoEumDefine.getMalePlayerLogoArray();
            }
            else
            {
                this.faceArray = LogoEumDefine.getFemalePlayerLogoArray();
            };
            this.faceSource = this.faceArray[this.faceIndex];
        }

        public function ___HeroSelect_Button2_click(_arg_1:MouseEvent):void
        {
            changeFace(1);
        }

        private function onLockChange1():void
        {
            if (((this.chk2.selected) && (this.chk3.selected)))
            {
                this.chk1.selected = false;
                return;
            };
            calCost();
        }

        private function onLockChange2():void
        {
            if (((this.chk1.selected) && (this.chk3.selected)))
            {
                this.chk2.selected = false;
                return;
            };
            calCost();
        }

        private function onLockChange3():void
        {
            if (((this.chk1.selected) && (this.chk2.selected)))
            {
                this.chk3.selected = false;
                return;
            };
            calCost();
        }

        [Bindable(event="propertyChange")]
        public function get playername():TextInput
        {
            return (this._2096610540playername);
        }


    }
}//package view.module.playerInfo

