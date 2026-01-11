// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.AdjustmentCess

package view.module.office
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import com.evony.client.response.ResponseDispatcher;
    import mx.controls.Label;
    import mx.controls.Button;
    import com.evony.common.beans.CastleBean;
    import mx.controls.NumericStepper;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.VRule;
    import view.ui.MyHRule;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import com.evony.Context;
    import view.module.playerInfo.UnlockSecurityCode;
    import view.module.playerInfo.ApplySecurityCode;
    import com.evony.client.action.ActionFactory;
    import flash.events.KeyboardEvent;
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
    import view.module.playerInfo.*;
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

    public class AdjustmentCess extends Canvas implements IBindingClient 
    {

        public static var instancePopup:AdjustmentCess;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _AdjustmentCess_Text1:Text;
        private var instance:ResponseDispatcher;
        public var _AdjustmentCess_Label1:Label;
        public var _AdjustmentCess_Label2:Label;
        public var _AdjustmentCess_Label5:Label;
        public var _AdjustmentCess_Label7:Label;
        public var _AdjustmentCess_Label4:Label;
        public var _AdjustmentCess_Label6:Label;
        private var _348630820submitBtn:Button;
        private var _691506344curCastle:CastleBean;
        private var _1092797764closeBtn:Button;
        private var _1620253356valueControl:NumericStepper;
        private var _1534460295taxRateInfo:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":240,
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
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "43";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "46";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AdjustmentCess_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":130.73334,
                                            "x":0,
                                            "y":32,
                                            "height":20,
                                            "styleName":"tableContent2"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AdjustmentCess_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":131.5,
                                            "x":134.5,
                                            "y":32,
                                            "height":20,
                                            "styleName":"tableContent2"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":NumericStepper,
                                    "id":"valueControl",
                                    "events":{"keyUp":"__valueControl_keyUp"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":306,
                                            "y":30,
                                            "height":22,
                                            "maximum":100,
                                            "minimum":0
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"taxRateInfo",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":390,
                                            "y":61,
                                            "height":22,
                                            "x":5,
                                            "styleName":"PropertyName2"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_AdjustmentCess_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":5,
                                            "y":83,
                                            "height":48,
                                            "width":390,
                                            "selectable":false,
                                            "styleName":"PropertyName2"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "top";
                                        this.left = "1";
                                        this.right = "1";
                                        this.top = "1";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":23,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":33.33,
                                                        "height":23,
                                                        "styleName":"textBackGroundFillColor",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_AdjustmentCess_Label4",
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
                                            }), new UIComponentDescriptor({"type":VRule}), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":33.33,
                                                        "height":23,
                                                        "styleName":"textBackGroundFillColor",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_AdjustmentCess_Label5",
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
                                            }), new UIComponentDescriptor({"type":VRule}), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":33.33,
                                                        "height":23,
                                                        "styleName":"textBackGroundFillColor",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_AdjustmentCess_Label6",
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
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":5,
                                            "y":58,
                                            "width":388
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "4";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":5,
                                            "width":388
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "4";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AdjustmentCess_Label7",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":2,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.right = "18";
                            this.bottom = "17";
                            this.horizontalAlign = "right";
                            this.verticalAlign = "middle";
                            this.horizontalGap = 8;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"submitBtn",
                                    "events":{"click":"__submitBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b40"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"closeBtn",
                                    "events":{"click":"__closeBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b40"});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___AdjustmentCess_Button3_click"},
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
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AdjustmentCess()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 240;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___AdjustmentCess_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AdjustmentCess._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object=null):void
        {
            if (instancePopup == null)
            {
                instancePopup = new (AdjustmentCess)();
            };
            PopUpManager.addPopUp(instancePopup, MainFrame.instance, true);
            if ((Application.application.width - instancePopup.width) > 0)
            {
                instancePopup.x = (((Application.application.width - instancePopup.width) / 2) - 150);
                instancePopup.y = (((Application.application.height - instancePopup.height) / 2) - 30);
                PopUpManager.bringToFront(instancePopup);
            }
            else
            {
                PopUpManager.centerPopUp(instancePopup);
            };
            instancePopup.castleBean = CastleBean(_arg_1);
        }


        public function set taxRateInfo(_arg_1:Label):void
        {
            var _local_2:Object = this._1534460295taxRateInfo;
            if (_local_2 !== _arg_1)
            {
                this._1534460295taxRateInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "taxRateInfo", _local_2, _arg_1));
            };
        }

        private function closeWindow(_arg_1:MouseEvent):void
        {
            if (this.parent != null)
            {
                PopUpManager.removePopUp(this);
            };
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

        override public function initialize():void
        {
            var target:AdjustmentCess;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AdjustmentCess_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_AdjustmentCessWatcherSetupUtil");
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

        public function set castleBean(_arg_1:CastleBean):void
        {
            this.curCastle = _arg_1;
        }

        public function ___AdjustmentCess_Button3_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        private function modifyResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("成功修改税率"));
            }
            else
            {
                if (_arg_1.ok == -200)
                {
                    if (Context.getInstance().bLoginSecurityCode)
                    {
                        UnlockSecurityCode.show(16);
                    }
                    else
                    {
                        ApplySecurityCode.show(16);
                    };
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
        }

        private function _AdjustmentCess_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curCastle.resource.curPopulation;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AdjustmentCess_Label1.text = _arg_1;
            }, "_AdjustmentCess_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curCastle.resource.support;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AdjustmentCess_Label2.text = _arg_1;
            }, "_AdjustmentCess_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.curCastle.resource.texRate);
            }, function (_arg_1:Number):void
            {
                valueControl.value = _arg_1;
            }, "valueControl.value");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("每小时可征收{0}黄金", String(Math.ceil(((int(this.curCastle.resource.curPopulation) * this.valueControl.value) * 0.01))));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                taxRateInfo.text = _arg_1;
            }, "taxRateInfo.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("过于沉重的税收");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AdjustmentCess_Text1.text = _arg_1;
            }, "_AdjustmentCess_Text1.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("人口");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AdjustmentCess_Label4.text = _arg_1;
            }, "_AdjustmentCess_Label4.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("民心");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AdjustmentCess_Label5.text = _arg_1;
            }, "_AdjustmentCess_Label5.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("税率");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AdjustmentCess_Label6.text = _arg_1;
            }, "_AdjustmentCess_Label6.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("修改税率");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AdjustmentCess_Label7.text = _arg_1;
            }, "_AdjustmentCess_Label7.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                submitBtn.label = _arg_1;
            }, "submitBtn.label");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("关闭");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                closeBtn.label = _arg_1;
            }, "closeBtn.label");
            result[10] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get submitBtn():Button
        {
            return (this._348630820submitBtn);
        }

        public function init():void
        {
        }

        public function __closeBtn_click(_arg_1:MouseEvent):void
        {
            closeWindow(_arg_1);
        }

        private function change():void
        {
            taxRateInfo.text = Lang.msg("每小时可征收{0}黄金", String(Math.ceil(((int(this.curCastle.resource.curPopulation) * this.valueControl.value) * 0.01))));
        }

        private function _AdjustmentCess_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.curCastle.resource.curPopulation;
            _local_1 = this.curCastle.resource.support;
            _local_1 = this.curCastle.resource.texRate;
            _local_1 = Lang.msg("每小时可征收{0}黄金", String(Math.ceil(((int(this.curCastle.resource.curPopulation) * this.valueControl.value) * 0.01))));
            _local_1 = Lang.msg("过于沉重的税收");
            _local_1 = Lang.msg("人口");
            _local_1 = Lang.msg("民心");
            _local_1 = Lang.msg("税率");
            _local_1 = Lang.msg("修改税率");
            _local_1 = Lang.msg("确定");
            _local_1 = Lang.msg("关闭");
        }

        private function set curCastle(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._691506344curCastle;
            if (_local_2 !== _arg_1)
            {
                this._691506344curCastle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curCastle", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get valueControl():NumericStepper
        {
            return (this._1620253356valueControl);
        }

        [Bindable(event="propertyChange")]
        public function get closeBtn():Button
        {
            return (this._1092797764closeBtn);
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

        private function curTaxRate():String
        {
            var _local_1:String = Lang.msg("每小时可征收黄金");
            return (_local_1 + String(Math.floor(((int(this.curCastle.resource.curPopulation) * this.valueControl.value) * 0.01))));
        }

        public function __submitBtn_click(_arg_1:MouseEvent):void
        {
            submitHandle();
        }

        public function set valueControl(_arg_1:NumericStepper):void
        {
            var _local_2:Object = this._1620253356valueControl;
            if (_local_2 !== _arg_1)
            {
                this._1620253356valueControl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "valueControl", _local_2, _arg_1));
            };
        }

        public function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        [Bindable(event="propertyChange")]
        private function get curCastle():CastleBean
        {
            return (this._691506344curCastle);
        }

        public function submitHandle():void
        {
            instance = ResponseDispatcher.getInstance();
            instance.addEventListener(ResponseDispatcher.INTERIOR_MODIFY_TAX_RATE, modifyResponse, false, 0, true);
            ActionFactory.getInstance().getInteriorCommands().modifyTaxRate(this.curCastle.id, valueControl.value);
            if (this.parent != null)
            {
                PopUpManager.removePopUp(this);
            };
        }

        public function __valueControl_keyUp(_arg_1:KeyboardEvent):void
        {
            change();
        }

        public function ___AdjustmentCess_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        public function get taxRateInfo():Label
        {
            return (this._1534460295taxRateInfo);
        }


    }
}//package view.module.office

