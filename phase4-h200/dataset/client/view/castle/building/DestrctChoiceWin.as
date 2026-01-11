// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.building.DestrctChoiceWin

package view.castle.building
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.BuildingBean;
    import mx.controls.Text;
    import mx.controls.Button;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import flash.events.MouseEvent;
    import com.evony.common.constants.ErrorCode;
    import com.evony.GameConfig;
    import com.evony.Context;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import com.evony.common.module.CommandResponse;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import com.evony.client.action.ActionFactory;
    import flash.utils.getDefinitionByName;
    import com.evony.util.UIUtil;
    import view.ui.AddFundWin;
    import com.evony.eum.ItemEumDefine;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.common.beans.ItemBean;
    import com.evony.common.module.shop.UseItemResultResponse;
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

    public class DestrctChoiceWin extends Canvas implements IBindingClient 
    {

        private static var instance:DestrctChoiceWin = new (DestrctChoiceWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var buildingBean:BuildingBean;
        private var _696171219myContent:Text;
        public var _DestrctChoiceWin_Button1:Button;
        public var _DestrctChoiceWin_Button3:Button;
        public var _DestrctChoiceWin_Button2:Button;
        public var _DestrctChoiceWin_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":500,
                    "height":250,
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
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalAlign = "top";
                            this.horizontalAlign = "center";
                            this.top = "65";
                            this.left = "40";
                            this.right = "40";
                            this.bottom = "37";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentHeight":100,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"myContent",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":98,
                                                        "styleName":"ParamgraphText1",
                                                        "selectable":false
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.horizontalAlign = "center";
                                        this.horizontalGap = 3;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_DestrctChoiceWin_Button1",
                                                "events":{"click":"___DestrctChoiceWin_Button1_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"b135"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_DestrctChoiceWin_Button2",
                                                "events":{"click":"___DestrctChoiceWin_Button2_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"b135"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_DestrctChoiceWin_Button3",
                                                "events":{"click":"___DestrctChoiceWin_Button3_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"b75"});
                                                }
                                            })]
                                        });
                                    }
                                })]});
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
                                    "id":"_DestrctChoiceWin_Label1",
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
                        "type":Button,
                        "events":{"click":"___DestrctChoiceWin_Button4_click"},
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

        public function DestrctChoiceWin()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.kerning = true;
            };
            this.width = 500;
            this.height = 250;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            DestrctChoiceWin._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:BuildingBean):void
        {
            instance.buildingBean = _arg_1;
            if (!instance.isPopUp)
            {
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
        }


        public function ___DestrctChoiceWin_Button1_click(_arg_1:MouseEvent):void
        {
            destrctCompleteHandle();
        }

        private function onBuildCommand(_arg_1:CommandResponse):void
        {
            trace((this.className + ".onBuildCommand."));
            if (((GameConfig.instance.enableBuildingQueue) && (_arg_1.ok == ErrorCode.TOWNHALL_LEVEL_UNSUPPORT)))
            {
                if (Context.getInstance().getDemolishQueueMinLevel(this.buildingBean.positionId) > 0)
                {
                    if (Context.getInstance().isItemEnough("player.queue.building"))
                    {
                        AlertWin.show(Lang.msg("拆除需要排队"), checkQueueBuilding);
                    }
                    else
                    {
                        AlertWin.show(Lang.msg("拆除需要排队及道具"), checkQueueBuilding);
                    };
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            }
            else
            {
                if (_arg_1.ok != CommandResponse.OK_DEFAULT)
                {
                    AlertWin.show(_arg_1.errorMsg);
                }
                else
                {
                    close();
                };
            };
        }

        public function ___DestrctChoiceWin_Button4_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        public function set myContent(_arg_1:Text):void
        {
            var _local_2:Object = this._696171219myContent;
            if (_local_2 !== _arg_1)
            {
                this._696171219myContent = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myContent", _local_2, _arg_1));
            };
        }

        private function _DestrctChoiceWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("拆除描述");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myContent.text = _arg_1;
            }, "myContent.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("完全拆除");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DestrctChoiceWin_Button1.label = _arg_1;
            }, "_DestrctChoiceWin_Button1.label");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("拆除一级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DestrctChoiceWin_Button2.label = _arg_1;
            }, "_DestrctChoiceWin_Button2.label");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("取消");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DestrctChoiceWin_Button3.label = _arg_1;
            }, "_DestrctChoiceWin_Button3.label");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("拆除建筑");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DestrctChoiceWin_Label1.text = _arg_1;
            }, "_DestrctChoiceWin_Label1.text");
            result[4] = binding;
            return (result);
        }

        public function ___DestrctChoiceWin_Button3_click(_arg_1:MouseEvent):void
        {
            close();
        }

        private function checkQueueBuilding(_arg_1:Boolean):void
        {
            var _local_2:int;
            if (_arg_1)
            {
                _local_2 = Context.getInstance().getDemolishQueueMinLevel(this.buildingBean.positionId);
                if (_local_2 == 100)
                {
                    _local_2 = (this.buildingBean.level - 1);
                }
                else
                {
                    _local_2--;
                };
                ActionFactory.getInstance().getCastleCommands().demolishBuildingQueue(Context.getInstance().getCurCastle().id, this.buildingBean.typeId, _local_2, this.buildingBean.positionId, onNewBuildingQueueResponse);
            };
        }

        private function onCommandResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                close();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        public function get myContent():Text
        {
            return (this._696171219myContent);
        }

        override public function initialize():void
        {
            var target:DestrctChoiceWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _DestrctChoiceWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castle_building_DestrctChoiceWinWatcherSetupUtil");
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

        public function ___DestrctChoiceWin_Button2_click(_arg_1:MouseEvent):void
        {
            destrctBuildingHandle();
        }

        private function destrctBuilding(_arg_1:Boolean):void
        {
            var _local_2:int;
            var _local_3:int;
            if (_arg_1)
            {
                _local_2 = Context.getInstance().getCurCastle().id;
                _local_3 = this.buildingBean.positionId;
                ActionFactory.getInstance().getCastleCommands().destructBuilding(_local_2, _local_3, onBuildCommand);
            };
        }

        private function buyAndUse(_arg_1:Boolean):void
        {
            var _local_2:int;
            var _local_3:int;
            if (_arg_1)
            {
                if (UIUtil.checkItem("player.destroy.1.a", 1))
                {
                    _local_2 = Context.getInstance().getCurCastle().id;
                    _local_3 = this.buildingBean.positionId;
                    ActionFactory.getInstance().getCastleCommands().destructBuilding(_local_2, _local_3, canDestruc);
                }
                else
                {
                    AddFundWin.show();
                };
            };
        }

        private function destrctComplete(_arg_1:Boolean):void
        {
            var _local_2:int;
            var _local_3:int;
            if (_arg_1)
            {
                if (canUseGood("player.destroy.1.a"))
                {
                    _local_2 = Context.getInstance().getCurCastle().id;
                    _local_3 = this.buildingBean.positionId;
                    ActionFactory.getInstance().getCastleCommands().destructBuilding(_local_2, _local_3, canDestruc);
                }
                else
                {
                    AlertWin.show(Lang.msg("买并使用{0}", ItemEumDefine.getItemEum("player.destroy.1.a").name), buyAndUse);
                };
            };
        }

        private function checkQueueBuilding2(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                ActionFactory.getInstance().getCastleCommands().demolishBuildingQueue(Context.getInstance().getCurCastle().id, this.buildingBean.typeId, -1, this.buildingBean.positionId, onNewBuildingQueueResponse);
            };
        }

        private function destrctBuildingHandle():void
        {
            AlertWin.show(Lang.msg("确认拆除一级建筑{0}(等级{1})", this.buildingBean.name, this.buildingBean.level), destrctBuilding);
        }

        private function _DestrctChoiceWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("拆除描述");
            _local_1 = Lang.msg("完全拆除");
            _local_1 = Lang.msg("拆除一级");
            _local_1 = Lang.msg("取消");
            _local_1 = Lang.msg("拆除建筑");
        }

        private function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        private function destrctCompleteHandle():void
        {
            AlertWin.show(Lang.msg("确认完全拆除建筑{0}(等级{1})", this.buildingBean.name, this.buildingBean.level), destrctComplete);
        }

        private function onNewBuildingQueueResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            };
            this.close();
        }

        private function canDestruc(_arg_1:CommandResponse):void
        {
            var _local_2:int;
            trace((this.className + ".onBuildCommand."));
            if (((GameConfig.instance.enableBuildingQueue) && (_arg_1.ok == ErrorCode.TOWNHALL_LEVEL_UNSUPPORT)))
            {
                if (Context.getInstance().getDemolishQueueMinLevel(this.buildingBean.positionId) > 0)
                {
                    if (Context.getInstance().isItemEnough("player.queue.building"))
                    {
                        AlertWin.show(Lang.msg("拆除需要排队"), checkQueueBuilding2);
                    }
                    else
                    {
                        AlertWin.show(Lang.msg("拆除需要排队及道具"), checkQueueBuilding2);
                    };
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            }
            else
            {
                if (_arg_1.ok == CommandResponse.OK_DEFAULT)
                {
                    _local_2 = Context.getInstance().getCurCastle().id;
                    ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CASTLE_SPEED_UP_BUILD_COMMAND, onCommandResponse, false, 0, true);
                    ActionFactory.getInstance().getCastleCommands().speedUpBuildCommand(_local_2, this.buildingBean.positionId, "player.destroy.1.a");
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
        }

        private function close():void
        {
            PopUpManager.removePopUp(this);
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

        private function onUseItemResponse(_arg_1:UseItemResultResponse):void
        {
            var _local_2:int;
            var _local_3:int;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                _local_2 = Context.getInstance().getCurCastle().id;
                _local_3 = this.buildingBean.positionId;
                ActionFactory.getInstance().getCastleCommands().destructBuilding(_local_2, _local_3, onBuildCommand);
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }


    }
}//package view.castle.building

