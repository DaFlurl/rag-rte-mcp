// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.ModifyCastleNameView

package view.module.office
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.client.response.ResponseDispatcher;
    import mx.controls.TextInput;
    import mx.controls.Label;
    import mx.controls.Button;
    import com.evony.common.beans.CastleBean;
    import mx.controls.Image;
    import mx.collections.ArrayCollection;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.VRule;
    import view.ui.MyHRule;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import com.evony.util.InputTextControl;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import com.evony.Lang;
    import flash.utils.getDefinitionByName;
    import com.evony.common.module.CommandResponse;
    import com.evony.Context;
    import view.ui.AlertWin;
    import mx.events.FlexEvent;
    import com.evony.eum.CityLogoEumDefine;
    import flash.display.Bitmap;
    import com.evony.BadWordCollection;
    import com.evony.client.action.ActionFactory;
    import com.evony.util.ImageSmooth;
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

    public class ModifyCastleNameView extends Canvas implements IBindingClient 
    {

        public static var instancePopup:ModifyCastleNameView;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var instance:ResponseDispatcher;
        private var _1845020747newName:TextInput;
        public var _ModifyCastleNameView_Label2:Label;
        public var _ModifyCastleNameView_Label4:Label;
        public var _ModifyCastleNameView_Label5:Label;
        public var _ModifyCastleNameView_Label6:Label;
        public var _ModifyCastleNameView_Label1:Label;
        private var faceArrayIndex:int;
        private var _348630820submitBtn:Button;
        private var _691506344curCastle:CastleBean;
        private var _1092797764closeBtn:Button;
        private var _3327403logo:Image;
        private var _114190243castleName:Label;
        private var _571486424faceSource:String;
        private var faceArray:ArrayCollection;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":230,
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
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "top";
                                        this.left = "1";
                                        this.top = "1";
                                        this.right = "1";
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
                                                        "percentWidth":50,
                                                        "height":23,
                                                        "styleName":"textBackGroundFillColor",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ModifyCastleNameView_Label1",
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
                                                        "percentWidth":50,
                                                        "height":23,
                                                        "styleName":"textBackGroundFillColor",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ModifyCastleNameView_Label2",
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
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":5,
                                            "y":109,
                                            "width":388
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"castleName",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.top = "29";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":198,
                                            "x":0,
                                            "styleName":"tableContent1"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"newName",
                                    "events":{"change":"__newName_change"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "28";
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":201,
                                            "width":195,
                                            "styleName":"textInput",
                                            "height":24,
                                            "maxChars":10
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":201,
                                            "y":63,
                                            "width":199,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___ModifyCastleNameView_Button1_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"previous"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Image,
                                                "id":"logo",
                                                "events":{"complete":"__logo_complete"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "source":"images/icon/cityLogo/citylogo_01.png",
                                                        "width":72,
                                                        "height":42
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___ModifyCastleNameView_Button2_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"next"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ModifyCastleNameView_Label4",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":70,
                                            "y":77,
                                            "styleName":"tableContent1"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ModifyCastleNameView_Label5",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"PropertyName2",
                                            "y":119,
                                            "x":10
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_ModifyCastleNameView_Label6",
                        "stylesFactory":function ():void
                        {
                            this.top = "6";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":167,
                                "width":0xFF,
                                "styleName":"funtionWindowTitle"
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
                        "events":{"click":"___ModifyCastleNameView_Button5_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":2,
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

        public function ModifyCastleNameView()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 230;
            this.addEventListener("creationComplete", ___ModifyCastleNameView_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ModifyCastleNameView._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object=null):void
        {
            if (instancePopup == null)
            {
                instancePopup = new (ModifyCastleNameView)();
            };
            if (!instancePopup.isPopUp)
            {
                PopUpManager.addPopUp(instancePopup, MainFrame.instance, true);
            };
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
            instancePopup.newName.text = "";
            instancePopup.castleBean = CastleBean(_arg_1);
        }


        public function __newName_change(_arg_1:Event):void
        {
            InputTextControl.textChange(_arg_1);
        }

        private function closeWindow(_arg_1:MouseEvent):void
        {
            if (this.parent != null)
            {
                PopUpManager.removePopUp(this);
            };
        }

        public function ___ModifyCastleNameView_Button1_click(_arg_1:MouseEvent):void
        {
            changeFace(-1);
        }

        public function ___ModifyCastleNameView_Button5_click(_arg_1:MouseEvent):void
        {
            onClose();
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

        private function _ModifyCastleNameView_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("城池");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ModifyCastleNameView_Label1.text = _arg_1;
            }, "_ModifyCastleNameView_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("新名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ModifyCastleNameView_Label2.text = _arg_1;
            }, "_ModifyCastleNameView_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curCastle.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                castleName.text = _arg_1;
            }, "castleName.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("城市图标");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ModifyCastleNameView_Label4.text = _arg_1;
            }, "_ModifyCastleNameView_Label4.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("每天只能更改一次城池名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ModifyCastleNameView_Label5.text = _arg_1;
            }, "_ModifyCastleNameView_Label5.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("城池改名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ModifyCastleNameView_Label6.text = _arg_1;
            }, "_ModifyCastleNameView_Label6.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                submitBtn.label = _arg_1;
            }, "submitBtn.label");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("关闭");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                closeBtn.label = _arg_1;
            }, "closeBtn.label");
            result[7] = binding;
            return (result);
        }

        override public function initialize():void
        {
            var target:ModifyCastleNameView;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ModifyCastleNameView_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_ModifyCastleNameViewWatcherSetupUtil");
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

        private function modifyResponse(_arg_1:CommandResponse):void
        {
            var _local_2:int;
            var _local_3:CastleBean;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                _local_2 = 0;
                while (_local_2 < Context.getInstance().getPlayerBean().castlesArray.length)
                {
                    _local_3 = Context.getInstance().getPlayerBean().getCastles(_local_2);
                    if (this.curCastle.id == _local_3.id)
                    {
                        _local_3.name = this.newName.text;
                        _local_3.logUrl = this.faceSource;
                    };
                    _local_2++;
                };
                AlertWin.show(Lang.msg("成功修改城市名"), null);
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set newName(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1845020747newName;
            if (_local_2 !== _arg_1)
            {
                this._1845020747newName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newName", _local_2, _arg_1));
            };
        }

        public function ___ModifyCastleNameView_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        public function get submitBtn():Button
        {
            return (this._348630820submitBtn);
        }

        public function init():void
        {
            this.newName.text = "";
            setFaceArray();
            logo.source = Context.getInstance().getCurCastle().logUrl;
        }

        [Bindable(event="propertyChange")]
        public function get logo():Image
        {
            return (this._3327403logo);
        }

        private function changeFace(_arg_1:int):void
        {
            this.faceArrayIndex = (this.faceArrayIndex + _arg_1);
            if (this.faceArrayIndex < 0)
            {
                this.faceArrayIndex = (this.faceArray.length - 1);
            }
            else
            {
                if (this.faceArrayIndex >= this.faceArray.length)
                {
                    this.faceArrayIndex = 0;
                };
            };
            this.faceSource = this.faceArray[this.faceArrayIndex];
            logo.source = this.faceSource;
        }

        public function set castleBean(_arg_1:CastleBean):void
        {
            var _local_2:int;
            this.curCastle = _arg_1;
            if (this.faceArray != null)
            {
                _local_2 = 0;
                while (_local_2 < this.faceArray.length)
                {
                    if (this.faceArray[_local_2] == this.curCastle.logUrl)
                    {
                        this.faceArrayIndex = _local_2;
                        this.faceSource = this.faceArray[this.faceArrayIndex];
                        logo.source = this.faceSource;
                        return;
                    };
                    _local_2++;
                };
            };
        }

        public function __closeBtn_click(_arg_1:MouseEvent):void
        {
            closeWindow(_arg_1);
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

        private function setFaceArray():void
        {
            this.faceArray = CityLogoEumDefine.getCityLogoArray();
        }

        [Bindable(event="propertyChange")]
        public function get castleName():Label
        {
            return (this._114190243castleName);
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

        [Bindable(event="propertyChange")]
        public function get closeBtn():Button
        {
            return (this._1092797764closeBtn);
        }

        public function set castleName(_arg_1:Label):void
        {
            var _local_2:Object = this._114190243castleName;
            if (_local_2 !== _arg_1)
            {
                this._114190243castleName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleName", _local_2, _arg_1));
            };
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

        public function ___ModifyCastleNameView_Button2_click(_arg_1:MouseEvent):void
        {
            changeFace(1);
        }

        public function __submitBtn_click(_arg_1:MouseEvent):void
        {
            submitHandle(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get newName():TextInput
        {
            return (this._1845020747newName);
        }

        private function _ModifyCastleNameView_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("城池");
            _local_1 = Lang.msg("新名称");
            _local_1 = this.curCastle.name;
            _local_1 = Lang.msg("城市图标");
            _local_1 = Lang.msg("每天只能更改一次城池名");
            _local_1 = Lang.msg("城池改名");
            _local_1 = Lang.msg("确定");
            _local_1 = Lang.msg("关闭");
        }

        public function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        public function set logo(_arg_1:Image):void
        {
            var _local_2:Object = this._3327403logo;
            if (_local_2 !== _arg_1)
            {
                this._3327403logo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "logo", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get curCastle():CastleBean
        {
            return (this._691506344curCastle);
        }

        private function submitHandle(_arg_1:MouseEvent):void
        {
            if (newName.text != "")
            {
                if (newName.text.length <= 10)
                {
                    instance = ResponseDispatcher.getInstance();
                    if (BadWordCollection.instance.isBadWord(newName.text))
                    {
                        AlertWin.show(Lang.msg("名字不合法"));
                    }
                    else
                    {
                        instance.addEventListener(ResponseDispatcher.CITY_MODIFY_CASTLE_NAME, modifyResponse, false, 0, true);
                        ActionFactory.getInstance().getCityCommands().modifyCastleName(this.curCastle.id, String(newName.text), this.faceSource);
                        if (this.parent != null)
                        {
                            PopUpManager.removePopUp(this);
                        };
                    };
                }
                else
                {
                    AlertWin.show(Lang.msg("城市名不能超过10个字符"));
                };
            }
            else
            {
                AlertWin.show(Lang.msg("城市名不能为空"));
            };
        }

        [Bindable(event="propertyChange")]
        private function get faceSource():String
        {
            return (this._571486424faceSource);
        }

        public function __logo_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        private function checkOutText():void
        {
            var _local_1:String = newName.text;
            var _local_2:int;
            while (_local_2 < _local_1.length)
            {
                if (((((_local_1.charAt(_local_2) == '"') || (_local_1.charAt(_local_2) == "'")) || (_local_1.charAt(_local_2) == "\\")) || (_local_1.charAt(_local_2) == " ")))
                {
                    _local_1 = _local_1.substr(0, _local_2);
                };
                newName.text = _local_1;
                _local_2++;
            };
        }


    }
}//package view.module.office

