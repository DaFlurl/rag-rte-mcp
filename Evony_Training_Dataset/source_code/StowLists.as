// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.trainningField.StowLists

package view.module.trainningField
{
    import view.ui.BaseFunctionWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.DataGrid;
    import mx.collections.ArrayCollection;
    import com.evony.Coordinate;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import com.evony.common.beans.CastleBean;
    import mx.core.ClassFactory;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import view.AllWindows;
    import com.evony.MsgDispacther;
    import com.evony.events.WindowChangeEvent;
    import mx.binding.BindingManager;
    import com.evony.Lang;
    import com.evony.common.beans.ColonyBean;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.colony.ColonialCastlesRespone;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
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

    public class StowLists extends BaseFunctionWindow implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "StowList.open";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _StowLists_DataGridColumn1:DataGridColumn;
        public var _StowLists_DataGridColumn4:DataGridColumn;
        private var _141409361otherCastleStow:DataGrid;
        public var _StowLists_DataGridColumn2:DataGridColumn;
        private var _114357537castleStow:DataGrid;
        private var boolean:Boolean = false;
        private var _601301008fieldAryAddC:ArrayCollection;
        private var temI:int = 0;
        private var _929036530fieldAry:ArrayCollection;
        private var coor:Coordinate;
        private var _1443166814dataAry:ArrayCollection;
        public var _StowLists_DataGridColumn3:DataGridColumn;
        public var _StowLists_DataGridColumn5:DataGridColumn;
        public var _StowLists_DataGridColumn6:DataGridColumn;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindow,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"castleStow",
                        "stylesFactory":function ():void
                        {
                            this.left = "34";
                            this.top = "43";
                            this.bottom = "43";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "rowHeight":35,
                                "styleName":"style2",
                                "width":373,
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "columns":[_StowLists_DataGridColumn1_i(), _StowLists_DataGridColumn2_i(), _StowLists_DataGridColumn3_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"otherCastleStow",
                        "stylesFactory":function ():void
                        {
                            this.right = "34";
                            this.bottom = "43";
                            this.top = "43";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "rowHeight":35,
                                "styleName":"style2",
                                "width":373,
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "columns":[_StowLists_DataGridColumn4_i(), _StowLists_DataGridColumn5_i(), _StowLists_DataGridColumn6_i()]
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function StowLists()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("removedFromStage", ___StowLists_BaseFunctionWindow1_removedFromStage);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            StowLists._watcherSetupUtil = _arg_1;
        }


        override public function destroy():void
        {
        }

        public function setCoordinate(_arg_1:Object):void
        {
            if ((_arg_1 is CastleBean))
            {
                coor = new Coordinate(_arg_1.fieldId);
            }
            else
            {
                coor = new Coordinate(0);
                coor.x = _arg_1.x;
                coor.y = _arg_1.y;
            };
            this.boolean = true;
            sendCoordinate();
        }

        private function _StowLists_ClassFactory6_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = StowLists_inlineComponent6;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:StowLists;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _StowLists_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_trainningField_StowListsWatcherSetupUtil");
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
        private function get fieldAry():ArrayCollection
        {
            return (this._929036530fieldAry);
        }

        private function set fieldAry(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._929036530fieldAry;
            if (_local_2 !== _arg_1)
            {
                this._929036530fieldAry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldAry", _local_2, _arg_1));
            };
        }

        private function sendCoordinate():void
        {
            if (this.boolean)
            {
                AllWindows.switchToFuncWindow(NewArmyWin.EVENT_SHOW);
                MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(NewArmyWin.EVENT_COORDINATE, coor));
            }
            else
            {
                MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(WindowChangeEvent.ID_CLOSE));
            };
        }

        [Bindable(event="propertyChange")]
        public function get castleStow():DataGrid
        {
            return (this._114357537castleStow);
        }

        private function _StowLists_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _StowLists_DataGridColumn1 = _local_1;
            _local_1.dataField = "id";
            _local_1.width = 60;
            _local_1.itemRenderer = _StowLists_ClassFactory1_c();
            BindingManager.executeBindings(this, "_StowLists_DataGridColumn1", _StowLists_DataGridColumn1);
            return (_local_1);
        }

        private function _StowLists_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _StowLists_DataGridColumn3 = _local_1;
            _local_1.dataField = "id";
            _local_1.labelFunction = changeCoordinate;
            _local_1.itemRenderer = _StowLists_ClassFactory3_c();
            BindingManager.executeBindings(this, "_StowLists_DataGridColumn3", _StowLists_DataGridColumn3);
            return (_local_1);
        }

        private function _StowLists_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _StowLists_DataGridColumn5 = _local_1;
            _local_1.dataField = "name";
            _local_1.width = 165;
            _local_1.itemRenderer = _StowLists_ClassFactory5_c();
            BindingManager.executeBindings(this, "_StowLists_DataGridColumn5", _StowLists_DataGridColumn5);
            return (_local_1);
        }

        public function set otherCastleStow(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._141409361otherCastleStow;
            if (_local_2 !== _arg_1)
            {
                this._141409361otherCastleStow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "otherCastleStow", _local_2, _arg_1));
            };
        }

        private function _StowLists_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("收藏");
            _local_1 = dataAry;
            _local_1 = Lang.msg("选择");
            _local_1 = Lang.msg("我的城池");
            _local_1 = Lang.msg("坐标");
            _local_1 = fieldAry;
            _local_1 = Lang.msg("选择");
            _local_1 = Lang.msg("城堡名称");
            _local_1 = Lang.msg("坐标");
        }

        private function _StowLists_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = StowLists_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _StowLists_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = StowLists_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _StowLists_ClassFactory5_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = StowLists_inlineComponent5;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function set dataAry(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1443166814dataAry;
            if (_local_2 !== _arg_1)
            {
                this._1443166814dataAry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataAry", _local_2, _arg_1));
            };
        }

        private function _StowLists_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("收藏");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.title = _arg_1;
            }, "this.title");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (dataAry);
            }, function (_arg_1:Object):void
            {
                castleStow.dataProvider = _arg_1;
            }, "castleStow.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("选择");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _StowLists_DataGridColumn1.headerText = _arg_1;
            }, "_StowLists_DataGridColumn1.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("我的城池");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _StowLists_DataGridColumn2.headerText = _arg_1;
            }, "_StowLists_DataGridColumn2.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("坐标");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _StowLists_DataGridColumn3.headerText = _arg_1;
            }, "_StowLists_DataGridColumn3.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():Object
            {
                return (fieldAry);
            }, function (_arg_1:Object):void
            {
                otherCastleStow.dataProvider = _arg_1;
            }, "otherCastleStow.dataProvider");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("选择");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _StowLists_DataGridColumn4.headerText = _arg_1;
            }, "_StowLists_DataGridColumn4.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("城堡名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _StowLists_DataGridColumn5.headerText = _arg_1;
            }, "_StowLists_DataGridColumn5.headerText");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("坐标");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _StowLists_DataGridColumn6.headerText = _arg_1;
            }, "_StowLists_DataGridColumn6.headerText");
            result[8] = binding;
            return (result);
        }

        public function set castleStow(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._114357537castleStow;
            if (_local_2 !== _arg_1)
            {
                this._114357537castleStow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleStow", _local_2, _arg_1));
            };
        }

        private function setColonyArr(_arg_1:ColonialCastlesRespone):void
        {
            var _local_2:Boolean;
            var _local_3:ColonyBean;
            var _local_4:Object;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                _local_2 = false;
                for each (_local_3 in _arg_1.colonyBeansArray)
                {
                    _local_2 = false;
                    for each (_local_4 in fieldAry)
                    {
                        if (_local_4.id == _local_3.position)
                        {
                            _local_2 = true;
                        };
                    };
                    if (!_local_2)
                    {
                        fieldAry.addItem({
                            "id":_local_3.position,
                            "name":_local_3.cityName
                        });
                    };
                };
            };
        }

        private function changeCoordinate(_arg_1:Object, _arg_2:DataGridColumn):String
        {
            var _local_3:Coordinate = new Coordinate(_arg_1.fieldId);
            var _local_4:* = (((("(" + _local_3.x) + ",") + _local_3.y) + ")");
            return (_local_4);
        }

        private function getColonyArr():void
        {
            ActionFactory.getInstance().getColonyCommands().getColonialCastlesInfo(Context.getInstance().getCurCastle().id, setColonyArr);
        }

        override public function refresh():void
        {
            dataAry = Context.getInstance().getPlayerBean().castlesArray;
            fieldAry = Context.getInstance().getPlayerBean().castleSignBeanArray;
            getColonyArr();
            var _local_1:int;
            while (_local_1 < this.dataAry.length)
            {
                if (this.castleStow.indexToItemRenderer(_local_1) != null)
                {
                    this.castleStow.indexToItemRenderer(_local_1).document.radionBtn.selected = false;
                };
                _local_1++;
            };
            var _local_2:int;
            while (_local_2 < this.fieldAry.length)
            {
                if (this.otherCastleStow.indexToItemRenderer(_local_2) != null)
                {
                    this.otherCastleStow.indexToItemRenderer(_local_2).document.radionBtn2.selected = false;
                };
                _local_2++;
            };
            this.boolean = false;
            temI = 0;
            super.refresh();
            trace((this.className + " refresh()"));
        }

        [Bindable(event="propertyChange")]
        private function get dataAry():ArrayCollection
        {
            return (this._1443166814dataAry);
        }

        [Bindable(event="propertyChange")]
        public function get otherCastleStow():DataGrid
        {
            return (this._141409361otherCastleStow);
        }

        private function _StowLists_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _StowLists_DataGridColumn2 = _local_1;
            _local_1.dataField = "name";
            _local_1.width = 165;
            _local_1.itemRenderer = _StowLists_ClassFactory2_c();
            BindingManager.executeBindings(this, "_StowLists_DataGridColumn2", _StowLists_DataGridColumn2);
            return (_local_1);
        }

        private function set fieldAryAddC(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._601301008fieldAryAddC;
            if (_local_2 !== _arg_1)
            {
                this._601301008fieldAryAddC = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldAryAddC", _local_2, _arg_1));
            };
        }

        private function _StowLists_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _StowLists_DataGridColumn6 = _local_1;
            _local_1.dataField = "id";
            _local_1.labelFunction = changeCoordinate2;
            _local_1.itemRenderer = _StowLists_ClassFactory6_c();
            BindingManager.executeBindings(this, "_StowLists_DataGridColumn6", _StowLists_DataGridColumn6);
            return (_local_1);
        }

        private function changeCoordinate2(_arg_1:Object, _arg_2:DataGridColumn):String
        {
            var _local_3:String;
            if (_arg_1.hasOwnProperty("x"))
            {
                _local_3 = (((("(" + _arg_1.x) + ",") + _arg_1.y) + ")");
            }
            else
            {
                _local_3 = (("(" + _arg_1.id.toString()) + ")");
                _local_3 = _local_3.replace(".", ",");
            };
            return (_local_3);
        }

        public function ___StowLists_BaseFunctionWindow1_removedFromStage(_arg_1:Event):void
        {
            destroy();
        }

        [Bindable(event="propertyChange")]
        private function get fieldAryAddC():ArrayCollection
        {
            return (this._601301008fieldAryAddC);
        }

        private function _StowLists_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = StowLists_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _StowLists_ClassFactory4_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = StowLists_inlineComponent4;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _StowLists_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _StowLists_DataGridColumn4 = _local_1;
            _local_1.dataField = "id";
            _local_1.width = 60;
            _local_1.itemRenderer = _StowLists_ClassFactory4_c();
            BindingManager.executeBindings(this, "_StowLists_DataGridColumn4", _StowLists_DataGridColumn4);
            return (_local_1);
        }


    }
}//package view.module.trainningField

