// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.EquipConditionTooltip

package view.ui
{
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.collections.ArrayCollection;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.Label;
    import mx.containers.Canvas;
    import mx.controls.Text;
    import mx.controls.DataGrid;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import mx.events.FlexEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.binding.BindingManager;
    import mx.core.ClassFactory;
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

    public class EquipConditionTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _2110128830levUpdata:String;
        private var _95356390dataP:ArrayCollection;
        public var _EquipConditionTooltip_DataGridColumn1:DataGridColumn;
        public var _EquipConditionTooltip_DataGridColumn2:DataGridColumn;
        public var _EquipConditionTooltip_DataGridColumn3:DataGridColumn;
        public var _EquipConditionTooltip_Label1:Label;
        private var _432490745updateBuilding_view:Canvas;
        public var _EquipConditionTooltip_Text1:Text;
        public var _EquipConditionTooltip_Text2:Text;
        private var _865670275needTime:String;
        private var _3079825desc:String;
        private var _1745048608updateBuildingDG:DataGrid;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":400,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.top = "5";
                            this.left = "5";
                            this.right = "5";
                            this.verticalGap = 6;
                            this.bottom = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_EquipConditionTooltip_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"contentheader1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_EquipConditionTooltip_Text1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText1",
                                            "width":354
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"updateBuilding_view",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"updateBuildingDG",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"work",
                                                        "rowHeight":28,
                                                        "columns":[_EquipConditionTooltip_DataGridColumn1_i(), _EquipConditionTooltip_DataGridColumn2_i(), _EquipConditionTooltip_DataGridColumn3_i()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_EquipConditionTooltip_Text2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"PropertyName1",
                                            "width":354
                                        });
                                    }
                                })]});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function EquipConditionTooltip()
        {
            mx_internal::_document = this;
            this.width = 400;
            this.styleName = "tooltips";
            this.addEventListener("creationComplete", ___EquipConditionTooltip_BaseTooltip1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            EquipConditionTooltip._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get needTime():String
        {
            return (this._865670275needTime);
        }

        private function set levUpdata(_arg_1:String):void
        {
            var _local_2:Object = this._2110128830levUpdata;
            if (_local_2 !== _arg_1)
            {
                this._2110128830levUpdata = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "levUpdata", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get updateBuilding_view():Canvas
        {
            return (this._432490745updateBuilding_view);
        }

        private function set needTime(_arg_1:String):void
        {
            var _local_2:Object = this._865670275needTime;
            if (_local_2 !== _arg_1)
            {
                this._865670275needTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "needTime", _local_2, _arg_1));
            };
        }

        public function set updateBuilding_view(_arg_1:Canvas):void
        {
            var _local_2:Object = this._432490745updateBuilding_view;
            if (_local_2 !== _arg_1)
            {
                this._432490745updateBuilding_view = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "updateBuilding_view", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get desc():String
        {
            return (this._3079825desc);
        }

        public function ___EquipConditionTooltip_BaseTooltip1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        override public function initialize():void
        {
            var target:EquipConditionTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _EquipConditionTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_EquipConditionTooltipWatcherSetupUtil");
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

        private function init():void
        {
        }

        private function set desc(_arg_1:String):void
        {
            var _local_2:Object = this._3079825desc;
            if (_local_2 !== _arg_1)
            {
                this._3079825desc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "desc", _local_2, _arg_1));
            };
        }

        private function _EquipConditionTooltip_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _EquipConditionTooltip_DataGridColumn2 = _local_1;
            _local_1.itemRenderer = _EquipConditionTooltip_ClassFactory1_c();
            BindingManager.executeBindings(this, "_EquipConditionTooltip_DataGridColumn2", _EquipConditionTooltip_DataGridColumn2);
            return (_local_1);
        }

        public function set updateBuildingDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1745048608updateBuildingDG;
            if (_local_2 !== _arg_1)
            {
                this._1745048608updateBuildingDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "updateBuildingDG", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get levUpdata():String
        {
            return (this._2110128830levUpdata);
        }

        public function setBeanArr(_arg_1:ArrayCollection):void
        {
            dataP = _arg_1;
        }

        private function _EquipConditionTooltip_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _EquipConditionTooltip_DataGridColumn3 = _local_1;
            _local_1.dataField = "current";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_EquipConditionTooltip_DataGridColumn3", _EquipConditionTooltip_DataGridColumn3);
            return (_local_1);
        }

        public function setDetail(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            this.desc = _arg_1;
            this.levUpdata = _arg_2;
            this.needTime = _arg_3;
        }

        private function _EquipConditionTooltip_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _EquipConditionTooltip_DataGridColumn1 = _local_1;
            _local_1.dataField = "name";
            _local_1.width = 120;
            BindingManager.executeBindings(this, "_EquipConditionTooltip_DataGridColumn1", _EquipConditionTooltip_DataGridColumn1);
            return (_local_1);
        }

        private function _EquipConditionTooltip_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = EquipConditionTooltip_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
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

        [Bindable(event="propertyChange")]
        private function get dataP():ArrayCollection
        {
            return (this._95356390dataP);
        }

        [Bindable(event="propertyChange")]
        public function get updateBuildingDG():DataGrid
        {
            return (this._1745048608updateBuildingDG);
        }

        private function _EquipConditionTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = levUpdata;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EquipConditionTooltip_Label1.text = _arg_1;
            }, "_EquipConditionTooltip_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.desc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EquipConditionTooltip_Text1.text = _arg_1;
            }, "_EquipConditionTooltip_Text1.text");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.dataP);
            }, function (_arg_1:Object):void
            {
                updateBuildingDG.dataProvider = _arg_1;
            }, "updateBuildingDG.dataProvider");
            result[2] = binding;
            binding = new Binding(this, function ():Number
            {
                return ((28 * dataP.length) + 35);
            }, function (_arg_1:Number):void
            {
                updateBuildingDG.height = _arg_1;
            }, "updateBuildingDG.height");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("建造条件");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EquipConditionTooltip_DataGridColumn1.headerText = _arg_1;
            }, "_EquipConditionTooltip_DataGridColumn1.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("需要条件");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EquipConditionTooltip_DataGridColumn2.headerText = _arg_1;
            }, "_EquipConditionTooltip_DataGridColumn2.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当前条件");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EquipConditionTooltip_DataGridColumn3.headerText = _arg_1;
            }, "_EquipConditionTooltip_DataGridColumn3.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (dataP.length > 0);
            }, function (_arg_1:Boolean):void
            {
                _EquipConditionTooltip_Text2.visible = _arg_1;
            }, "_EquipConditionTooltip_Text2.visible");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (dataP.length > 0);
            }, function (_arg_1:Boolean):void
            {
                _EquipConditionTooltip_Text2.includeInLayout = _arg_1;
            }, "_EquipConditionTooltip_Text2.includeInLayout");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("升级星降级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EquipConditionTooltip_Text2.text = _arg_1;
            }, "_EquipConditionTooltip_Text2.text");
            result[9] = binding;
            return (result);
        }

        private function _EquipConditionTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = levUpdata;
            _local_1 = this.desc;
            _local_1 = this.dataP;
            _local_1 = ((28 * dataP.length) + 35);
            _local_1 = Lang.msg("建造条件");
            _local_1 = Lang.msg("需要条件");
            _local_1 = Lang.msg("当前条件");
            _local_1 = (dataP.length > 0);
            _local_1 = (dataP.length > 0);
            _local_1 = Lang.msg("升级星降级");
        }


    }
}//package view.ui

