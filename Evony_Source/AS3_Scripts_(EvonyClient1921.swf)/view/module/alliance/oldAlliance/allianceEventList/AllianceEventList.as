// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.allianceEventList.AllianceEventList

package view.module.alliance.oldAlliance.allianceEventList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.DataGrid;
    import mx.controls.Label;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.controls.Button;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import mx.core.ClassFactory;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Lang;
    import com.evony.client.action.ActionFactory;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.alliance.AllianceEventListResponse;
    import mx.binding.BindingManager;
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

    public class AllianceEventList extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _AllianceEventList_DataGrid1:DataGrid;
        private var _577409037totalPage:int = 0;
        public var _AllianceEventList_Label1:Label;
        public var _AllianceEventList_DataGridColumn1:DataGridColumn;
        public var _AllianceEventList_DataGridColumn2:DataGridColumn;
        private var _1125923055curPage:int = 1;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"_AllianceEventList_DataGrid1",
                        "stylesFactory":function ():void
                        {
                            this.top = "30";
                            this.bottom = "36";
                            this.left = "1";
                            this.right = "1";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"style2",
                                "rowHeight":33,
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_AllianceEventList_DataGridColumn1_i(), _AllianceEventList_DataGridColumn2_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalAlign = "right";
                            this.verticalAlign = "middle";
                            this.bottom = "5";
                            this.right = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___AllianceEventList_Button1_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":543,
                                            "styleName":"previous"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AllianceEventList_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":579,
                                            "styleName":"ftp14f"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___AllianceEventList_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":648,
                                            "styleName":"next"
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        private var _295928095eventListArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllianceEventList()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.backgroundAlpha = 0;
            };
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___AllianceEventList_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllianceEventList._watcherSetupUtil = _arg_1;
        }


        private function set curPage(_arg_1:int):void
        {
            var _local_2:Object = this._1125923055curPage;
            if (_local_2 !== _arg_1)
            {
                this._1125923055curPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curPage", _local_2, _arg_1));
            };
        }

        public function destroy():void
        {
        }

        public function ___AllianceEventList_Button1_click(_arg_1:MouseEvent):void
        {
            turnPage(-1);
        }

        private function _AllianceEventList_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = AllianceEventList_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:AllianceEventList;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AllianceEventList_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_oldAlliance_allianceEventList_AllianceEventListWatcherSetupUtil");
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

        private function set eventListArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._295928095eventListArray;
            if (_local_2 !== _arg_1)
            {
                this._295928095eventListArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "eventListArray", _local_2, _arg_1));
            };
        }

        private function _AllianceEventList_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (eventListArray);
            }, function (_arg_1:Object):void
            {
                _AllianceEventList_DataGrid1.dataProvider = _arg_1;
            }, "_AllianceEventList_DataGrid1.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("事件");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceEventList_DataGridColumn1.headerText = _arg_1;
            }, "_AllianceEventList_DataGridColumn1.headerText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceEventList_DataGridColumn2.headerText = _arg_1;
            }, "_AllianceEventList_DataGridColumn2.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.curPage + "/") + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceEventList_Label1.text = _arg_1;
            }, "_AllianceEventList_Label1.text");
            result[3] = binding;
            return (result);
        }

        public function ___AllianceEventList_Button2_click(_arg_1:MouseEvent):void
        {
            turnPage(1);
        }

        [Bindable(event="propertyChange")]
        private function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        public function refresh():void
        {
            ActionFactory.getInstance().getAllianceCommands().getAllianceEventList(curPage);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_GET_ALLIANCE_EVENT_LIST, onGetEventList);
            if (this.initialized)
            {
                this.refresh();
            };
        }

        private function onGetEventList(_arg_1:AllianceEventListResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.eventListArray = _arg_1.eventsArray;
                this.totalPage = _arg_1.totalPage;
            };
        }

        private function set totalPage(_arg_1:int):void
        {
            var _local_2:Object = this._577409037totalPage;
            if (_local_2 !== _arg_1)
            {
                this._577409037totalPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "totalPage", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get eventListArray():ArrayCollection
        {
            return (this._295928095eventListArray);
        }

        private function turnPage(_arg_1:int):void
        {
            var _local_2:int = curPage;
            this.curPage = (this.curPage + _arg_1);
            if (((this.curPage >= 1) && (this.curPage <= this.totalPage)))
            {
                this.refresh();
            }
            else
            {
                this.curPage = _local_2;
            };
        }

        [Bindable(event="propertyChange")]
        private function get curPage():int
        {
            return (this._1125923055curPage);
        }

        private function _AllianceEventList_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceEventList_DataGridColumn1 = _local_1;
            _local_1.dataField = "eventName";
            BindingManager.executeBindings(this, "_AllianceEventList_DataGridColumn1", _AllianceEventList_DataGridColumn1);
            return (_local_1);
        }

        private function _AllianceEventList_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceEventList_DataGridColumn2 = _local_1;
            _local_1.dataField = "time";
            _local_1.width = 200;
            _local_1.itemRenderer = _AllianceEventList_ClassFactory1_c();
            BindingManager.executeBindings(this, "_AllianceEventList_DataGridColumn2", _AllianceEventList_DataGridColumn2);
            return (_local_1);
        }

        public function ___AllianceEventList_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function _AllianceEventList_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = eventListArray;
            _local_1 = Lang.msg("事件");
            _local_1 = Lang.msg("时间");
            _local_1 = ((this.curPage + "/") + this.totalPage);
        }


    }
}//package view.module.alliance.oldAlliance.allianceEventList

