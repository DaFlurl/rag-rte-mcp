// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.UIEscapeCamp

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.DataGrid;
    import mx.controls.Button;
    import mx.controls.Label;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.TextArea;
    import com.evony.common.beans.PlayerInfoBean;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import mx.collections.ArrayCollection;
    import com.evony.Lang;
    import com.evony.common.beans.CastleBean;
    import com.evony.Context;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import com.evony.client.response.ResponseDispatcher;
    import mx.events.FlexEvent;
    import mx.binding.BindingManager;
    import com.evony.common.module.CommandResponse;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.server.events.FleeTroopUpdate;
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

    public class UIEscapeCamp extends Canvas implements IBindingClient 
    {

        public static var instance:UIEscapeCamp = new (UIEscapeCamp)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _2036223254goldNeed:int = 0;
        private var _1477443227dgEscapeArms:DataGrid;
        private var _482159758btnDismiss:Button;
        public var _UIEscapeCamp_Label1:Label;
        public var _UIEscapeCamp_DataGridColumn1:DataGridColumn;
        public var _UIEscapeCamp_DataGridColumn2:DataGridColumn;
        private var _1495860549btnEnabled:Boolean = false;
        public var _UIEscapeCamp_TextArea1:TextArea;
        private var _2095520559playerInfo:PlayerInfoBean;
        private var _2071824769btnPersuade:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":434,
                    "height":376,
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
                                    "id":"_UIEscapeCamp_Label1",
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
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":19,
                                "y":41,
                                "width":396,
                                "percentHeight":90,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":80,
                                            "x":0,
                                            "y":10,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":TextArea,
                                                "id":"_UIEscapeCamp_TextArea1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":80,
                                                        "percentWidth":100,
                                                        "editable":false,
                                                        "styleName":"withGreyBackground"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"dgEscapeArms",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "styleName":"style2",
                                                        "columns":[_UIEscapeCamp_DataGridColumn1_i(), _UIEscapeCamp_DataGridColumn2_i()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"btnPersuade",
                                    "events":{"click":"__btnPersuade_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.disabledColor = 0xE7E7E7;
                                        this.right = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":293,
                                            "styleName":"b75"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"btnDismiss",
                                    "events":{"click":"__btnDismiss_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.disabledColor = 0xE7E7E7;
                                        this.left = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":293,
                                            "styleName":"b75"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___UIEscapeCamp_Button3_click"},
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
        private var _1917016683mArrArms:ArrayCollection = new ArrayCollection([]);
        private var typeAry:Array = new Array("archer", "carriage", "swordsmen", "catapult", "scouter", "militia", "pikemen", "ballista", "heavyCavalry", "lightCavalry", "batteringRam", "peasants");
        private var typeAry_MSG:Array = new Array(Lang.msg("弓箭手"), Lang.msg("辎重车"), Lang.msg("刀盾兵"), Lang.msg("投石车"), Lang.msg("斥候"), Lang.msg("义兵"), Lang.msg("枪兵"), Lang.msg("车弩"), Lang.msg("铁骑兵"), Lang.msg("轻骑兵"), Lang.msg("冲车"), Lang.msg("民夫"));
        private var currentCastle:CastleBean = Context.getInstance().getCurCastle();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function UIEscapeCamp()
        {
            mx_internal::_document = this;
            this.width = 434;
            this.height = 376;
            this.addEventListener("creationComplete", ___UIEscapeCamp_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            UIEscapeCamp._watcherSetupUtil = _arg_1;
        }

        public static function show():void
        {
            instance.playerInfo = Context.getInstance().getPlayerBean().playerInfo;
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
            instance.reFresh();
        }


        public function ___UIEscapeCamp_Button3_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        private function _UIEscapeCamp_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("逃兵营");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.label = _arg_1;
            }, "this.label");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("逃兵营");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UIEscapeCamp_Label1.text = _arg_1;
            }, "_UIEscapeCamp_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当你城池的粮食不足导致军队哗变后，逃跑的军队会暂时滞留在集结点的“逃兵营”中。花费一定的黄金，即可将哗变的士兵劝说归营。没有及时劝说的士兵会逐渐逃跑。");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UIEscapeCamp_TextArea1.text = _arg_1;
            }, "_UIEscapeCamp_TextArea1.text");
            result[2] = binding;
            binding = new Binding(this, function ():Object
            {
                return (mArrArms);
            }, function (_arg_1:Object):void
            {
                dgEscapeArms.dataProvider = _arg_1;
            }, "dgEscapeArms.dataProvider");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("军团");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UIEscapeCamp_DataGridColumn1.headerText = _arg_1;
            }, "_UIEscapeCamp_DataGridColumn1.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UIEscapeCamp_DataGridColumn2.headerText = _arg_1;
            }, "_UIEscapeCamp_DataGridColumn2.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("劝说");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                btnPersuade.label = _arg_1;
            }, "btnPersuade.label");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnEnabled);
            }, function (_arg_1:Boolean):void
            {
                btnPersuade.enabled = _arg_1;
            }, "btnPersuade.enabled");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("解散");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                btnDismiss.label = _arg_1;
            }, "btnDismiss.label");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnEnabled);
            }, function (_arg_1:Boolean):void
            {
                btnDismiss.enabled = _arg_1;
            }, "btnDismiss.enabled");
            result[9] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get btnPersuade():Button
        {
            return (this._2071824769btnPersuade);
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

        public function set btnPersuade(_arg_1:Button):void
        {
            var _local_2:Object = this._2071824769btnPersuade;
            if (_local_2 !== _arg_1)
            {
                this._2071824769btnPersuade = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnPersuade", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get btnDismiss():Button
        {
            return (this._482159758btnDismiss);
        }

        private function set goldNeed(_arg_1:int):void
        {
            var _local_2:Object = this._2036223254goldNeed;
            if (_local_2 !== _arg_1)
            {
                this._2036223254goldNeed = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "goldNeed", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:UIEscapeCamp;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _UIEscapeCamp_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_UIEscapeCampWatcherSetupUtil");
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
        private function get goldNeed():int
        {
            return (this._2036223254goldNeed);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_FLEE_TROOP_UPDATE, onUpdateFleeArmy);
        }

        internal function onBtnPersuade():void
        {
            AlertWin.show(Lang.msg("劝说你的士兵归营需要花费{0}黄金。", goldNeed), onBtnPersuadeReturn);
        }

        public function ___UIEscapeCamp_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        public function get dgEscapeArms():DataGrid
        {
            return (this._1477443227dgEscapeArms);
        }

        public function set btnDismiss(_arg_1:Button):void
        {
            var _local_2:Object = this._482159758btnDismiss;
            if (_local_2 !== _arg_1)
            {
                this._482159758btnDismiss = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnDismiss", _local_2, _arg_1));
            };
        }

        private function _UIEscapeCamp_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _UIEscapeCamp_DataGridColumn2 = _local_1;
            _local_1.dataField = "amount";
            BindingManager.executeBindings(this, "_UIEscapeCamp_DataGridColumn2", _UIEscapeCamp_DataGridColumn2);
            return (_local_1);
        }

        private function onGetFleeTroopResponse(_arg_1:CommandResponse):void
        {
        }

        private function reFresh():void
        {
            this.playerInfo = Context.getInstance().getPlayerBean().playerInfo;
            currentCastle = Context.getInstance().getCurCastle();
            ActionFactory.getInstance().getArmyCommands().getFleeTroop(Context.getInstance().getCurCastle().id, onGetFleeTroopResponse);
        }

        public function set dgEscapeArms(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1477443227dgEscapeArms;
            if (_local_2 !== _arg_1)
            {
                this._1477443227dgEscapeArms = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dgEscapeArms", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get playerInfo():PlayerInfoBean
        {
            return (this._2095520559playerInfo);
        }

        [Bindable(event="propertyChange")]
        private function get btnEnabled():Boolean
        {
            return (this._1495860549btnEnabled);
        }

        private function onUpdateFleeArmy(_arg_1:FleeTroopUpdate):void
        {
            var _local_2:Object;
            var _local_3:int;
            var _local_4:Object;
            if (_arg_1.castleId == this.currentCastle.id)
            {
                this.goldNeed = _arg_1.goldNeed;
                mArrArms.removeAll();
                _local_2 = _arg_1.troop.toObject();
                _local_3 = 0;
                while (_local_3 < typeAry.length)
                {
                    _local_4 = new Object();
                    _local_4["type"] = typeAry_MSG[_local_3];
                    _local_4["amount"] = _local_2[typeAry[_local_3]];
                    if (int(_local_2[typeAry[_local_3]]) > 0)
                    {
                        mArrArms.addItem(_local_4);
                    };
                    _local_3++;
                };
            };
            if (mArrArms.length > 0)
            {
                this.btnEnabled = true;
            };
        }

        internal function onBtnDismiss():void
        {
            ActionFactory.getInstance().getArmyCommands().disbandFleeTroop(Context.getInstance().getCurCastle().id);
        }

        private function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        private function set mArrArms(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1917016683mArrArms;
            if (_local_2 !== _arg_1)
            {
                this._1917016683mArrArms = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mArrArms", _local_2, _arg_1));
            };
        }

        private function set playerInfo(_arg_1:PlayerInfoBean):void
        {
            var _local_2:Object = this._2095520559playerInfo;
            if (_local_2 !== _arg_1)
            {
                this._2095520559playerInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerInfo", _local_2, _arg_1));
            };
        }

        private function _UIEscapeCamp_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("逃兵营");
            _local_1 = Lang.msg("逃兵营");
            _local_1 = Lang.msg("当你城池的粮食不足导致军队哗变后，逃跑的军队会暂时滞留在集结点的“逃兵营”中。花费一定的黄金，即可将哗变的士兵劝说归营。没有及时劝说的士兵会逐渐逃跑。");
            _local_1 = mArrArms;
            _local_1 = Lang.msg("军团");
            _local_1 = Lang.msg("数量");
            _local_1 = Lang.msg("劝说");
            _local_1 = this.btnEnabled;
            _local_1 = Lang.msg("解散");
            _local_1 = this.btnEnabled;
        }

        public function __btnPersuade_click(_arg_1:MouseEvent):void
        {
            onBtnPersuade();
        }

        private function onArmyCommandResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != 1)
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function _UIEscapeCamp_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _UIEscapeCamp_DataGridColumn1 = _local_1;
            _local_1.dataField = "type";
            BindingManager.executeBindings(this, "_UIEscapeCamp_DataGridColumn1", _UIEscapeCamp_DataGridColumn1);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get mArrArms():ArrayCollection
        {
            return (this._1917016683mArrArms);
        }

        public function __btnDismiss_click(_arg_1:MouseEvent):void
        {
            onBtnDismiss();
        }

        private function onBtnPersuadeReturn(_arg_1:Boolean):void
        {
            var _local_2:int;
            if (_arg_1)
            {
                ActionFactory.getInstance().getArmyCommands().recruitFleeTroop(Context.getInstance().getCurCastle().id, onArmyCommandResponse);
            };
        }


    }
}//package view.ui

