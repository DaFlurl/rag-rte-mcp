// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ViewMessage

package view
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.DataGrid;
    import mx.collections.ArrayCollection;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.core.ClassFactory;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.beans.VisitorCommentBean;
    import com.evony.common.module.CommandResponse;
    import view.ui.NeighborInfo;
    import com.evony.common.module.visit.GetAllVisitorCommentsResponse;
    import mx.managers.PopUpManager;
    import mx.controls.dataGridClasses.DataGridColumn;
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

    public class ViewMessage extends Canvas implements IBindingClient 
    {

        public static var instance:ViewMessage = new (ViewMessage)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1721972741nametxt:Label;
        private var pageSize:int = 3;
        private var _577409037totalPage:int = 0;
        private var _655126789questDg:DataGrid;
        private var _1125923055curPage:int = 1;
        public var _ViewMessage_Label3:Label;
        private var _1617090326commentBeanArray:ArrayCollection;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":443,
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
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":2,
                                            "text":"Message",
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"nametxt",
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.top = "55";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"funtionWindowTitle"});
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalAlign = "right";
                            this.right = "20";
                            this.verticalAlign = "middle";
                            this.top = "55";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":174,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___ViewMessage_Button1_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"previous"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ViewMessage_Label3",
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
                                    "events":{"click":"___ViewMessage_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"next"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "80";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "30";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"questDg",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "styleName":"style2",
                                            "rowHeight":110,
                                            "showHeaders":false,
                                            "resizableColumns":false,
                                            "rowCount":3,
                                            "draggableColumns":false,
                                            "selectable":false,
                                            "sortableColumns":false,
                                            "columns":[_ViewMessage_DataGridColumn1_c()]
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___ViewMessage_Button3_click"},
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
        private var _3237038info:Object = new Object();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ViewMessage()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 443;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ViewMessage._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object):void
        {
            instance.info = _arg_1;
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
            instance.reFresh();
        }


        [Bindable(event="propertyChange")]
        public function get nametxt():Label
        {
            return (this._1721972741nametxt);
        }

        private function _ViewMessage_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = ViewMessage_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function set nametxt(_arg_1:Label):void
        {
            var _local_2:Object = this._1721972741nametxt;
            if (_local_2 !== _arg_1)
            {
                this._1721972741nametxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "nametxt", _local_2, _arg_1));
            };
        }

        public function ___ViewMessage_Button2_click(_arg_1:MouseEvent):void
        {
            showPage(1);
        }

        override public function initialize():void
        {
            var target:ViewMessage;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ViewMessage_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ViewMessageWatcherSetupUtil");
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

        public function set questDg(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._655126789questDg;
            if (_local_2 !== _arg_1)
            {
                this._655126789questDg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questDg", _local_2, _arg_1));
            };
        }

        private function _ViewMessage_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("Messages from:" + info.name);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                nametxt.text = _arg_1;
            }, "nametxt.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.curPage + "/") + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ViewMessage_Label3.text = _arg_1;
            }, "_ViewMessage_Label3.text");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.commentBeanArray);
            }, function (_arg_1:Object):void
            {
                questDg.dataProvider = _arg_1;
            }, "questDg.dataProvider");
            result[2] = binding;
            return (result);
        }

        private function getReportListFromServer():void
        {
            ActionFactory.getInstance().getVisitCommands().getVisitorComments(info.fbid, curPage, pageSize, GetVisitorCommentResponse);
        }

        private function _ViewMessage_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ("Messages from:" + info.name);
            _local_1 = ((this.curPage + "/") + this.totalPage);
            _local_1 = this.commentBeanArray;
        }

        [Bindable(event="propertyChange")]
        public function get questDg():DataGrid
        {
            return (this._655126789questDg);
        }

        private function showPage(_arg_1:int):void
        {
            var _local_2:int = curPage;
            this.curPage = (this.curPage + _arg_1);
            if (((this.curPage >= 1) && (this.curPage <= this.totalPage)))
            {
                this.getReportListFromServer();
            }
            else
            {
                this.curPage = _local_2;
            };
        }

        [Bindable(event="propertyChange")]
        private function get info():Object
        {
            return (this._3237038info);
        }

        private function reFresh():void
        {
            getReportListFromServer();
            nametxt.text = ("Messages from:" + info.name);
        }

        public function ___ViewMessage_Button1_click(_arg_1:MouseEvent):void
        {
            showPage(-1);
        }

        public function ___ViewMessage_Button3_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        private function GetVisitorCommentResponse(_arg_1:GetAllVisitorCommentsResponse):void
        {
            var _local_2:VisitorCommentBean;
            var _local_3:int;
            if (this.commentBeanArray != null)
            {
                this.commentBeanArray.removeAll();
            };
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.curPage = _arg_1.pageNo;
                this.totalPage = _arg_1.totalPage;
                this.commentBeanArray = _arg_1.commentBeansArray;
                _local_3 = 0;
                while (_local_3 < this.commentBeanArray.length)
                {
                    _local_2 = (this.commentBeanArray[_local_3] as VisitorCommentBean);
                    ActionFactory.getInstance().getVisitCommands().markCommentAsRead(_local_2.id);
                    _local_3++;
                };
                NeighborInfo.instance.reFresh();
            };
        }

        private function set commentBeanArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1617090326commentBeanArray;
            if (_local_2 !== _arg_1)
            {
                this._1617090326commentBeanArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "commentBeanArray", _local_2, _arg_1));
            };
        }

        private function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        private function set info(_arg_1:Object):void
        {
            var _local_2:Object = this._3237038info;
            if (_local_2 !== _arg_1)
            {
                this._3237038info = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "info", _local_2, _arg_1));
            };
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
        private function get commentBeanArray():ArrayCollection
        {
            return (this._1617090326commentBeanArray);
        }

        [Bindable(event="propertyChange")]
        private function get curPage():int
        {
            return (this._1125923055curPage);
        }

        [Bindable(event="propertyChange")]
        private function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        private function _ViewMessage_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.itemRenderer = _ViewMessage_ClassFactory1_c();
            return (_local_1);
        }


    }
}//package view

