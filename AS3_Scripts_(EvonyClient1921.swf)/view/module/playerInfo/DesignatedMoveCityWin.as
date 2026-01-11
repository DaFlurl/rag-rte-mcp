// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.DesignatedMoveCityWin

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextArea;
    import mx.controls.Label;
    import com.evony.eum.ItemEum;
    import mx.controls.TextInput;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import flash.events.MouseEvent;
    import com.evony.Lang;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.FlexEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.eum.ItemEumDefine;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import view.ui.AlertWin;
    import com.evony.common.module.CommandResponse;
    import com.evony.MsgDispacther;
    import flash.events.Event;
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

    public class DesignatedMoveCityWin extends Canvas implements IBindingClient 
    {

        private static var instance:DesignatedMoveCityWin = new (DesignatedMoveCityWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _DesignatedMoveCityWin_TextArea1:TextArea;
        public var _DesignatedMoveCityWin_Label1:Label;
        public var _DesignatedMoveCityWin_Label2:Label;
        private var _2116180394itemEum:ItemEum;
        private var _1183866418inputX:TextInput;
        public var _DesignatedMoveCityWin_Button1:Button;
        private var _1183866417inputY:TextInput;
        private var iFlag:int = 0;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":195,
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
                            this.top = "4";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_DesignatedMoveCityWin_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":4,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"_DesignatedMoveCityWin_TextArea1",
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.right = "20";
                            this.top = "73";
                            this.bottom = "17";
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"labelWithBackGround",
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.right = "20";
                            this.top = "32";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":36,
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_DesignatedMoveCityWin_Label2"
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"text":":"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"text":"X"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"inputX",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":60,
                                                        "styleName":"textInput",
                                                        "maxChars":3,
                                                        "restrict":"0-9"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"text":"Y"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"inputY",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":60,
                                                        "styleName":"textInput",
                                                        "maxChars":3,
                                                        "restrict":"0-9"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_DesignatedMoveCityWin_Button1",
                                                "events":{"click":"___DesignatedMoveCityWin_Button1_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"b75"});
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___DesignatedMoveCityWin_Button2_click"},
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

        public function DesignatedMoveCityWin()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 195;
            this.addEventListener("creationComplete", ___DesignatedMoveCityWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            DesignatedMoveCityWin._watcherSetupUtil = _arg_1;
        }

        public static function hide():void
        {
            if (instance.isPopUp)
            {
                PopUpManager.removePopUp(instance);
            };
        }

        public static function show(_arg_1:MouseEvent, _arg_2:int):void
        {
            if (!instance.isPopUp)
            {
                PopUpManager.addPopUp(instance, MainFrame.instance);
            };
            PopUpManager.centerPopUp(instance);
            instance.refresh();
            instance.iFlag = _arg_2;
        }


        private function _DesignatedMoveCityWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("高级迁城令");
            _local_1 = this.itemEum.itemDesc;
            _local_1 = Lang.msg("坐标");
            _local_1 = Lang.msg("迁城");
        }

        public function ___DesignatedMoveCityWin_Button2_click(_arg_1:MouseEvent):void
        {
            hide();
        }

        [Bindable(event="propertyChange")]
        public function get inputX():TextInput
        {
            return (this._1183866418inputX);
        }

        [Bindable(event="propertyChange")]
        public function get inputY():TextInput
        {
            return (this._1183866417inputY);
        }

        override public function initialize():void
        {
            var target:DesignatedMoveCityWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _DesignatedMoveCityWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_DesignatedMoveCityWinWatcherSetupUtil");
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

        public function ___DesignatedMoveCityWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function ___DesignatedMoveCityWin_Button1_click(_arg_1:MouseEvent):void
        {
            changeZone();
        }

        public function refresh():void
        {
            instance.inputX.text = "";
            instance.inputY.text = "";
        }

        public function set inputX(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1183866418inputX;
            if (_local_2 !== _arg_1)
            {
                this._1183866418inputX = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inputX", _local_2, _arg_1));
            };
        }

        public function set inputY(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1183866417inputY;
            if (_local_2 !== _arg_1)
            {
                this._1183866417inputY = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inputY", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            this.itemEum = ItemEumDefine.getItemEum("player.more.castle.1.a");
        }

        private function _DesignatedMoveCityWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("高级迁城令");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DesignatedMoveCityWin_Label1.text = _arg_1;
            }, "_DesignatedMoveCityWin_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.itemEum.itemDesc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DesignatedMoveCityWin_TextArea1.text = _arg_1;
            }, "_DesignatedMoveCityWin_TextArea1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("坐标");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DesignatedMoveCityWin_Label2.text = _arg_1;
            }, "_DesignatedMoveCityWin_Label2.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("迁城");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DesignatedMoveCityWin_Button1.label = _arg_1;
            }, "_DesignatedMoveCityWin_Button1.label");
            result[3] = binding;
            return (result);
        }

        private function set itemEum(_arg_1:ItemEum):void
        {
            var _local_2:Object = this._2116180394itemEum;
            if (_local_2 !== _arg_1)
            {
                this._2116180394itemEum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemEum", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get itemEum():ItemEum
        {
            return (this._2116180394itemEum);
        }

        private function changeZone():void
        {
            if (((!(inputX.text == "")) && (!(inputY.text == ""))))
            {
                if (iFlag == 0)
                {
                    ActionFactory.getInstance().getCityCommands().advMoveCastle(Context.getInstance().getCurCastle().id, ((int(inputY.text) * Context.mapSizeX) + int(inputX.text)), moveCityResponse);
                }
                else
                {
                    ActionFactory.getInstance().getCityCommands().uniteAdvMoveCastle(Context.getInstance().getCurCastle().id, ((int(inputY.text) * Context.mapSizeX) + int(inputX.text)), moveCityResponse);
                };
                hide();
            }
            else
            {
                AlertWin.show(Lang.msg("请输入坐标"), null);
            };
        }

        private function moveCityResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                MyTreasure.instance.refresh();
                MsgDispacther.getInstance().dispatchEvent(new Event(Context.EVENT_CASTLE_MOVE));
                AlertWin.show(Lang.msg("迁城成功"), null);
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }


    }
}//package view.module.playerInfo

