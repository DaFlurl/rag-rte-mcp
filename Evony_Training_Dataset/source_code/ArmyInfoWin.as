// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.infoWin.ArmyInfoWin

package view.module.info.infoWin
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.Label;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.DataGrid;
    import com.evony.common.beans.ArmyBean;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.events.PropertyChangeEvent;
    import mx.binding.BindingManager;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.managers.PopUpManager;
    import com.evony.Lang;
    import com.evony.Context;
    import com.evony.client.action.ActionFactory;
    import com.evony.eum.ItemEum;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.client.response.ResponseDispatcher;
    import view.ui.SpeedupItemSelector;
    import com.evony.common.constants.ArmyConstants;
    import com.evony.factory.ItemManager;
    import com.evony.common.beans.TroopStrBean;
    import com.evony.common.beans.ResourceBean;
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

    public class ArmyInfoWin extends Canvas implements IBindingClient 
    {

        public static var instance:ArmyInfoWin;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _101207577jmBtn:Button;
        private var _1806944311alliance:Label;
        public var _ArmyInfoWin_DataGridColumn1:DataGridColumn;
        public var _ArmyInfoWin_DataGridColumn2:DataGridColumn;
        public var _ArmyInfoWin_DataGridColumn3:DataGridColumn;
        public var _ArmyInfoWin_DataGridColumn4:DataGridColumn;
        private var _384703012resourceInfo:DataGrid;
        public var _ArmyInfoWin_Label1:Label;
        public var _ArmyInfoWin_Label2:Label;
        public var _ArmyInfoWin_Label3:Label;
        public var _ArmyInfoWin_Label4:Label;
        public var _ArmyInfoWin_Label5:Label;
        private var _102865796level:Label;
        private var _1489803932callBackFriendArmyBtn:Button;
        private var _760685641callBackBtn:Button;
        private var _3198970hero:Label;
        private var _2095657228playerName:Label;
        private var _1415277589armyInfo:DataGrid;
        private var _1415494931armyBean:ArmyBean;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":480,
                    "height":510,
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
                                    "id":"_ArmyInfoWin_Label1",
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
                        "type":DataGrid,
                        "id":"armyInfo",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.left = "40";
                            this.right = "40";
                            this.top = "123";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":198,
                                "styleName":"style2",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_ArmyInfoWin_DataGridColumn1_i(), _ArmyInfoWin_DataGridColumn2_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"resourceInfo",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.bottom = "63";
                            this.left = "40";
                            this.right = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":118,
                                "styleName":"style2",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_ArmyInfoWin_DataGridColumn3_i(), _ArmyInfoWin_DataGridColumn4_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"callBackBtn",
                        "events":{"click":"__callBackBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "33";
                            this.right = "125";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b95",
                                "width":95
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"jmBtn",
                        "events":{"click":"__jmBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "33";
                            this.left = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b95",
                                "width":95
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "40";
                            this.right = "40";
                            this.top = "53";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":65,
                                "styleName":"canvasGroupBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ArmyInfoWin_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                        this.top = "5";
                                        this.right = "320";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"focusColor"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ArmyInfoWin_Label3",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                        this.bottom = "5";
                                        this.right = "320";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"focusColor"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ArmyInfoWin_Label4",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "5";
                                        this.textAlign = "right";
                                        this.left = "190";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"focusColor",
                                            "width":80
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ArmyInfoWin_Label5",
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "5";
                                        this.textAlign = "right";
                                        this.left = "190";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"focusColor",
                                            "width":80
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"playerName",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "5";
                                        this.left = "82";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":100,
                                            "height":20
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"alliance",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "5";
                                        this.left = "273";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":100});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"hero",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.bottom = "5";
                                        this.left = "82";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":100});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"level",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.bottom = "5";
                                        this.left = "273";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":100});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"callBackFriendArmyBtn",
                        "events":{"click":"__callBackFriendArmyBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "37";
                            this.right = "230";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b95",
                                "width":95,
                                "visible":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___ArmyInfoWin_Button4_click"},
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
        private var _1498862854myTroop:ArrayCollection = new ArrayCollection();
        private var _119785946myResource:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ArmyInfoWin()
        {
            mx_internal::_document = this;
            this.width = 480;
            this.height = 510;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ArmyInfoWin._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:ArmyBean):void
        {
            if (instance == null)
            {
                instance = new (ArmyInfoWin)();
            };
            UIUtil.setPopopHelpWindowStye(instance);
            MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
            MinePopupManager.instance.centerPopUp();
            instance.myArmyBean = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get hero():Label
        {
            return (this._3198970hero);
        }

        [Bindable(event="propertyChange")]
        public function get armyInfo():DataGrid
        {
            return (this._1415277589armyInfo);
        }

        public function set callBackBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._760685641callBackBtn;
            if (_local_2 !== _arg_1)
            {
                this._760685641callBackBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "callBackBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get myResource():ArrayCollection
        {
            return (this._119785946myResource);
        }

        private function _ArmyInfoWin_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ArmyInfoWin_DataGridColumn1 = _local_1;
            _local_1.dataField = "army";
            BindingManager.executeBindings(this, "_ArmyInfoWin_DataGridColumn1", _ArmyInfoWin_DataGridColumn1);
            return (_local_1);
        }

        public function __jmBtn_click(_arg_1:MouseEvent):void
        {
            jmApply();
        }

        [Bindable(event="propertyChange")]
        public function get level():Label
        {
            return (this._102865796level);
        }

        [Bindable(event="propertyChange")]
        private function get myTroop():ArrayCollection
        {
            return (this._1498862854myTroop);
        }

        public function set level(_arg_1:Label):void
        {
            var _local_2:Object = this._102865796level;
            if (_local_2 !== _arg_1)
            {
                this._102865796level = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "level", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:ArmyInfoWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ArmyInfoWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_infoWin_ArmyInfoWinWatcherSetupUtil");
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

        private function _ArmyInfoWin_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ArmyInfoWin_DataGridColumn3 = _local_1;
            _local_1.dataField = "resource";
            BindingManager.executeBindings(this, "_ArmyInfoWin_DataGridColumn3", _ArmyInfoWin_DataGridColumn3);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get jmBtn():Button
        {
            return (this._101207577jmBtn);
        }

        private function closeOwner():void
        {
            PopUpManager.removePopUp(this);
        }

        [Bindable(event="propertyChange")]
        public function get callBackFriendArmyBtn():Button
        {
            return (this._1489803932callBackFriendArmyBtn);
        }

        private function _ArmyInfoWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("军队详情");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoWin_Label1.text = _arg_1;
            }, "_ArmyInfoWin_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.myTroop);
            }, function (_arg_1:Object):void
            {
                armyInfo.dataProvider = _arg_1;
            }, "armyInfo.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("兵种");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoWin_DataGridColumn1.headerText = _arg_1;
            }, "_ArmyInfoWin_DataGridColumn1.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoWin_DataGridColumn2.headerText = _arg_1;
            }, "_ArmyInfoWin_DataGridColumn2.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.myResource);
            }, function (_arg_1:Object):void
            {
                resourceInfo.dataProvider = _arg_1;
            }, "resourceInfo.dataProvider");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("资源");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoWin_DataGridColumn3.headerText = _arg_1;
            }, "_ArmyInfoWin_DataGridColumn3.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoWin_DataGridColumn4.headerText = _arg_1;
            }, "_ArmyInfoWin_DataGridColumn4.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("召回");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                callBackBtn.label = _arg_1;
            }, "callBackBtn.label");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.armyBean.king == Context.getInstance().getPlayerBean().playerInfo.userName);
            }, function (_arg_1:Boolean):void
            {
                callBackBtn.visible = _arg_1;
            }, "callBackBtn.visible");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("计谋");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                jmBtn.label = _arg_1;
            }, "jmBtn.label");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("君主") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoWin_Label2.text = _arg_1;
            }, "_ArmyInfoWin_Label2.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("将领") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoWin_Label3.text = _arg_1;
            }, "_ArmyInfoWin_Label3.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("联盟") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoWin_Label4.text = _arg_1;
            }, "_ArmyInfoWin_Label4.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("等级") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoWin_Label5.text = _arg_1;
            }, "_ArmyInfoWin_Label5.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.armyBean.king == null) ? "--" : this.armyBean.king);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                playerName.text = _arg_1;
            }, "playerName.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.armyBean.alliance == null) ? "--" : this.armyBean.alliance);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                alliance.text = _arg_1;
            }, "alliance.text");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.armyBean.hero == null) ? "--" : this.armyBean.hero);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                hero.text = _arg_1;
            }, "hero.text");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.armyBean.heroLevel == 0) ? "--" : this.armyBean.heroLevel);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                level.text = _arg_1;
            }, "level.text");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("遣返");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                callBackFriendArmyBtn.label = _arg_1;
            }, "callBackFriendArmyBtn.label");
            result[18] = binding;
            return (result);
        }

        private function onJmApply(_arg_1:ItemEum=null):void
        {
            var _local_2:int;
            if (_arg_1 != null)
            {
                _local_2 = Context.getInstance().getCurCastle().id;
                ActionFactory.getInstance().getShopCommands().useTrickItem(armyBean.startFieldId, armyBean.armyId, _arg_1.id, callBackTrickHandle);
            };
        }

        public function ___ArmyInfoWin_Button4_click(_arg_1:MouseEvent):void
        {
            closeOwner();
        }

        private function _ArmyInfoWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("军队详情");
            _local_1 = this.myTroop;
            _local_1 = Lang.msg("兵种");
            _local_1 = Lang.msg("数量");
            _local_1 = this.myResource;
            _local_1 = Lang.msg("资源");
            _local_1 = Lang.msg("数量");
            _local_1 = Lang.msg("召回");
            _local_1 = (this.armyBean.king == Context.getInstance().getPlayerBean().playerInfo.userName);
            _local_1 = Lang.msg("计谋");
            _local_1 = (Lang.msg("君主") + ":");
            _local_1 = (Lang.msg("将领") + ":");
            _local_1 = (Lang.msg("联盟") + ":");
            _local_1 = (Lang.msg("等级") + ":");
            _local_1 = ((this.armyBean.king == null) ? "--" : this.armyBean.king);
            _local_1 = ((this.armyBean.alliance == null) ? "--" : this.armyBean.alliance);
            _local_1 = ((this.armyBean.hero == null) ? "--" : this.armyBean.hero);
            _local_1 = ((this.armyBean.heroLevel == 0) ? "--" : this.armyBean.heroLevel);
            _local_1 = Lang.msg("遣返");
        }

        public function __callBackBtn_click(_arg_1:MouseEvent):void
        {
            callBack();
        }

        public function init():void
        {
        }

        public function set playerName(_arg_1:Label):void
        {
            var _local_2:Object = this._2095657228playerName;
            if (_local_2 !== _arg_1)
            {
                this._2095657228playerName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerName", _local_2, _arg_1));
            };
        }

        public function set jmBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._101207577jmBtn;
            if (_local_2 !== _arg_1)
            {
                this._101207577jmBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "jmBtn", _local_2, _arg_1));
            };
        }

        private function set myResource(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._119785946myResource;
            if (_local_2 !== _arg_1)
            {
                this._119785946myResource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myResource", _local_2, _arg_1));
            };
        }

        private function callBackTrickHandle(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("计谋使用成功"));
                closeOwner();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        public function get alliance():Label
        {
            return (this._1806944311alliance);
        }

        [Bindable(event="propertyChange")]
        public function get playerName():Label
        {
            return (this._2095657228playerName);
        }

        public function set callBackFriendArmyBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1489803932callBackFriendArmyBtn;
            if (_local_2 !== _arg_1)
            {
                this._1489803932callBackFriendArmyBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "callBackFriendArmyBtn", _local_2, _arg_1));
            };
        }

        public function __callBackFriendArmyBtn_click(_arg_1:MouseEvent):void
        {
            callBack();
        }

        public function set resourceInfo(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._384703012resourceInfo;
            if (_local_2 !== _arg_1)
            {
                this._384703012resourceInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resourceInfo", _local_2, _arg_1));
            };
        }

        public function set hero(_arg_1:Label):void
        {
            var _local_2:Object = this._3198970hero;
            if (_local_2 !== _arg_1)
            {
                this._3198970hero = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hero", _local_2, _arg_1));
            };
        }

        private function _ArmyInfoWin_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ArmyInfoWin_DataGridColumn2 = _local_1;
            _local_1.dataField = "num";
            BindingManager.executeBindings(this, "_ArmyInfoWin_DataGridColumn2", _ArmyInfoWin_DataGridColumn2);
            return (_local_1);
        }

        private function _ArmyInfoWin_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ArmyInfoWin_DataGridColumn4 = _local_1;
            _local_1.dataField = "num";
            BindingManager.executeBindings(this, "_ArmyInfoWin_DataGridColumn4", _ArmyInfoWin_DataGridColumn4);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get callBackBtn():Button
        {
            return (this._760685641callBackBtn);
        }

        private function set myTroop(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1498862854myTroop;
            if (_local_2 !== _arg_1)
            {
                this._1498862854myTroop = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myTroop", _local_2, _arg_1));
            };
        }

        public function set armyInfo(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1415277589armyInfo;
            if (_local_2 !== _arg_1)
            {
                this._1415277589armyInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyInfo", _local_2, _arg_1));
            };
        }

        private function callBack():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ARMY_CALL_BACK_ARMY, callBackArmyHandle, false, 0, true);
            ActionFactory.getInstance().getArmyCommands().callBackArmy(Context.getInstance().getCurCastle().id, this.armyBean.armyId);
        }

        private function set armyBean(_arg_1:ArmyBean):void
        {
            var _local_2:Object = this._1415494931armyBean;
            if (_local_2 !== _arg_1)
            {
                this._1415494931armyBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyBean", _local_2, _arg_1));
            };
        }

        private function callBackArmyHandle(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("军队成功召回"));
                closeOwner();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function jmApply():void
        {
            var _local_1:ArrayCollection;
            var _local_2:int;
            SpeedupItemSelector.getInstance().armyBean = armyBean;
            SpeedupItemSelector.getInstance().speedType = SpeedupItemSelector.ON_JM_APPLY;
            if (this.armyBean.king == Context.getInstance().getPlayerBean().playerInfo.userName)
            {
                _local_1 = new ArrayCollection();
                if (armyBean.direction == ArmyConstants.ARMY_STAY)
                {
                    _local_2 = 0;
                    while (_local_2 < ItemManager.trickItemArray.length)
                    {
                        if (ItemManager.trickItemArray[_local_2] != "player.trick.qlbx")
                        {
                            _local_1.addItem(ItemManager.trickItemArray[_local_2]);
                        };
                        _local_2++;
                    };
                }
                else
                {
                    _local_1 = ItemManager.trickItemArray;
                };
                SpeedupItemSelector.show(_local_1, onJmApply);
            }
            else
            {
                SpeedupItemSelector.show(ItemManager.trickOtherItemArray, onJmApply);
            };
        }

        public function set alliance(_arg_1:Label):void
        {
            var _local_2:Object = this._1806944311alliance;
            if (_local_2 !== _arg_1)
            {
                this._1806944311alliance = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alliance", _local_2, _arg_1));
            };
        }

        public function set myArmyBean(_arg_1:ArmyBean):void
        {
            this.armyBean = _arg_1;
            var _local_2:TroopStrBean = this.armyBean.troop;
            this.myTroop.removeAll();
            if (_local_2.peasants != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("民夫"),
                    "num":_local_2.peasants
                });
            };
            if (_local_2.militia != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("义兵"),
                    "num":_local_2.militia
                });
            };
            if (_local_2.scouter != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("斥候"),
                    "num":_local_2.scouter
                });
            };
            if (_local_2.pikemen != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("枪兵"),
                    "num":_local_2.pikemen
                });
            };
            if (_local_2.swordsmen != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("刀盾兵"),
                    "num":_local_2.swordsmen
                });
            };
            if (_local_2.archer != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("弓箭手"),
                    "num":_local_2.archer
                });
            };
            if (_local_2.lightCavalry != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("轻骑兵"),
                    "num":_local_2.lightCavalry
                });
            };
            if (_local_2.heavyCavalry != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("铁骑兵"),
                    "num":_local_2.heavyCavalry
                });
            };
            if (_local_2.carriage != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("辎重车"),
                    "num":_local_2.carriage
                });
            };
            if (_local_2.ballista != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("车弩"),
                    "num":_local_2.ballista
                });
            };
            if (_local_2.batteringRam != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("冲车"),
                    "num":_local_2.batteringRam
                });
            };
            if (_local_2.catapult != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("投石车"),
                    "num":_local_2.catapult
                });
            };
            var _local_3:ResourceBean = this.armyBean.resource;
            this.myResource.removeAll();
            if (_local_3 != null)
            {
                if (_local_3.food)
                {
                    myResource.addItem({
                        "resource":Lang.msg("粮食"),
                        "num":_local_3.food
                    });
                };
                if (_local_3.wood)
                {
                    myResource.addItem({
                        "resource":Lang.msg("木材"),
                        "num":_local_3.wood
                    });
                };
                if (_local_3.iron)
                {
                    myResource.addItem({
                        "resource":Lang.msg("铁矿"),
                        "num":_local_3.iron
                    });
                };
                if (_local_3.stone)
                {
                    myResource.addItem({
                        "resource":Lang.msg("石料"),
                        "num":_local_3.stone
                    });
                };
                if (_local_3.gold)
                {
                    myResource.addItem({
                        "resource":Lang.msg("黄金"),
                        "num":_local_3.gold
                    });
                };
            };
        }

        [Bindable(event="propertyChange")]
        private function get armyBean():ArmyBean
        {
            return (this._1415494931armyBean);
        }

        [Bindable(event="propertyChange")]
        public function get resourceInfo():DataGrid
        {
            return (this._384703012resourceInfo);
        }


    }
}//package view.module.info.infoWin

