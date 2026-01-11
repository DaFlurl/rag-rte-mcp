// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.AllFieldView

package view.module.office
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.FieldBean;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.DataGrid;
    import com.evony.common.beans.CastleBean;
    import mx.core.UIComponentDescriptor;
    import com.evony.Lang;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import com.evony.common.module.CommandResponse;
    import mx.events.PropertyChangeEvent;
    import mx.binding.BindingManager;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.core.ClassFactory;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.Context;
    import com.evony.Coordinate;
    import mx.events.FlexEvent;
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

    public class AllFieldView extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var curFiled:FieldBean;
        public var _AllFieldView_DataGridColumn1:DataGridColumn;
        public var _AllFieldView_DataGridColumn2:DataGridColumn;
        public var _AllFieldView_DataGridColumn3:DataGridColumn;
        public var _AllFieldView_DataGridColumn4:DataGridColumn;
        public var _AllFieldView_DataGridColumn5:DataGridColumn;
        private var _861252867fieldDG:DataGrid;
        private var _691506344curCastle:CastleBean;
        private var currentId:int;
        private var curFieldViews:CurFieldView;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"fieldDG",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.verticalAlign = "middle";
                            this.left = "0";
                            this.right = "0";
                            this.bottom = "0";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"style2",
                                "rowHeight":38,
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "columns":[_AllFieldView_DataGridColumn1_i(), _AllFieldView_DataGridColumn2_i(), _AllFieldView_DataGridColumn3_i(), _AllFieldView_DataGridColumn4_i(), _AllFieldView_DataGridColumn5_i()]
                            });
                        }
                    })]});
            }
        });
        private var _1120764471lookUpStr:String = Lang.msg("查看");
        private var _929036537fieldArr:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllFieldView()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.styleName = "baseBackGround";
            this.addEventListener("creationComplete", ___AllFieldView_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllFieldView._watcherSetupUtil = _arg_1;
        }


        private function giveUpResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.reFresh();
            };
        }

        [Bindable(event="propertyChange")]
        private function get fieldArr():ArrayCollection
        {
            return (this._929036537fieldArr);
        }

        private function setFieldArr():void
        {
            var _local_2:FieldBean;
            fieldArr.removeAll();
            var _local_1:int;
            while (_local_1 < this.curCastle.fieldsArray.length)
            {
                _local_2 = this.curCastle.getFields(_local_1);
                fieldArr.addItem(_local_2);
                _local_1++;
            };
        }

        private function _AllFieldView_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = fieldArr;
            _local_1 = Lang.msg("野地");
            _local_1 = Lang.msg("位置");
            _local_1 = Lang.msg("等级");
            _local_1 = Lang.msg("状态");
            _local_1 = Lang.msg("查看");
        }

        private function set fieldArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._929036537fieldArr;
            if (_local_2 !== _arg_1)
            {
                this._929036537fieldArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldArr", _local_2, _arg_1));
            };
        }

        private function deleteField():void
        {
            var _local_1:int;
            while (_local_1 < fieldArr.length)
            {
                if (fieldArr[_local_1].id == this.currentId)
                {
                    fieldArr.removeItemAt(_local_1);
                };
                _local_1++;
            };
        }

        private function _AllFieldView_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllFieldView_DataGridColumn2 = _local_1;
            _local_1.dataField = "id";
            _local_1.width = 100;
            _local_1.itemRenderer = _AllFieldView_ClassFactory2_c();
            BindingManager.executeBindings(this, "_AllFieldView_DataGridColumn2", _AllFieldView_DataGridColumn2);
            return (_local_1);
        }

        private function _AllFieldView_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllFieldView_DataGridColumn4 = _local_1;
            _local_1.dataField = "statu";
            _local_1.width = 100;
            _local_1.itemRenderer = _AllFieldView_ClassFactory3_c();
            _local_1.setStyle("fontSize", 12);
            BindingManager.executeBindings(this, "_AllFieldView_DataGridColumn4", _AllFieldView_DataGridColumn4);
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:AllFieldView;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AllFieldView_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_AllFieldViewWatcherSetupUtil");
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

        private function _AllFieldView_ClassFactory4_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = AllFieldView_inlineComponent4;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function init():void
        {
            this.reFresh();
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FIELD_GIVE_UP_FIELD, giveUpResponse);
        }

        private function set curCastle(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._691506344curCastle;
            if (_local_2 !== _arg_1)
            {
                this._691506344curCastle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curCastle", _local_2, _arg_1));
            };
        }

        private function _AllFieldView_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = AllFieldView_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function set castleBean(_arg_1:CastleBean):void
        {
            this.curCastle = _arg_1;
            setFieldArr();
        }

        [Bindable(event="propertyChange")]
        public function get lookUpStr():String
        {
            return (this._1120764471lookUpStr);
        }

        public function reFresh():void
        {
            this.curCastle = Context.getInstance().getCurCastle();
            setFieldArr();
        }

        public function fieldView(_arg_1:Object):void
        {
            var _local_2:FieldBean = (_arg_1 as FieldBean);
            var _local_3:Coordinate = new Coordinate(_local_2.id);
            CurFieldView.show(_local_2, _local_3, (((("(" + _local_3.x) + ",") + _local_3.y) + ")"));
        }

        public function ___AllFieldView_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function _AllFieldView_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllFieldView_DataGridColumn1 = _local_1;
            _local_1.dataField = "name";
            _local_1.width = 150;
            _local_1.itemRenderer = _AllFieldView_ClassFactory1_c();
            BindingManager.executeBindings(this, "_AllFieldView_DataGridColumn1", _AllFieldView_DataGridColumn1);
            return (_local_1);
        }

        private function _AllFieldView_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllFieldView_DataGridColumn3 = _local_1;
            _local_1.dataField = "level";
            _local_1.width = 60;
            _local_1.setStyle("fontSize", 12);
            BindingManager.executeBindings(this, "_AllFieldView_DataGridColumn3", _AllFieldView_DataGridColumn3);
            return (_local_1);
        }

        private function _AllFieldView_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllFieldView_DataGridColumn5 = _local_1;
            _local_1.dataField = "statu";
            _local_1.width = 50;
            _local_1.itemRenderer = _AllFieldView_ClassFactory4_c();
            BindingManager.executeBindings(this, "_AllFieldView_DataGridColumn5", _AllFieldView_DataGridColumn5);
            return (_local_1);
        }

        private function fieldType(_arg_1:int):String
        {
            var _local_2:String;
            switch (_arg_1)
            {
                case 1:
                    _local_2 = Lang.msg("森林");
                    break;
                case 2:
                    _local_2 = Lang.msg("荒漠");
                    break;
                case 3:
                    _local_2 = Lang.msg("山丘");
                    break;
                case 4:
                    _local_2 = Lang.msg("沼泽");
                    break;
                case 5:
                    _local_2 = Lang.msg("草原");
                    break;
                case 6:
                    _local_2 = Lang.msg("湖泊");
                    break;
                case 10:
                    _local_2 = Lang.msg("平地");
                    break;
                case 11:
                    _local_2 = Lang.msg("城堡");
                    break;
            };
            return (_local_2);
        }

        [Bindable(event="propertyChange")]
        private function get curCastle():CastleBean
        {
            return (this._691506344curCastle);
        }

        private function _AllFieldView_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = AllFieldView_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _AllFieldView_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = AllFieldView_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function set lookUpStr(_arg_1:String):void
        {
            var _local_2:Object = this._1120764471lookUpStr;
            if (_local_2 !== _arg_1)
            {
                this._1120764471lookUpStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lookUpStr", _local_2, _arg_1));
            };
        }

        public function set fieldDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._861252867fieldDG;
            if (_local_2 !== _arg_1)
            {
                this._861252867fieldDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldDG", _local_2, _arg_1));
            };
        }

        private function _AllFieldView_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (fieldArr);
            }, function (_arg_1:Object):void
            {
                fieldDG.dataProvider = _arg_1;
            }, "fieldDG.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("野地");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllFieldView_DataGridColumn1.headerText = _arg_1;
            }, "_AllFieldView_DataGridColumn1.headerText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("位置");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllFieldView_DataGridColumn2.headerText = _arg_1;
            }, "_AllFieldView_DataGridColumn2.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("等级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllFieldView_DataGridColumn3.headerText = _arg_1;
            }, "_AllFieldView_DataGridColumn3.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("状态");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllFieldView_DataGridColumn4.headerText = _arg_1;
            }, "_AllFieldView_DataGridColumn4.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查看");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllFieldView_DataGridColumn5.headerText = _arg_1;
            }, "_AllFieldView_DataGridColumn5.headerText");
            result[5] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get fieldDG():DataGrid
        {
            return (this._861252867fieldDG);
        }


    }
}//package view.module.office

