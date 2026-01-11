// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.market.NewTradeWin

package view.module.market
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.RadioButton;
    import mx.controls.Label;
    import view.ui.NumberInput;
    import mx.controls.Text;
    import com.evony.common.beans.CastleResourceBean;
    import com.evony.common.beans.ResourceInfoBean;
    import mx.controls.Button;
    import mx.controls.RadioButtonGroup;
    import mx.controls.TextInput;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import view.ui.MyHRule;
    import mx.containers.HBox;
    import com.evony.common.beans.CastleBean;
    import com.evony.Context;
    import mx.core.mx_internal;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import flash.events.MouseEvent;
    import com.evony.MsgDispacther;
    import com.evony.events.AutomaticTradeEvent;
    import flash.events.Event;
    import mx.managers.PopUpManager;
    import com.evony.common.constants.TradeConstants;
    import mx.events.PropertyChangeEvent;
    import mx.events.ItemClickEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.client.action.ActionFactory;
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

    public class NewTradeWin extends Canvas implements IBindingClient 
    {

        public static const EVENT_BACK:String = "newTradeWin.back";
        public static const EVENT_TRADE_COMPLETE:String = "newTradeWin.tradeComplete";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1176951768priceStr:String = "";
        private var _110549828total:Number = 0;
        private var _996685547buyRadio:RadioButton;
        private var _106934601price:Number = 0;
        public var _NewTradeWin_Label1:Label;
        public var _NewTradeWin_Label2:Label;
        public var _NewTradeWin_Label3:Label;
        public var _NewTradeWin_Label4:Label;
        public var _NewTradeWin_Label5:Label;
        public var _NewTradeWin_Label6:Label;
        public var _NewTradeWin_Label7:Label;
        public var _NewTradeWin_Label8:Label;
        public var _NewTradeWin_Label9:Label;
        private var _1531832375sellRadio:RadioButton;
        private var _1018264811commission:Number = 0;
        private var _1413853096amount:Number = 0;
        public var _NewTradeWin_Label10:Label;
        private var _1231385006amountInput:NumberInput;
        public var _NewTradeWin_Text1:Text;
        private var _384920354resourceBean:CastleResourceBean;
        private var _1096237422resInfo:ResourceInfoBean;
        public var _NewTradeWin_Button2:Button;
        public var _NewTradeWin_Button3:Button;
        private var _164873549radiogroup1:RadioButtonGroup;
        private var tradeType:int = 0;
        private var _3446944post:Button;
        private var _1096374091resName:String;
        private var _1483663296priceInout:TextInput;
        private var resType:int = 0;
        private var _549659792canPost:Boolean = false;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalAlign = "center";
                            this.verticalGap = 1;
                            this.paddingTop = 10;
                            this.left = "5";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentHeight":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.strokeWidth = 1;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentWidth":95});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":25,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_NewTradeWin_Label1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyName1",
                                                        "width":130
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_NewTradeWin_Label2",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyValue1",
                                                        "width":164
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.strokeWidth = 1;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentWidth":95});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":25,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_NewTradeWin_Label3",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyName1",
                                                        "width":130
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_NewTradeWin_Label4",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyValue1",
                                                        "width":164
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.strokeWidth = 1;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentWidth":95});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.horizontalAlign = "center";
                                        this.horizontalGap = 30;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":25,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":RadioButton,
                                                "id":"buyRadio",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"contentHeader1",
                                                        "groupName":"radiogroup1",
                                                        "selected":true
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":RadioButton,
                                                "id":"sellRadio",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"contentHeader1",
                                                        "groupName":"radiogroup1"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.strokeWidth = 1;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentWidth":95});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":25,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_NewTradeWin_Label5",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyName1",
                                                        "width":130
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":NumberInput,
                                                "id":"amountInput",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"textInput",
                                                        "onDataChange":onAmountChange,
                                                        "width":130,
                                                        "maxChars":8
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.strokeWidth = 1;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentWidth":95});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":25,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_NewTradeWin_Label6",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyName1",
                                                        "width":130
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"priceInout",
                                                "events":{"change":"__priceInout_change"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"textInput",
                                                        "restrict":"0-9.",
                                                        "maxChars":5,
                                                        "width":130
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.strokeWidth = 1;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentWidth":95});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":25,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_NewTradeWin_Label7",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyName1",
                                                        "width":130
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_NewTradeWin_Label8",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyValue1",
                                                        "width":164
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.strokeWidth = 1;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentWidth":95});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":25,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_NewTradeWin_Label9",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyName1",
                                                        "width":130
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_NewTradeWin_Label10",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyValue1",
                                                        "width":164
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.strokeWidth = 1;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentWidth":95});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_NewTradeWin_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText1",
                                            "percentWidth":100,
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.strokeWidth = 1;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentWidth":95});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.horizontalAlign = "right";
                                        this.horizontalGap = 4;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":98,
                                            "height":35,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"post",
                                                "events":{
                                                    "click":"__post_click",
                                                    "mouseOut":"__post_mouseOut",
                                                    "mouseOver":"__post_mouseOver",
                                                    "mouseMove":"__post_mouseMove"
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"y125",
                                                        "width":125
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_NewTradeWin_Button2",
                                                "events":{"click":"___NewTradeWin_Button2_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"y125"});
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_NewTradeWin_Button3",
                        "events":{
                            "click":"___NewTradeWin_Button3_click",
                            "mouseOut":"___NewTradeWin_Button3_mouseOut",
                            "mouseOver":"___NewTradeWin_Button3_mouseOver",
                            "mouseMove":"___NewTradeWin_Button3_mouseMove"
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b75",
                                "width":75,
                                "x":297,
                                "y":96
                            });
                        }
                    })]});
            }
        });
        private var myPresentationTooltip:PresentationTooltip = PresentationTooltip.getInstance();
        private var curCastle:CastleBean = Context.getInstance().getCurCastle();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function NewTradeWin()
        {
            mx_internal::_document = this;
            _NewTradeWin_RadioButtonGroup1_i();
            this.addEventListener("creationComplete", ___NewTradeWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            NewTradeWin._watcherSetupUtil = _arg_1;
        }


        private function onPriceChange(_arg_1:Number):void
        {
            if (_arg_1 >= 0)
            {
                if (_arg_1 >= 150)
                {
                    _arg_1 = 150;
                    this.priceInout.text = _arg_1.toString();
                };
                this.price = _arg_1;
                this.calcCommission();
            }
            else
            {
                this.priceInout.text = "0";
            };
        }

        private function onNewTradeResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            }
            else
            {
                AlertWin.show(Lang.msg("市场下单成功"), onNewTradeComplete, "Ok", null);
                canPost = false;
                post.enabled = false;
                price = 0;
                amount = 0;
                this.priceStr = "0";
            };
        }

        public function __post_click(_arg_1:MouseEvent):void
        {
            onNewTradeClick();
        }

        [Bindable(event="propertyChange")]
        private function get commission():Number
        {
            return (this._1018264811commission);
        }

        private function init():void
        {
            MsgDispacther.getInstance().addEventListener(AutomaticTradeEvent.EVENT_NAME, automaticTradeHandle);
        }

        [Bindable(event="propertyChange")]
        public function get buyRadio():RadioButton
        {
            return (this._996685547buyRadio);
        }

        public function __post_mouseMove(_arg_1:MouseEvent):void
        {
            moveHandler(_arg_1);
        }

        private function onBackBtnClick():void
        {
            this.dispatchEvent(new Event(EVENT_BACK));
        }

        public function __post_mouseOver(_arg_1:MouseEvent):void
        {
            overHandler(_arg_1);
            this.myPresentationTooltip.presentation = Lang.msg("发布交易按钮提示");
        }

        private function outHandler():void
        {
            PopUpManager.removePopUp(this.myPresentationTooltip);
        }

        private function calcCommission():void
        {
            total = (this.amount * this.price);
            this.canPost = false;
            this.commission = (total * TradeConstants.MARKET_TRADE_COMMISSION);
            if (((this.total < 0) || (this.commission < 0)))
            {
                onMaxAmount();
            }
            else
            {
                if (((this.price > 0) && (this.amount > 0)))
                {
                    if (this.tradeType == 0)
                    {
                        this.canPost = (this.resourceBean.gold >= (total + commission));
                    }
                    else
                    {
                        this.canPost = ((this.amount <= resInfo.amount) && (this.resourceBean.gold >= commission));
                    };
                };
            };
        }

        [Bindable(event="propertyChange")]
        private function get priceStr():String
        {
            return (this._1176951768priceStr);
        }

        private function moveHandler(_arg_1:MouseEvent):void
        {
            this.myPresentationTooltip.moveToMouse(_arg_1);
        }

        public function set post(_arg_1:Button):void
        {
            var _local_2:Object = this._3446944post;
            if (_local_2 !== _arg_1)
            {
                this._3446944post = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "post", _local_2, _arg_1));
            };
        }

        public function set buyRadio(_arg_1:RadioButton):void
        {
            var _local_2:Object = this._996685547buyRadio;
            if (_local_2 !== _arg_1)
            {
                this._996685547buyRadio = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buyRadio", _local_2, _arg_1));
            };
        }

        private function selectTradeType(_arg_1:ItemClickEvent):void
        {
            this.tradeType = _arg_1.index;
            this.calcCommission();
        }

        [Bindable(event="propertyChange")]
        public function get priceInout():TextInput
        {
            return (this._1483663296priceInout);
        }

        [Bindable(event="propertyChange")]
        private function get price():Number
        {
            return (this._106934601price);
        }

        [Bindable(event="propertyChange")]
        private function get resName():String
        {
            return (this._1096374091resName);
        }

        [Bindable(event="propertyChange")]
        public function get radiogroup1():RadioButtonGroup
        {
            return (this._164873549radiogroup1);
        }

        public function __post_mouseOut(_arg_1:MouseEvent):void
        {
            outHandler();
        }

        [Bindable(event="propertyChange")]
        private function get total():Number
        {
            return (this._110549828total);
        }

        public function ___NewTradeWin_Button3_mouseOver(_arg_1:MouseEvent):void
        {
            overHandler(_arg_1);
            this.myPresentationTooltip.presentation = Lang.msg("市场最大按扭提示");
        }

        private function set priceStr(_arg_1:String):void
        {
            var _local_2:Object = this._1176951768priceStr;
            if (_local_2 !== _arg_1)
            {
                this._1176951768priceStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "priceStr", _local_2, _arg_1));
            };
        }

        public function ___NewTradeWin_Button3_mouseMove(_arg_1:MouseEvent):void
        {
            moveHandler(_arg_1);
        }

        private function _NewTradeWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (this.resName + ": ");
            _local_1 = Math.floor(this.resInfo.amount);
            _local_1 = (Lang.msg("黄金") + ": ");
            _local_1 = Math.floor(this.resourceBean.gold);
            _local_1 = Lang.msg("买");
            _local_1 = Lang.msg("卖");
            _local_1 = (Lang.msg("数量") + ": ");
            _local_1 = this.amount;
            _local_1 = (Lang.msg("单价") + ": ");
            _local_1 = this.priceStr;
            _local_1 = (Lang.msg("手续费") + ": ");
            _local_1 = ((Lang.msg("黄金") + " ") + (Math.ceil((this.commission * 100)) / 100));
            _local_1 = (Lang.msg("总价") + ": ");
            _local_1 = ((Lang.msg("黄金") + " ") + Math.ceil(this.total));
            _local_1 = Lang.msg("交易扣除费用提示");
            _local_1 = Lang.msg("发布交易");
            _local_1 = this.canPost;
            _local_1 = Lang.msg("返回");
            _local_1 = Lang.msg("最大");
        }

        [Bindable(event="propertyChange")]
        public function get amountInput():NumberInput
        {
            return (this._1231385006amountInput);
        }

        [Bindable(event="propertyChange")]
        private function get amount():Number
        {
            return (this._1413853096amount);
        }

        private function set canPost(_arg_1:Boolean):void
        {
            var _local_2:Object = this._549659792canPost;
            if (_local_2 !== _arg_1)
            {
                this._549659792canPost = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canPost", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get resInfo():ResourceInfoBean
        {
            return (this._1096237422resInfo);
        }

        public function set priceInout(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1483663296priceInout;
            if (_local_2 !== _arg_1)
            {
                this._1483663296priceInout = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "priceInout", _local_2, _arg_1));
            };
        }

        private function automaticTradeHandle(_arg_1:AutomaticTradeEvent):void
        {
            this.amount = 0;
            this.price = Number(_arg_1.count);
            priceStr = _arg_1.count;
            this.commission = 0;
            this.total = 0;
            if (_arg_1.tradeType == "buy")
            {
                this.tradeType = 1;
                this.sellRadio.selected = true;
            };
            if (_arg_1.tradeType == "sell")
            {
                this.tradeType = 0;
                this.buyRadio.selected = true;
            };
        }

        public function ___NewTradeWin_Button2_click(_arg_1:MouseEvent):void
        {
            onBackBtnClick();
        }

        private function set total(_arg_1:Number):void
        {
            var _local_2:Object = this._110549828total;
            if (_local_2 !== _arg_1)
            {
                this._110549828total = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "total", _local_2, _arg_1));
            };
        }

        private function _NewTradeWin_RadioButtonGroup1_i():RadioButtonGroup
        {
            var _local_1:RadioButtonGroup = new RadioButtonGroup();
            radiogroup1 = _local_1;
            _local_1.addEventListener("itemClick", __radiogroup1_itemClick);
            _local_1.initialized(this, "radiogroup1");
            return (_local_1);
        }

        public function set sellRadio(_arg_1:RadioButton):void
        {
            var _local_2:Object = this._1531832375sellRadio;
            if (_local_2 !== _arg_1)
            {
                this._1531832375sellRadio = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sellRadio", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:NewTradeWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _NewTradeWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_market_NewTradeWinWatcherSetupUtil");
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

        private function _NewTradeWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (this.resName + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewTradeWin_Label1.text = _arg_1;
            }, "_NewTradeWin_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Math.floor(this.resInfo.amount);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewTradeWin_Label2.text = _arg_1;
            }, "_NewTradeWin_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("黄金") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewTradeWin_Label3.text = _arg_1;
            }, "_NewTradeWin_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Math.floor(this.resourceBean.gold);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewTradeWin_Label4.text = _arg_1;
            }, "_NewTradeWin_Label4.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("买");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                buyRadio.label = _arg_1;
            }, "buyRadio.label");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("卖");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                sellRadio.label = _arg_1;
            }, "sellRadio.label");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("数量") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewTradeWin_Label5.text = _arg_1;
            }, "_NewTradeWin_Label5.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.amount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                amountInput.text = _arg_1;
            }, "amountInput.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("单价") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewTradeWin_Label6.text = _arg_1;
            }, "_NewTradeWin_Label6.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.priceStr;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                priceInout.text = _arg_1;
            }, "priceInout.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("手续费") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewTradeWin_Label7.text = _arg_1;
            }, "_NewTradeWin_Label7.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Lang.msg("黄金") + " ") + (Math.ceil((this.commission * 100)) / 100));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewTradeWin_Label8.text = _arg_1;
            }, "_NewTradeWin_Label8.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("总价") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewTradeWin_Label9.text = _arg_1;
            }, "_NewTradeWin_Label9.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Lang.msg("黄金") + " ") + Math.ceil(this.total));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewTradeWin_Label10.text = _arg_1;
            }, "_NewTradeWin_Label10.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("交易扣除费用提示");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewTradeWin_Text1.text = _arg_1;
            }, "_NewTradeWin_Text1.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("发布交易");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                post.label = _arg_1;
            }, "post.label");
            result[15] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.canPost);
            }, function (_arg_1:Boolean):void
            {
                post.enabled = _arg_1;
            }, "post.enabled");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("返回");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewTradeWin_Button2.label = _arg_1;
            }, "_NewTradeWin_Button2.label");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("最大");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewTradeWin_Button3.label = _arg_1;
            }, "_NewTradeWin_Button3.label");
            result[18] = binding;
            return (result);
        }

        private function set price(_arg_1:Number):void
        {
            var _local_2:Object = this._106934601price;
            if (_local_2 !== _arg_1)
            {
                this._106934601price = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "price", _local_2, _arg_1));
            };
        }

        private function set resName(_arg_1:String):void
        {
            var _local_2:Object = this._1096374091resName;
            if (_local_2 !== _arg_1)
            {
                this._1096374091resName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get post():Button
        {
            return (this._3446944post);
        }

        public function set radiogroup1(_arg_1:RadioButtonGroup):void
        {
            var _local_2:Object = this._164873549radiogroup1;
            if (_local_2 !== _arg_1)
            {
                this._164873549radiogroup1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "radiogroup1", _local_2, _arg_1));
            };
        }

        public function set amountInput(_arg_1:NumberInput):void
        {
            var _local_2:Object = this._1231385006amountInput;
            if (_local_2 !== _arg_1)
            {
                this._1231385006amountInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "amountInput", _local_2, _arg_1));
            };
        }

        private function onNewTradeClick():void
        {
            if (this.amount > 0)
            {
                ActionFactory.getInstance().getTradeCommands().newTrade(curCastle.id, this.resType, this.tradeType, this.amount, String(this.price), onNewTradeResponse);
            };
        }

        private function onAmountChange(_arg_1:Number):void
        {
            this.amount = _arg_1;
            this.calcCommission();
        }

        [Bindable(event="propertyChange")]
        private function get canPost():Boolean
        {
            return (this._549659792canPost);
        }

        public function ___NewTradeWin_Button3_mouseOut(_arg_1:MouseEvent):void
        {
            outHandler();
        }

        public function __priceInout_change(_arg_1:Event):void
        {
            onPriceChange(Number(priceInout.text));
        }

        private function set resourceBean(_arg_1:CastleResourceBean):void
        {
            var _local_2:Object = this._384920354resourceBean;
            if (_local_2 !== _arg_1)
            {
                this._384920354resourceBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resourceBean", _local_2, _arg_1));
            };
        }

        private function onMaxAmount():void
        {
            if (this.price > 0)
            {
                if (this.tradeType == 0)
                {
                    this.amount = ((Number((this.resourceBean.gold / (this.price * (1 + TradeConstants.MARKET_TRADE_COMMISSION)))) > 100000000) ? 99999999 : Number(Math.floor((this.resourceBean.gold / (this.price * (1 + TradeConstants.MARKET_TRADE_COMMISSION))))));
                }
                else
                {
                    this.amount = ((Number(this.resInfo.amount) > 100000000) ? 99999999 : Number(Math.floor(this.resInfo.amount)));
                };
            };
            this.calcCommission();
        }

        public function ___NewTradeWin_Button3_click(_arg_1:MouseEvent):void
        {
            onMaxAmount();
        }

        private function set amount(_arg_1:Number):void
        {
            var _local_2:Object = this._1413853096amount;
            if (_local_2 !== _arg_1)
            {
                this._1413853096amount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "amount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get sellRadio():RadioButton
        {
            return (this._1531832375sellRadio);
        }

        private function overHandler(_arg_1:MouseEvent):void
        {
            this.myPresentationTooltip.moveToMouse(_arg_1);
            if (!this.myPresentationTooltip.isPopUp)
            {
                PopUpManager.addPopUp(this.myPresentationTooltip, this);
            };
        }

        public function refresh(_arg_1:int, _arg_2:String):void
        {
            this.resType = _arg_1;
            this.resName = _arg_2;
            curCastle = Context.getInstance().getCurCastle();
            this.resourceBean = curCastle.resource;
            switch (this.resType)
            {
                case 0:
                    this.resInfo = curCastle.resource.food;
                    break;
                case 1:
                    this.resInfo = curCastle.resource.wood;
                    break;
                case 2:
                    this.resInfo = curCastle.resource.stone;
                    break;
                case 3:
                    this.resInfo = curCastle.resource.iron;
                    break;
            };
            this.calcCommission();
        }

        private function set commission(_arg_1:Number):void
        {
            var _local_2:Object = this._1018264811commission;
            if (_local_2 !== _arg_1)
            {
                this._1018264811commission = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "commission", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get resourceBean():CastleResourceBean
        {
            return (this._384920354resourceBean);
        }

        public function __radiogroup1_itemClick(_arg_1:ItemClickEvent):void
        {
            selectTradeType(_arg_1);
        }

        public function ___NewTradeWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set resInfo(_arg_1:ResourceInfoBean):void
        {
            var _local_2:Object = this._1096237422resInfo;
            if (_local_2 !== _arg_1)
            {
                this._1096237422resInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resInfo", _local_2, _arg_1));
            };
        }

        private function onNewTradeComplete(_arg_1:Boolean):void
        {
            this.dispatchEvent(new Event(EVENT_TRADE_COMPLETE));
        }


    }
}//package view.module.market

