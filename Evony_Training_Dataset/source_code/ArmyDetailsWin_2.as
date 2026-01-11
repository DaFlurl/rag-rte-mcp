// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.infoWin.ArmyDetailsWin

package view.module.info.infoWin
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.Label;
    import mx.controls.DataGrid;
    import mx.controls.Button;
    import mx.utils.ObjectProxy;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.binding.Binding;
    import com.evony.Lang;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import com.evony.common.constants.TFConstants;
    import mx.binding.BindingManager;
    import flash.events.MouseEvent;
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

    public class ArmyDetailsWin extends Canvas implements IBindingClient 
    {

        public static var instance:ArmyDetailsWin;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _ArmyDetailsWin_DataGridColumn1:DataGridColumn;
        public var _ArmyDetailsWin_DataGridColumn2:DataGridColumn;
        public var _ArmyDetailsWin_DataGridColumn3:DataGridColumn;
        public var _ArmyDetailsWin_DataGridColumn4:DataGridColumn;
        private var _1806944311alliance:Label;
        private var _384703012resourceInfo:DataGrid;
        private var _102865796level:Label;
        public var _ArmyDetailsWin_Label1:Label;
        public var _ArmyDetailsWin_Label2:Label;
        public var _ArmyDetailsWin_Label3:Label;
        public var _ArmyDetailsWin_Label4:Label;
        public var _ArmyDetailsWin_Label5:Label;
        private var _1092797764closeBtn:Button;
        private var _2095657228playerName:Label;
        private var _3198970hero:Label;
        private var _1409292208armyOb:ObjectProxy;
        private var _1415277589armyInfo:DataGrid;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":430,
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
                                    "id":"_ArmyDetailsWin_Label1",
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
                            this.left = "20";
                            this.right = "20";
                            this.top = "103";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":138,
                                "styleName":"style2",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_ArmyDetailsWin_DataGridColumn1_i(), _ArmyDetailsWin_DataGridColumn2_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"resourceInfo",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.bottom = "43";
                            this.left = "20";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":138,
                                "styleName":"style2",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_ArmyDetailsWin_DataGridColumn3_i(), _ArmyDetailsWin_DataGridColumn4_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"closeBtn",
                        "events":{"click":"__closeBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "13";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"b75"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.right = "20";
                            this.top = "33";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":65,
                                "styleName":"canvasGroupBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ArmyDetailsWin_Label2",
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
                                    "id":"_ArmyDetailsWin_Label3",
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
                                    "id":"_ArmyDetailsWin_Label4",
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
                                    "id":"_ArmyDetailsWin_Label5",
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
                        "events":{"click":"___ArmyDetailsWin_Button2_click"},
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
        private var _865287327troops:ArrayCollection = new ArrayCollection();
        private var _119785946myResource:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ArmyDetailsWin()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 430;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ArmyDetailsWin._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:ObjectProxy):void
        {
            if (instance == null)
            {
                instance = new (ArmyDetailsWin)();
            };
            PopUpManager.addPopUp(instance, MainFrame.instance, false);
            PopUpManager.centerPopUp(instance);
            instance.armyOb = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get hero():Label
        {
            return (this._3198970hero);
        }

        private function _ArmyDetailsWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("军队详情");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Label1.text = _arg_1;
            }, "_ArmyDetailsWin_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.troops);
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
                _ArmyDetailsWin_DataGridColumn1.headerText = _arg_1;
            }, "_ArmyDetailsWin_DataGridColumn1.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_DataGridColumn2.headerText = _arg_1;
            }, "_ArmyDetailsWin_DataGridColumn2.headerText");
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
                _ArmyDetailsWin_DataGridColumn3.headerText = _arg_1;
            }, "_ArmyDetailsWin_DataGridColumn3.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_DataGridColumn4.headerText = _arg_1;
            }, "_ArmyDetailsWin_DataGridColumn4.headerText");
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
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("君主") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Label2.text = _arg_1;
            }, "_ArmyDetailsWin_Label2.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("将领") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Label3.text = _arg_1;
            }, "_ArmyDetailsWin_Label3.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("联盟") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Label4.text = _arg_1;
            }, "_ArmyDetailsWin_Label4.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("等级") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyDetailsWin_Label5.text = _arg_1;
            }, "_ArmyDetailsWin_Label5.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.armyOb.hasOwnProperty("Lord")) ? this.armyOb.Lord : "--");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                playerName.text = _arg_1;
            }, "playerName.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.armyOb.hasOwnProperty("Alliance")) ? this.armyOb.Alliance : "--");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                alliance.text = _arg_1;
            }, "alliance.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.armyOb.hasOwnProperty("heroName")) ? this.armyOb.heroName : "--");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                hero.text = _arg_1;
            }, "hero.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.armyOb.hasOwnProperty("heroLevel")) ? this.armyOb.heroLevel : "--");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                level.text = _arg_1;
            }, "level.text");
            result[15] = binding;
            return (result);
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

        [Bindable(event="propertyChange")]
        public function get level():Label
        {
            return (this._102865796level);
        }

        override public function initialize():void
        {
            var target:ArmyDetailsWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ArmyDetailsWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_infoWin_ArmyDetailsWinWatcherSetupUtil");
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

        private function closeOwner():void
        {
            PopUpManager.removePopUp(this);
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

        [Bindable(event="propertyChange")]
        public function get playerName():Label
        {
            return (this._2095657228playerName);
        }

        private function checkArmyType(_arg_1:int):String
        {
            var _local_2:String;
            switch (_arg_1)
            {
                case TFConstants.T_PEASANTS:
                    _local_2 = Lang.msg("民夫");
                    break;
                case TFConstants.T_MILITIA:
                    _local_2 = Lang.msg("义兵");
                    break;
                case TFConstants.T_SCOUTER:
                    _local_2 = Lang.msg("斥候");
                    break;
                case TFConstants.T_PIKEMAN:
                    _local_2 = Lang.msg("枪兵");
                    break;
                case TFConstants.T_SWORDSMEN:
                    _local_2 = Lang.msg("刀盾兵");
                    break;
                case TFConstants.T_ARCHER:
                    _local_2 = Lang.msg("弓箭手");
                    break;
                case TFConstants.T_LIGHTCAVALRY:
                    _local_2 = Lang.msg("轻骑兵");
                    break;
                case TFConstants.T_HEAVYCAVALRY:
                    _local_2 = Lang.msg("铁骑兵");
                    break;
                case TFConstants.T_CARRIAGE:
                    _local_2 = Lang.msg("辎重车");
                    break;
                case TFConstants.T_BALLISTA:
                    _local_2 = Lang.msg("车弩");
                    break;
                case TFConstants.T_BATTERINGRAM:
                    _local_2 = Lang.msg("冲车");
                    break;
                case TFConstants.T_CATAPULT:
                    _local_2 = Lang.msg("投石车");
                    break;
            };
            return (_local_2);
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

        public function init():void
        {
        }

        private function _ArmyDetailsWin_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ArmyDetailsWin_DataGridColumn2 = _local_1;
            _local_1.dataField = "num";
            BindingManager.executeBindings(this, "_ArmyDetailsWin_DataGridColumn2", _ArmyDetailsWin_DataGridColumn2);
            return (_local_1);
        }

        private function _ArmyDetailsWin_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ArmyDetailsWin_DataGridColumn4 = _local_1;
            _local_1.dataField = "num";
            BindingManager.executeBindings(this, "_ArmyDetailsWin_DataGridColumn4", _ArmyDetailsWin_DataGridColumn4);
            return (_local_1);
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

        public function __closeBtn_click(_arg_1:MouseEvent):void
        {
            closeOwner();
        }

        [Bindable(event="propertyChange")]
        public function get alliance():Label
        {
            return (this._1806944311alliance);
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

        private function set myResource(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._119785946myResource;
            if (_local_2 !== _arg_1)
            {
                this._119785946myResource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myResource", _local_2, _arg_1));
            };
        }

        private function _ArmyDetailsWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("军队详情");
            _local_1 = this.troops;
            _local_1 = Lang.msg("兵种");
            _local_1 = Lang.msg("数量");
            _local_1 = this.myResource;
            _local_1 = Lang.msg("资源");
            _local_1 = Lang.msg("数量");
            _local_1 = Lang.msg("关闭");
            _local_1 = (Lang.msg("君主") + ":");
            _local_1 = (Lang.msg("将领") + ":");
            _local_1 = (Lang.msg("联盟") + ":");
            _local_1 = (Lang.msg("等级") + ":");
            _local_1 = ((this.armyOb.hasOwnProperty("Lord")) ? this.armyOb.Lord : "--");
            _local_1 = ((this.armyOb.hasOwnProperty("Alliance")) ? this.armyOb.Alliance : "--");
            _local_1 = ((this.armyOb.hasOwnProperty("heroName")) ? this.armyOb.heroName : "--");
            _local_1 = ((this.armyOb.hasOwnProperty("heroLevel")) ? this.armyOb.heroLevel : "--");
        }

        [Bindable(event="propertyChange")]
        public function get closeBtn():Button
        {
            return (this._1092797764closeBtn);
        }

        public function ___ArmyDetailsWin_Button2_click(_arg_1:MouseEvent):void
        {
            closeOwner();
        }

        [Bindable(event="propertyChange")]
        private function get armyOb():ObjectProxy
        {
            return (this._1409292208armyOb);
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

        [Bindable(event="propertyChange")]
        public function get resourceInfo():DataGrid
        {
            return (this._384703012resourceInfo);
        }

        private function set armyOb(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._1409292208armyOb;
            if (_local_2 !== _arg_1)
            {
                this._1409292208armyOb = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyOb", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get troops():ArrayCollection
        {
            return (this._865287327troops);
        }

        private function set troops(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._865287327troops;
            if (_local_2 !== _arg_1)
            {
                this._865287327troops = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troops", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get myResource():ArrayCollection
        {
            return (this._119785946myResource);
        }

        [Bindable(event="propertyChange")]
        public function get armyInfo():DataGrid
        {
            return (this._1415277589armyInfo);
        }

        private function _ArmyDetailsWin_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ArmyDetailsWin_DataGridColumn1 = _local_1;
            _local_1.dataField = "army";
            BindingManager.executeBindings(this, "_ArmyDetailsWin_DataGridColumn1", _ArmyDetailsWin_DataGridColumn1);
            return (_local_1);
        }

        private function _ArmyDetailsWin_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ArmyDetailsWin_DataGridColumn3 = _local_1;
            _local_1.dataField = "resource";
            BindingManager.executeBindings(this, "_ArmyDetailsWin_DataGridColumn3", _ArmyDetailsWin_DataGridColumn3);
            return (_local_1);
        }

        public function set myArmyBean(_arg_1:ObjectProxy):void
        {
            var _local_2:ArrayCollection;
            var _local_3:int;
            var _local_4:int;
            var _local_5:String;
            var _local_6:ObjectProxy;
            this.armyOb = _arg_1;
            this.troops.removeAll();
            if (this.armyOb.hasOwnProperty("troops"))
            {
                if ((this.armyOb.troops is ArrayCollection))
                {
                    _local_2 = this.armyOb.troops;
                    _local_3 = 0;
                    while (_local_3 < _local_2.length)
                    {
                        _local_4 = _local_2[_local_3].count;
                        _local_5 = checkArmyType(_local_2[_local_3].typeId);
                        this.troops.addItem({
                            "army":_local_5,
                            "num":_local_4
                        });
                        _local_3++;
                    };
                }
                else
                {
                    this.troops.addItem({
                        "army":checkArmyType(this.armyOb.troops.typeId),
                        "num":this.armyOb.troops.count
                    });
                };
            };
            this.myResource.removeAll();
            if (this.armyOb.hasOwnProperty("resource"))
            {
                _local_6 = this.armyOb.resource;
            }
            else
            {
                return;
            };
            myResource.addItem({
                "resource":Lang.msg("粮食"),
                "num":_local_6.food
            });
            myResource.addItem({
                "resource":Lang.msg("木材"),
                "num":_local_6.wood
            });
            myResource.addItem({
                "resource":Lang.msg("铁矿"),
                "num":_local_6.iron
            });
            myResource.addItem({
                "resource":Lang.msg("石料"),
                "num":_local_6.stone
            });
            myResource.addItem({
                "resource":Lang.msg("黄金"),
                "num":_local_6.gold
            });
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


    }
}//package view.module.info.infoWin

