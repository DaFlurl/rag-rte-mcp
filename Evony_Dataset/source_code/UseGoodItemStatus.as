// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.herosMansion.UseGoodItemStatus

package view.module.herosMansion
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.HeroBean;
    import mx.controls.DataGrid;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.Button;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.binding.BindingManager;
    import mx.events.PropertyChangeEvent;
    import mx.core.ClassFactory;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.MouseEvent;
    import com.evony.Lang;
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

    public class UseGoodItemStatus extends Canvas implements IBindingClient 
    {

        public static var instance:UseGoodItemStatus;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _811312001heroMes:HeroBean;
        public var _UseGoodItemStatus_DataGrid1:DataGrid;
        public var _UseGoodItemStatus_DataGridColumn2:DataGridColumn;
        public var _UseGoodItemStatus_DataGridColumn1:DataGridColumn;
        public var _UseGoodItemStatus_Button1:Button;
        public var _UseGoodItemStatus_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":218,
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
                                    "id":"_UseGoodItemStatus_Label1",
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
                        "id":"_UseGoodItemStatus_DataGrid1",
                        "stylesFactory":function ():void
                        {
                            this.top = "33";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "46";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"style2",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_UseGoodItemStatus_DataGridColumn1_i(), _UseGoodItemStatus_DataGridColumn2_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_UseGoodItemStatus_Button1",
                        "events":{"click":"___UseGoodItemStatus_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "10";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":63,
                                "styleName":"b75",
                                "width":75,
                                "height":25
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___UseGoodItemStatus_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":0,
                                "label":"",
                                "styleName":"close"
                            });
                        }
                    })]
                });
            }
        });
        private var datap:ArrayCollection = new ArrayCollection();
        private var awardHeroView:AwardHero = new AwardHero();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function UseGoodItemStatus()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 218;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            UseGoodItemStatus._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object=null):void
        {
            if (instance == null)
            {
                instance = new (UseGoodItemStatus)();
            };
            PopUpManager.addPopUp(instance, MainFrame.instance, true);
            PopUpManager.centerPopUp(instance);
            instance.heroMes = HeroBean(_arg_1);
        }


        private function _UseGoodItemStatus_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _UseGoodItemStatus_DataGridColumn1 = _local_1;
            _local_1.dataField = "descName";
            BindingManager.executeBindings(this, "_UseGoodItemStatus_DataGridColumn1", _UseGoodItemStatus_DataGridColumn1);
            return (_local_1);
        }

        private function _UseGoodItemStatus_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _UseGoodItemStatus_DataGridColumn2 = _local_1;
            _local_1.dataField = "endTime";
            _local_1.itemRenderer = _UseGoodItemStatus_ClassFactory1_c();
            BindingManager.executeBindings(this, "_UseGoodItemStatus_DataGridColumn2", _UseGoodItemStatus_DataGridColumn2);
            return (_local_1);
        }

        private function set heroMes(_arg_1:HeroBean):void
        {
            var _local_2:Object = this._811312001heroMes;
            if (_local_2 !== _arg_1)
            {
                this._811312001heroMes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroMes", _local_2, _arg_1));
            };
        }

        public function set _heroMes(_arg_1:HeroBean):void
        {
            heroMes = _arg_1;
        }

        [Bindable(event="propertyChange")]
        private function get heroMes():HeroBean
        {
            return (this._811312001heroMes);
        }

        private function _UseGoodItemStatus_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = UseGoodItemStatus_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:UseGoodItemStatus;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _UseGoodItemStatus_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_herosMansion_UseGoodItemStatusWatcherSetupUtil");
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

        public function ___UseGoodItemStatus_Button1_click(_arg_1:MouseEvent):void
        {
            awardHero();
        }

        public function ___UseGoodItemStatus_Button2_click(_arg_1:MouseEvent):void
        {
            PopUpManager.removePopUp(this);
        }

        private function _UseGoodItemStatus_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("赏赐");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UseGoodItemStatus_Label1.text = _arg_1;
            }, "_UseGoodItemStatus_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (heroMes.buffsArray);
            }, function (_arg_1:Object):void
            {
                _UseGoodItemStatus_DataGrid1.dataProvider = _arg_1;
            }, "_UseGoodItemStatus_DataGrid1.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UseGoodItemStatus_DataGridColumn1.headerText = _arg_1;
            }, "_UseGoodItemStatus_DataGridColumn1.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("持续时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UseGoodItemStatus_DataGridColumn2.headerText = _arg_1;
            }, "_UseGoodItemStatus_DataGridColumn2.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("赏赐");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UseGoodItemStatus_Button1.label = _arg_1;
            }, "_UseGoodItemStatus_Button1.label");
            result[4] = binding;
            return (result);
        }

        private function _UseGoodItemStatus_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("赏赐");
            _local_1 = heroMes.buffsArray;
            _local_1 = Lang.msg("名称");
            _local_1 = Lang.msg("持续时间");
            _local_1 = Lang.msg("赏赐");
        }

        public function awardHero():void
        {
            AwardHero.show(heroMes);
            PopUpManager.removePopUp(this);
        }


    }
}//package view.module.herosMansion

