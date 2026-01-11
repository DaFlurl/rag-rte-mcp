// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.herosMansion.HerosMansion

package view.module.herosMansion
{
    import view.ui.BaseBuildingWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.DataGrid;
    import view.module.guide.GuideArrow;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Canvas;
    import mx.containers.HBox;
    import com.evony.Lang;
    import mx.collections.ArrayCollection;
    import com.evony.Context;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import com.evony.common.beans.HeroBean;
    import view.module.guide.GuideStep;
    import mx.events.PropertyChangeEvent;
    import mx.binding.BindingManager;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.core.ClassFactory;
    import view.ui.UICallEscape;
    import flash.events.MouseEvent;
    import mx.events.FlexEvent;
    import com.evony.common.module.hero.HeroResponse;
    import com.evony.common.beans.BuildingBean;
    import view.castle.TownView;
    import com.evony.common.constants.BuildingConstants;
    import view.AllWindows;
    import view.module.tavern.Tavern;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.client.action.ActionFactory;
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

    public class HerosMansion extends BaseBuildingWindow implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "HerosMansion.show";
        public static const EVENT_REFRESH:String = "HerosMansion.refresh";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _HerosMansion_DataGridColumn1:DataGridColumn;
        public var _HerosMansion_DataGridColumn2:DataGridColumn;
        public var _HerosMansion_DataGridColumn3:DataGridColumn;
        public var _HerosMansion_DataGridColumn4:DataGridColumn;
        public var _HerosMansion_DataGridColumn5:DataGridColumn;
        public var _HerosMansion_DataGridColumn7:DataGridColumn;
        public var _HerosMansion_DataGridColumn8:DataGridColumn;
        public var _HerosMansion_DataGridColumn9:DataGridColumn;
        public var _HerosMansion_DataGridColumn6:DataGridColumn;
        private var _1990025787heroListDG:DataGrid;
        private var _1485163707appointGuide:GuideArrow;
        public var isKingOrQueen:int = 2;
        public var _HerosMansion_Button2:Button;
        public var _HerosMansion_Button3:Button;
        public var _HerosMansion_Button1:Button;
        private var curHeroStr:String = "";

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseBuildingWindow,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":320,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "percentHeight":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"heroListDG",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "26";
                                        this.bottom = "1";
                                        this.right = "1";
                                        this.left = "1";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"style3",
                                            "resizableColumns":false,
                                            "draggableColumns":false,
                                            "horizontalScrollPolicy":"off",
                                            "sortableColumns":false,
                                            "selectable":false,
                                            "columns":[_HerosMansion_DataGridColumn1_i(), _HerosMansion_DataGridColumn2_i(), _HerosMansion_DataGridColumn3_i(), _HerosMansion_DataGridColumn4_i(), _HerosMansion_DataGridColumn5_i(), _HerosMansion_DataGridColumn6_i(), _HerosMansion_DataGridColumn7_i(), _HerosMansion_DataGridColumn8_i(), _HerosMansion_DataGridColumn9_i()]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "5";
                                        this.top = "-1";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_HerosMansion_Button1",
                                                "events":{"click":"___HerosMansion_Button1_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "styleName":"b95"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_HerosMansion_Button2",
                                                "events":{"click":"___HerosMansion_Button2_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "styleName":"b95"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_HerosMansion_Button3",
                                                "events":{"click":"___HerosMansion_Button3_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "styleName":"b95"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"appointGuide",
                        "stylesFactory":function ():void
                        {
                            this.top = "27";
                            this.left = "149";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"arrowTGuide"});
                        }
                    })]
                });
            }
        });
        private var heroProperty:HeroProperties = new HeroProperties();
        private var castleChief:CastleChief = new CastleChief();
        private var _1150317143lookupStr:String = Lang.msg("查看");
        private var _347225142backStr:String = Lang.msg("召回");
        private var _95356390dataP:ArrayCollection = Context.getInstance().getCurCastle().herosArray;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function HerosMansion()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.height = 320;
            this.addEventListener("creationComplete", ___HerosMansion_BaseBuildingWindow1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            HerosMansion._watcherSetupUtil = _arg_1;
        }


        public function seeAbout(_arg_1:HeroBean):void
        {
            if (!heroProperty.isPopUp)
            {
                PopUpManager.addPopUp(heroProperty, MainFrame.instance, true);
            };
            heroProperty._heroList = dataP;
            heroProperty._heroMes = _arg_1;
            curHeroStr = _arg_1.name;
        }

        private function _HerosMansion_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = dataP;
            _local_1 = Lang.msg("将领");
            _local_1 = Lang.msg("等级");
            _local_1 = Lang.msg("内政");
            _local_1 = Lang.msg("勇武");
            _local_1 = Lang.msg("智谋");
            _local_1 = Lang.msg("忠诚");
            _local_1 = Lang.msg("状态");
            _local_1 = Lang.msg("召回");
            _local_1 = Lang.msg("行为");
            _local_1 = Lang.msg("招募");
            _local_1 = Lang.msg("任命城守");
            _local_1 = Lang.msg("召回旧部");
            _local_1 = (GuideStep.getInstance().currentStep == 12);
            _local_1 = (GuideStep.getInstance().currentStep == 12);
        }

        [Bindable(event="propertyChange")]
        public function get lookupStr():String
        {
            return (this._1150317143lookupStr);
        }

        public function set appointGuide(_arg_1:GuideArrow):void
        {
            var _local_2:Object = this._1485163707appointGuide;
            if (_local_2 !== _arg_1)
            {
                this._1485163707appointGuide = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "appointGuide", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get backStr():String
        {
            return (this._347225142backStr);
        }

        [Bindable(event="propertyChange")]
        private function get dataP():ArrayCollection
        {
            return (this._95356390dataP);
        }

        private function _HerosMansion_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _HerosMansion_DataGridColumn2 = _local_1;
            _local_1.dataField = "level";
            _local_1.width = 60;
            _local_1.itemRenderer = _HerosMansion_ClassFactory2_c();
            BindingManager.executeBindings(this, "_HerosMansion_DataGridColumn2", _HerosMansion_DataGridColumn2);
            return (_local_1);
        }

        private function _HerosMansion_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _HerosMansion_DataGridColumn4 = _local_1;
            _local_1.dataField = "power";
            _local_1.width = 60;
            _local_1.itemRenderer = _HerosMansion_ClassFactory4_c();
            BindingManager.executeBindings(this, "_HerosMansion_DataGridColumn4", _HerosMansion_DataGridColumn4);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get heroListDG():DataGrid
        {
            return (this._1990025787heroListDG);
        }

        private function init():void
        {
        }

        private function _HerosMansion_DataGridColumn8_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _HerosMansion_DataGridColumn8 = _local_1;
            _local_1.dataField = "recall";
            _local_1.width = 75;
            _local_1.itemRenderer = _HerosMansion_ClassFactory8_c();
            BindingManager.executeBindings(this, "_HerosMansion_DataGridColumn8", _HerosMansion_DataGridColumn8);
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:HerosMansion;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _HerosMansion_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_herosMansion_HerosMansionWatcherSetupUtil");
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

        private function _HerosMansion_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = HerosMansion_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _HerosMansion_ClassFactory4_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = HerosMansion_inlineComponent4;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _HerosMansion_ClassFactory6_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = HerosMansion_inlineComponent6;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _HerosMansion_ClassFactory8_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = HerosMansion_inlineComponent8;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        internal function onBtnCallOld(_arg_1:MouseEvent):void
        {
            UICallEscape.show();
        }

        public function ___HerosMansion_Button2_click(_arg_1:MouseEvent):void
        {
            onCastleChief(_arg_1);
        }

        public function set heroListDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1990025787heroListDG;
            if (_local_2 !== _arg_1)
            {
                this._1990025787heroListDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroListDG", _local_2, _arg_1));
            };
        }

        public function set lookupStr(_arg_1:String):void
        {
            var _local_2:Object = this._1150317143lookupStr;
            if (_local_2 !== _arg_1)
            {
                this._1150317143lookupStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lookupStr", _local_2, _arg_1));
            };
        }

        public function set backStr(_arg_1:String):void
        {
            var _local_2:Object = this._347225142backStr;
            if (_local_2 !== _arg_1)
            {
                this._347225142backStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "backStr", _local_2, _arg_1));
            };
        }

        public function ___HerosMansion_BaseBuildingWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set dataP(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._95356390dataP;
            if (_local_2 !== _arg_1)
            {
                this._95356390dataP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataP", _local_2, _arg_1));
            };
        }

        private function _HerosMansion_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _HerosMansion_DataGridColumn6 = _local_1;
            _local_1.dataField = "loyalty";
            _local_1.width = 55;
            _local_1.itemRenderer = _HerosMansion_ClassFactory6_c();
            BindingManager.executeBindings(this, "_HerosMansion_DataGridColumn6", _HerosMansion_DataGridColumn6);
            return (_local_1);
        }

        private function _HerosMansion_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _HerosMansion_DataGridColumn1 = _local_1;
            _local_1.dataField = "name";
            _local_1.width = 125;
            _local_1.itemRenderer = _HerosMansion_ClassFactory1_c();
            BindingManager.executeBindings(this, "_HerosMansion_DataGridColumn1", _HerosMansion_DataGridColumn1);
            return (_local_1);
        }

        private function _HerosMansion_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _HerosMansion_DataGridColumn3 = _local_1;
            _local_1.dataField = "management";
            _local_1.width = 60;
            _local_1.itemRenderer = _HerosMansion_ClassFactory3_c();
            BindingManager.executeBindings(this, "_HerosMansion_DataGridColumn3", _HerosMansion_DataGridColumn3);
            return (_local_1);
        }

        private function _HerosMansion_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _HerosMansion_DataGridColumn5 = _local_1;
            _local_1.dataField = "stratagem";
            _local_1.width = 80;
            _local_1.itemRenderer = _HerosMansion_ClassFactory5_c();
            BindingManager.executeBindings(this, "_HerosMansion_DataGridColumn5", _HerosMansion_DataGridColumn5);
            return (_local_1);
        }

        private function onCastleChief(_arg_1:MouseEvent):void
        {
            var _local_2:HeroBean;
            var _local_3:HeroBean;
            var _local_4:ArrayCollection = new ArrayCollection();
            var _local_5:int;
            while (_local_5 < dataP.length)
            {
                _local_2 = dataP[_local_5];
                if (_local_2.status == HeroResponse.FREE_HERO_STATUS)
                {
                    _local_4.addItem(_local_2);
                }
                else
                {
                    if (_local_2.status == HeroResponse.CHIEF_HERO_STATUS)
                    {
                        _local_3 = _local_2;
                    };
                };
                _local_5++;
            };
            CastleChief.show(_local_3, _local_4);
            if (appointGuide.visible)
            {
                appointGuide.visible = false;
                appointGuide.includeInLayout = false;
            };
        }

        private function onTavern():void
        {
            var _local_1:BuildingBean;
            if (TownView.singleton() != null)
            {
                for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
                {
                    if (_local_1.typeId == BuildingConstants.TYPE_TAVERN)
                    {
                        AllWindows.switchToBuildingWindow(Tavern.EVENT_SHOW, _local_1);
                        return;
                    };
                };
            };
        }

        private function _HerosMansion_DataGridColumn7_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _HerosMansion_DataGridColumn7 = _local_1;
            _local_1.dataField = "status";
            _local_1.width = 80;
            _local_1.itemRenderer = _HerosMansion_ClassFactory7_c();
            BindingManager.executeBindings(this, "_HerosMansion_DataGridColumn7", _HerosMansion_DataGridColumn7);
            return (_local_1);
        }

        override public function refresh():void
        {
            super.refresh();
            dataP = Context.getInstance().getCurCastle().herosArray;
        }

        private function _HerosMansion_ClassFactory5_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = HerosMansion_inlineComponent5;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _HerosMansion_ClassFactory7_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = HerosMansion_inlineComponent7;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _HerosMansion_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = HerosMansion_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _HerosMansion_ClassFactory9_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = HerosMansion_inlineComponent9;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _HerosMansion_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = HerosMansion_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___HerosMansion_Button1_click(_arg_1:MouseEvent):void
        {
            onTavern();
        }

        public function ___HerosMansion_Button3_click(_arg_1:MouseEvent):void
        {
            onBtnCallOld(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get appointGuide():GuideArrow
        {
            return (this._1485163707appointGuide);
        }

        private function _HerosMansion_DataGridColumn9_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _HerosMansion_DataGridColumn9 = _local_1;
            _local_1.dataField = "action";
            _local_1.width = 75;
            _local_1.itemRenderer = _HerosMansion_ClassFactory9_c();
            BindingManager.executeBindings(this, "_HerosMansion_DataGridColumn9", _HerosMansion_DataGridColumn9);
            return (_local_1);
        }

        private function _HerosMansion_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (dataP);
            }, function (_arg_1:Object):void
            {
                heroListDG.dataProvider = _arg_1;
            }, "heroListDG.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("将领");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HerosMansion_DataGridColumn1.headerText = _arg_1;
            }, "_HerosMansion_DataGridColumn1.headerText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("等级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HerosMansion_DataGridColumn2.headerText = _arg_1;
            }, "_HerosMansion_DataGridColumn2.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("内政");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HerosMansion_DataGridColumn3.headerText = _arg_1;
            }, "_HerosMansion_DataGridColumn3.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("勇武");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HerosMansion_DataGridColumn4.headerText = _arg_1;
            }, "_HerosMansion_DataGridColumn4.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("智谋");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HerosMansion_DataGridColumn5.headerText = _arg_1;
            }, "_HerosMansion_DataGridColumn5.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("忠诚");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HerosMansion_DataGridColumn6.headerText = _arg_1;
            }, "_HerosMansion_DataGridColumn6.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("状态");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HerosMansion_DataGridColumn7.headerText = _arg_1;
            }, "_HerosMansion_DataGridColumn7.headerText");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("召回");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HerosMansion_DataGridColumn8.headerText = _arg_1;
            }, "_HerosMansion_DataGridColumn8.headerText");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("行为");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HerosMansion_DataGridColumn9.headerText = _arg_1;
            }, "_HerosMansion_DataGridColumn9.headerText");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("招募");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HerosMansion_Button1.label = _arg_1;
            }, "_HerosMansion_Button1.label");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("任命城守");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HerosMansion_Button2.label = _arg_1;
            }, "_HerosMansion_Button2.label");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("召回旧部");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HerosMansion_Button3.label = _arg_1;
            }, "_HerosMansion_Button3.label");
            result[12] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 12);
            }, function (_arg_1:Boolean):void
            {
                appointGuide.includeInLayout = _arg_1;
            }, "appointGuide.includeInLayout");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 12);
            }, function (_arg_1:Boolean):void
            {
                appointGuide.visible = _arg_1;
            }, "appointGuide.visible");
            result[14] = binding;
            return (result);
        }

        override public function destroy():void
        {
            if (heroProperty.initialized)
            {
                heroProperty.destroy();
            };
        }

        public function heroCallBack(event:MouseEvent):void
        {
            var heroCallBack:Function;
            heroCallBack = function (_arg_1:CommandResponse):void
            {
                if (_arg_1.ok == CommandResponse.OK_DEFAULT)
                {
                    AlertWin.show(Lang.msg("英雄返回"));
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
            ActionFactory.getInstance().getHeroCommand().callBackHero(Context.getInstance().getCurCastle().id, event.target.data.id, heroCallBack);
        }


    }
}//package view.module.herosMansion

