// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.shop.Turntable

package view.module.shop
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import com.evony.common.module.shop.UseItemResultResponse;
    import mx.binding.IWatcherSetupUtil;
    import view.module.guide.GuideArrow;
    import flash.display.Loader;
    import com.evony.common.beans.PlayerBean;
    import com.evony.common.beans.ItemBean;
    import mx.controls.Button;
    import view.module.market.WalletShowAll;
    import com.evony.eum.ItemEum;
    import mx.core.UIComponent;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import com.evony.util.EvonyImage;
    import com.evony.util.UICache;
    import flash.utils.Timer;
    import mx.core.mx_internal;
    import com.evony.util.ResourceLoader;
    import com.evony.util.EvonyAnimation;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import com.evony.Context;
    import mx.events.PropertyChangeEvent;
    import mx.collections.ArrayCollection;
    import com.evony.eum.ItemEumDefine;
    import com.evony.GameConfig;
    import flash.events.TimerEvent;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.net.URLRequest;
    import com.evony.common.beans.CastleBean;
    import view.module.playerInfo.UseGoodWin;
    import com.evony.client.action.ActionFactory;
    import view.ui.AmountInputUI;
    import mx.managers.PopUpManager;
    import view.module.guide.GuideStep;
    import view.ui.DescribeTooltip;
    import view.ChatFrame;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Lang;
    import mx.events.FlexEvent;
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

    public class Turntable extends Canvas implements IBindingClient 
    {

        public static var instance:Turntable = new (Turntable)();
        private static const AMOUNT:int = 12;
        private static var pendingEvent:UseItemResultResponse = null;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _482839393closeHint:GuideArrow;
        private var _1495860549btnEnabled:Boolean;
        private var count:int = 0;
        private var iWaitCount:int = 0;
        private var _loader:Loader;
        private var _985752863player:PlayerBean;
        private var runCircle:uint;
        private var timerDelay:int = 10;
        private var total:int = 0;
        private var itemAry:Array;
        private var _1824893668stopBtnEnabld:Boolean;
        private var _1176977763itemBean:ItemBean;
        private var _1884363014stopBtn:Button;
        public var _Turntable_WalletShowAll1:WalletShowAll;
        private var _1132706763continueBtn:Button;
        private var itemEum:ItemEum;
        public var _Turntable_Button3:Button;
        private var _2138522996itemboxUi:UIComponent;
        private var _10782607mainCanvas:Canvas;
        private var _2000529757closeBtnEnabled:Boolean;
        public var _Turntable_Label1:Label;
        public var _Turntable_Label2:Label;
        private var _1478417739itemAmount:int = 0;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":525,
                    "height":506,
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
                                    "id":"_Turntable_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":6,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":UIComponent,
                        "id":"itemboxUi",
                        "stylesFactory":function ():void
                        {
                            this.left = "42";
                            this.top = "50";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "includeInLayout":true,
                                "width":445,
                                "height":435
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"mainCanvas",
                        "stylesFactory":function ():void
                        {
                            this.left = "17";
                            this.top = "30";
                            this.right = "12";
                            this.bottom = "10";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"fla/dynamic/ui234.swf@icon.png",
                                            "x":102.5,
                                            "y":360.5
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_Turntable_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 12;
                                        this.color = 0xFFFF00;
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":125,
                                            "y":362.5,
                                            "width":104.5
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":WalletShowAll,
                                    "id":"_Turntable_WalletShowAll1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":265,
                                            "y":362.5,
                                            "width":129,
                                            "height":20.5,
                                            "fontColor":0xFFFFFF
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"stopBtn",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "174";
                                        this.top = "330";
                                        this.fontSize = 12;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"y125"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"continueBtn",
                                    "events":{"click":"__continueBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "174";
                                        this.top = "330";
                                        this.fontSize = 12;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"y125"});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_Turntable_Button3",
                        "events":{"click":"___Turntable_Button3_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "41";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"closeHint",
                        "stylesFactory":function ():void
                        {
                            this.top = "20";
                            this.right = "55";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "type":"arrowTGuide",
                                "visible":false
                            });
                        }
                    })]
                });
            }
        });
        private var uiCache:UICache = new UICache(30);
        private var myTimer:Timer = new Timer(10, 0);
        private var turnTimer:Timer = new Timer(3000, 1);
        private var copyItemAry:Array = new Array();
        private var sendItemIdAry:Array = [];
        private var sendItemNumAry:Array = [];
        private var tooltipAry:Array = [];
        private var kindOneAry:Array = new Array();
        private var kindTowAry:Array = new Array();
        private var kindThreeAry:Array = new Array();
        private var kindFourAry:Array = new Array();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Turntable()
        {
            mx_internal::_document = this;
            this.width = 525;
            this.height = 506;
            this.addEventListener("creationComplete", ___Turntable_Canvas1_creationComplete);
        }

        public static function getInstance():Turntable
        {
            if (instance == null)
            {
                instance = new (Turntable)();
            };
            return (instance);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Turntable._watcherSetupUtil = _arg_1;
        }

        public static function turntableShow(_arg_1:UseItemResultResponse=null):void
        {
            pendingEvent = _arg_1;
            ResourceLoader.loadResource(EvonyAnimation.getAniInfoById(EvonyAnimation.TYPE_TurnTableItem).file, "", onItemMovieLoaded, ResourceLoader.LOAD_DEMAND);
        }

        private static function onItemMovieLoaded(_arg_1:Object):void
        {
            trace("onItemMovieLoaded");
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
            instance.player = Context.getInstance().getPlayerBean();
            instance.btnEnabled = false;
            instance.stopBtnEnabld = false;
            instance.closeBtnEnabled = false;
            instance.refresh(pendingEvent);
            instance.setItemCount();
        }


        public function set mainCanvas(_arg_1:Canvas):void
        {
            var _local_2:Object = this._10782607mainCanvas;
            if (_local_2 !== _arg_1)
            {
                this._10782607mainCanvas = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mainCanvas", _local_2, _arg_1));
            };
        }

        private function randomSort(_arg_1:Object, _arg_2:Object):Number
        {
            return (Math.random() - 0.5);
        }

        [Bindable(event="propertyChange")]
        public function get stopBtn():Button
        {
            return (this._1884363014stopBtn);
        }

        private function getKind(_arg_1:UseItemResultResponse):void
        {
            kindOneAry = [];
            kindTowAry = [];
            kindThreeAry = [];
            kindFourAry = [];
            this.itemBean = _arg_1.getItemBeans(0);
            if (this.itemBean.id == ".a")
            {
                this.itemBean.id = "player.box.hero.a";
            };
            var _local_2:ArrayCollection = _arg_1.gamblingItemsBeansArray;
            var _local_3:int;
            while (_local_3 < _local_2.length)
            {
                sendItemIdAry[_local_3] = _local_2.getItemAt(_local_3).id;
                sendItemNumAry[_local_3] = _local_2.getItemAt(_local_3).count;
                this.itemEum = ItemEumDefine.getItemEum(_local_2.getItemAt(_local_3).id);
                tooltipAry[_local_3] = this.itemEum;
                if (_local_2.getItemAt(_local_3).id == ".a")
                {
                    _local_2.getItemAt(_local_3).id = "player.box.hero.a";
                };
                if (_local_2.getItemAt(_local_3).kind == 1)
                {
                    kindOneAry.push(_local_3);
                }
                else
                {
                    if (_local_2.getItemAt(_local_3).kind == 2)
                    {
                        kindTowAry.push(_local_3);
                    }
                    else
                    {
                        if (_local_2.getItemAt(_local_3).kind == 3)
                        {
                            kindThreeAry.push(_local_3);
                        }
                        else
                        {
                            kindFourAry.push(_local_3);
                        };
                    };
                };
                _local_3++;
            };
            kindTowAry.sort(randomSort);
            kindThreeAry.sort(randomSort);
            kindFourAry.sort(randomSort);
            startSendItem();
        }

        private function init():void
        {
            this.setItemCount();
            var _local_1:int = int((GameConfig.instance.TurnTable_RunSeconds - 2));
            if (_local_1 <= 0)
            {
                _local_1 = 1;
            };
            runCircle = uint((_local_1 / 0.5));
            if (runCircle > 4)
            {
                runCircle = 4;
            };
            this.turnTimer.addEventListener(TimerEvent.TIMER, turnContinue);
        }

        private function randRange(_arg_1:Number, _arg_2:Number):Number
        {
            return (Math.floor((Math.random() * ((_arg_2 - _arg_1) + 1))) + _arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get stopBtnEnabld():Boolean
        {
            return (this._1824893668stopBtnEnabld);
        }

        public function ___Turntable_Button3_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        public function set itemboxUi(_arg_1:UIComponent):void
        {
            var _local_2:Object = this._2138522996itemboxUi;
            if (_local_2 !== _arg_1)
            {
                this._2138522996itemboxUi = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemboxUi", _local_2, _arg_1));
            };
        }

        public function __continueBtn_click(_arg_1:MouseEvent):void
        {
            useGoodWinShow();
        }

        [Bindable(event="propertyChange")]
        public function get continueBtn():Button
        {
            return (this._1132706763continueBtn);
        }

        private function onComplete():void
        {
            trace("onComplete");
        }

        private function startSendItem():void
        {
            if (_loader != null)
            {
                Object(_loader.content).startTurnTable(this.itemBean.id, this.itemBean.count, sendItemIdAry, sendItemNumAry, this.kindOneAry, this.kindTowAry, this.kindThreeAry, this.kindFourAry);
            }
            else
            {
                _loader = new Loader();
                _loader.contentLoaderInfo.addEventListener(Event.INIT, itemInit);
                _loader.load(new URLRequest(ResourceLoader.getNormalUrl("fla/dynamic/turnTable.swf")));
            };
        }

        private function set stopBtnEnabld(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1824893668stopBtnEnabld;
            if (_local_2 !== _arg_1)
            {
                this._1824893668stopBtnEnabld = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stopBtnEnabld", _local_2, _arg_1));
            };
        }

        public function set closeHint(_arg_1:GuideArrow):void
        {
            var _local_2:Object = this._482839393closeHint;
            if (_local_2 !== _arg_1)
            {
                this._482839393closeHint = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "closeHint", _local_2, _arg_1));
            };
        }

        private function turnContinue(_arg_1:TimerEvent):void
        {
            this.stopBtnEnabld = false;
            this.closeBtnEnabled = false;
            var _local_2:PlayerBean = Context.getInstance().getPlayerBean();
            var _local_3:CastleBean = Context.getInstance().getCurCastle();
            var _local_4:String = UseGoodWin.getInstance()._itemEum;
            ActionFactory.getInstance().getShopCommands().useGoods(_local_3.id, _local_4, 1);
        }

        [Bindable(event="propertyChange")]
        private function get btnEnabled():Boolean
        {
            return (this._1495860549btnEnabled);
        }

        public function onClose():void
        {
            this.closeHint.visible = false;
            AmountInputUI.instance.removeListener();
            PopUpManager.removePopUp(this);
            if (GuideStep.getInstance().currentStep == 13)
            {
                GuideStep.getInstance().step13();
            };
        }

        [Bindable(event="propertyChange")]
        private function get itemAmount():int
        {
            return (this._1478417739itemAmount);
        }

        [Bindable(event="propertyChange")]
        private function get closeBtnEnabled():Boolean
        {
            return (this._2000529757closeBtnEnabled);
        }

        [Bindable(event="propertyChange")]
        private function get itemBean():ItemBean
        {
            return (this._1176977763itemBean);
        }

        public function set continueBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1132706763continueBtn;
            if (_local_2 !== _arg_1)
            {
                this._1132706763continueBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "continueBtn", _local_2, _arg_1));
            };
        }

        public function onMouseOut():void
        {
            DescribeTooltip.hide();
        }

        [Bindable(event="propertyChange")]
        public function get mainCanvas():Canvas
        {
            return (this._10782607mainCanvas);
        }

        private function useGoodWinShow():void
        {
            var _local_1:String = UIUtil.checkItemAmulet();
            if (_local_1 != null)
            {
                UseGoodWin.show(_local_1, this.itemAmount);
            }
            else
            {
                UseGoodWin.show(UseGoodWin.getInstance()._itemEum, this.itemAmount);
            };
        }

        private function showResult():void
        {
            this.setItemCount();
            this.stopBtnEnabld = true;
            this.closeBtnEnabled = true;
            UseGoodWin.getInstance().turnAmount--;
            var _local_1:* = "Lord";
            var _local_2:int = Context.getInstance().getPlayerBean().playerInfo.sex;
            if (_local_2 != 0)
            {
                _local_1 = "Lady";
            };
            var _local_3:* = ((((((((("<FONT COLOR='#FF0000'>" + _local_1) + " ") + Context.getInstance().getPlayerBean().playerInfo.userName) + " gained </FONT>") + "<FONT COLOR='#0066FF'>") + this.itemBean.count) + " ") + ItemEumDefine.getItemEum(this.itemBean.id).name) + "</FONT><FONT COLOR='#FF0000'> from Amulet!</font>");
            ChatFrame.instance.onFinishInfoMSg(_local_3);
            if (UseGoodWin.getInstance().turnAmount > 0)
            {
                this.turnTimer.start();
            };
            if (UseGoodWin.getInstance().turnAmount == 0)
            {
                if (((Context.getInstance().needUserGuide) && (GuideStep.getInstance().currentStep == 13)))
                {
                    this.closeHint.visible = true;
                };
                this.btnEnabled = true;
                this.stopBtnEnabld = false;
                this.closeBtnEnabled = true;
            };
        }

        private function setItemCount():void
        {
            var _local_1:ArrayCollection = Context.getInstance().getPlayerBean().itemsArray;
            var _local_2:int;
            var _local_3:int;
            while (_local_3 < _local_1.length)
            {
                if (UIUtil.isAmulet(_local_1.getItemAt(_local_3).id))
                {
                    _local_2 = (_local_2 + _local_1.getItemAt(_local_3).count);
                };
                _local_3++;
            };
            this.itemAmount = _local_2;
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
        public function get itemboxUi():UIComponent
        {
            return (this._2138522996itemboxUi);
        }

        override public function initialize():void
        {
            var target:Turntable;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _Turntable_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_shop_TurntableWatcherSetupUtil");
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

        private function set itemAmount(_arg_1:int):void
        {
            var _local_2:Object = this._1478417739itemAmount;
            if (_local_2 !== _arg_1)
            {
                this._1478417739itemAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemAmount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get closeHint():GuideArrow
        {
            return (this._482839393closeHint);
        }

        public function finishTurn():void
        {
            showResult();
        }

        private function set closeBtnEnabled(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2000529757closeBtnEnabled;
            if (_local_2 !== _arg_1)
            {
                this._2000529757closeBtnEnabled = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "closeBtnEnabled", _local_2, _arg_1));
            };
        }

        private function set player(_arg_1:PlayerBean):void
        {
            var _local_2:Object = this._985752863player;
            if (_local_2 !== _arg_1)
            {
                this._985752863player = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "player", _local_2, _arg_1));
            };
        }

        private function itemInit(_arg_1:Event):void
        {
            this.itemboxUi.addChild(_loader);
            Object(_loader.content).startTurnTable(this.itemBean.id, this.itemBean.count, sendItemIdAry, sendItemNumAry, this.kindOneAry, this.kindTowAry, this.kindThreeAry, this.kindFourAry);
        }

        private function set itemBean(_arg_1:ItemBean):void
        {
            var _local_2:Object = this._1176977763itemBean;
            if (_local_2 !== _arg_1)
            {
                this._1176977763itemBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get player():PlayerBean
        {
            return (this._985752863player);
        }

        private function _Turntable_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("幸运之轮");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Turntable_Label1.text = _arg_1;
            }, "_Turntable_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Lang.msg("持有") + ": ") + this.itemAmount);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Turntable_Label2.text = _arg_1;
            }, "_Turntable_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():int
            {
                return (player.playerInfo.medal);
            }, function (_arg_1:int):void
            {
                _Turntable_WalletShowAll1.medal = _arg_1;
            }, "_Turntable_WalletShowAll1.medal");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("停止");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                stopBtn.label = _arg_1;
            }, "stopBtn.label");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.stopBtnEnabld);
            }, function (_arg_1:Boolean):void
            {
                stopBtn.enabled = _arg_1;
            }, "stopBtn.enabled");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("继续");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                continueBtn.label = _arg_1;
            }, "continueBtn.label");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnEnabled);
            }, function (_arg_1:Boolean):void
            {
                continueBtn.visible = _arg_1;
            }, "continueBtn.visible");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.closeBtnEnabled);
            }, function (_arg_1:Boolean):void
            {
                _Turntable_Button3.enabled = _arg_1;
            }, "_Turntable_Button3.enabled");
            result[7] = binding;
            return (result);
        }

        private function _Turntable_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("幸运之轮");
            _local_1 = ((Lang.msg("持有") + ": ") + this.itemAmount);
            _local_1 = player.playerInfo.medal;
            _local_1 = Lang.msg("停止");
            _local_1 = this.stopBtnEnabld;
            _local_1 = Lang.msg("继续");
            _local_1 = this.btnEnabled;
            _local_1 = this.closeBtnEnabled;
        }

        public function ___Turntable_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function refresh(_arg_1:UseItemResultResponse=null):void
        {
            if (((!(this.initialized)) && (_arg_1 == null)))
            {
                return;
            };
            this.getKind(_arg_1);
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

        public function onMouseMove(_arg_1:MouseEvent):void
        {
            DescribeTooltip.move2Mouse(_arg_1);
        }

        public function onMouseOver(_arg_1:MouseEvent, _arg_2:int):void
        {
            var _local_3:ItemEum = this.tooltipAry[_arg_2];
            DescribeTooltip.show(_local_3.name, _local_3.desc, _arg_1);
        }


    }
}//package view.module.shop

