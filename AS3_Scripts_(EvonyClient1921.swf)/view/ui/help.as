// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.help

package view.ui
{
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.collections.ArrayCollection;
    import mx.controls.Button;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.Text;
    import mx.controls.Label;
    import mx.controls.DataGrid;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Canvas;
    import mx.containers.HBox;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import mx.events.ListEvent;
    import mx.binding.BindingManager;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.FlexEvent;
    import flash.events.Event;
    import mx.core.ClassFactory;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import com.evony.common.beans.*;
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

    public class help extends BaseWindow implements IBindingClient 
    {

        public static var instance:help = new (help)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1783104352questList:ArrayCollection;
        private var _1456175557toRightBtn:Button;
        private var _995752784pageNo:int = 1;
        private var _892024219strArg:String = "";
        public var _help_DataGridColumn1:DataGridColumn;
        private var pageSize:int = 100;
        private var _577409037totalPage:int = 10;
        private var _789140625helpinfo:Text;
        public var _help_Label1:Label;
        private var _776676342curSelectRankIndex:int = 0;
        private var _425636739questTypeArray:ArrayCollection;
        private var winTitle:WinTitle;
        private var _1607799334toLeftBtn:Button;
        private var _1359545350cjitem:DataGrid;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseWindow,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":819,
                    "height":475,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "50";
                            this.bottom = "30";
                            this.left = "30";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"textBackground",
                                "width":200,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"cjitem",
                                    "events":{"itemClick":"__cjitem_itemClick"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "styleName":"style2",
                                            "resizableColumns":false,
                                            "draggableColumns":false,
                                            "sortableColumns":false,
                                            "rowHeight":25,
                                            "headerHeight":25,
                                            "columns":[_help_DataGridColumn1_i()]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "50";
                            this.bottom = "30";
                            this.right = "34";
                            this.left = "250";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"helpinfo",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":95,
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "12";
                                        this.right = "230";
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"toLeftBtn",
                                                "events":{"click":"__toLeftBtn_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"previous"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_help_Label1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"ftp14f"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"toRightBtn",
                                                "events":{"click":"__toRightBtn_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"next"});
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        private var _790254965helpData:Array = new Array({
            "label":Lang.msg("帮助1"),
            "data":1
        });
        private var _790093937helpInfo:Array = new Array({
            "label":Lang.msg("内容1"),
            "data":1
        }, {
            "label":Lang.msg("内容2"),
            "data":2
        }, {
            "label":Lang.msg("内容3"),
            "data":3
        }, {
            "label":Lang.msg("内容4"),
            "data":4
        }, {
            "label":Lang.msg("内容2"),
            "data":2
        }, {
            "label":Lang.msg("内容3"),
            "data":3
        }, {
            "label":Lang.msg("内容4"),
            "data":4
        }, {
            "label":Lang.msg("内容4"),
            "data":4
        }, {
            "label":Lang.msg("内容2"),
            "data":2
        }, {
            "label":Lang.msg("内容3"),
            "data":3
        }, {
            "label":Lang.msg("内容4"),
            "data":4
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function help()
        {
            mx_internal::_document = this;
            this.width = 819;
            this.height = 475;
            this.styleName = "BaseFunctionWindow";
            this.addEventListener("creationComplete", ___help_BaseWindow1_creationComplete);
            this.addEventListener("removedFromStage", ___help_BaseWindow1_removedFromStage);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            help._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object=null):void
        {
            UIUtil.setPopopHelpWindowStye(instance);
            if (!instance.isPopUp)
            {
                PopUpManager.addPopUp(instance, MainFrame.instance, true);
            };
            PopUpManager.centerPopUp(instance);
        }


        private function changePageNo(_arg_1:int):void
        {
            var _local_2:int = (this.pageNo + _arg_1);
            if (((_local_2 > 0) && (_local_2 <= this.totalPage)))
            {
                this.pageNo = _local_2;
                this.helpinfo.text = this.helpInfo[(_local_2 - 1)].label;
            };
        }

        [Bindable(event="propertyChange")]
        public function get cjitem():DataGrid
        {
            return (this._1359545350cjitem);
        }

        [Bindable(event="propertyChange")]
        private function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        public function __toLeftBtn_click(_arg_1:MouseEvent):void
        {
            this.changePageNo(-1);
        }

        [Bindable(event="propertyChange")]
        private function get questTypeArray():ArrayCollection
        {
            return (this._425636739questTypeArray);
        }

        private function set questTypeArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._425636739questTypeArray;
            if (_local_2 !== _arg_1)
            {
                this._425636739questTypeArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questTypeArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get helpData():Array
        {
            return (this._790254965helpData);
        }

        [Bindable(event="propertyChange")]
        public function get helpInfo():Array
        {
            return (this._790093937helpInfo);
        }

        public function __cjitem_itemClick(_arg_1:ListEvent):void
        {
            onChange(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get curSelectRankIndex():int
        {
            return (this._776676342curSelectRankIndex);
        }

        private function _help_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _help_DataGridColumn1 = _local_1;
            _local_1.itemRenderer = _help_ClassFactory1_c();
            BindingManager.executeBindings(this, "_help_DataGridColumn1", _help_DataGridColumn1);
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:help;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _help_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_helpWatcherSetupUtil");
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

        public function set curSelectRankIndex(_arg_1:int):void
        {
            var _local_2:Object = this._776676342curSelectRankIndex;
            if (_local_2 !== _arg_1)
            {
                this._776676342curSelectRankIndex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curSelectRankIndex", _local_2, _arg_1));
            };
        }

        public function set strArg(_arg_1:String):void
        {
            var _local_2:Object = this._892024219strArg;
            if (_local_2 !== _arg_1)
            {
                this._892024219strArg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strArg", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get questList():ArrayCollection
        {
            return (this._1783104352questList);
        }

        public function ___help_BaseWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set helpData(_arg_1:Array):void
        {
            var _local_2:Object = this._790254965helpData;
            if (_local_2 !== _arg_1)
            {
                this._790254965helpData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "helpData", _local_2, _arg_1));
            };
        }

        private function _help_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.helpData);
            }, function (_arg_1:Object):void
            {
                cjitem.dataProvider = _arg_1;
            }, "cjitem.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("帮助索引");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _help_DataGridColumn1.headerText = _arg_1;
            }, "_help_DataGridColumn1.headerText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.helpInfo[0].label;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                helpinfo.text = _arg_1;
            }, "helpinfo.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.pageNo + "/") + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _help_Label1.text = _arg_1;
            }, "_help_Label1.text");
            result[3] = binding;
            return (result);
        }

        public function set toLeftBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1607799334toLeftBtn;
            if (_local_2 !== _arg_1)
            {
                this._1607799334toLeftBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toLeftBtn", _local_2, _arg_1));
            };
        }

        public function set helpInfo(_arg_1:Array):void
        {
            var _local_2:Object = this._790093937helpInfo;
            if (_local_2 !== _arg_1)
            {
                this._790093937helpInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "helpInfo", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            winTitle = new WinTitle();
            winTitle.title = Lang.msg("帮助");
            winTitle.addEventListener("onClose", onClose);
            this.addChild(winTitle);
            this.refresh();
        }

        private function set questList(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1783104352questList;
            if (_local_2 !== _arg_1)
            {
                this._1783104352questList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questList", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get pageNo():int
        {
            return (this._995752784pageNo);
        }

        [Bindable(event="propertyChange")]
        public function get toRightBtn():Button
        {
            return (this._1456175557toRightBtn);
        }

        public function onClose(_arg_1:Event):void
        {
            PopUpManager.removePopUp(this);
        }

        override public function refresh():void
        {
        }

        public function set helpinfo(_arg_1:Text):void
        {
            var _local_2:Object = this._789140625helpinfo;
            if (_local_2 !== _arg_1)
            {
                this._789140625helpinfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "helpinfo", _local_2, _arg_1));
            };
        }

        private function _help_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.helpData;
            _local_1 = Lang.msg("帮助索引");
            _local_1 = this.helpInfo[0].label;
            _local_1 = ((this.pageNo + "/") + this.totalPage);
        }

        [Bindable(event="propertyChange")]
        public function get strArg():String
        {
            return (this._892024219strArg);
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

        public function ___help_BaseWindow1_removedFromStage(_arg_1:Event):void
        {
            destroy();
        }

        private function _help_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = help_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function onChange(_arg_1:ListEvent):void
        {
            this.helpinfo.text = this.helpInfo[0].label;
        }

        public function __toRightBtn_click(_arg_1:MouseEvent):void
        {
            this.changePageNo(1);
        }

        public function set cjitem(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1359545350cjitem;
            if (_local_2 !== _arg_1)
            {
                this._1359545350cjitem = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cjitem", _local_2, _arg_1));
            };
        }

        private function set pageNo(_arg_1:int):void
        {
            var _local_2:Object = this._995752784pageNo;
            if (_local_2 !== _arg_1)
            {
                this._995752784pageNo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pageNo", _local_2, _arg_1));
            };
        }

        override public function destroy():void
        {
        }

        [Bindable(event="propertyChange")]
        public function get toLeftBtn():Button
        {
            return (this._1607799334toLeftBtn);
        }

        public function set toRightBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1456175557toRightBtn;
            if (_local_2 !== _arg_1)
            {
                this._1456175557toRightBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toRightBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get helpinfo():Text
        {
            return (this._789140625helpinfo);
        }


    }
}//package view.ui

