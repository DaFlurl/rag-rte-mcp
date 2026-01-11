// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.MoveCityWin

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.ZoneInfoBean;
    import mx.containers.ViewStack;
    import mx.controls.Label;
    import mx.controls.Text;
    import mx.controls.ComboBox;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import mx.managers.PopUpManager;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Lang;
    import flash.events.Event;
    import com.evony.common.module.CommandResponse;
    import com.evony.MsgDispacther;
    import com.evony.Context;
    import view.ui.AlertWin;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.client.action.ActionFactory;
    import mx.events.ListEvent;
    import com.evony.common.module.common.ZoneInfoResponse;
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

    public class MoveCityWin extends Canvas implements IBindingClient 
    {

        private static var instance:MoveCityWin = new (MoveCityWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var curZone:ZoneInfoBean;
        private var _1828964878choiseVS:ViewStack;
        private var _1006753127discript_users:Canvas;
        private var _2067273540showMsg:Canvas;
        private var _1246832046discript_random:Canvas;
        private var _94935213crowd:Label;
        public var _MoveCityWin_Text1:Text;
        private var _79623641zoneSelectCB:ComboBox;
        public var _MoveCityWin_Label2:Label;
        public var _MoveCityWin_Label3:Label;
        private var _1098677438hostNum:Label;
        public var _MoveCityWin_Button1:Button;
        public var _MoveCityWin_Label1:Label;
        private var _785423899cityNum:Label;
        public var _MoveCityWin_Label4:Label;
        public var _MoveCityWin_Label8:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":190,
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
                                    "id":"_MoveCityWin_Label1",
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
                        "type":Canvas,
                        "id":"showMsg",
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.right = "20";
                            this.top = "73";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":100,
                                "visible":true,
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":ViewStack,
                                    "id":"choiseVS",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"discript_users",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":VBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalAlign = "center";
                                                                this.horizontalCenter = "0";
                                                                this.verticalGap = 0;
                                                                this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":90,
                                                                    "height":96,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.horizontalAlign = "center";
                                                                            this.horizontalGap = 3;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":VBox,
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentHeight":100,
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Label,
                                                                                                "id":"_MoveCityWin_Label2",
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.fontSize = 15;
                                                                                                    this.textAlign = "right";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"commonNormalColor",
                                                                                                        "percentWidth":100
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Label,
                                                                                                "id":"_MoveCityWin_Label3",
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.fontSize = 15;
                                                                                                    this.textAlign = "right";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"commonNormalColor",
                                                                                                        "percentWidth":100
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Label,
                                                                                                "id":"_MoveCityWin_Label4",
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.fontSize = 15;
                                                                                                    this.textAlign = "right";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"commonNormalColor",
                                                                                                        "percentWidth":100
                                                                                                    });
                                                                                                }
                                                                                            })]
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":VBox,
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentHeight":100,
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Label,
                                                                                                "id":"hostNum",
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.fontSize = 15;
                                                                                                    this.textAlign = "left";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"commonNormalColor",
                                                                                                        "percentWidth":100
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Label,
                                                                                                "id":"cityNum",
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.fontSize = 15;
                                                                                                    this.textAlign = "left";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"commonNormalColor",
                                                                                                        "percentWidth":100
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Label,
                                                                                                "id":"crowd",
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.fontSize = 15;
                                                                                                    this.textAlign = "left";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"commonNormalColor",
                                                                                                        "percentWidth":100
                                                                                                    });
                                                                                                }
                                                                                            })]
                                                                                        });
                                                                                    }
                                                                                })]
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"discript_random",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"",
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_MoveCityWin_Text1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                                this.verticalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":243,
                                                                    "height":54
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
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
                                "height":35,
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
                                                "id":"_MoveCityWin_Label8",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"focusColor"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ComboBox,
                                                "id":"zoneSelectCB",
                                                "events":{"change":"__zoneSelectCB_change"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":200});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_MoveCityWin_Button1",
                                                "events":{"click":"___MoveCityWin_Button1_click"},
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
                        "events":{"click":"___MoveCityWin_Button2_click"},
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
        private var _1421979723cityData:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function MoveCityWin()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 190;
        }

        public static function mouseMove(_arg_1:MouseEvent):void
        {
            if (instance.isPopUp)
            {
            };
        }

        public static function hide():void
        {
            if (instance.isPopUp)
            {
                PopUpManager.removePopUp(instance);
            };
        }

        public static function show(_arg_1:MouseEvent):void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance);
            };
            MinePopupManager.instance.centerPopUp();
            instance.refresh();
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            MoveCityWin._watcherSetupUtil = _arg_1;
        }


        private function set cityData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1421979723cityData;
            if (_local_2 !== _arg_1)
            {
                this._1421979723cityData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityData", _local_2, _arg_1));
            };
        }

        public function set hostNum(_arg_1:Label):void
        {
            var _local_2:Object = this._1098677438hostNum;
            if (_local_2 !== _arg_1)
            {
                this._1098677438hostNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hostNum", _local_2, _arg_1));
            };
        }

        public function ___MoveCityWin_Button1_click(_arg_1:MouseEvent):void
        {
            changeZone();
        }

        [Bindable(event="propertyChange")]
        public function get choiseVS():ViewStack
        {
            return (this._1828964878choiseVS);
        }

        public function set showMsg(_arg_1:Canvas):void
        {
            var _local_2:Object = this._2067273540showMsg;
            if (_local_2 !== _arg_1)
            {
                this._2067273540showMsg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showMsg", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:MoveCityWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _MoveCityWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_MoveCityWinWatcherSetupUtil");
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
        public function get discript_users():Canvas
        {
            return (this._1006753127discript_users);
        }

        [Bindable(event="propertyChange")]
        public function get cityNum():Label
        {
            return (this._785423899cityNum);
        }

        public function set discript_random(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1246832046discript_random;
            if (_local_2 !== _arg_1)
            {
                this._1246832046discript_random = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "discript_random", _local_2, _arg_1));
            };
        }

        private function _MoveCityWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("迁城令");
            _local_1 = (Lang.msg("玩家数") + ":");
            _local_1 = (Lang.msg("城池数量") + ":");
            _local_1 = (Lang.msg("Crowding") + ":");
            _local_1 = Lang.msg("选择洲的描述提示");
            _local_1 = Lang.msg("迁移至");
            _local_1 = this.cityData;
            _local_1 = Lang.msg("迁城");
        }

        private function selectName(_arg_1:Event):void
        {
            trace(this.zoneSelectCB.selectedItem.label);
            if (this.zoneSelectCB.selectedItem.data != null)
            {
                setArrayName(ZoneInfoBean(this.zoneSelectCB.selectedItem.data));
                this.choiseVS.selectedChild = discript_users;
            }
            else
            {
                randomName();
            };
        }

        public function set choiseVS(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._1828964878choiseVS;
            if (_local_2 !== _arg_1)
            {
                this._1828964878choiseVS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "choiseVS", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get crowd():Label
        {
            return (this._94935213crowd);
        }

        [Bindable(event="propertyChange")]
        public function get zoneSelectCB():ComboBox
        {
            return (this._79623641zoneSelectCB);
        }

        public function set discript_users(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1006753127discript_users;
            if (_local_2 !== _arg_1)
            {
                this._1006753127discript_users = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "discript_users", _local_2, _arg_1));
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

        [Bindable(event="propertyChange")]
        public function get hostNum():Label
        {
            return (this._1098677438hostNum);
        }

        public function set cityNum(_arg_1:Label):void
        {
            var _local_2:Object = this._785423899cityNum;
            if (_local_2 !== _arg_1)
            {
                this._785423899cityNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityNum", _local_2, _arg_1));
            };
        }

        private function setArrayName(_arg_1:ZoneInfoBean):void
        {
            curZone = _arg_1;
            trace(((((this.className + ".setArrayName(): playerCount:") + _arg_1.playerCount) + " castleCount:") + _arg_1.castleCount));
            hostNum.text = ((_arg_1.playerCount + "") as String);
            cityNum.text = ((_arg_1.castleCount + "") as String);
            crowd.text = ((_arg_1.rate + "%") as String);
        }

        public function ___MoveCityWin_Button2_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        public function set zoneSelectCB(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._79623641zoneSelectCB;
            if (_local_2 !== _arg_1)
            {
                this._79623641zoneSelectCB = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "zoneSelectCB", _local_2, _arg_1));
            };
        }

        private function _MoveCityWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("迁城令");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MoveCityWin_Label1.text = _arg_1;
            }, "_MoveCityWin_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("玩家数") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MoveCityWin_Label2.text = _arg_1;
            }, "_MoveCityWin_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("城池数量") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MoveCityWin_Label3.text = _arg_1;
            }, "_MoveCityWin_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("Crowding") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MoveCityWin_Label4.text = _arg_1;
            }, "_MoveCityWin_Label4.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("选择洲的描述提示");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MoveCityWin_Text1.text = _arg_1;
            }, "_MoveCityWin_Text1.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("迁移至");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MoveCityWin_Label8.text = _arg_1;
            }, "_MoveCityWin_Label8.text");
            result[5] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.cityData);
            }, function (_arg_1:Object):void
            {
                zoneSelectCB.dataProvider = _arg_1;
            }, "zoneSelectCB.dataProvider");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("迁城");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MoveCityWin_Button1.label = _arg_1;
            }, "_MoveCityWin_Button1.label");
            result[7] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get discript_random():Canvas
        {
            return (this._1246832046discript_random);
        }

        [Bindable(event="propertyChange")]
        private function get cityData():ArrayCollection
        {
            return (this._1421979723cityData);
        }

        public function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        public function refresh():void
        {
            trace((this.className + ".refresh()"));
            this.cityData.removeAll();
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.COMMON_ZONE_INFO, onZoneInfo);
            ActionFactory.getInstance().getCommonCommands().zoneInfo();
        }

        public function __zoneSelectCB_change(_arg_1:ListEvent):void
        {
            selectName(_arg_1);
        }

        private function randomName():void
        {
            var _local_1:int = int(int((Math.random() * 16)));
            this.choiseVS.selectedChild = discript_random;
            curZone = ZoneInfoBean(this.cityData.getItemAt(_local_1).data);
            setArrayName(curZone);
        }

        [Bindable(event="propertyChange")]
        public function get showMsg():Canvas
        {
            return (this._2067273540showMsg);
        }

        public function set crowd(_arg_1:Label):void
        {
            var _local_2:Object = this._94935213crowd;
            if (_local_2 !== _arg_1)
            {
                this._94935213crowd = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "crowd", _local_2, _arg_1));
            };
        }

        private function onZoneInfo(_arg_1:ZoneInfoResponse):void
        {
            var _local_4:ZoneInfoBean;
            var _local_2:ArrayCollection = _arg_1.zonesArray;
            this.cityData.addItem({
                "label":Lang.msg("随机"),
                "data":null
            });
            var _local_3:int;
            while (_local_3 < _local_2.length)
            {
                _local_4 = (_local_2.getItemAt(_local_3) as ZoneInfoBean);
                this.cityData.addItem({
                    "label":_local_4.name,
                    "data":_local_4
                });
                _local_3++;
            };
            randomName();
        }

        private function changeZone():void
        {
            ActionFactory.getInstance().getCityCommands().moveCastle(Context.getInstance().getCurCastle().id, this.curZone.id, moveCityResponse);
            hide();
        }


    }
}//package view.module.playerInfo

